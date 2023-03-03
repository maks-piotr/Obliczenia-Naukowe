#Autor: Maksymilian Piotrowski

# funkcja sprawdzająca czy x>0
# x - liczba Float
function eta_conditions_met(x)::Bool
    if x > typeof(x)(0.0)
        return true
    end
    return false
end

# funkcja zwracająca eta dla danego typu
# eta_type - typ dla którego chcemy wyznaczyć eta
function get_eta(eta_type)
    x = eta_type(1.0) # poprzedni kandydat na eta
    while(true)
        y = x / eta_type(2.0) # rozpatrywany kandydat na eta
        if eta_conditions_met(y)
            x = y
        else
            return x
        end
    end
end

for eta_type in [Float16, Float32, Float64]
    print(string("Iterative ", eta_type," eta: ", get_eta(eta_type)), "\n")
    print(string("nextfloat(", eta_type, "(0.0)) = ", nextfloat(eta_type(0.0)), "\n\n"))
end
