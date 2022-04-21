@inbounds #suppress bounds-checking
#appending a ! at the end of a function name means it modifies the argument directly
    #instead of myvec = myfunc(myvec) we can do myfunc!(myvec)
    



function together(N::Int64)
    ans1::Float64 = 0.0
    for i in 1:N
        ans2::Float64 = 0.0
        for j in 1:N
            ans2 += 0.012
        end
        ans1 += ans2
    end

    return ans1
end

function apart1(N::Int64)
    ans1::Float64 = 0.0
    for i in 1:N
        ans1 += apart2(N)
    end
    return ans1
end

function apart2(N::Int64)
    ans2::Float64 = 0.0
    for j in 1:N
        ans2 += 0.012
    end
    return ans2
end

using BenchmarkTools
function test(N::Int64)
    print("together: ")
    @time together(N)
    print("aprt: ")
    @time apart1(N)
end

test(100000)

@time together(50000)
@time apart1(50000)
