#Autor: Maksymilian Piotrowski

#implementacja f(x)
function f(x)
    return sqrt(x*x + Float64(1)) - Float64(1)
end
#implementacja g(x)
function g(x)
    return (x*x) / (sqrt(x*x + Float64(1)) + Float64(1))
end

for i in vcat(1:10,[10,20,30,40,50,60,70,80,90,100],[120,140,160,180,200])
    y = Float64(8)^Float64(-i)
    print("\$8^{-", i, "}\$&", f(y), "&",g(y),"\\\\\n","\\hline","\n")
end