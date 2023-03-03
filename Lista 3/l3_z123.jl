#Autor: Maksymilian Piotrowski

module Approximate

export mbisekcji, mstycznych, msiecznych

# Funkcja znajdująca pierwiastek funkcji f metodą bisekcji
# Dane:
#	f – funkcja f(x) zadana jako anonimowa funkcja
#   a,b – końce przedziału początkowego,
#   delta – dokładność obliczeń ze względu na odległość między przybliżeniami,
#   epsilon – dokładność obliczeń ze względu na wartość bezwględną f(przybliżenie),
#
# Wyniki:
#   (r,v,it,err) – czwórka, gdzie
#   r – przybliżenie pierwiastka równania f(x) = 0,
#   v – wartość f(r)
#   it – liczba wykonanych iteracji
#   err – sygnalizacja błędu
#       0 - brak błędu
#       1 - funkcja nie zmienia znaku w przedziale [a,b]
function mbisekcji(f, a::Float64, b::Float64, delta::Float64, epsilon::Float64)
    fa = f(a)
    fb = f(b)
    #d - odległość miedzy a, b
    d = b - a
    if (sign(fa) == sign(fb))
        return (0,0,0,1)
    end
    i = 0
    while true
        i += 1
        d = d/2
        c = a + d
        fc = f(c)
        if abs(d) <= delta || abs(fc) <= epsilon
            return (a+d,fc,i,0)
        end
        if sign(fa) != sign(fc)
            b = c
            fb = fc
        else
            a = c
            fa = fc
        end
    end
end
# Funkcja znajdująca pierwiastek funkcji f metodą stycznych (Newtona)
# Dane:
#	f, pf – funkcją f(x) oraz pochodną f'(x) zadane jako anonimowe funkcje
#   x0 – przybliżenie początkowe,
#   delta – dokładność obliczeń ze względu na odległość między przybliżeniami,
#   epsilon – dokładność obliczeń ze względu na wartość bezwględną f(przybliżenie),
#   maxit – maksymalna dopuszczalna liczba iteracji
#
# Wyniki:
#   (r,v,it,err) – czwórka, gdzie
#   r – przybliżenie pierwiastka równania f(x) = 0,
#   v – wartość f(r)
#   it – liczba wykonanych iteracji
#   err – sygnalizacja błędu
#       0 - metoda zbieżna
#       1 - nie osiągnięto wymaganej dokładności w maxit iteracji
#       2 - pochodna bliska zeru

function mstycznych(f,pf,x0::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    #fx - wartość f(x_n)
    fx = Float64(f(x0))
    if (abs(fx) < epsilon)
        return (x0,fx,0,0)
    end
    for i in 1:maxit
        #pfx - wartość f'(x_n)
        pfx = Float64(pf(x0))
        if (abs(pfx) <= eps(Float64))
            return (x0,fx,i,2)
        end
        x1 = x0 - fx/pfx
        fx = f(x1)
        if (abs(x1 - x0) <= delta || abs(fx) <= epsilon)
            return (x1,fx,i,0)
        end
        x0 = x1
    end
    return(x0,fx,maxit+1,1)
end
# Funkcja znajdująca pierwiastek funkcji f metodą siecznych
# Dane:
#	f – funkcja f(x) zadana jako anonimowa funkcja
#   x0,x1 – przybliżenia początkowe,
#   delta – dokładność obliczeń ze względu na odległość między przybliżeniami,
#   epsilon – dokładność obliczeń ze względu na wartość bezwględną f(przybliżenie),
#   maxit – maksymalna dopuszczalna liczba iteracji
#
# Wyniki:
#   (r,v,it,err) – czwórka, gdzie
#   r – przybliżenie pierwiastka równania f(x) = 0,
#   v – wartość f(r)
#   it – liczba wykonanych iteracji
#   err – sygnalizacja błędu
#       0 - metoda zbieżna
#       1 - nie osiągnięto wymaganej dokładności w maxit iteracji
function msiecznych(f, x0::Float64, x1::Float64, delta::Float64, epsilon::Float64, maxit::Int)
    #fx0 - wartość f(x_n)
    fx0 = f(x0)
    #fx1 - wartość f(x_(n+1))
    fx1 = f(x1)
    for i in 1:maxit
        if (abs(fx0) > abs(fx1))
            x0, x1 = x1, x0
            fx0, fx1 = fx1, fx0
        end
        #s - przybliżenie wartości f'(x_(n+1))
        s = (x1 - x0)/(fx1 - fx0)
        x1 = x0
        fx1 = fx0
        x0 = x0 - fx0 * s 
        fx0 = f(x0)
        if (abs(x1 -x0) <= delta || abs(fx0) <= epsilon)
            return (x0,fx0,i,0)
        end
    end
    return (x0,fx0,maxit+1,1)
end


            

        

end