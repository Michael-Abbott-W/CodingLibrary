function colorplot(Nb,Nc)
    plot1 = plot()
    rootcolors = distinguishable_colors(Nc, [RGB(1,1,1), RGB(0,0,0)],
                dropseed=true,
                lchoices=range(30, stop=40, length=3))
    rootcolors = map(col -> [float(red(col)), float(green(col)), float(blue(col))], rootcolors)

    for i in 1:Nc
        coloradder = ([1.0,1.0,1.0] .- rootcolors[i]) ./ (Nb+2)
        for j in 1:Nb
            mycolor = rootcolors[i] .+ j .* coloradder
            red = floor(Int,255*mycolor[1])
            green = floor(Int,255*mycolor[2])
            blue = floor(Int,255*mycolor[3])
            plot!(plot1, [0,10],[i + j/Nb,i + j/Nb],
                  color = RGB(red/255,green/255,blue/255))
        end
    end
    return plot1
end

colorplot(10,6)
