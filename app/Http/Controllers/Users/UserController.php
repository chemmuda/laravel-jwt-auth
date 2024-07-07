<?php

namespace App\Http\Controllers\Users;

use App\Http\Controllers\Controller;
use Illuminate\Http\JsonResponse;
use Illuminate\Support\Facades\Auth;
use App\Models\ViewUsers;

class UserController extends Controller
{
    public function show()
    {
        $user = Auth::user();
        $users = ViewUsers::all();
        return response()->json([
            'data' => $users,
            "status" => 1,
          ], 200);
    }
}
