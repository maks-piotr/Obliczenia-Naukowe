#Autor: Maksymilian Piotrowski
include("./l3_z123.jl")

using .Approximate

f = x -> sin(Float64(x)) - (Float64(x)/2)^2
pf = x -> cos(Float64(x)) - (Float64(x)/2)
delta = (Float64(10)^(-5))/2
epsilon = (Float64(10)^(-5))/2
maxit = 100

bisekcja = mbisekcji(f, Float64(1.5), Float64(2),delta,epsilon)
styczne = mstycznych(f, pf, Float64(1.5),delta,epsilon,maxit)
sieczne = msiecznych(f, Float64(1), Float64(2),delta,epsilon,maxit)

print("M. bisekcji&",bisekcja[1],"&",bisekcja[2],"&",bisekcja[3], "\\\\\n\\hline\n")
print("M. stycznych&",styczne[1],"&",styczne[2],"&",styczne[3], "\\\\\n\\hline\n")
print("M. siecznych&",sieczne[1],"&",sieczne[2],"&",sieczne[3], "\\\\\n\\hline\n")