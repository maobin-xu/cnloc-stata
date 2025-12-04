*! version 1.0.0 2025-12-05
* by Maobin Xu

program define cnloc
    version 16.1
    // command setting
    /*
    * get location information
    cnloc location year , mode(1) pre(a_) suf(_b)
    cnloc location , year(2024) mode(1) drop(year adcode id) pre(a_) suf(_b)
    */
    syntax varlist(default=none max=2) [, year(integer 2024) mode(integer 1) drop(string) PREfix(string) SUFfix(string) ]   
	
	// input_data and year variables
	local varnum: word count `varlist' 
	if `varnum'==2 {
		local input_location: word 1 of `varlist' 
		local parsing_year: word 2 of `varlist' 
	}
	else if `varnum'==1 {
		local input_location: word 1 of `varlist' 
		local parsing_year = `year'
	}
	
	// parse address using python cnloc
    if !missing("`input_location'") {
		* parse address
		python: import cnloc
		python: cnloc.parse_address_from_Stata("`input_location'", year="`parsing_year'", mode=`mode', drop="`drop'", prefix="`prefix'", suffix="`suffix'")
    }
end


