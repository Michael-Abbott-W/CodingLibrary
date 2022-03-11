#Lets start by making a module called First
module First
    #inside this I can define functions, structs, etc
    function Func(x,y)
        return x + y
    end

    struct MyStruct
        a
        b
    end

    Thing = MyStruct(1.0,2.0)
end  # module First

#define a similar second module with it's own struct
module Second
    function Func(x,y)
        return x-y
    end

    struct MyStruct
        a
        b
    end

    Thing = MyStruct(100,8)
end  # module First
