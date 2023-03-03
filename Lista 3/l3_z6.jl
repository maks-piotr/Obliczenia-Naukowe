#Autor: Maksymilian Piotrowski
include("./l3_z123.jl")

using .Approximate
e = 2.7182817284590452

f = x -> e^(Float64(1 - x)) - 1
pf = x -> -e^(Float64(1 - x))
delta = Float64(10)^(-5)
epsilon = Float64(10)^(-5)
maxit = 100

bisekcja = mbisekcji(f, Float64(0), Float64(2),delta,epsilon)
styczne = mstycznych(f, pf, Float64(0),delta,epsilon,maxit)
sieczne = msiecznych(f, Float64(-0.1), Float64(0),delta,epsilon,maxit)

print("M. bisekcji, \$a = 0\$, \$b = 2\$&",bisekcja[1],"&",bisekcja[2],"&",bisekcja[3], "\\\\\n\\hline\n")
print("M. stycznych, \$x_0 = 0\$&",styczne[1],"&",styczne[2],"&",styczne[3], "\\\\\n\\hline\n")
print("M. siecznych, \$x_0 = -0.1\$, \$x_1 = 0\$&",sieczne[1],"&",sieczne[2],"&",sieczne[3], "\\\\\n\\hline\n")

print("\n")
styczne = mstycznych(f, pf, Float64(1.5),delta,epsilon,maxit)
print(styczne, "\n")
print("M. stycznych, \$x_0 = 1.5 \\in (1,\\infty]\$&",styczne[1],"&",styczne[2],"&",styczne[3], "\\\\\n\\hline\n")



print("\n")



f = x -> x*e^(Float64(-x))
pf = x -> -(e^(Float64(-x)))*(x-1)
delta = Float64(10)^(-5)
epsilon = Float64(10)^(-5)
maxit = 100

bisekcja = mbisekcji(f, Float64(-1), Float64(2),delta,epsilon)
styczne = mstycznych(f, pf, Float64(-1),delta,epsilon,maxit)
sieczne = msiecznych(f, Float64(-1.1), Float64(-1),delta,epsilon,maxit)

print("M. bisekcji, \$a = -1\$, \$b = 2\$&",bisekcja[1],"&",bisekcja[2],"&",bisekcja[3], "\\\\\n\\hline\n")
print("M. stycznych, \$x_0 = -1\$&",styczne[1],"&",styczne[2],"&",styczne[3], "\\\\\n\\hline\n")
print("M. siecznych, \$x_0 = -1.1\$, \$x_1 = -1\$&",sieczne[1],"&",sieczne[2],"&",sieczne[3], "\\\\\n\\hline\n")

print("\n")
styczne = mstycznych(f, pf, Float64(1.1),delta,epsilon,maxit)
print(styczne, "\n")
print("M. stycznych \$x_0 = 1.1 \\in (1,\\infty]\$&",styczne[1],"&",styczne[2],"&",styczne[3], "\\\\\n\\hline\n")