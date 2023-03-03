#Autor: Maksymilian Piotrowski
include("./l4_z1234.jl")

using .L4
using Plots

e = 2.7182817284590452

rysujNnfx(x -> e^x, Float64(0), Float64(1), 5)
savefig("./plotting/l4z5a5.png")

rysujNnfx(x -> e^x, Float64(0), Float64(1), 10)
savefig("./plotting/l4z5a10.png")

rysujNnfx(x -> e^x, Float64(0), Float64(1), 15)
savefig("./plotting/l4z5a15.png")

rysujNnfx(x -> x^2*sin(x), Float64(-1), Float64(1), 5)
savefig("./plotting/l4z5b5.png")

rysujNnfx(x -> x^2*sin(x), Float64(-1), Float64(1), 10)
savefig("./plotting/l4z5b10.png")

rysujNnfx(x -> x^2*sin(x), Float64(-1), Float64(1), 15)
savefig("./plotting/l4z5b15.png")

