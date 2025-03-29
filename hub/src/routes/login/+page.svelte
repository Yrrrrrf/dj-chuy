<!-- src/routes/login/+page.svelte -->
<script lang="ts">
    import { authStore } from '$lib/stores/auth.svelte';
    import { onMount } from 'svelte';
    import { goto } from '$app/navigation';
    import LoginForm from '../../components/auth/LoginForm.svelte';
    
    onMount(() => {
      // Check if already authenticated
      authStore.checkAuth();
      if (authStore.isAuthenticated) {
        goto('/admin');
      }
    });
  </script>
  
  <svelte:head>
    <title>Iniciar sesión - DJ Chuy</title>
  </svelte:head>
  
  <LoginForm />
  