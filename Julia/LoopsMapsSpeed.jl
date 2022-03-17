function fn1((x,y))
    return 1/(abs(x)+1) * y/(abs(y)+1)
end

function NMxf(Nx,Ny)
    myarray = zeros(Float64, Nx, Ny)
    for i in 1:Nx
        for j in 1:Ny
            myarray[i,j]= fn1(i,j)
        end
    end
    return myarray
end

function NMyf(Nx,Ny)
    myarray = zeros(Float64, Nx, Ny)
    for j in 1:Ny
        for i in 1:Nx
            myarray[i,j]= fn1(i,j)
        end
    end
    return myarray
end

function Mxf(Nx,Ny)
    myarray = zeros(Float64, Nx, Ny)
    for i in 1:Nx
        myarray[i,:] = map(j -> fn1(i,j),1:Ny)
    end
    return myarray
end

function Myf(Nx,Ny)
    myarray = zeros(Float64, Nx, Ny)
    for j in 1:Ny
        myarray[:,j] = map(i -> fn1(i,j),1:Nx)
    end
    return myarray
end

NMxf(10,5)
NMyf(10,5)
Mxf(10,5)
Myf(10,5)

using BenchmarkTools
function test(Nx,Ny)
    println()
    print("NMxf: ")
    @time NMxf(Nx,Ny)

    print("NMyf: ")
    @time NMyf(Nx,Ny)

    print("Mxf: ")
    @time Mxf(Nx,Ny)

    print("Myf: ")
    @time Myf(Nx,Ny)
end

Pkg.add("BenchmarkTools")

test(10000,10000)
