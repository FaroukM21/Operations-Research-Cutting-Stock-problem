/*********************************************
 * OPL 20.1.0.0 Model
 * Author: fmohamed
 * Creation Date: 9 avr. 2024 at 13:42:44
 *********************************************/
int NbPatGen = 500;
range patterns = 22..NbPatGen;
range patt =1..NbPatGen;
range widhts = 1..21;
int Pattern[i in 1..21][j in 1..NbPatGen];
int loss[i in 1..NbPatGen];
int SizeRoll[i in 1..21]=...;
int const[i in 1..21]=...;




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
	loss[pat]=100-CurrentWitdth;			
 }
		
}



dvar int+ X[i in patt] ;



minimize sum(i in patt)(loss[i]*X[i]);
subject to{
  forall(i in 1..21) C: sum (j in patt)(Pattern[i][j]*X[j]) >=const[i];
} 

