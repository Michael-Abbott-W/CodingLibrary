function fn(a,b;c=1)
    return a + b + c
end

fn(2,3,c=5)



#These next two functions demonstrate how to use a tuple as keyword argument.
function MyDefTuple()
    DefGrid = [0.0,1.2,3.5,4.1]
    DefN = length(DefGrid)
    return DefGrid,DefN
end

function fn2(a;b=2,cdTup=MyDefTuple())
    c,d = cdTup
    return a + b + d
end

fn2(1)
