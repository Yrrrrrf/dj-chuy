<!-- src/lib/components/admin/ServiceTable.svelte -->
<script lang="ts">
    import { serviceStore } from '$lib/stores/services.svelte';
    import type { Service } from '$lib/types';
    
    // Get services from store
    let services = $derived(serviceStore.services);
    
    // Form state for adding a new service
    let showAddForm = $state(false);
    let newService = $state<Omit<Service, 'id'>>({
      name: '',
      description: '',
      videoSrc: '',
      features: []
    });
    
    // New feature being added
    let newFeature = $state('');
    
    // Form state for editing a service
    let editingService = $state<Service | null>(null);
    let editingFeature = $state('');
    
    // Handle add service form submission
    function handleAddService() {
      serviceStore.addService(newService);
      resetNewServiceForm();
    }
    
    // Reset the new service form
    function resetNewServiceForm() {
      newService = {
        name: '',
        description: '',
        videoSrc: '',
        features: []
      };
      newFeature = '';
      showAddForm = false;
    }
    
    // Add a feature to the new service
    function addFeature() {
      if (newFeature.trim()) {
        newService.features = [...(newService.features || []), newFeature.trim()];
        newFeature = '';
      }
    }
    
    // Remove a feature from the new service
    function removeFeature(index: number) {
      if (newService.features) {
        newService.features = newService.features.filter((_, i) => i !== index);
      }
    }
    
    // Handle edit service form submission
    function handleEditService() {
      if (editingService) {
        serviceStore.updateService(editingService.id, editingService);
        editingService = null;
      }
    }
    
    // Start editing a service
    function startEditing(service: Service) {
      editingService = { ...service };
      editingFeature = '';
    }
    
    // Cancel editing
    function cancelEditing() {
      editingService = null;
      editingFeature = '';
    }
    
    // Add a feature to the service being edited
    function addEditingFeature() {
      if (editingService && editingFeature.trim()) {
        editingService.features = [...(editingService.features || []), editingFeature.trim()];
        editingFeature = '';
      }
    }
    
    // Remove a feature from the service being edited
    function removeEditingFeature(index: number) {
      if (editingService && editingService.features) {
        editingService.features = editingService.features.filter((_, i) => i !== index);
      }
    }
    
    // Delete a service
    function deleteService(id: string) {
      if (confirm('¿Estás seguro de que deseas eliminar este servicio?')) {
        serviceStore.deleteService(id);
      }
    }
  </script>
  
  <div class="bg-white rounded-lg shadow-md p-6">
    <div class="flex justify-between items-center mb-6">
      <h2 class="text-2xl font-bold text-gray-800">Servicios</h2>
      <button
        onclick={() => showAddForm = !showAddForm}
        class="bg-amber-500 hover:bg-amber-600 text-white px-4 py-2 rounded-lg"
      >
        {showAddForm ? 'Cancelar' : 'Agregar Servicio'}
      </button>
    </div>
    
    {#if showAddForm}
      <div class="mb-6 bg-gray-50 p-4 rounded-lg">
        <h3 class="text-lg font-semibold mb-4">Agregar Nuevo Servicio</h3>
        <form onsubmit={handleAddService} class="space-y-4">
          <div>
            <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Nombre</label>
            <input
              id="name"
              type="text"
              bind:value={newService.name}
              required
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-amber-500"
            />
          </div>
          
          <div>
            <label for="description" class="block text-sm font-medium text-gray-700 mb-1">Descripción</label>
            <textarea
              id="description"
              bind:value={newService.description}
              required
              rows="3"
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-amber-500"
            ></textarea>
          </div>
          
          <div>
            <label for="videoSrc" class="block text-sm font-medium text-gray-700 mb-1">URL del video (opcional)</label>
            <input
              id="videoSrc"
              type="text"
              bind:value={newService.videoSrc}
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-amber-500"
              placeholder="/videos/ejemplo.mp4"
            />
          </div>
          
          <div>
            <label class="block text-sm font-medium text-gray-700 mb-1">Características</label>
            <div class="flex">
              <input
                type="text"
                bind:value={newFeature}
                class="flex-1 px-3 py-2 border border-gray-300 rounded-l-lg focus:ring-2 focus:ring-amber-500 focus:border-amber-500"
                placeholder="Agregar característica"
              />
              <button
                type="button"
                onclick={addFeature}
                class="bg-amber-500 hover:bg-amber-600 text-white px-4 py-2 rounded-r-lg"
              >
                Agregar
              </button>
            </div>
            
            {#if newService.features && newService.features.length > 0}
              <ul class="mt-3 space-y-1">
                {#each newService.features as feature, index}
                  <li class="flex items-center justify-between bg-white px-3 py-2 rounded-lg">
                    <span>{feature}</span>
                    <button
                      type="button"
                      onclick={() => removeFeature(index)}
                      class="text-red-500 hover:text-red-700"
                    >
                      ✕
                    </button>
                  </li>
                {/each}
              </ul>
            {/if}
          </div>
          
          <div>
            <button
              type="submit"
              class="bg-amber-500 hover:bg-amber-600 text-white px-4 py-2 rounded-lg"
            >
              Guardar Servicio
            </button>
          </div>
        </form>
      </div>
    {/if}
    
    {#if services.length === 0}
      <div class="text-center py-8 text-gray-500">
        No hay servicios registrados.
      </div>
    {:else}
      <div class="overflow-x-auto">
        <table class="w-full text-left">
          <thead class="bg-gray-50">
            <tr>
              <th class="px-4 py-3 text-sm font-medium text-gray-500">Nombre</th>
              <th class="px-4 py-3 text-sm font-medium text-gray-500">Descripción</th>
              <th class="px-4 py-3 text-sm font-medium text-gray-500">Características</th>
              <th class="px-4 py-3 text-sm font-medium text-gray-500">Acciones</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-200">
            {#each services as service}
              <tr class="hover:bg-gray-50">
                {#if editingService && editingService.id === service.id}
                  <td class="px-4 py-3">
                    <input
                      type="text"
                      bind:value={editingService.name}
                      class="w-full px-2 py-1 border border-gray-300 rounded"
                    />
                  </td>
                  <td class="px-4 py-3">
                    <textarea
                      bind:value={editingService.description}
                      rows="3"
                      class="w-full px-2 py-1 border border-gray-300 rounded"
                    ></textarea>
                  </td>
                  <td class="px-4 py-3">
                    <div class="flex mb-2">
                      <input
                        type="text"
                        bind:value={editingFeature}
                        class="flex-1 px-2 py-1 border border-gray-300 rounded-l"
                        placeholder="Agregar característica"
                      />
                      <button
                        type="button"
                        onclick={addEditingFeature}
                        class="bg-amber-500 hover:bg-amber-600 text-white px-2 py-1 rounded-r"
                      >
                        +
                      </button>
                    </div>
                    
                    {#if editingService.features && editingService.features.length > 0}
                      <ul class="space-y-1 text-sm">
                        {#each editingService.features as feature, index}
                          <li class="flex items-center justify-between bg-gray-50 px-2 py-1 rounded">
                            <span>{feature}</span>
                            <button
                              type="button"
                              onclick={() => removeEditingFeature(index)}
                              class="text-red-500 hover:text-red-700"
                            >
                              ✕
                            </button>
                          </li>
                        {/each}
                      </ul>
                    {/if}
                  </td>
                  <td class="px-4 py-3">
                    <button
                      onclick={handleEditService}
                      class="text-green-600 hover:text-green-900 mr-2"
                    >
                      Guardar
                    </button>
                    <button
                      onclick={cancelEditing}
                      class="text-gray-600 hover:text-gray-900"
                    >
                      Cancelar
                    </button>
                  </td>
                {:else}
                  <td class="px-4 py-3">{service.name}</td>
                  <td class="px-4 py-3">{service.description}</td>
                  <td class="px-4 py-3">
                    {#if service.features && service.features.length > 0}
                      <ul class="list-disc list-inside text-sm">
                        {#each service.features as feature}
                          <li>{feature}</li>
                        {/each}
                      </ul>
                    {:else}
                      <span class="text-gray-400">Sin características</span>
                    {/if}
                  </td>
                  <td class="px-4 py-3">
                    <button
                      onclick={() => startEditing(service)}
                      class="text-blue-600 hover:text-blue-900 mr-2"
                    >
                      Editar
                    </button>
                    <button
                      onclick={() => deleteService(service.id)}
                      class="text-red-600 hover:text-red-900"
                    >
                      Eliminar
                    </button>
                  </td>
                {/if}
              </tr>
            {/each}
          </tbody>
        </table>
      </div>
    {/if}
  </div>