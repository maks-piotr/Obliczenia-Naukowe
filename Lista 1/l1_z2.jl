#Autor: Maksymilian Piotrowski
for typ in [Float16, Float32, Float64]
    print(string(typ(3)*(typ(4)/typ(3) - typ(1)) - typ(1),"\n"))
end