<script>
    // Import icons you may need from 'phosphor-svelte'
    // e.g. import { SpeakerHigh } from 'phosphor-svelte';
  
    // Example data for the package cards
    const packages = [
      {
        title: 'Paquete Simple',
        price: 4499,
        features: [
          'Audio para 30-50 personas',
          '2 cañones de iluminación wash',
          'Cabina',
          'DJ',
          '5 horas de servicio'
        ]
      },
      {
        title: 'Paquete Master',
        price: 6899,
        features: [
          'Audio para 50-150 personas',
          '4 cañones de iluminación wash',
          '1 cámara de humo',
          'DJ',
          '5 horas de servicio'
        ]
      }
    ];
  </script>
  
  <!-- Grid of package cards -->
  <div class="container mx-auto px-4" id="paquetes">
    <h2 class="text-3xl font-bold text-center mb-8">Paquetes</h2>
    <div class="grid gap-8 md:grid-cols-2">
      {#each packages as pkg}
        <div class="bg-white shadow-md rounded-md p-6 text-center">
          <h3 class="text-xl font-semibold mb-2">{pkg.title}</h3>
          <p class="text-2xl font-bold text-orange-600 mb-4">${pkg.price}</p>
          <ul class="text-gray-700 mb-4">
            {#each pkg.features as feature}
              <li class="mb-1">- {feature}</li>
            {/each}
          </ul>
          <button class="bg-orange-500 hover:bg-orange-600 text-white px-4 py-2 rounded">
            Contratar
          </button>
        </div>
      {/each}
    </div>
  </div>
  