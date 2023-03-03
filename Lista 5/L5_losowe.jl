#Autor: Maksymilian Piotrowski
#Test rozwiązań dla losowych macierzy
include("./L5_module.jl")
include("./matrixgen.jl")
using .L5
using .matrixgen
import LinearAlgebra.norm

for i in [100,1000,10000,100000,200000,300000,400000,500000]
    blockmat(i,4,100.0,"out.txt")
    A,b = readA_and_generate_b("./out.txt")
    x = [1 for k in 1:A.n]
    println("Test n = ", i, ": ")
    #Rozwiązywanie układu równań metodą eliminacji Gaussa bez częściowego wyboru:
    calculated_x = solve_equations(A,b,false,false)
    diff_x = norm(calculated_x - x, 2)/norm(x, 2)
    println("||x'-x||/||x|| metodą eliminacji Gaussa bez częściowego wyboru: ", diff_x)
    #Rozwiązywanie układu równań używając rozkładu LU bez częściowego wyboru:
    calculated_x = solve_equations(A,b,false,true)
    diff_x = norm(calculated_x - x, 2)/norm(x, 2)
    println("||x'-x||/||x|| używając rozkładu LU bez częściowego wyboru: ", diff_x)
    #Rozwiązywanie układu równań metodą eliminacji Gaussa z częściowym wyborem:
    calculated_x = solve_equations(A,b,true,false)
    diff_x = norm(calculated_x - x, 2)/norm(x, 2)
    println("||x'-x||/||x|| metodą eliminacji Gaussa z częściowym wyborem: ", diff_x)
    #Rozwiązywanie układu równań używając rozkładu LU z częściowym wyborem:
    calculated_x = solve_equations(A,b,true,true)
    diff_x = norm(calculated_x - x, 2)/norm(x, 2)
    println("||x'-x||/||x|| używając rozkładu LU z częściowym wyborem: ", diff_x)
        
end
