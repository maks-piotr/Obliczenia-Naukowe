#Autor: Maksymilian Piotrowski

# funkcja sprawdzająca czy 1+x>1
# x - liczba Float
function macheps_conditions_met(x)::Bool
    if typeof(x)(1.0) + x > typeof(x)(1.0)
        return true
    end
    return false
end


# funkcja zwracająca macheps dla danego typu
# macheps_type - typ dla którego chcemy wyznaczyć macheps
function get_macheps(macheps_type)
    x = macheps_type(1.0) # poprzedni kandydat na macheps
    while(true)
        y = x / macheps_type(2.0) # rozpatrywany kandydat na macheps
        if macheps_conditions_met(y)
            x = y
        else
            return x
        end
    end
end

for macheps_type in [Float16, Float32, Float64]
    print(string("Iterative ", macheps_type," macheps: ", get_macheps(macheps_type)), "\n")
    print(string("eps(", macheps_type, ") = ", eps(macheps_type), "\n\n"))
end
