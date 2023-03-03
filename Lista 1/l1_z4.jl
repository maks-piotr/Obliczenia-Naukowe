#Autor: Maksymilian Piotrowski

#funkcja sprawdzająca czy liczba spełnia x*(1/x) != 1
# x - liczba float
function isAcceptable(x)::Bool
    if (Float64(x*Float64(Float64(1)/x)) != Float64(1))
        return true
    end
    return false
end

#funkcja zwracająca najmniejszego x spełniającego isAcceptable()
function findLowestAcceptable()::Float64
    x = Float64(1) #rozpatrywany x
    while (x < 2)
        x = nextfloat(x)
        if (isAcceptable(x))
            return x
        end
    end
    return 0
end

x= findLowestAcceptable()
print(x, "\n")
print(bitstring(x))