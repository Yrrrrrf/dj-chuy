<!-- src/lib/components/admin/QuoteTable.svelte -->
<script lang="ts">
    import { clientStore } from '$lib/stores/clients.svelte';
    import { serviceStore } from '$lib/stores/services.svelte';
    import type { Quote } from '$lib/types';
    
    // Get quotes, clients, and services from stores
    let quotes = $derived(clientStore.quotes);
    let clients = $derived(clientStore.clients);
    let services = $derived([...serviceStore.services, ...serviceStore.packages]);
    
    // Get client name from ID
    function getClientName(clientId: string): string {
      const client = clients.find(c => c.id === clientId);
      return client ? client.name : 'Cliente desconocido';
    }
    
    // Get service name from ID
    function getServiceName(serviceId: string): string {
      const service = services.find(s => s.id === serviceId);
      return service ? service.name : 'Servicio desconocido';
    }
    
    // Form state for adding a new quote
    let showAddForm = $state(false);
    let newQuote = $state<Omit<Quote, 'id' | 'createdAt'>>({
      clientId: '',
      serviceId: '',
      price: 0,
      status: 'pending'
    });
    
    // Form state for editing a quote
    let editingQuote = $state<Quote | null>(null);
    
    // Handle add quote form submission
    function handleAddQuote() {
      clientStore.addQuote(newQuote);
      resetNewQuoteForm();
    }
    
    // Reset the new quote form
    function resetNewQuoteForm() {
      newQuote = {
        clientId: '',
        serviceId: '',
        price: 0,
        status: 'pending'
      };
      showAddForm = false;
    }
    
    // Handle edit quote form submission
    function handleEditQuote() {
      if (editingQuote) {
        clientStore.updateQuote(editingQuote.id, editingQuote);
        editingQuote = null;
      }
    }
    
    // Start editing a quote
    function startEditing(quote: Quote) {
      editingQuote = { ...quote };
    }
    
    // Cancel editing
    function cancelEditing() {
      editingQuote = null;
    }
    
    // Delete a quote
    function deleteQuote(id: string) {
      if (confirm('¿Estás seguro de que deseas eliminar esta cotización?')) {
        clientStore.deleteQuote(id);
      }
    }
    
    // Get the status badge class based on status
    function getStatusBadgeClass(status: Quote['status']): string {
      switch (status) {
        case 'accepted':
          return 'bg-green-100 text-green-800';
        case 'rejected':
          return 'bg-red-100 text-red-800';
        default:
          return 'bg-yellow-100 text-yellow-800';
      }
    }
  </script>
  
  <div class="bg-white rounded-lg shadow-md p-6">
    <div class="flex justify-between items-center mb-6">
      <h2 class="text-2xl font-bold text-gray-800">Cotizaciones</h2>
      <button
        onclick={() => showAddForm = !showAddForm}
        class="bg-amber-500 hover:bg-amber-600 text-white px-4 py-2 rounded-lg"
      >
        {showAddForm ? 'Cancelar' : 'Agregar Cotización'}
      </button>
    </div>
    
    {#if showAddForm}
      <div class="mb-6 bg-gray-50 p-4 rounded-lg">
        <h3 class="text-lg font-semibold mb-4">Agregar Nueva Cotización</h3>
        <form onsubmit={handleAddQuote} class="space-y-4">
          <div>
            <label for="clientId" class="block text-sm font-medium text-gray-700 mb-1">Cliente</label>
            <select
              id="clientId"
              bind:value={newQuote.clientId}
              required
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-amber-500"
            >
              <option value="">Selecciona un cliente</option>
              {#each clients as client}
                <option value={client.id}>{client.name}</option>
              {/each}
            </select>
          </div>
          
          <div>
            <label for="serviceId" class="block text-sm font-medium text-gray-700 mb-1">Servicio</label>
            <select
              id="serviceId"
              bind:value={newQuote.serviceId}
              required
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-amber-500"
            >
              <option value="">Selecciona un servicio</option>
              {#each services as service}
                <option value={service.id}>{service.name}</option>
              {/each}
            </select>
          </div>
          
          <div>
            <label for="price" class="block text-sm font-medium text-gray-700 mb-1">Precio</label>
            <input
              id="price"
              type="number"
              bind:value={newQuote.price}
              min="0"
              step="0.01"
              required
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-amber-500"
            />
          </div>
          
          <div>
            <label for="status" class="block text-sm font-medium text-gray-700 mb-1">Estado</label>
            <select
              id="status"
              bind:value={newQuote.status}
              required
              class="w-full px-3 py-2 border border-gray-300 rounded-lg focus:ring-2 focus:ring-amber-500 focus:border-amber-500"
            >
              <option value="pending">Pendiente</option>
              <option value="accepted">Aceptada</option>
              <option value="rejected">Rechazada</option>
            </select>
          </div>
          
          <div>
            <button
              type="submit"
              class="bg-amber-500 hover:bg-amber-600 text-white px-4 py-2 rounded-lg"
            >
              Guardar Cotización
            </button>
          </div>
        </form>
      </div>
    {/if}
    
    {#if quotes.length === 0}
      <div class="text-center py-8 text-gray-500">
        No hay cotizaciones registradas.
      </div>
    {:else}
      <div class="overflow-x-auto">
        <table class="w-full text-left">
          <thead class="bg-gray-50">
            <tr>
              <th class="px-4 py-3 text-sm font-medium text-gray-500">Cliente</th>
              <th class="px-4 py-3 text-sm font-medium text-gray-500">Servicio</th>
              <th class="px-4 py-3 text-sm font-medium text-gray-500">Precio</th>
              <th class="px-4 py-3 text-sm font-medium text-gray-500">Estado</th>
              <th class="px-4 py-3 text-sm font-medium text-gray-500">Fecha</th>
              <th class="px-4 py-3 text-sm font-medium text-gray-500">Acciones</th>
            </tr>
          </thead>
          <tbody class="divide-y divide-gray-200">
            {#each quotes as quote}
              <tr class="hover:bg-gray-50">
                {#if editingQuote && editingQuote.id === quote.id}
                  <td class="px-4 py-3">
                    <select
                      bind:value={editingQuote.clientId}
                      class="w-full px-2 py-1 border border-gray-300 rounded"
                    >
                      {#each clients as client}
                        <option value={client.id}>{client.name}</option>
                      {/each}
                    </select>
                  </td>
                  <td class="px-4 py-3">
                    <select
                      bind:value={editingQuote.serviceId}
                      class="w-full px-2 py-1 border border-gray-300 rounded"
                    >
                      {#each services as service}
                        <option value={service.id}>{service.name}</option>
                      {/each}
                    </select>
                  </td>
                  <td class="px-4 py-3">
                    <input
                      type="number"
                      bind:value={editingQuote.price}
                      min="0"
                      step="0.01"
                      class="w-full px-2 py-1 border border-gray-300 rounded"
                    />
                  </td>
                  <td class="px-4 py-3">
                    <select
                      bind:value={editingQuote.status}
                      class="w-full px-2 py-1 border border-gray-300 rounded"
                    >
                      <option value="pending">Pendiente</option>
                      <option value="accepted">Aceptada</option>
                      <option value="rejected">Rechazada</option>
                    </select>
                  </td>
                  <td class="px-4 py-3">
                    {new Date(quote.createdAt).toLocaleDateString()}
                  </td>
                  <td class="px-4 py-3">
                    <button
                      onclick={handleEditQuote}
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
                  <td class="px-4 py-3">{getClientName(quote.clientId)}</td>
                  <td class="px-4 py-3">{getServiceName(quote.serviceId)}</td>
                  <td class="px-4 py-3">${quote.price.toLocaleString()}</td>
                  <td class="px-4 py-3">
                    <span class={`inline-flex items-center px-2.5 py-0.5 rounded-full text-xs font-medium ${getStatusBadgeClass(quote.status)}`}>
                      {quote.status === 'pending' ? 'Pendiente' : quote.status === 'accepted' ? 'Aceptada' : 'Rechazada'}
                    </span>
                  </td>
                  <td class="px-4 py-3">{new Date(quote.createdAt).toLocaleDateString()}</td>
                  <td class="px-4 py-3">
                    <button
                      onclick={() => startEditing(quote)}
                      class="text-blue-600 hover:text-blue-900 mr-2"
                    >
                      Editar
                    </button>
                    <button
                      onclick={() => deleteQuote(quote.id)}
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