#Autor: Maksymilian Piotrowski
include("./l4_z1234.jl")

using .L4
using Plots

e = 2.7182817284590452

rysujNnfx(x -> abs(x), Float64(-1), Float64(1), 5)
savefig("./plotting/l4z6a5.png")

rysujNnfx(x -> abs(x), Float64(-1), Float64(1), 10)
savefig("./plotting/l4z6a10.png")

rysujNnfx(x -> abs(x), Float64(-1), Float64(1), 15)
savefig("./plotting/l4z6a15.png")

rysujNnfx(x -> 1/(1+x^2), Float64(-5), Float64(5), 5)
savefig("./plotting/l4z6b5.png")

rysujNnfx(x -> 1/(1+x^2), Float64(-5), Float64(5), 10)
savefig("./plotting/l4z6b10.png")

rysujNnfx(x -> 1/(1+x^2), Float64(-5), Float64(5), 15)
savefig("./plotting/l4z6b15.png")

