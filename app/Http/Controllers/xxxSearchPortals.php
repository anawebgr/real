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
	    $pricemin=$request->input('pricemin');
	    $pricemax=$request->input('pricemax');
	    $availability=$request->input('availability');
	    $sqmmin=$request->input('sqmmin');
	    $sqmmax=$request->input('sqmmax');	
		
		$FinalDataset=array();
		$atypeswheres=array();
		
		//Parse Types to Array
		$anumoftypes=$this->NumOfPortalsTypes($request,'type');
		
		//No filter Type Search All Types
		if ($anumoftypes['count']==0){
		    	                     
									 }
	    else //Search to specify Types
	    {
         foreach ($anumoftypes['data'] as $type){
		                    $atypeswheres[]=$type;
		 	 }
	    }		   
		
		//Parse Locations to Array
		$anumofportals=$this->NumOfPortalsTypes($request,'location');
	
		//No filter Location Search All Portals
	   if ($anumofportals['count']==0){
		   $anumofportals['data']=array('Athens','Chania','Patra','Thessaloniki');
		  
	   }
	  
            foreach ($anumofportals['data'] as $portal){
			if ($portal=='Athens') {
				$AthensData=AthensModel::select();
				$AthensData->where('location', $portal);
				$this->ManageTypes($AthensData,$atypeswheres);
				
				/*foreach ($atypeswheres as $key=>$type){
				if ($key==0)
				         $AthensData->where('type', $type);
				        else
					     $AthensData->orwhere('type', $type);
			    }*/
				$this->checkranges($pricemin,$pricemax,'price',$AthensData);
			    $this->checkranges($sqmmin,$sqmmax,'sqm',$AthensData);
                if ($availability!='')
			    $AthensData->where('availability', $availability);
		
		
		
			$FinalDataset['Athens']=json_encode($AthensData->get());
			
			
			}
			if ($portal=='Chania') {
				$ChaniaData=ChaniaModel::select();
				$ChaniaData->where('location', $portal);
			$this->ManageTypes($ChaniaData,$atypeswheres);
			/*foreach ($atypeswheres as $keych=>$type)
				{
				  	if ($keych==0)
				         $ChaniaData->where('type', $type);
				        else
					     $ChaniaData->orwhere('type', $type);
				
				}*/
				$this->checkranges($pricemin,$pricemax,'price',$ChaniaData);
			    $this->checkranges($sqmmin,$sqmmax,'sqm',$ChaniaData);
                if ($availability!='')
			    $ChaniaData->where('availability', $availability);
			
				
				
				$FinalDataset['Chania']=json_encode($ChaniaData->get());
			}
			if ($portal=='Patra') {
				$PatraData=PatraModel::select();
				$PatraData->where('location', $portal);
				$this->ManageTypes($PatraData,$atypeswheres);
				
				/*foreach ($atypeswheres as $keypat=>$type){
				        				
					if ($keypat==0)
				         $PatraData->where('type', $type);
				        else
					     $PatraData->orwhere('type', $type);
				
				}*/
			    $this->checkranges($pricemin,$pricemax,'price',$PatraData);
			    $this->checkranges($sqmmin,$sqmmax,'sqm',$PatraData);
                if ($availability!='')
			    $PatraData->where('availability', $availability);			
				
				
				
				
				$FinalDataset['Patra']=json_encode($PatraData->get());
			}
			if ($portal=='Thessaloniki') {
			$ThessalonikiData=ThessalonikiModel::select();
				$ThessalonikiData->where('location', $portal);
				$this->ManageTypes($ThessalonikiData,$atypeswheres);
				/*foreach ($atypeswheres as $keythes=>$type)
				       
					   {
						  	if ($keythes==0)
				         $ThessalonikiData->where('type', $type);
				        else
					     $ThessalonikiData->orwhere('type', $type); 
						   
					   }*/
			    $this->checkranges($pricemin,$pricemax,'price',$ThessalonikiData);
			    $this->checkranges($sqmmin,$sqmmax,'sqm',$ThessalonikiData);
                if ($availability!='')
			    $ThessalonikiData->where('availability', $availability);				
				
				
				$FinalDataset['Thessaloniki']=json_encode($ThessalonikiData->get());
			}
		 }
	   	   
	   
	  
Log::info($FinalDataset);

//print_r($FinalDataset);
echo $sfinal=json_encode($FinalDataset,true);


		
	
	}
	

	//Fields with comma values manage 
	// return array with count and values 
	public function NumOfPortalsTypes($request,$field)
	{   
	    $alocinfo=array();
		$location=trim($request->input($field));
		if ($location!='')
		{
		$alocation=explode(',',$location);
		$icnt_locations=count($alocation);
		$alocinfo['count']=$icnt_locations;
		$alocinfo['data']=$alocation;
		}
		else{
		$alocinfo['count']=0;
		$alocinfo['data']=array();
			
		}
	 		
		
		return $alocinfo;
		
	}
	
	
	//Apply where or between in range of values price sqms
	public function checkranges($min,$max,$field,$dataset)
	{
		
		if (($max>$min) && ($max>0 && $min>0)){
		$dataset->whereBetween($field, [$min, $max]);
	
		}
	if (($max==0 && $min>0)){
		$dataset->where($field, '>=',$min);
		echo "sdfsdf";
		}
		
		if (($max>0 && $min==0)){
		$dataset->where($field, '<=',$max);
	
		}	
	}
	
	
	public function ManageTypes($dataset,$atypeswheres)
	{
		foreach ($atypeswheres as $key=>$type){
				if ($key==0)
				         $dataset->where('type', $type);
				        else
					     $dataset->orwhere('type', $type);
			    }
		
		
	}

	
}
