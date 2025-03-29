// src/lib/types/index.ts

export interface Service {
    id: string;
    name: string;
    description: string;
    price?: number;
    videoSrc?: string;
    imageSrc?: string;
    features?: string[];
  }
  
  export interface Package extends Service {
    capacity: string;
    duration: string;
    includesAnimator: boolean;
    includesSouvenirs: boolean;
    includesCabin?: boolean;
    includesSmokeMachine?: boolean;
    lightsCount?: number;
    extraFeatures?: string[];
  }
  
  export interface Client {
    id: string;
    name: string;
    email: string;
    phone?: string;
    createdAt: Date;
  }
  
  export interface Quote {
    id: string;
    clientId: string;
    serviceId: string;
    price: number;
    eventDate?: Date;
    status: 'pending' | 'accepted' | 'rejected';
    createdAt: Date;
  }
  
  export interface User {
    id: string;
    email: string;
    role: 'admin' | 'client';
  }