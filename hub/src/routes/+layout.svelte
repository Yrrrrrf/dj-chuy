<!-- src/routes/+layout.svelte -->
<script lang="ts">
	import '../app.css';
	import { authStore } from '$lib/stores/auth.svelte';
	import { onMount } from 'svelte';

	// Get the children slot
	let { children } = $props();

	// Check authentication on mount
	onMount(() => {
		authStore.checkAuth();
	});
</script>

{@render children()}