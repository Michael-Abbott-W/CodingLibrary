#This file tests out the Interact package, showing how to use it

#using Pkg
#Pkg.add("Interact")
#Pkg.add("Plots")
using Interact, Plots
plot(rand(10))

#=
@manipulate for x = 1:20, y = (-1,1,2), z = ("happy", "sad")
    vals = 1.0:10.0
    px = plot(rand(x),  title = string(x))
    py = plot(vals.^y, title = string(y))
    if z == "happy"
        pz = plot((vals.-5).^2, title = z)
    elseif z == "sad"
        pz = plot(-(vals.-5).^2, title = z)
    end
    pw = plot(rand(x), title = "Plotw")
    l = @layout [grid(2,2) a{0.15w}]
    plot(px,py,pz,pw)#,size = (1000,800))
end

###putting the manipulated object in an electron window
#Pkg.add("Blink") #if you don't already have blink (the julia wrapper for electron)
#=
using Blink
Blink.AtomShell.install()
w = Window()
ThingYouWantInWindow = @manipulate for ....
    ...
    ...
end
body!(w, ThingYouWantInWindow)
=#



###using it with stata

required packages
Pkg.add("StatFiles")
Pkg.add("DataFrames")
=#
#using StatFiles, DataFrames

#data = Dataframe(load("stataoutput.dta"))
