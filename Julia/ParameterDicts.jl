#Author: Michael Abbott
#Project: library
#Date Last Updated: Oct 19, 2021
#Description:   This is some template code for how to import a CSV Parameter Dictionary

using DataFrames, CSV

#set working directory to project folder
cd("/Users/michaelwalkerabbott/Professional/Grad Year 3/3rdYearPaper")

#set the parlist
parlist = ["alpha", "beta"]

#set each parameter's dictionary as two Julia dictionaries:
#one with (key, value) = (index, values)
#one with (key, value) = (index, labels)
function CreateDictionaries(ParamList)
    Dicts = Dict{String,Any}()
    for par in ParamList
        parFrame = DataFrame(CSV.File("Dictionaries/"*par*"Dict.csv"))
        parFrame[!,:index] .= string.(parFrame[!,:index])
        parFrame[!,:labels] .= string.(parFrame[!,:labels])
        parDict = Dict(zip(parFrame[!,:index],parFrame[!,:values]))
        parlabDict = Dict(zip(parFrame[:,:index],parFrame[:,:labels]))
        merge!(Dicts, Dict(par => parDict))
        merge!(Dicts, Dict(par*"_lab" => parlabDict))
    end
    return Dicts
end

Dicts = CreateDictionaries(parlist)

#Then to output a DataFrame as a CSV
CSV.write("filename.csv", MyDataframe)
