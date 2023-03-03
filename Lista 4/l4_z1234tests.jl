#Autor: Maksymilian Piotrowski
include("./l4_z1234.jl")

using .L4
using Plots

#Zadanie 4 z listy 3 ćwiczenia
#oczekiwany wynik: -25, 28, -15, 5, 0, 1
iR = ilorazyRoznicowe(Vector{Float64}([-2,-1,0,1,2,3]),Vector{Float64}([-25,3,1,-1,27,235]))
println("L3Z4 cw ilorazy różnicowe: ", iR)

#Postać naturalna wielomianu interpolacyjnego Newtona dla ilorazów różnicowych iR
#wg. wolfram alpha: -25 + (28(x-(-2))) + (-15(x-(-2))(x-(-1))) + (5(x-(-2))(x-(-1))(x)) + (0(x-(-2))(x-(-1))(x)(x-1)) +(1(x-(-2))(x-(-1))(x)(x-1)(x-2)) = x^5 - 3x + 1
println("Postać naturalna wielomianu dla L3Z4: ", naturalna(Vector{Float64}([-2,-1,0,1,2,3]), iR) )

#wartość wielomianu interpolacyjnego Newtona w punkcie 1 dla ilorazów różnicowych iR
#wg. Wolfram alpha x^5 - 3x + 1 = -1 dla x = 1 
println("Wartość wielomianu interpolacyjnego w t=1 dla L3Z4: ", warNewton(Vector{Float64}([-2,-1,0,1,2,3]),iR,Float64(1)))


#oczekiwany wynik: -5, 10, -2.5, 0 wg. obliczeń
iR2 = ilorazyRoznicowe(Vector{Float64}([1,2,3,4]),Vector{Float64}([-5,5,10,10]))
println("\niR2 ilorazy różnicowe: ", iR2)

#wg. wolfram alpha: -5 + 10(x-1) + (-2.5(x-1)(x-2)) + 0 = -2.5*x^2 + 17.5*x -20
println("Postać naturalna wielomianu dla iR2: ", naturalna(Vector{Float64}([1,2,3,4]), iR2) )

#wg. wolfram alpha -2.5*1 + 17.5*1 - 20 = -5
println("Wartość wielomianu interpolacyjnego w t=1 dla iR2: ", warNewton(Vector{Float64}([1,2,3,4]),iR2,Float64(1)))


#Przykład z wykładu
#oczekiwany wynik: 1, 2, -3/8, 7/40
iR3 = ilorazyRoznicowe(Vector{Float64}([3,1,5,6]),Vector{Float64}([1,-3,2,4]))
println("\niR3 ilorazy różnicowe: ", iR3)

#wg. wolfram alpha: 1 + 2(x-3) + (-(3/8)(x-3)(x-1)) + (7/40)(x-3)(x-1)(x-5) = 0.175 x^3 - 1.95 x^2 + 7.525 x - 8.75
println("Postać naturalna wielomianu dla iR3: ", naturalna(Vector{Float64}([3,1,5,6]), iR3) )

#wg. wolfram alpha 1 + 2(x-3) + (-(3/8)(x-3)(x-1)) + (7/40)(x-3)(x-1)(x-5) dla x=1 zwraca -3
println("Wartość wielomianu interpolacyjnego w t=1 dla iR3: ", warNewton(Vector{Float64}([3,1,5,6]),iR3,Float64(1)))


print("\n")
#rysowanie wielomianu interpolacyjnego dla funkcji sinus
rysujNnfx(x -> sin(x), Float64(0), Float64(10), 5)
savefig("./plotting/plotsin.png")
#rysowanie wielomianu interpolacyjnego dla funkcji cosinus
rysujNnfx(x -> cos(x), Float64(0), Float64(10), 10)
savefig("./plotting/plotcos.png")

