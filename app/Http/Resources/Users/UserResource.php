<?php

namespace App\Http\Resources\Users;

use App\Models\ViewUsers;
use Illuminate\Http\Request;
use Illuminate\Http\Resources\Json\JsonResource;

/**
 * @mixin User
 */
class UserResource extends JsonResource
{
    public function toArray(Request $request): array
    {
        return [
        "id" => $this->id,
        "first_name" => $this->first_name,
        "last_name" => $this->last_name,
        "dob" => $this->dob,
        "gender" => $this->gender,
        "role_id" => $this->role_id,
        "roleName" => $this->roleName,
        "email" => $this->email,
        "phone" => $this->phone,
        "username" => $this->username,
        "status_id" => $this->status_id,
        "statusName" => $this->statusName,
        ];
    }
}
