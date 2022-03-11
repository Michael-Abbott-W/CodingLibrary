#this is about how to declare constants and use them in functions.

#method 1:

const C = 3

function tryitout(x)
    ans = x + C
    return ans
end
mynum = tryitout(2)



#or method 2:

const C = 3

function tryitout(x,C) #when we define the function with an argument "C" it treats it as
    ans = x + C        #a local variable (local to the function). so when "C" appears in the body
    return ans         #of the function, its treated as the function argument, NOT the constant C.
end

mynum = tryitout(2,C) #this returns 5
mynum = tryitout(2,10) #this reutrns 12.

#= I, for now, recommend the second method. This is because I might re-use functions for other projects,
and it's helpful to know right in the function declaration line which paramters are used in that function.
It's not good to have a function myfunction(x) which has a parameter η hidden somewhere in it. if I use
myfunction() in a new project, and that project doesn't have a constant η, then I'll get an error. And if
the new project happens to have it's own constant η, then the function might give
me a wrong answer and I won't know why.
=#

const α = 4
const β = 5
const γ = 6

const MyCon = (α, β, γ)



const CONS = (α = 1,
                   β = 2,
                   γ = 3)

x = CONS.β


function example((α, β, γ))
    return α + β + γ
end

x = example(α,β,γ)


#= UPDATE. It is inconvenient to use method 2 because I'm passing way more varibles
through every function than I want to. The point of method 2 was to be aware of which
global constants are being used by each function. I can achieve this by adding a comment
to each new function listing the used constants. i.e. METHOD 3:
=#

const C = 3

function tryitout(x) #Constants Used: {C}
    ans = x + C
    return ans
end

mynum = tryitout(2)
