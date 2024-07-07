<?php

namespace App\Http\Middleware;

use Closure;
use Exception;
use Illuminate\Http\Request;
use Tymon\JWTAuth\Facades\JWTAuth;
use Tymon\JWTAuth\Exceptions\TokenExpiredException;
use Tymon\JWTAuth\Exceptions\TokenInvalidException;

class JwtMiddleware
{
    /**
     * Handle an incoming request.
     *
     * @param  \Closure(\Illuminate\Http\Request): (\Symfony\Component\HttpFoundation\Response)  $next
     */
    public function handle(Request $request, Closure $next)
    {
        try {
            $user = JWTAuth::parseToken()->authenticate();
        } catch (Exception $e) {
            if ($e instanceof TokenInvalidException) {
                return response()->json(['status' => 0, 'message' => 'Authorization token is invalid'], 401);
            } else if ($e instanceof TokenExpiredException) {
                return response()->json(['status' => 0, 'message' => 'Authorization token has expired'], 401);
            } else {
                return response()->json(['status' => 0, 'message' => 'Authorization token not found'], 401);
            }
        }

        return $next($request);
    }
}
