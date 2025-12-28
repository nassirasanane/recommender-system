<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProductController extends Controller
{
    // Liste des produits FEMME avec pagination
    public function index(Request $request)
    {
        // Catégories typiquement féminines
        $femaleCategories = ['Home & Kitchen', 'Books'];
        
        // Grouper par product_id pour éviter les doublons
        $query = Product::select(
                'product_id', 
                'product_name', 
                'category', 
                'unit_price',
                'gender'
            )
            ->selectRaw('CAST(AVG(CAST(rating AS FLOAT)) AS INTEGER) as rating')
            ->selectRaw('SUM(CAST(quantity AS INTEGER)) as quantity')
            ->selectRaw('MAX(order_status) as order_status')
            ->whereIn('category', $femaleCategories)  // ⭐ FILTRE PAR CATÉGORIES FEMME
            ->groupBy('product_id', 'product_name', 'category', 'unit_price', 'gender');
        
        // Recherche par nom
        if ($request->has('search')) {
            $query->where('product_name', 'ILIKE', '%' . $request->search . '%');
        }
        
        // Filtrer par catégorie
        if ($request->has('category') && $request->category != '') {
            $query->where('category', $request->category);
        }
        
        // Filtrer par prix min/max
        if ($request->has('min_price')) {
            $query->where('unit_price', '>=', $request->min_price);
        }
        if ($request->has('max_price')) {
            $query->where('unit_price', '<=', $request->max_price);
        }
        
        // Tri
        $sortBy = $request->get('sort_by', 'product_id');
        $sortOrder = $request->get('sort_order', 'asc');
        $query->orderBy($sortBy, $sortOrder);
        
        // Pagination
        $perPage = $request->get('per_page', 12);
        $products = $query->paginate($perPage);
        
        return response()->json($products);
    }
    
    // Détail d'un produit
    public function show($id)
    {
        $femaleCategories = ['Home & Kitchen', 'Books'];
        
        $product = Product::where('product_id', $id)
                         ->whereIn('category', $femaleCategories)  // ⭐ FILTRE PAR CATÉGORIES
                         ->first();
        
        if (!$product) {
            return response()->json(['error' => 'Product not found'], 404);
        }
        
        return response()->json($product);
    }
    
    // Liste des catégories (seulement produits femme)
    public function categories()
    {
        $femaleCategories = ['Home & Kitchen', 'Books'];
        
        $categories = Product::select('category')
            ->whereIn('category', $femaleCategories)  // ⭐ FILTRE PAR CATÉGORIES
            ->distinct()
            ->orderBy('category')
            ->pluck('category');
        
        return response()->json($categories);
    }
}