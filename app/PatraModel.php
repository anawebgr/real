<?php

namespace App;

use Illuminate\Database\Eloquent\Model;

class PatraModel extends Model
{
    //
	protected $connection = 'patradb';
	public $table = "spinview";
}
