<!-- src/lib/components/auth/LoginForm.svelte -->
<script lang="ts">
    import { authStore } from '$lib/stores/auth.svelte';
    
    let email = $state('');
    let password = $state('');
    let showError = $derived(!!authStore.error);
    
    async function handleSubmit() {
      await authStore.login(email, password);
    }
  </script>
  
  <div class="flex justify-center items-center min-h-screen bg-gray-100">
    <div class="bg-white rounded-xl shadow-lg p-8 w-full max-w-md">
      <h2 class="text-2xl font-bold text-amber-500 text-center mb-6">Iniciar sesión</h2>
      
      <form onsubmit={handleSubmit} class="space-y-6">
        <div class="space-y-2">
          <label for="email" class="block font-semibold text-gray-700">Correo electrónico</label>
          <input 
            id="email"
            type="email" 
            bind:value={email}
            class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-amber-500 focus:border-amber-500" 
            placeholder="Ingresa tu correo"
            required
          />
        </div>
        
        <div class="space-y-2">
          <label for="password" class="block font-semibold text-gray-700">Contraseña</label>
          <input 
            id="password"
            type="password" 
            bind:value={password}
            class="w-full px-4 py-3 rounded-lg border border-gray-300 focus:ring-2 focus:ring-amber-500 focus:border-amber-500" 
            placeholder="Ingresa tu contraseña"
            required
          />
        </div>
        
        {#if showError}
          <div class="bg-red-100 text-red-700 p-3 rounded-lg">
            {authStore.error}
          </div>
        {/if}
        
        <button 
          type="submit" 
          class="w-full bg-amber-500 hover:bg-amber-600 text-white font-semibold py-3 px-4 rounded-lg transition duration-200"
          disabled={authStore.isLoading}
        >
          {#if authStore.isLoading}
            <span class="inline-block animate-spin mr-2">↻</span>
            Cargando...
          {:else}
            Iniciar sesión
          {/if}
        </button>
      </form>
      
      <div class="mt-6 text-center">
        <p class="text-gray-600">
          <a href="#" class="text-amber-500 hover:underline">¿Olvidaste tu contraseña?</a>
        </p>
        <p class="text-gray-600 mt-2">
          <a href="#" class="text-amber-500 hover:underline">¿No tienes cuenta? Regístrate</a>
        </p>
      </div>
    </div>
  </div>
  
  <footer class="fixed bottom-4 left-0 right-0 text-center text-gray-500 text-sm">
    <p>&copy; 2025 DJ Chuy | <a href="mailto:jlopezg@gmail.com" class="text-amber-500 hover:underline">jlopezg@gmail.com</a></p>
  </footer>