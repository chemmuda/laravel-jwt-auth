<?php

namespace App\Http\Controllers\Auth;

use App\Models\ViewUsers;
use Illuminate\Http\Response;
use App\Actions\Users\CreateUser;
use Illuminate\Http\JsonResponse;
use Tymon\JWTAuth\Facades\JWTAuth;
use App\Http\Controllers\Controller;
use Illuminate\Support\Facades\Auth;
use App\Http\Requests\Auth\LoginRequest;
use App\Http\Resources\Users\UserResource;
use App\Http\Requests\Auth\RegisterRequest;

class AuthController extends Controller
{
    public function login(LoginRequest $request): JsonResponse
    {
        $token = JWTAuth::attempt([
            "email" => request()->input("email"),
            "password" => request()->input("password"),
        ]);

        if (!$token) {
            // try with email and password
            $token = JWTAuth::attempt([
                "email" => request()->input("email"),
                "password" => request()->input("password"),
            ]);

            if (!$token) {
                return response()->json(["user" => [], "status" => 0, "message" => "Invalid credentials."], 401);
            }
        }

        $user = Auth::user();

        if ($user->status_id != 1) {
            return response()->json(["user" => [], "status" => 0, "message" => "Your account is not activated."], 401);
        }

        $viewUser = ViewUsers::where('id', $user->id)->first();

        return response()->json([
            'user'         => $viewUser,
            'access_token' => $token,
        ]);
    }

    public function logout(): Response
    {
        Auth::logout();

        return response()->noContent();
    }

    public function refresh(): JsonResponse
    {
        $token = Auth::refresh();

        return response()->json([
            'access_token' => $token,
        ]);
    }
}
