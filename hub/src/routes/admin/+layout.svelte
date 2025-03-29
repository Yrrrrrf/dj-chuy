<!-- src/routes/admin/+layout.svelte -->
<script lang="ts">
    import { onMount } from 'svelte';
    import { goto } from '$app/navigation';
    import { authStore } from '$lib/stores/auth.svelte';
    import Sidebar from '../../components/layout/Sidebar.svelte';

    // Get children slot
    let { children } = $props();
    
    // Check authentication status on mount
    onMount(() => {
      authStore.checkAuth();
      if (!authStore.isAuthenticated) {
        // Redirect to login if not authenticated
        goto('/login');
      }
    });
  </script>
  
  <svelte:head>
    <title>Panel de Administración - DJ Chuy</title>
  </svelte:head>
  
  <div class="flex bg-gray-100 min-h-screen">
    <!-- Sidebar -->
    <Sidebar />
    
    <!-- Main Content -->
    <div class="flex-1 ml-64 p-8">
      <header class="mb-8">
        <div class="flex justify-between items-center">
          <h1 class="text-3xl font-bold text-gray-800">Panel de Administración</h1>
          <a 
            href="/" 
            target="_blank"
            class="bg-amber-500 hover:bg-amber-600 text-white px-4 py-2 rounded-lg text-sm"
          >
            Ver sitio web
          </a>
        </div>
        <p class="text-gray-600 mt-2">
          Gestiona los servicios, clientes y cotizaciones de DJ Chuy.
        </p>
      </header>
      
      <!-- Child routes render here -->
      {@render children()}
    </div>
  </div>