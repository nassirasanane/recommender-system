<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Product extends Model
{
    protected $table = 'products';
    public $timestamps = false;
    protected $primaryKey = 'product_id';
    public $incrementing = false;
    protected $keyType = 'string';

    protected $fillable = [
        'customer_id',
        'first_name',
        'last_name',
        'gender',
        'age_group',
        'signup_date',
        'country',
        'product_id',
        'product_name',
        'category',
        'quantity',
        'unit_price',
        'order_id',
        'order_date',
        'order_status',
        'payment_method',
        'rating',
        'review_text',
        'review_id',
        'review_date'
    ];
}