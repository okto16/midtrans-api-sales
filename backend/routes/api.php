<?php

use App\Http\Controllers\HandlePaymentNotifController;
use App\Http\Controllers\ProductController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;

Route::get('/user', function (Request $request) {
    return $request->user();
})->middleware('auth:sanctum');

Route::get('transaction-status/{orderId}', [ProductController::class, 'getStatus']);
Route::get('/products', [ProductController::class, 'index']);
Route::post('/midtrans/notif-callback', HandlePaymentNotifController::class);
Route::post('/product/buy', [ProductController::class, 'buy']);