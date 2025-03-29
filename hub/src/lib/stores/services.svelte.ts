// src/lib/stores/services.svelte.ts
import type { Service, Package } from '$lib/types';

class ServiceStore {
  services = $state<Service[]>([
    {
      id: '1',
      name: 'DJ Profesional',
      description: 'La mejor selección musical para hacer de tu evento algo inolvidable.',
      videoSrc: '/videos/djversatil.mp4'
    },
    {
      id: '2',
      name: 'Renta de Audio',
      description: 'Sonido de alta fidelidad para eventos de cualquier tamaño.',
      videoSrc: '/videos/audiochuy.mp4'
    },
    {
      id: '3',
      name: 'Iluminación',
      description: 'Efectos visuales impresionantes para una experiencia única.',
      videoSrc: '/videos/iluminacion.mp4'
    }
  ]);

  packages = $state<Package[]>([
    {
      id: '4',
      name: 'Paquete Simple',
      description: 'Audio básico para eventos pequeños',
      price: 4499,
      capacity: '30-50 personas',
      duration: '5 horas',
      includesAnimator: true,
      includesSouvenirs: true,
      imageSrc: '/images/Simple.jpeg',
      features: ['Audio para 30-50 personas', 'DJ', 'Animador', 'Subenirs', 'Servicio de 5 horas']
    },
    {
      id: '5',
      name: 'Paquete Master',
      description: 'Audio y efectos para eventos medianos',
      price: 6899,
      capacity: '50-150 personas',
      duration: '5 horas',
      includesAnimator: true,
      includesSouvenirs: true,
      includesCabin: true,
      includesSmokeMachine: true,
      lightsCount: 4,
      imageSrc: '/images/Master.jpeg',
      features: [
        'Audio para 50-150 personas',
        'DJ',
        'Animador',
        'Subenirs',
        'Cabina',
        'Cámara de humo',
        '4 cañones de iluminación wash profesional',
        'Servicio de 5 horas'
      ]
    },
    {
      id: '6',
      name: 'Paquete Gold',
      description: 'Audio y efectos premium para eventos grandes',
      price: 12899,
      capacity: '150-300 personas',
      duration: '5 horas',
      includesAnimator: true,
      includesSouvenirs: true,
      includesCabin: true,
      includesSmokeMachine: true,
      lightsCount: 5,
      videoSrc: '/videos/Gold.mp4',
      features: [
        'Audio para 150-300 personas',
        'DJ',
        'Animador',
        'Subenirs',
        'Cabina',
        'Pantalla gigante 6 metros cuadrados',
        'Cámara de humo',
        '5 cañones de iluminación wash profesional',
        '1 Arlequín',
        '2 Personajes (cabezones)',
        'Servicio de 5 horas'
      ]
    },
    {
      id: '7',
      name: 'Paquete Plus',
      description: 'Experiencia completa para eventos premium',
      price: 16899,
      capacity: '300-500 personas',
      duration: '5 horas',
      includesAnimator: true,
      includesSouvenirs: true,
      includesCabin: true,
      includesSmokeMachine: true,
      lightsCount: 5,
      videoSrc: '/videos/plus.mp4',
      features: [
        'Audio para 300-500 personas',
        'DJ',
        'Animador',
        'Subenirs',
        'Cabina',
        'Pantalla gigante 6 metros cuadrados',
        '2 TV 55 pulgadas',
        'Cámara de humo',
        '5 cañones de iluminación wash profesional',
        'Iluminación Beans',
        '1 robot LED, show permanente',
        '1 Arlequín',
        '2 Personajes (cabezones)',
        'Servicio de 5 horas'
      ]
    }
  ]);

  // Methods for admin panel
  addService(service: Service) {
    this.services = [...this.services, { ...service, id: crypto.randomUUID() }];
  }

  updateService(id: string, updatedService: Partial<Service>) {
    this.services = this.services.map(service => 
      service.id === id ? { ...service, ...updatedService } : service
    );
  }

  deleteService(id: string) {
    this.services = this.services.filter(service => service.id !== id);
  }

  // Similar methods for packages
  addPackage(pkg: Package) {
    this.packages = [...this.packages, { ...pkg, id: crypto.randomUUID() }];
  }

  updatePackage(id: string, updatedPackage: Partial<Package>) {
    this.packages = this.packages.map(pkg => 
      pkg.id === id ? { ...pkg, ...updatedPackage } : pkg
    );
  }

  deletePackage(id: string) {
    this.packages = this.packages.filter(pkg => pkg.id !== id);
  }
}

// Create singleton instance
export const serviceStore = new ServiceStore();