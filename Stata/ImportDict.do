
set more off
clear

cd "Dictionaries"
local ParameterList = "thing1 thing2"
foreach par in `ParameterList'{
	clear
	import delimited `par'Dict.csv, stringcols(1,3)
	describe
	local Num`par' = r(N)
	local ind = index[1]
	local `par'_`ind' = values[1]
	local `par'_`ind'_lab = labels[1]
	local `par'_`ind'_ind = "`ind'"
	local `par'_list = "`par'_`ind'"

	if `Num`par'' > 1{
		forvalues i = 2/`Num`par''{
			local ind = index[`i']
			local `par'_`ind' = values[`i']
			local `par'_`ind'_lab = labels[`i']
			local `par'_`ind'_ind = "`ind'"
			local `par'_list = "``par'_list'"+" "+"`par'_`ind'"
		}
	}
}

