#Autor: Maksymilian Piotrowski

#funkcja wyświetlająca co piątą wartość ciągu p[n]
#typ - typ zmiennoprzecinkowy na którym mają być wykonywane obliczenia
#beginning - n od którego zaczynamy obliczać p[n]
#ending - n na którym kończymy obliczać p[n]
#start_val - wartość p[beginning-1]
function print_pn(typ,beginning::Int,ending::Int,start_val)
    p0 = typ(start_val)
    r = typ(3)
    p = [typ(0) for _ in 1:40]
    p[beginning] = p0 + r*p0*(1 - p0)
    for i in beginning+1:ending
        p[i] = p[i-1] + r*p[i-1]*(typ(1)-p[i-1])
        if (i % 5 == 0)
            print(i,"&",p[i],"\\\\\n\\hline\n")
        end
    end
end

for typ in [Float32, Float64]
    print(0,"&",0.01,"\\\\\n\\hline\n")
    print_pn(typ,1,40,typ(0.01))
    print("\n\n\n")
end

print(0,"&",0.01,"\\\\\n\\hline\n")
print_pn(Float32,1,9,Float32(0.01))
print(0,"&",0.722,"\\\\\n\\hline\n")
print_pn(Float32,11,40,Float32(0.722))