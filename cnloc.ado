*! version 1.1.2 2026-11-20
* by Maobin Xu

program define cnloc
    version 16.1
    // command setting
    /*
    * get location information
    cnloc location year , mode(1) pre(a_) suf(_b)
    cnloc location , year(2025) mode(1) drop(year adcode id) pre(a_) suf(_b) county_short
    */
    syntax varlist(default=none min=1 max=2) [if] [in] [, year(integer 2025) mode(integer 1) drop(string) PREfix(string) SUFfix(string) county_short ]   
	
	// mark sample
	marksample touse, novarlist

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
		python: county_short = True if "`county_short'" != "" else False
		python: cnloc.parse_address_from_Stata("`input_location'", year="`parsing_year'", mode=`mode', drop="`drop'", prefix="`prefix'", suffix="`suffix'", sample="`touse'", county_short=county_short)
    }
end

