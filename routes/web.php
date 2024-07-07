<?php
use Illuminate\Support\Facades\Route;

Route::get('/', function () {
    return response()->json([
        'application' => 'MyPlayc API',
        'version' => env('APP_VERSION'),
        'developers' => '@myPlayc',
        'developer_link' => 'https://atmyplayc.com'
    ]);
});
