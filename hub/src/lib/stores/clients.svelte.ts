// src/lib/stores/clients.svelte.ts
import type { Client, Quote } from '$lib/types';

class ClientStore {
  clients = $state<Client[]>([
    {
      id: '1',
      name: 'Juan Pérez',
      email: 'juan@gmail.com',
      phone: '7121234567',
      createdAt: new Date('2025-01-15')
    }
  ]);

  quotes = $state<Quote[]>([
    {
      id: '1',
      clientId: '1',
      serviceId: '1',
      price: 500,
      status: 'pending',
      createdAt: new Date('2025-02-10')
    }
  ]);

  // Methods for admin panel
  addClient(client: Omit<Client, 'id' | 'createdAt'>) {
    const newClient: Client = {
      ...client,
      id: crypto.randomUUID(),
      createdAt: new Date()
    };
    this.clients = [...this.clients, newClient];
    return newClient;
  }

  updateClient(id: string, updatedClient: Partial<Client>) {
    this.clients = this.clients.map(client => 
      client.id === id ? { ...client, ...updatedClient } : client
    );
  }

  deleteClient(id: string) {
    this.clients = this.clients.filter(client => client.id !== id);
    // Also delete associated quotes
    this.quotes = this.quotes.filter(quote => quote.clientId !== id);
  }

  // Quote management
  addQuote(quote: Omit<Quote, 'id' | 'createdAt'>) {
    const newQuote: Quote = {
      ...quote,
      id: crypto.randomUUID(),
      createdAt: new Date()
    };
    this.quotes = [...this.quotes, newQuote];
    return newQuote;
  }

  updateQuote(id: string, updatedQuote: Partial<Quote>) {
    this.quotes = this.quotes.map(quote => 
      quote.id === id ? { ...quote, ...updatedQuote } : quote
    );
  }

  deleteQuote(id: string) {
    this.quotes = this.quotes.filter(quote => quote.id !== id);
  }
  
  // Get quotes by client
  getClientQuotes(clientId: string): Quote[] {
    return this.quotes.filter(quote => quote.clientId === clientId);
  }
}

// Create singleton instance
export const clientStore = new ClientStore();