#Autor: Maksymilian Piotrowski

module L4

using Plots
export ilorazyRoznicowe, warNewton, naturalna, rysujNnfx

# Funkcja obliczająca ilorazy różnicowe
# Dane:
#	x – wektor długości n + 1 zawierający węzły x_0, ... , x_n
#       x[1]=x0, ..., x[n+1]=xn
#   f - wektor długości n + 1 zawierający wartości interpolowanej funkcji w węzłach f(x0), ... , f(xn)
#
# Wyniki:
#   fx - wektor długości n + 1 zawierający obliczone ilorazy różnicowe
function ilorazyRoznicowe(x::Vector{Float64}, f::Vector{Float64})
    for i in 2:length(x)
        for j in reverse(i:length(x))
            f[j] = (f[j] - f[j-1])/(x[j]-x[j-i+1])
        end
    end
    return f
end

# Funkcja obliczająca wartość wielomianu interpolacyjnego w punkcie t
# Dane:
#	x – wektor długości n + 1 zawierający węzły x_0, ... , x_n
#       x[1]=x0, ..., x[n+1]=xn
#   f - wektor długości n + 1 zawierający ilorazy różnicowe
#       fx[1]=f[x0],
#       fx[2]=f[x0, x1],..., fx[n]=f[x0, . . . , xn−1], fx[n+1]=f[x0, . . . , xn]
#   t – punkt, w którym należy obliczyć wartość wielomianu
#
# Wyniki:
#   nt – wartość wielomianu w punkcie t
function warNewton(x::Vector{Float64}, fx::Vector{Float64}, t::Float64)
    n = length(fx)
    wn = fx[n]
    for i in reverse(1:n-1)
        wn = fx[i] + (t-x[i])*wn
    end
    return wn
end

# Funkcja obliczająca współczynniki postaci naturalnej
# Dane:
#	x – wektor długości n + 1 zawierający węzły x_0, ... , x_n
#       x[1]=x0, ..., x[n+1]=xn
#   f - wektor długości n + 1 zawierający ilorazy różnicowe
#       fx[1]=f[x0],
#       fx[2]=f[x0, x1], ..., fx[n]=f[x0, . . . , xn−1], fx[n+1]=f[x0, . . . , xn]
#
# Wyniki:
#   a – wektor długości n + 1 zawierający obliczone współczynniki postaci naturalnej
#       a[1]=a0
#       a[2]=a1, ..., a[n]=an−1, a[n+1]=an
function naturalna(x::Vector{Float64}, fx::Vector{Float64})
    n = length(x)
    a = Vector{Float64}(undef, n)
    a[n] = fx[n]
    for i in 1:(n-1)
        a[n-i] = fx[n-i] - a[n-(i-1)]*x[n-i]
        for j in ((n-i)+1):(n-1)
            a[j] = a[j] - a[j+1]*x[n-i]
        end
    end
    return a

end

# Funkcja obliczająca współczynniki postaci naturalnej
# Dane:
#	f – funkcja f(x) zadana jako anonimowa funkcja,
#   a,b – przedział interpolacji
#   n – stopień wielomianu interpolacyjnego
#
# Wyniki:
#    funkcja rysuje wielomian interpolacyjny i interpolowaną funkcję w przedziale [a, b].
function rysujNnfx(f,a::Float64,b::Float64,n::Int)
    x = Vector{Float64}(undef, n+1)
    f_val = Vector{Float64}(undef, n+1)
    h = ((b-a)/n)
    for i in (0:n)
        x[i+1] = a + i*h
        f_val[i+1] = f(x[i+1]) 
    end
    fx = ilorazyRoznicowe(x,f_val)
    x_axis_org = range(a, b, length=1000)
    y_axis_org = f.(x_axis_org)
    plot(x_axis_org,y_axis_org, label="interpolowana funkcja", dpi=300)
    y_axis_int = Vector{Float64}(undef, length(x_axis_org))
    for i in 1:length(x_axis_org)
        y_axis_int[i]=warNewton(x,fx,x_axis_org[i])
    end
    plot!(x_axis_org, y_axis_int, label="wielomian interpolacyjny, n = " * string(n), dpi=300)
    plot!(legend=:outerbottom, legendcolumns=2)

    diff = Float64(0)
    for i in 1:length(y_axis_org)
        diff = diff + abs(y_axis_org[i]-y_axis_int[i])
    end
    diff /= length(y_axis_org)
    println("n = ", n,", Średnia odległość wartości wielomianu od wartości funkcji: ", diff)

end

end