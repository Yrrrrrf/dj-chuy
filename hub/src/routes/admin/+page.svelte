<!-- src/routes/admin/+page.svelte -->
<script lang="ts">
  import { clientStore } from '$lib/stores/clients.svelte';
  import { serviceStore } from '$lib/stores/services.svelte';
    import ClientTable from '../../components/admin/ClientTable.svelte';
    import QuoteTable from '../../components/admin/QuoteTable.svelte';
    import ServiceTable from '../../components/admin/ServiceTable.svelte';
  
  // Get counts for dashboard
  let clientCount = $derived(clientStore.clients.length);
  let quoteCount = $derived(clientStore.quotes.length);
  let serviceCount = $derived(serviceStore.services.length);
  let packageCount = $derived(serviceStore.packages.length);
  
  // Get pending quotes
  let pendingQuotes = $derived(clientStore.quotes.filter(q => q.status === 'pending').length);
</script>

<div class="space-y-8">
  <!-- Dashboard Summary -->
  <div id="dashboard">
    <h2 class="text-2xl font-bold text-gray-800 mb-4">Dashboard</h2>
    
    <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-6">
      <!-- Clients Card -->
      <div class="bg-white rounded-lg shadow-md p-6">
        <div class="flex items-center">
          <div class="p-3 rounded-full bg-amber-100 text-amber-500 mr-4">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
            </svg>
          </div>
          <div>
            <p class="text-gray-500 text-sm">Clientes</p>
            <p class="text-2xl font-bold">{clientCount}</p>
          </div>
        </div>
      </div>
      
      <!-- Services Card -->
      <div class="bg-white rounded-lg shadow-md p-6">
        <div class="flex items-center">
          <div class="p-3 rounded-full bg-blue-100 text-blue-500 mr-4">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19v-6a2 2 0 00-2-2H5a2 2 0 00-2 2v6a2 2 0 002 2h2a2 2 0 002-2zm0 0V9a2 2 0 012-2h2a2 2 0 012 2v10m-6 0a2 2 0 002 2h2a2 2 0 002-2m0 0V5a2 2 0 012-2h2a2 2 0 012 2v14a2 2 0 01-2 2h-2a2 2 0 01-2-2z" />
            </svg>
          </div>
          <div>
            <p class="text-gray-500 text-sm">Servicios</p>
            <p class="text-2xl font-bold">{serviceCount}</p>
          </div>
        </div>
      </div>
      
      <!-- Packages Card -->
      <div class="bg-white rounded-lg shadow-md p-6">
        <div class="flex items-center">
          <div class="p-3 rounded-full bg-green-100 text-green-500 mr-4">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M20 7l-8-4-8 4m16 0l-8 4m8-4v10l-8 4m0-10L4 7m8 4v10M4 7v10l8 4" />
            </svg>
          </div>
          <div>
            <p class="text-gray-500 text-sm">Paquetes</p>
            <p class="text-2xl font-bold">{packageCount}</p>
          </div>
        </div>
      </div>
      
      <!-- Quotes Card -->
      <div class="bg-white rounded-lg shadow-md p-6">
        <div class="flex items-center">
          <div class="p-3 rounded-full bg-purple-100 text-purple-500 mr-4">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-8 w-8" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 5H7a2 2 0 00-2 2v12a2 2 0 002 2h10a2 2 0 002-2V7a2 2 0 00-2-2h-2M9 5a2 2 0 002 2h2a2 2 0 002-2M9 5a2 2 0 012-2h2a2 2 0 012 2m-3 7h3m-3 4h3m-6-4h.01M9 16h.01" />
            </svg>
          </div>
          <div>
            <p class="text-gray-500 text-sm">Cotizaciones</p>
            <p class="text-2xl font-bold">{quoteCount} <span class="text-sm text-yellow-500">({pendingQuotes} pendientes)</span></p>
          </div>
        </div>
      </div>
    </div>
  </div>
  
  <!-- Services Section -->
  <div id="servicios">
    <ServiceTable />
  </div>
  
  <!-- Clients Section -->
  <div id="clientes">
    <ClientTable />
  </div>
  
  <!-- Quotes Section -->
  <div id="cotizaciones">
    <QuoteTable />
  </div>
</div>