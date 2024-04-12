/*********************************************
 * OPL 20.1.0.0 Model
 * Author: fmohamed
 * Creation Date: 9 avr. 2024 at 13:42:44
 *********************************************/
int NbPatGen = 500;
int NbPat = 50;
range index=1..NbPat;
range index1=NbPat+1..NbPatGen;
range patterns = 22..NbPatGen;
range patt =1..NbPatGen;
range widhts = 1..21;
int Pattern[i in 1..21][j in 1..NbPatGen];
int SizeRoll[i in 1..21]=...;
int const[i in 1..21]=...;
range r=1..21;
float c[i in 1..NbPatGen-NbPat-21];


/*
execute 
{
  var pat;
  for(pat in patterns){
	var width; // one of the 21 widths
	var CurrentWitdth = 0; // Total width used
	for (var j=1 ; j<= 21 ; j++)
	{
	width= Opl.rand(21) + 1; // select one width
	if (Pattern[width][pat]==0) { // check if this width has no yet been selected
		var nbRoll = 1+Opl.rand(9); //number of rolls of this width
		//the max. number of rolls is 9
		if ((CurrentWitdth + nbRoll*SizeRoll[width])<=100) {
		//the current pattern is feasible
		Pattern[width][pat] =nbRoll;
		CurrentWitdth = CurrentWitdth + nbRoll*SizeRoll[width];
	    }
	 }
	}		
 }
		
}
*/
execute 
{
  var pat;
  for(pat in widhts){
	Pattern[pat][pat]=1	
 }
 for(pat in patterns){
	var width; // one of the 21 widths
	var CurrentWitdth = 0; // Total width used
	for (var j=1 ; j<= 21 ; j++)
	{
	width= Opl.rand(21) + 1; // select one width
	if (Pattern[width][pat]==0) { // check if this width has no yet been selected
		var nbRoll = 1+Opl.rand(9); //number of rolls of this width
		//the max. number of rolls is 9
		if ((CurrentWitdth + nbRoll*SizeRoll[width])<=100) {
		//the current pattern is feasible
		Pattern[width][pat] =nbRoll;
		CurrentWitdth = CurrentWitdth + nbRoll*SizeRoll[width];
	    }
	 }
	}		
 }
 
		
}

dvar float+ X[i in patt];
int selected[i in patt];
execute
{
  for(i in index ){
    selected[i]=1;
  }
  for(i in index1){
    selected[i]=0;
  }
  selected[360]=1;
  selected[359]=1;
  selected[310]=1;
  selected[156]=1;
  selected[355]=1;
  selected[213]=1;
  selected[332]=1;
  selected[258]=1;
  selected[281]=1;
  selected[161]=1;
  selected[265]=1;
  selected[230]=1;
  selected[103]=1;
  selected[295]=1;
  selected[154]=1;
  selected[242]=1;
  selected[381]=1;
  selected[427]=1;
  selected[107]=1;
  selected[209]=1;
  selected[65]=1;
  selected[177]=1;
}


minimize sum(i in patt)(selected[i]*X[i]);
subject to{
  forall(i in 1..21) C: sum (j in patt)(selected[j]*Pattern[i][j]*X[j]) >=const[i];
} 

execute{
  var i;
  for(i =1;i<=NbPatGen-NbPat-21;i++){
    c[i]=1
    for(var j in r){
      c[i]=c[i]-C[j].dual*Pattern[j][i];
    } 
}   
}


execute DISPALY{
 var min =0;
 var arg;
 var i;
for(i =1;i<=NbPatGen-NbPat-21;i++){
  
  if(c[i]<min){
    writeln(' the reduced cost is =',c[i],'for var number',i);
    min=c[i];
    arg=i;
  }
}  
	//var pat;
	//if(arg <310) pat = arg + 50; 
	//else pat=arg+52; 	 
   //writeln(' the minimum reduced cost is =',min,'for var number',pat,' found at ',arg);
}