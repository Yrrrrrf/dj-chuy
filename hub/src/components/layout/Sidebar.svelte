<!-- src/lib/components/layout/Sidebar.svelte -->
<script lang="ts">
    import { authStore } from '$lib/stores/auth.svelte';
    
    // The active section
    let activeSection = $state('dashboard');
    
    // Set active section
    function setActive(section: string) {
      activeSection = section;
    }
    
    // Handle logout
    function handleLogout() {
      authStore.logout();
    }
  </script>
  
  <div class="w-64 bg-neutral-800 text-white h-screen fixed left-0 top-0 overflow-y-auto">
    <div class="p-6">
      <h3 class="text-xl font-bold mb-8 text-center">Admin Panel</h3>
      
      <nav class="space-y-2">
        <a 
          href="#dashboard" 
          class={`block px-4 py-3 rounded-lg transition duration-200 ${activeSection === 'dashboard' ? 'bg-amber-500 text-white' : 'hover:bg-neutral-700'}`}
          onclick={() => setActive('dashboard')}
        >
          <div class="flex items-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2V6zM14 6a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2V6zM4 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2H6a2 2 0 01-2-2v-2zM14 16a2 2 0 012-2h2a2 2 0 012 2v2a2 2 0 01-2 2h-2a2 2 0 01-2-2v-2z" />
            </svg>
            Dashboard
          </div>
        </a>
        
        <a 
          href="#servicios" 
          class={`block px-4 py-3 rounded-lg transition duration-200 ${activeSection === 'servicios' ? 'bg-amber-500 text-white' : 'hover:bg-neutral-700'}`}
          onclick={() => setActive('servicios')}
        >
          <div class="flex items-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 19V6l12-3v13M9 19c0 1.105-1.343 2-3 2s-3-.895-3-2 1.343-2 3-2 3 .895 3 2zm12-3c0 1.105-1.343 2-3 2s-3-.895-3-2 1.343-2 3-2 3 .895 3 2zM9 10l12-3" />
            </svg>
            Servicios
          </div>
        </a>
        
        <a 
          href="#clientes" 
          class={`block px-4 py-3 rounded-lg transition duration-200 ${activeSection === 'clientes' ? 'bg-amber-500 text-white' : 'hover:bg-neutral-700'}`}
          onclick={() => setActive('clientes')}
        >
          <div class="flex items-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M12 4.354a4 4 0 110 5.292M15 21H3v-1a6 6 0 0112 0v1zm0 0h6v-1a6 6 0 00-9-5.197M13 7a4 4 0 11-8 0 4 4 0 018 0z" />
            </svg>
            Clientes
          </div>
        </a>
        
        <a 
          href="#cotizaciones" 
          class={`block px-4 py-3 rounded-lg transition duration-200 ${activeSection === 'cotizaciones' ? 'bg-amber-500 text-white' : 'hover:bg-neutral-700'}`}
          onclick={() => setActive('cotizaciones')}
        >
          <div class="flex items-center">
            <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
              <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M9 12h6m-6 4h6m2 5H7a2 2 0 01-2-2V5a2 2 0 012-2h5.586a1 1 0 01.707.293l5.414 5.414a1 1 0 01.293.707V19a2 2 0 01-2 2z" />
            </svg>
            Cotizaciones
          </div>
        </a>
      </nav>
      
      <div class="mt-12 pt-6 border-t border-neutral-700">
        <a 
          href="/" 
          target="_blank"
          class="flex items-center px-4 py-3 rounded-lg hover:bg-neutral-700 transition duration-200"
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M10 6H6a2 2 0 00-2 2v10a2 2 0 002 2h10a2 2 0 002-2v-4M14 4h6m0 0v6m0-6L10 14" />
          </svg>
          Ver sitio web
        </a>
        
        <button 
          onclick={handleLogout}
          class="w-full flex items-center px-4 py-3 rounded-lg hover:bg-neutral-700 transition duration-200 text-left"
        >
          <svg xmlns="http://www.w3.org/2000/svg" class="h-5 w-5 mr-3" fill="none" viewBox="0 0 24 24" stroke="currentColor">
            <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M17 16l4-4m0 0l-4-4m4 4H7m6 4v1a3 3 0 01-3 3H6a3 3 0 01-3-3V7a3 3 0 013-3h4a3 3 0 013 3v1" />
          </svg>
          Cerrar sesión
        </button>
      </div>
    </div>
  </div>