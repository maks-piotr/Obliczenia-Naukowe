#Autor: Maksymilian Piotrowski
include("./l3_z123.jl")

using .Approximate
e = 2.7182817284590452

f = x -> 3*Float64(x) - Float64(e)^x
pf = x -> 3 - Float64(e)^x
delta = (Float64(10)^(-5))/2
epsilon = (Float64(10)^(-5))/2

m_zerowe = mbisekcji(pf,Float64(0),Float64(3),delta,epsilon)
print(m_zerowe, "\n")
print(f(m_zerowe[1]), "\n")

bisekcja1 = mbisekcji(f, Float64(0), m_zerowe[1],delta,epsilon)
bisekcja2 = mbisekcji(f, m_zerowe[1], Float64(3),delta,epsilon)

print("[0, \$x_0\$]&",bisekcja1[1],"&",bisekcja1[2],"&",bisekcja1[3], "\\\\\n\\hline\n")
print("[\$x_0\$, 3]&",bisekcja2[1],"&",bisekcja2[2],"&",bisekcja2[3], "\\\\\n\\hline\n")