#Autor: Maksymilian Piotrowski

using Polynomials

#-2^(-23)

p_n=[1, -210.0-2^(-23), 20615.0,-1256850.0,
      53327946.0,-1672280820.0, 40171771630.0, -756111184500.0,          
      11310276995381.0, -135585182899530.0,
      1307535010540395.0,     -10142299865511450.0,
      63030812099294896.0,     -311333643161390640.0,
      1206647803780373360.0,     -3599979517947607200.0,
      8037811822645051776.0,      -12870931245150988800.0,
      13803759753640704000.0,      -8752948036761600000.0,
      2432902008176640000.0]



#funkcja licząca wielomian Wilkinsona w postaci iloczynowej
#x - wartość podstawiona za x w wielomianie
function p(x)
    product = ComplexF64(1)
    for i in reverse(1:20)
        product *= (x - ComplexF64(i))
    end
    return product
end


#funkcja licząca wielomian Wilkinsona w postaci naturalnej
#x - wartość podstawiona za x w wielomianie
function P(x)
    return Polynomial(reverse(p_n))(x)
end

z = (roots(Polynomial(reverse(p_n))))

for k in 1:20
    #print(k,"&",z[k],"&",abs(z[k]-k),"&",abs(P(z[k])),"&",abs(p(z[k])),"\\\\\n\\hline\n")
    print(k,"&",z[k],"&",abs(z[k]-k),"&",round(abs(P(z[k])),sigdigits=7),"&",round(abs(p(z[k])),sigdigits=7),"\\\\\n\\hline\n")
end











