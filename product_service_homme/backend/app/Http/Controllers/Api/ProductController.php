<?php

namespace App\Http\Controllers\Api;

use App\Http\Controllers\Controller;
use App\Models\Product;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class ProductController extends Controller
{
    // Liste des produits avec pagination (SANS DOUBLONS)
    public function index(Request $request)
    {
        // Utiliser DISTINCT ON pour PostgreSQL (plus performant)
        $query = DB::table(DB::raw('(SELECT DISTINCT ON (product_id) * FROM products ORDER BY product_id) as products'));

        // Recherche par nom
        if ($request->has('search') && $request->search) {
            $query->where('product_name', 'ILIKE', '%' . $request->search . '%');
        }

        // Filtrer par catégorie
        if ($request->has('category') && $request->category) {
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
        $page = $request->get('page', 1);
        
        // Compter le total
        $total = DB::table(DB::raw('(SELECT DISTINCT ON (product_id) * FROM products) as products'))->count();
        
        // Obtenir les données paginées
        $products = $query->offset(($page - 1) * $perPage)
                         ->limit($perPage)
                         ->get();

        // Formater la réponse comme Laravel Pagination
        $result = [
            'current_page' => (int) $page,
            'data' => $products,
            'first_page_url' => url("/api/products?page=1"),
            'from' => (($page - 1) * $perPage) + 1,
            'last_page' => (int) ceil($total / $perPage),
            'last_page_url' => url("/api/products?page=" . ceil($total / $perPage)),
            'next_page_url' => $page < ceil($total / $perPage) ? url("/api/products?page=" . ($page + 1)) : null,
            'path' => url("/api/products"),
            'per_page' => (int) $perPage,
            'prev_page_url' => $page > 1 ? url("/api/products?page=" . ($page - 1)) : null,
            'to' => min($page * $perPage, $total),
            'total' => $total,
        ];

        return response()->json($result);
    }

    // Détail d'un produit
    public function show($id)
    {
        $product = DB::table('products')
            ->where('product_id', $id)
            ->first();

        if (!$product) {
            return response()->json(['error' => 'Product not found'], 404);
        }

        return response()->json($product);
    }

    // Liste des catégories
    public function categories()
    {
        $categories = DB::table('products')
            ->select('category')
            ->distinct()
            ->orderBy('category')
            ->pluck('category');

        return response()->json($categories);
    }
}