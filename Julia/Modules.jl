#This file demonstrates how to use modules

#NOTICE THROUGHOUT: using is a more specific form of import. import A makes
#everything in A available through namespace referencing (e.g. A.thingInA)
#"using A" first does "import A" if it's not already done, and then it looks
#for the "export" list in A, and makes all of the items in that export list
#available to reference WITHOUT the "A." prefix.

#(1)#######################################################
    #Let's start with a simple module
    module A
        #inside this I can define functions, structs, etc
        function Func(xvar,yvar)
            return xvar + yvar
        end

        x = 1.0
        y = 2.0
    end  # module First

    #try to use stuff from First
    try
        println(string(Func(x,y)))
    catch myerr
        println("Error (1)")
    end

    #try to use stuff from first, but specify the namespace
    println("Real way: "*string(A.Func(A.x,A.y)))

    #modules in the global scope are automatically "imported", which means that
    #their contents are available, but ONLY if you specify the module namespace

    import .A
#(2)################################################

    #Now let's define a second Module that will use things from module A
    module B
        function Funky()
            return A.Func(A.x,A.y)
        end
    end

    #Try to use Funky from B, correctly using the B namespace
    try
        println(string(B.Funky()))
    catch myerr
        println("Error (2)")
    end

    #The Problem above is that when make a new module, (B), it has a new scope
    #of it's own. so it cannot "see" module A.
    #Try again with module C, this time importing A into it.
    module C
        import ..A #".." means A and C are in the same scope
        function Funky()
            return A.Func(A.x,A.y)
        end
    end

    #Try to use Funky from C, correctly using the B namespace
    println("Now with C: "*string(C.Funky()))

#(3)########################################################
    #Now we look at nested modules
    #first try something that seems natural
    module D
        good = 0.5
        #now start a nested module
        module E
            gooder = 10*good #referencing good from D
        end
    end
    #This won't work because E can't "see" good

    module D
        good = 0.5
        #now start a nested module
        module E
            gooder = 10*D.good #referencing good from D
        end
    end
    #This Won't work because E can't even see D

    module D
        good = 0.5
        #now start a nested module
        module E
            import D: good
            gooder = 10*D.good #referencing good from D
        end
    end
    #Even this won't work because it can't find D in the current scope

    module D
        good = 0.5
        #now start a nested module
        module E
            import ...D
            gooder = 10*D.good #referencing good from D
        end
    end

#(4)###############################################################
#some more nesting

module M1
    module M2
        module M3
            a = 1
        end
        b=M3.a + 1
    end
    c = M2.b + 1
end
# module M1

M1.c
M1.M2.b


#(5)##########################################################
    module fancy
        export SpeakToMe
        function SpeakToMe()
            println("My Word")
        end
    end

    module crude
        export SpeakToMe
        function SpeakToMe()
            println("aww shit")
        end
    end

    using .fancy
    SpeakToMe()
    using .crude #This will not override the namespace of .fancy
    SpeakToMe()
