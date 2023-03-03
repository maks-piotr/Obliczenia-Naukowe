#Autor: Maksymilian Piotrowski
#Test zapisywania wyników do pliku
include("./L5_module.jl")
include("./matrixgen.jl")
using .L5
using .matrixgen

#generowanie plików zawierających A, b
blockmat(1000,4,100.0,"input_A.txt")
A, b = readA_and_generate_b("input_A.txt")
open("input_b.txt", "w") do file
    write(file, string(length(b))*"\n")
    for i in 1:length(b)
        write(file, string(b[i])*"\n")
    end
end

#Zapisywanie obliczonego x' do pliku tekstowego razem z błędem względem (1,...,1), bo b generowane
calculated_x = read_solve_save("input_A.txt",true,false,"output1.txt")
#Zapisywanie obliczonego x' do pliku tekstowego bez błędu względnego, bo b czytane z pliku
calculated_x = read_solve_save("input_A.txt","input_b.txt",true,false,"output2.txt")
