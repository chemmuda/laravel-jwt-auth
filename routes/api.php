<?php

use Illuminate\Support\Facades\Route;
use App\Http\Controllers\Auth\AuthController;
use App\Http\Controllers\Users\UserController;


    Route::controller(AuthController::class)
    ->prefix('v1/auth')
    ->group(function () {
        Route::post('/login', 'login');
        Route::post('/logout', 'logout')->middleware(['auth', 'api']);
    });

Route::middleware('auth:api')->group(function () {
    Route::get('/users', [UserController::class, 'show']);
});


