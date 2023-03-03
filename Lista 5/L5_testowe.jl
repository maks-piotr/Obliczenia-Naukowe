
#Autor: Maksymilian Piotrowski
#Testy dla przykładów od prof. Zielińskiego, do uruchomienia w folderze zawierającym załączony folder "data" z pliku L5_ON_261746_MP_dane.zip
include("./L5_module.jl")
include("./matrixgen.jl")
using .L5
using .matrixgen
import LinearAlgebra.norm

for i in [16,10000,50000,100000,300000,500000]
    x = [1 for k in 1:i]

    #Czytanie macierzy A:
    A = readA("./data/A" * string(i) * ".txt")
    #Czytanie wektora prawych stron b:
    b = readb("./data/b" * string(i) * ".txt")
    println("Test " * string(i) * ":")

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


    print("\n")

end
