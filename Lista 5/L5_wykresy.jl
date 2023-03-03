#Autor: Maksymilian Piotrowski
include("./L5_module.jl")
include("./matrixgen.jl")
using BenchmarkTools
using Plots
using .L5
using .matrixgen
import LinearAlgebra.norm

#Wykres czasu w zależności od rozmiaru n macierzy, l = 5, 100 <= n <= 10000

x_axis = range(100, 10000, step=100)
x_axis = map(x -> convert(Int,round(x)), x_axis)
y_axis_pivot = Vector{Float64}(undef, length(x_axis))
y_axis_no_pivot = Vector{Float64}(undef, length(x_axis))
y_axis_pivot_s = Vector{Float64}(undef, length(x_axis))
y_axis_no_pivot_s = Vector{Float64}(undef, length(x_axis))
Ly_axis_pivot = Vector{Float64}(undef, length(x_axis))
Ly_axis_no_pivot = Vector{Float64}(undef, length(x_axis))
Ly_axis_pivot_s = Vector{Float64}(undef, length(x_axis))
Ly_axis_no_pivot_s = Vector{Float64}(undef, length(x_axis))
samples = 1
for i in 1:length(x_axis)
    println("Mierzenie ", x_axis[i])
    blockmat(x_axis[i],5,100.0,"out.txt")
    A,b = readA_and_generate_b("./out.txt")
    x = [1 for k in 1:A.n]
    #time_no_pivot = median(@benchmark solve_equations($A,$b,false,false)  samples=5).time
    #time_pivot = median(@benchmark solve_equations($A,$b,true,false)  samples=5).time
    time_pivot = Vector{Float64}(undef, samples)
    time_no_pivot = Vector{Float64}(undef, samples)
    time_pivot_s = Vector{Float64}(undef, samples)
    time_no_pivot_s = Vector{Float64}(undef, samples)
    Ltime_pivot = Vector{Float64}(undef, samples)
    Ltime_no_pivot = Vector{Float64}(undef, samples)
    Ltime_pivot_s = Vector{Float64}(undef, samples)
    Ltime_no_pivot_s = Vector{Float64}(undef, samples)
    for j in 1:samples
        blockmat(x_axis[i],5,100.0,"out.txt")
        A,b = readA_and_generate_b("./out.txt")
        sleep = @elapsed solve_equations(A,b,false,false)
        time_pivot[j] = @elapsed solve_equations(A,b,true,false)
        time_no_pivot[j] = @elapsed solve_equations(A,b,false,false)
        Ltime_pivot[j] = @elapsed solve_equations(A,b,true,true)
        Ltime_no_pivot[j] = @elapsed solve_equations(A,b,false,true)
    end
    time_no_pivot_m = median(time_no_pivot)
    time_no_pivot_s = mean(time_no_pivot)
    time_pivot_m =  median(time_pivot)
    time_pivot_s =  mean(time_pivot)
    Ltime_no_pivot_m = median(Ltime_no_pivot)
    Ltime_no_pivot_s = mean(Ltime_no_pivot)
    Ltime_pivot_m =  median(Ltime_pivot)
    Ltime_pivot_s =  mean(Ltime_pivot)
    open("no_pivot.txt", "a") do file
        println(file,x_axis[i], ", ", time_no_pivot_m)
        println(file,x_axis[i], ", ", time_no_pivot_s)
    end
    open("pivot.txt", "a") do file
        println(file, x_axis[i], ", " ,time_pivot_m)
        println(file, x_axis[i], ", " ,time_pivot_s)
    end
    y_axis_pivot[i] = time_pivot_m
    y_axis_no_pivot[i] = time_no_pivot_m
    y_axis_pivot_s[i] = time_pivot_s
    y_axis_no_pivot_s[i] = time_no_pivot_s
    Ly_axis_pivot[i] = Ltime_pivot_m
    Ly_axis_no_pivot[i] = Ltime_no_pivot_m
    Ly_axis_pivot_s[i] = Ltime_pivot_s
    Ly_axis_no_pivot_s[i] = Ltime_no_pivot_s
end
plot(x_axis,y_axis_no_pivot, label="Bez wyboru el. głównego", dpi=300)
plot!(x_axis,y_axis_pivot, label="Częściowy wybór el. głónego", dpi=300)
plot!(x_axis,Ly_axis_no_pivot, label="Bez wyboru el. głównego - LU", dpi=300)
plot!(x_axis,Ly_axis_pivot, label="Częściowy wybór el. głónego - LU", dpi=300)


plot!(legend=:topleft)
xlabel!("Rozmiar macierzy")
ylabel!("Mediana czasu wykonania [s]")
savefig("./plotting/l5time4.png")

plot(x_axis,y_axis_no_pivot_s, label="Bez wyboru el. głównego", dpi=300)
plot!(x_axis,y_axis_pivot_s, label="Częściowy wybór el. głónego", dpi=300)
plot!(x_axis,Ly_axis_no_pivot_s, label="Bez wyboru el. głównego - LU", dpi=300)
plot!(x_axis,Ly_axis_pivot_s, label="Częściowy wybór el. głónego - LU", dpi=300)
plot!(legend=:topleft)
xlabel!("Rozmiar macierzy")
ylabel!("Średni czas wykonania [s]")
savefig("./plotting/l5time5.png")

