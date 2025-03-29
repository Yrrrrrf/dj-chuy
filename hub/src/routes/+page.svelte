<!-- src/routes/+page.svelte -->
<script lang="ts">
    // import Header from '$lib/components/layout/Header.svelte';
    // import Footer from '$lib/components/layout/Footer.svelte';
    // import Hero from '$lib/components/home/Hero.svelte';
    // import ServiceCard from '$lib/components/home/ServiceCard.svelte';
    import { serviceStore } from '$lib/stores/services.svelte';
    import Header from '../components/Header.svelte';
    import Hero from '../components/Hero.svelte';
    import ServiceCard from '../components/home/ServiceCard.svelte';
    import Footer from '../components/layout/Footer.svelte';
  
    // Get services and packages from the store
    let services = $derived(serviceStore.services);
    let packages = $derived(serviceStore.packages);
  </script>
  
  <svelte:head>
    <title>DJ Chuy - DJ & Audio Rental</title>
    <meta name="description" content="DJ Chuy ofrece servicios profesionales de DJ y renta de audio para todo tipo de eventos." />
  </svelte:head>
  
  <div class="flex flex-col min-h-screen">
    <Header dark={true} />
    
    <main class="flex-grow">
      <!-- Hero Section -->
      <Hero />
      
      <!-- Services Section -->
      <section class="py-16 bg-neutral-900" id="servicios">
        <div class="container mx-auto px-4">
          <h2 class="text-3xl font-bold text-amber-500 text-center mb-12">Nuestros Servicios</h2>
          
          <div class="grid grid-cols-1 md:grid-cols-3 gap-8 mb-16">
            {#each services as service}
              <ServiceCard {service} />
            {/each}
          </div>
          
          <h2 class="text-3xl font-bold text-amber-500 text-center mb-12">Paquetes</h2>
          
          <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-4 gap-8">
            {#each packages as pkg}
              <ServiceCard service={pkg} isPackage={true} />
            {/each}
          </div>
        </div>
      </section>
    </main>

    <Footer />
  </div>