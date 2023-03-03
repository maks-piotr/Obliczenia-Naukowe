#Autor: Maksymilian Piotrowski
include("./l3_z123.jl")

using .Approximate

function check_values(f,pf,a::Float64,b::Float64,x0::Float64,x1::Float64,delta::Float64,epsilon::Float64,maxit::Int,wolframapprox::String)
    print("Wolfram approx: ", wolframapprox, "\n")
    print("Metoda bisekcji: ", mbisekcji(f,a,b,delta,epsilon), "\n")
    print("Metoda stycznych: ", mstycznych(f,pf,x0,delta,epsilon,maxit), "\n")
    print("Metoda siecznych: ", msiecznych(f,x0,x1,delta,epsilon,maxit), "\n")
    print("\n")
end

#wg wolfram alpha jedyne miejsce zerowe to x≈-3.4798157487551455566513905912709308
check_values(x -> Float64((x^3 + 4)/2 + x^2 - 2x), x -> Float64((3*x^2)/2 + 2x - 2), Float64(-10) , Float64(10) , Float64(-5) , Float64(10), Float64(10^(-10)), Float64(10^(-10)), 100, "-3.4798157487551455566513905912709308")

#wg wolfram alpha jedyne miejsce zerowe to x=0
check_values(x -> Float64(x^3), x -> Float64(3*x^2), Float64(-10) , Float64(11.5) , Float64(-10) , Float64(11.5), Float64(10^(-10)), Float64(10^(-10)), 100, "0")

#wg wolfram alpha miejsca zerowe w x≈ - -33.02775637731994646559611 oraz x≈3.027756377319946465596106
check_values(x -> Float64(((x^2)/10)+3*x-10), x -> Float64(x/5 + 3), Float64(-10) , Float64(11.5) , Float64(-10) , Float64(11.5), Float64(10^(-10)), Float64(10^(-10)), 100, "3.027756377319946465596106")