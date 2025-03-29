<!-- src/lib/components/layout/Header.svelte -->
<script lang="ts">
  import { authStore } from '$lib/stores/auth.svelte';
  
  // Props
  let { dark = false } = $props<{
    dark?: boolean;
  }>();
  
  let showMenu = $state(false);
  
  function toggleMenu() {
    showMenu = !showMenu;
  }
</script>

<nav class={`w-full py-4 ${dark ? 'bg-neutral-900 text-white' : 'bg-white text-neutral-900'}`}>
  <div class="container mx-auto px-4 flex items-center justify-between">
    <!-- Logo -->
    <a href="/" class="flex items-center space-x-2">
      <img src="/djchuy.png" alt="DJ Chuy" class="h-12 w-12 rounded-full">
      <span class="text-xl font-bold">DJ Chuy</span>
    </a>

    <!-- Mobile menu button -->
    <button 
      class="md:hidden focus:outline-none"
      onclick={toggleMenu}
      aria-label="Toggle menu"
    >
      <svg xmlns="http://www.w3.org/2000/svg" class="h-6 w-6" fill="none" viewBox="0 0 24 24" stroke="currentColor">
        <path stroke-linecap="round" stroke-linejoin="round" stroke-width="2" d="M4 6h16M4 12h16M4 18h16" />
      </svg>
    </button>
    
    <!-- Desktop Navigation -->
    <div class="hidden md:flex items-center space-x-6">
      <a href="/" class="hover:text-amber-500 transition duration-200">Inicio</a>
      <a href="/#servicios" class="hover:text-amber-500 transition duration-200">Servicios</a>
      <a href="/#contacto" class="hover:text-amber-500 transition duration-200">Contacto</a>
      
      {#if authStore.isAuthenticated}
        <a href="/admin" class="hover:text-amber-500 transition duration-200">Admin</a>
        <button 
          onclick={() => authStore.logout()}
          class="bg-amber-500 hover:bg-amber-600 text-white px-4 py-2 rounded-lg transition duration-200"
        >
          Cerrar sesión
        </button>
      {:else}
        <a 
          href="/login" 
          class="bg-amber-500 hover:bg-amber-600 text-white px-4 py-2 rounded-lg transition duration-200"
        >
          Iniciar sesión
        </a>
      {/if}
    </div>
  </div>
  
  <!-- Mobile menu -->
  {#if showMenu}
    <div class="md:hidden bg-neutral-800 text-white mt-4 py-4">
      <div class="container mx-auto px-4 flex flex-col space-y-4">
        <a href="/" class="block px-2 py-1 hover:text-amber-500 transition duration-200">Inicio</a>
        <a href="/#servicios" class="block px-2 py-1 hover:text-amber-500 transition duration-200">Servicios</a>
        <a href="/#contacto" class="block px-2 py-1 hover:text-amber-500 transition duration-200">Contacto</a>
        
        {#if authStore.isAuthenticated}
          <a href="/admin" class="block px-2 py-1 hover:text-amber-500 transition duration-200">Admin</a>
          <button 
            onclick={() => authStore.logout()}
            class="bg-amber-500 hover:bg-amber-600 text-white px-4 py-2 rounded-lg transition duration-200"
          >
            Cerrar sesión
          </button>
        {:else}
          <a 
            href="/login" 
            class="bg-amber-500 hover:bg-amber-600 text-white px-4 py-2 rounded-lg transition duration-200"
          >
            Iniciar sesión
          </a>
        {/if}
      </div>
    </div>
  {/if}
</nav>