<?php

namespace App\Http\Controllers;

use Illuminate\Database\Eloquent\Builder;
use Illuminate\Support\Facades\DB;
use Illuminate\Http\Request;
use App\AthensModel;
use App\ChaniaModel;
use App\ThessalonikiModel;
use App\PatraModel;
use Illuminate\Support\Facades\Log;


class SearchPortals extends Controller
{
	//
	public function Search(Request $request)

	{
		//Grab Data from request
		$pricemin = $request->input('pricemin');
		$pricemax = $request->input('pricemax');
		$availability = $request->input('availability');
		$sqmmin = $request->input('sqmmin');
		$sqmmax = $request->input('sqmmax');

		$FinalDataset = array();
		$atypeswheres = array();

		//Parse Types to Array
		$anumoftypes = $this->NumOfPortalsTypes($request, 'type');

		//No filter Type Search All Types
		if ($anumoftypes['count'] == 0) {
			$anumoftypes['data']=array('Apartment','Loft','Maisonette','Studio');
		}
			foreach ($anumoftypes['data'] as $type) {
				$atypeswheres[] = $type;
			}
		

		//Parse Locations to Array
		$anumofportals = $this->NumOfPortalsTypes($request, 'location');

		//No filter Location Search All Portals
		if ($anumofportals['count'] == 0) {
			$anumofportals['data'] = array('Athens', 'Chania', 'Patra', 'Thessaloniki');
		}


		//Loop on selected portals load models and apply criteria return a common dataset FinalDataset
		//with results
		foreach ($anumofportals['data'] as $portal) {
			if ($portal == 'Athens') {
		        //Load Model
				$AthensData = AthensModel::select();
		        //Apply location filter
				$AthensData->where('location', $portal);

				//Apply price filter
				$this->checkranges($pricemin, $pricemax, 'price', $AthensData);
				//Apply sqm filter
				$this->checkranges($sqmmin, $sqmmax, 'sqm', $AthensData);
				//Apply availability filter
				if ($availability != '-')
					$AthensData->where('availability', $availability);
				
								//Apply type filter
				$this->ManageTypes($AthensData, $atypeswheres);
				
				
//echo $AthensData->toSql();
			


                //Attach this portal resutls to common response dataset
				$FinalDataset['Athens'] = json_encode($AthensData->get());
			}
			if ($portal == 'Chania') {
				$ChaniaData = ChaniaModel::select();
				$ChaniaData->where('location',$portal);
		
				$this->checkranges($pricemin, $pricemax, 'price', $ChaniaData);
				$this->checkranges($sqmmin, $sqmmax, 'sqm', $ChaniaData);
				if ($availability != '-')
					$ChaniaData->where('availability', $availability);

		        $this->ManageTypes($ChaniaData, $atypeswheres);

				$FinalDataset['Chania'] = json_encode($ChaniaData->get());
			}
			if ($portal == 'Patra') {
				$PatraData = PatraModel::select();
				$PatraData->where('location', $portal);
				
				$this->checkranges($pricemin, $pricemax, 'price', $PatraData);
				$this->checkranges($sqmmin, $sqmmax, 'sqm', $PatraData);
				if ($availability != '-')
					$PatraData->where('availability', $availability);



                $this->ManageTypes($PatraData, $atypeswheres);
				$FinalDataset['Patra'] = json_encode($PatraData->get());
			}
			if ($portal == 'Thessaloniki') {
				$ThessalonikiData = ThessalonikiModel::select();
				$ThessalonikiData->where('location', $portal);
				
				$this->checkranges($pricemin, $pricemax, 'price', $ThessalonikiData);
				$this->checkranges($sqmmin, $sqmmax, 'sqm', $ThessalonikiData);
				if ($availability != '-')
					$ThessalonikiData->where('availability', $availability);

                $this->ManageTypes($ThessalonikiData, $atypeswheres);
				$FinalDataset['Thessaloniki'] = json_encode($ThessalonikiData->get());
			}
		}



		Log::info($FinalDataset);

		//The final response as json for ajax consume
		echo $sfinal = json_encode($FinalDataset, true);
	}


	//Fields with comma values manage 
	// return array with count and values array('count'=>0,''data'=>'sample1,sample2')
	public function NumOfPortalsTypes($request, $field)
	{
		$alocinfo = array();
		$location = trim($request->input($field));
		if ($location != '') {
			$alocation = explode(',', $location);
			$icnt_locations = count($alocation);
			$alocinfo['count'] = $icnt_locations;
			$alocinfo['data'] = $alocation;
		} else {
			$alocinfo['count'] = 0;
			$alocinfo['data'] = array();
		}


		return $alocinfo;
	}


	//Apply where or wherebetween in range of values price,sqm
	public function checkranges($min, $max, $field, $dataset)
	{

		if (($max > $min) && ($max > 0 && $min > 0)) {
			$dataset->whereBetween($field, [$min, $max]);
		}
		if (($max == 0 && $min > 0)) {
			$dataset->where($field, '>=', $min);
			
		}

		if (($max > 0 && $min == 0)) {
			$dataset->where($field, '<=', $max);
		}
	}


	public function ManageTypes($dataset, $atypeswheres)
	{
	
			
		$dataset->where(function ($dataset)  use($atypeswheres){
		foreach ($atypeswheres as $key1 => $type1) {
			if ($key1==0)
					$dataset->whereRaw("find_in_set('".$type1."',type)");
			if ($key1>0)
				$dataset->orwhereRaw("find_in_set('".$type1."',type)");
		}	
			
		});	
			
			
		
	}
}
