<!-- src/lib/components/admin/ClientTable.svelte -->
<script lang="ts">
    import { clientStore } from '$lib/stores/clients.svelte';
    import type { Client } from '$lib/types';
    
    // Get clients from store
    let clients = $derived(clientStore.clients);
    
    // Form state for adding a new client
    let showAddForm = $state(false);
    let newClient = $state<Omit<Client, 'id' | 'createdAt'>>({
      name: '',
      email: '',
      phone: ''
    });
    
    // Form state for editing a client
    let editingClient = $state<Client | null>(null);
    
    // Handle add client form submission
    function handleAddClient() {
      clientStore.addClient(newClient);
      newClient = { name: '', email: '', phone: '' };
      showAddForm = false;
    }
    
    // Handle edit client form submission
    function handleEditClient() {
      if (editingClient) {
        clientStore.updateClient(editingClient.id, editingClient);
        editingClient = null;
      }
    }
    
    // Set up client for editing
    function startEditing(client: Client) {
      editingClient = { ...client };
    }
    
    // Cancel editing
    function cancelEditing() {
      editingClient = null;
    }
    
    // Delete a client
    function deleteClient(id: string) {
      if (confirm('¿Estás seguro de que deseas eliminar este cliente?')) {
        clientStore.deleteClient(id);
      }
    }
  </script>
  
  <div class="bg-white rounded-lg shadow-md p-6">
    <div class="flex justify-between items-center mb-6">
      <h2 class="text-2xl font-bold text-gray-800">Clientes</h2>
      <button
        onclick={() => showAddForm = !showAddForm}
        class="bg-amber-500 hover:bg-amber-600 text-white px-4 py-2 rounded-lg"
      >
        {showAddForm ? 'Cancelar' : 'Agregar Cliente'}
      </button>
    </div>
    
    {#if showAddForm}
      <div class="mb-6 bg-gray-50 p-4 rounded-lg">
        <h3 class="text-lg font-semibold mb-4">Agregar Nuevo Cliente</h3>
        <form onsubmit={handleAddClient} class="space-y-4">
          <div>
            <label for="name" class="block text-sm font-medium text-gray-700 mb-1">Nombre</label>
            <input
              id="name"
              type="text"
              bind:value={newClient.name}
              required
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-amber-500"
            />
          </div>
          
          <div>
            <label for="email" class="block text-sm font-medium text-gray-700 mb-1">Email</label>
            <input
              id="email"
              type="email"
              bind:value={newClient.email}
              required
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-amber-500"
            />
          </div>
          
          <div>
            <label for="phone" class="block text-sm font-medium text-gray-700 mb-1">Teléfono</label>
            <input
              id="phone"
              type="tel"
              bind:value={newClient.phone}
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-amber-500"
            />
          </div>
          
          <div>
            <button
              type="submit"
              class="bg-amber-500 hover:bg-amber-600 text-white px-4 py-2 rounded-lg"
            >
              Guardar Cliente
            </button>
          </div>
        </form>
      </div>
    {/if}
    
    {#if clients.length === 0}
      <div class="text-center py-8 text-gray-500">
        No hay clientes registrados.
      </div>
    {:else}
      <div class="overflow-x-auto">
        <table class="w-full text-left">
          <thead class="bg-gray-50">
            <tr>
              <th class="px-4 py-3 text-sm font-medium text-gray-500">Nombre</th>
              <th class="px-4 py-3 text-sm font-medium text-gray-500">Email</th>
              <th class="px-4 py-3 text-sm font-medium text-gray-500">Teléfono</th>
              <th class="px-4 py-3 text-sm font-medium text-gray-500">Fecha</th>
              <th class="px-4 py-3 text-sm font-medium text-gray-500">Acciones</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-200">
            {#each clients as client}
              <tr class="hover:bg-gray-50">
                {#if editingClient && editingClient.id === client.id}
                  <td class="px-4 py-3">
                    <input
                      type="text"
                      bind:value={editingClient.name}
                      class="w-full px-2 py-1 border border-gray-300 rounded"
                    />
                  </td>
                  <td class="px-4 py-3">
                    <input
                      type="email"
                      bind:value={editingClient.email}
                      class="w-full px-2 py-1 border border-gray-300 rounded"
                    />
                  </td>
                  <td class="px-4 py-3">
                    <input
                      type="tel"
                      bind:value={editingClient.phone}
                      class="w-full px-2 py-1 border border-gray-300 rounded"
                    />
                  </td>
                  <td class="px-4 py-3">
                    {new Date(client.createdAt).toLocaleDateString()}
                  </td>
                  <td class="px-4 py-3">
                    <button
                      onclick={handleEditClient}
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
                  <td class="px-4 py-3">{client.name}</td>
                  <td class="px-4 py-3">{client.email}</td>
                  <td class="px-4 py-3">{client.phone || '-'}</td>
                  <td class="px-4 py-3">{new Date(client.createdAt).toLocaleDateString()}</td>
                  <td class="px-4 py-3">
                    <button
                      onclick={() => startEditing(client)}
                      class="text-blue-600 hover:text-blue-900 mr-2"
                    >
                      Editar
                    </button>
                    <button
                      onclick={() => deleteClient(client.id)}
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