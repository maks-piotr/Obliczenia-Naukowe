#Autor: Maksymilian Piotrowski

# funkcja sprawdzająca czy !isinf(x)
# x - liczba Float
function MAX_conditions_met(x)::Bool
    if !isinf(x)
        return true
    end
    return false
end

# funkcja zwracająca MAX dla danego typu
# MAX_type - typ dla którego chcemy wyznaczyć MAX
function get_MAX(MAX_type)
    x = MAX_type(1.0) # poprzedni kandydat na MAX
    while(true)
        y = x * MAX_type(2.0) # rozpatrywany kandydat na MAX
        if MAX_conditions_met(y)
            x = y
        else
            break
        end
    end
    x_iterator = x / MAX_type(2.0) # o ile zwiększamy x w kroku
    while (x_iterator > MAX_type(0.0))
        y = x + x_iterator
        if MAX_conditions_met(y)
            x = y
        end
        x_iterator = x_iterator / MAX_type(2.0)
    end
    return x
end

for MAX_type in [Float16, Float32, Float64]
    print(string("Iterative ", MAX_type," MAX: ", get_MAX(MAX_type), "\n"))
    print(string("floatmax(", MAX_type, ") = ", floatmax(MAX_type), "\n\n"))
end
