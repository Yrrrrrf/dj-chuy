<!-- src/lib/components/home/ServiceCard.svelte -->
<script lang="ts">
    import type { Service, Package } from '$lib/types';
  
    // Props
    let { service, isPackage = false } = $props<{
      service: Service | Package;
      isPackage?: boolean;
    }>();
    
    // Helper to determine if a service is a package
    let serviceAsPackage = $derived(isPackage ? service as Package : null);
    
    // Check if the service has a video
    let hasVideo = $derived(!!service.videoSrc);
    let hasImage = $derived(!!service.imageSrc);
  </script>
  
  <div class="bg-neutral-800 rounded-xl overflow-hidden shadow-xl h-full transition-transform duration-300 hover:-translate-y-2">
    {#if hasVideo}
      <div class="aspect-video w-full overflow-hidden">
        <video 
          class="w-full h-full object-cover"
          autoplay 
          muted 
          loop 
          playsinline
        >
          <source src={service.videoSrc} type="video/mp4">
          <source src={service.videoSrc?.replace('.mp4', '.webm')} type="video/webm">
          Your browser does not support HTML5 video.
        </video>
      </div>
    {:else if hasImage}
      <div class="aspect-video w-full overflow-hidden">
        <img 
          src={service.imageSrc} 
          alt={service.name} 
          class="w-full h-full object-cover"
        />
      </div>
    {/if}
    
    <div class="p-6">
      <h3 class="text-xl font-bold text-white mb-2">{service.name}</h3>
      <p class="text-gray-300 mb-4">{service.description}</p>
      
      {#if isPackage && serviceAsPackage?.price}
        <div class="text-2xl font-bold text-amber-500 mb-4">
          ${serviceAsPackage.price.toLocaleString()}
        </div>
      {/if}
      
      {#if service.features && service.features.length > 0}
        <ul class="text-gray-300 mb-4 space-y-1">
          {#each service.features as feature}
            <li class="flex items-start">
              <span class="text-amber-500 mr-2">•</span>
              <span>{feature}</span>
            </li>
          {/each}
        </ul>
      {/if}
      
      <a 
        href={`https://wa.me/7122443562?text=Hola, me interesa el servicio de ${service.name}`} 
        target="_blank"
        class="inline-block bg-amber-500 hover:bg-amber-600 text-white font-semibold px-6 py-2 rounded-lg transition duration-200"
      >
        Cotizar
      </a>
    </div>
  </div>