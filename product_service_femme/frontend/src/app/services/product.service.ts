import { Injectable } from '@angular/core';
import { HttpClient, HttpParams } from '@angular/common/http';
import { Observable } from 'rxjs';

export interface Product {
  customer_id: string;
  first_name: string;
  last_name: string;
  gender: string;
  age_group: string;
  signup_date: string;
  country: string;
  product_id: string;
  product_name: string;
  category: string;
  quantity: string;
  unit_price: string;
  order_id: string;
  order_date: string;
  order_status: string;
  payment_method: string;
  rating: string;
  review_text: string;
  review_id: string;
  review_date: string;
}

export interface ProductResponse {
  current_page: number;
  data: Product[];
  last_page: number;
  per_page: number;
  total: number;
}

@Injectable({
  providedIn: 'root'
})
export class ProductService {
  private apiUrl = 'http://127.0.0.1:8001/api/products';

  constructor(private http: HttpClient) { }

  getProducts(page: number = 1, search: string = '', category: string = ''): Observable<ProductResponse> {
    let params = new HttpParams().set('page', page.toString());
    
    if (search) {
      params = params.set('search', search);
    }
    if (category) {
      params = params.set('category', category);
    }

    return this.http.get<ProductResponse>(this.apiUrl, { params });
  }

  getProductById(id: string): Observable<Product> {
    return this.http.get<Product>(`${this.apiUrl}/${id}`);
  }

  getCategories(): Observable<string[]> {
    return this.http.get<string[]>(`${this.apiUrl}/categories`);
  }

  getProductImage(product: Product): string {
    const productName = product.product_name.toLowerCase();
    const category = product.category.toLowerCase();
    const gender = product.gender?.toLowerCase() || '';
    
    // ========== ELECTRONICS ==========
    if (category.includes('electronics') || category.includes('électronique')) {
      if (productName.includes('iphone')) {
        return 'https://images.unsplash.com/photo-1592286927505-2fac0b7e0e0b?w=300&h=400&fit=crop';
      } else if (productName.includes('samsung') && productName.includes('phone')) {
        return 'https://images.unsplash.com/photo-1610945415295-d9bbf067e59c?w=300&h=400&fit=crop';
      } else if (productName.includes('headphone') || productName.includes('earphone') || productName.includes('écouteur')) {
        return 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300&h=400&fit=crop';
      } else if (productName.includes('laptop') || productName.includes('ordinateur') || productName.includes('macbook')) {
        return 'https://images.unsplash.com/photo-1496181133206-80ce9b88a853?w=300&h=400&fit=crop';
      } else if (productName.includes('tablet') || productName.includes('ipad') || productName.includes('kindle')) {
        return 'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=300&h=400&fit=crop';
      } else if (productName.includes('watch') || productName.includes('smartwatch')) {
        return 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=300&h=400&fit=crop';
      } else {
        return 'https://images.unsplash.com/photo-1498049794561-7780e7231661?w=300&h=400&fit=crop';
      }
    }
    
    // ========== APPAREL (VÊTEMENTS) ==========
    if (category.includes('apparel') || category.includes('vêtement') || category.includes('clothing')) {
      
      // Vêtements FEMME
      if (gender === 'female' || gender === 'femme' || gender === 'f') {
        if (productName.includes('robe') || productName.includes('dress')) {
          return 'https://images.unsplash.com/photo-1595777457583-95e059d581b8?w=300&h=400&fit=crop';
        } else if (productName.includes('jupe') || productName.includes('skirt')) {
          return 'https://images.unsplash.com/photo-1583496661160-fb5886a0aaaa?w=300&h=400&fit=crop';
        } else if (productName.includes('blouse') || productName.includes('chemise') || productName.includes('shirt') || productName.includes('top')) {
          return 'https://images.unsplash.com/photo-1618932260643-eee4a2f652a6?w=300&h=400&fit=crop';
        } else if (productName.includes('pantalon') || productName.includes('jean') || productName.includes('pants')) {
          return 'https://images.unsplash.com/photo-1541099649105-f69ad21f3246?w=300&h=400&fit=crop';
        } else if (productName.includes('chaussure') || productName.includes('shoe') || productName.includes('heel')) {
          return 'https://images.unsplash.com/photo-1543163521-1bf539c55dd2?w=300&h=400&fit=crop';
        } else if (productName.includes('sac') || productName.includes('bag') || productName.includes('purse')) {
          return 'https://images.unsplash.com/photo-1590874103328-eac38a683ce7?w=300&h=400&fit=crop';
        } else {
          return 'https://images.unsplash.com/photo-1490481651871-ab68de25d43d?w=300&h=400&fit=crop';
        }
      }
      
      // Vêtements HOMME
      if (gender === 'male' || gender === 'homme' || gender === 'm') {
        if (productName.includes('chemise') || productName.includes('shirt')) {
          return 'https://images.unsplash.com/photo-1602810318383-e386cc2a3ccf?w=300&h=400&fit=crop';
        } else if (productName.includes('t-shirt') || productName.includes('tshirt') || productName.includes('tee')) {
          return 'https://images.unsplash.com/photo-1521572163474-6864f9cf17ab?w=300&h=400&fit=crop';
        } else if (productName.includes('pantalon') || productName.includes('jean') || productName.includes('pants')) {
          return 'https://images.unsplash.com/photo-1624378439575-d8705ad7ae80?w=300&h=400&fit=crop';
        } else if (productName.includes('chaussure') || productName.includes('shoe') || productName.includes('sneaker') || productName.includes('nike') || productName.includes('adidas')) {
          return 'https://images.unsplash.com/photo-1542291026-7eec264c27ff?w=300&h=400&fit=crop';
        } else if (productName.includes('veste') || productName.includes('jacket')) {
          return 'https://images.unsplash.com/photo-1551028719-00167b16eac5?w=300&h=400&fit=crop';
        } else if (productName.includes('montre') || productName.includes('watch')) {
          return 'https://images.unsplash.com/photo-1523275335684-37898b6baf30?w=300&h=400&fit=crop';
        } else {
          return 'https://images.unsplash.com/photo-1489987707025-afc232f7ea0f?w=300&h=400&fit=crop';
        }
      }
      
      // Si genre non spécifié
      return 'https://images.unsplash.com/photo-1445205170230-053b83016050?w=300&h=400&fit=crop';
    }
    
    // ========== HOME & KITCHEN ==========
    if (category.includes('home') || category.includes('kitchen') || category.includes('maison') || category.includes('cuisine')) {
      // Produits spécifiques d'abord
      if (productName.includes('aromatherapy') || productName.includes('diffuser') || productName.includes('diffuseur')) {
        return 'https://images.unsplash.com/photo-1608571423902-eed4a5ad8108?w=300&h=400&fit=crop';
      } else if (productName.includes('skincare') || (productName.includes('skin') && productName.includes('set'))) {
        return 'https://images.unsplash.com/photo-1620916566398-39f1143ab7be?w=300&h=400&fit=crop';
      } else if (productName.includes('instant pot') || productName.includes('pot') || productName.includes('cook')) {
        return 'https://images.unsplash.com/photo-1556909114-f6e7ad7d3136?w=300&h=400&fit=crop';
      } else if (productName.includes('dyson') || productName.includes('vacuum') || productName.includes('aspirateur')) {
        return 'https://images.unsplash.com/photo-1558317374-067fb5f30001?w=300&h=400&fit=crop';
      } else if (productName.includes('makeup') || productName.includes('cosmetic') || productName.includes('maquillage') || productName.includes('palette')) {
        return 'https://images.unsplash.com/photo-1596462502278-27bfdc403348?w=300&h=400&fit=crop';
      } else if (productName.includes('pillow') || productName.includes('cushion') || productName.includes('coussin') || productName.includes('oreiller') || productName.includes('throw')) {
        return 'https://images.unsplash.com/photo-1584100936595-c0654b55a2e2?w=300&h=400&fit=crop';
      } else if (productName.includes('yoga') || productName.includes('mat') || productName.includes('tapis')) {
        return 'https://images.unsplash.com/photo-1601925260368-ae2f83cf8b7f?w=300&h=400&fit=crop';
      } else if (productName.includes('resistance') || productName.includes('band') || productName.includes('élastique')) {
        return 'https://images.unsplash.com/photo-1598289431512-b97b0917affc?w=300&h=400&fit=crop';
      } else if (productName.includes('dryer') || productName.includes('hair') || productName.includes('séchoir') || productName.includes('professional')) {
        return 'https://images.unsplash.com/photo-1522338242992-e1a54906a8da?w=300&h=400&fit=crop';
      } else if (productName.includes('cookware') || productName.includes('rose gold') || productName.includes('gold')) {
        return 'https://images.unsplash.com/photo-1585515320310-259814833e62?w=300&h=400&fit=crop';
      } else {
        return 'https://images.unsplash.com/photo-1556911220-bff31c812dba?w=300&h=400&fit=crop';
      }
    }
    
    // ========== BOOKS ==========
    if (category.includes('books') || category.includes('livre')) {
      return 'https://images.unsplash.com/photo-1544947950-fa07a98d237f?w=300&h=200&fit=crop';
    }
    
    // ========== SPORTS ==========
    if (category.includes('sports') || category.includes('sport')) {
      if (productName.includes('fitbit') || productName.includes('tracker')) {
        return 'https://images.unsplash.com/photo-1575311373937-040b8e1fd5b6?w=300&h=400&fit=crop';
      } else {
        return 'https://images.unsplash.com/photo-1461896836934-ffe607ba8211?w=300&h=200&fit=crop';
      }
    }
    
    // ========== TOYS ==========
    if (category.includes('toys') || category.includes('jouet') || productName.includes('lego') || productName.includes('barbie')) {
      return 'https://images.unsplash.com/photo-1515488764276-beab7607c1e6?w=300&h=200&fit=crop';
    }
    
    // ========== IMAGE PAR DÉFAUT ==========
    return 'https://images.unsplash.com/photo-1505740420928-5e560c06d30e?w=300&h=400&fit=crop';
  }
}