// src/lib/stores/auth.svelte.ts
import { goto } from '$app/navigation';
import type { User } from '$lib/types';

class AuthStore {
  // State with runes
  currentUser = $state<User | null>(null);
  isAuthenticated = $derived(!!this.currentUser);
  isAdmin = $derived(this.currentUser?.role === 'admin');
  isLoading = $state(false);
  error = $state<string | null>(null);
  
  async login(email: string, password: string) {
    this.isLoading = true;
    this.error = null;
    
    try {
      if (email === 'jlopezg034@gmail.com' && password === '12345678') {
        this.currentUser = {
          id: '1',
          email: email,
          role: 'admin'
        };
        
        // Store in localStorage for session persistence
        localStorage.setItem('user', JSON.stringify(this.currentUser));
        
        console.log('Login successful:', this.currentUser);
        
        // Try a more direct approach to navigation
        // Option 1: Use window.location for a full page navigation
        window.location.href = '/admin';
        
        // Option 2: If above doesn't work, try with a slight delay
        // setTimeout(() => goto('/admin'), 100);
        
        return true;
      } else {
        throw new Error('Credenciales incorrectas. Intenta de nuevo.');
      }
    } catch (error) {
      this.error = error instanceof Error ? error.message : 'Error al iniciar sesión';
      return false;
    } finally {
      this.isLoading = false;
    }
  }
  
  logout() {
    this.currentUser = null;
    localStorage.removeItem('user');
    goto('/login');
  }
  
  checkAuth() {
    const userJson = localStorage.getItem('user');
    if (userJson) {
      try {
        this.currentUser = JSON.parse(userJson);
      } catch (e) {
        this.logout();
      }
    }
  }
}

// Create singleton instance
export const authStore = new AuthStore();