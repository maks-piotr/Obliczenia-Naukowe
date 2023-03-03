#Autor: Maksymilian Piotrowski

#implementcja f(x)
function f(x)
    return sin(x) + cos(Float64(3)*x)
end

#implementacja przybliżonej pochodnej f(x)
function fprimtilda(x, h)
    return (f(x + h) - f(x))/h
end

#pochodna f(x)
function fprim(x)
    return cos(x) - Float64(3)*sin(Float64(3)*x)
end

for i in 1:54
    y = Float64(2)^Float64(-i) # argument h dla fprimtilda
    #print("\$2^{-",i,"}\$&",fprimtilda(Float64(1),y),"&", abs(fprimtilda(Float64(1),y)-fprim(Float64(1))),"\\\\\n","\\hline","\n")
    print(i,",",fprimtilda(Float64(1),y),",", abs(fprimtilda(Float64(1),y)-fprim(Float64(1))),"\n")
end