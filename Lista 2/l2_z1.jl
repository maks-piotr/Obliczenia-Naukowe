#Autor: Maksymilian Piotrowski

x_arr = [2.718281828, -3.141592654, 1.414213562, 0.577215664, 0.301029995]
y_arr = [1486.2497, 878366.9879, -22.37492, 4773714.647, 0.000185049]

#funkcja sumująca iloczyn wektorowy x,y w sposób a
# x - wektor pierwszy
# y - wektor drugi
# typ danych
# rozmiar wektorów
function forward(x,y,typ,n::Int64)
    s = typ(0) # akumulator do obliczania sumy
    for i in 1:n
        s = s + typ(x[i])*typ(y[i])
    end
    return s
end
#funkcja sumująca iloczyn wektorowy x,y w sposób b
# x - wektor pierwszy
# y - wektor drugi
# typ danych
# rozmiar wektorów
function backward(x,y,typ,n::Int64)
    s = typ(0) # akumulator do obliczania sumy
    for i in 1:n
        s = s + typ(x[n+1-i])*typ(y[n+1-i])
    end
    return s
end
#funkcja sumująca iloczyn wektorowy x,y w sposób d
# x - wektor pierwszy
# y - wektor drugi
# typ danych
# rozmiar wektorów
function lowtohigh(x,y,typ,n::Int64)
    positive = []
    negative = []
    for i in 1:n
        z = typ(x[i])*typ(y[i])
        if (z > 0)
            push!(positive,z)
        else
            push!(negative,z)
        end
    end
    positive = sort(positive)
    negative = sort(negative, rev=true)
    s_pos = typ(0) # akumulator do obliczania sumy dodatnich wartości
    s_neg = typ(0) # akumulator do obliczania sumy ujemnych wartości
    for i in 1:length(positive)
        s_pos += positive[i]
    end
    for i in 1:length(negative)
        s_neg += negative[i]
    end
    
    return s_pos + s_neg
end
#funkcja sumująca iloczyn wektorowy x,y w sposób c
# x - wektor pierwszy
# y - wektor drugi
# typ danych
# rozmiar wektorów
function hightolow(x,y,typ,n::Int64)
    positive = []
    negative = []
    s = typ(0)
    for i in 1:n
        z = typ(x[i])*typ(y[i])
        if (z > 0)
            push!(positive,z)
        else
            push!(negative,z)
        end
    end
    positive = sort(positive, rev=true)
    negative = sort(negative)
    s_pos = typ(0) # akumulator do obliczania sumy dodatnich wartości
    s_neg = typ(0) # akumulator do obliczania sumy ujemnych wartości
    for i in 1:length(positive)
        s_pos += positive[i]
    end
    for i in 1:length(negative)
        s_neg += negative[i]
    end
    
    return s_pos + s_neg
end

for typ in [Float32,Float64]
    print("Forward ", typ, " ", forward(x_arr,y_arr,typ,5), "\n")
    print("Backward ", typ, " ",backward(x_arr,y_arr,typ,5), "\n")
    print("Lowtohigh ", typ, " ",lowtohigh(x_arr,y_arr,typ,5), "\n")
    print("Hightolow ", typ, " ",hightolow(x_arr,y_arr,typ,5), "\n\n")
end
