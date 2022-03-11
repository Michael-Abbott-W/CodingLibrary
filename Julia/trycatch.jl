function funky(x)
    return x/x
end

try
    funky("yes")
catch myerr
    println("that ain't right")
end
