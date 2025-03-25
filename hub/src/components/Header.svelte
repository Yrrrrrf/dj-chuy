<script>
    import { MusicNoteSimple } from 'phosphor-svelte'; // Example icon
  </script>
  
  <!-- Sticky or static top navigation bar -->
  <nav class="bg-neutral-900 text-white p-4">
    <div class="container mx-auto flex items-center justify-between">
      <!-- Logo / Brand -->
      <div class="flex items-center space-x-2">
        <MusicNoteSimple size={28} />
        <span class="font-bold text-xl">DJCHUY</span>
      </div>
  
      <!-- Simple nav links -->
      <ul class="flex space-x-4">
        <li><a href="/" class="hover:text-orange-500">Inicio</a></li>
        <li><a href="#paquetes" class="hover:text-orange-500">Paquetes</a></li>
        <li><a href="#contact" class="hover:text-orange-500">Contacto</a></li>
      </ul>
    </div>
  </nav>
  