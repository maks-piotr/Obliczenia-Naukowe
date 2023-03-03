#Autor: Maksymilian Piotrowski
include("hilb.jl")
include("matcond.jl")
using LinearAlgebra

#Generowanie błędu względnego x dla macierzy Hilberta
for i in ([2:10; [12,15,18,20]])
    x = [1 for j in 1:i]
    A = hilb(i)
    b = A * x
    # x' obliczony za pomocą metody Gaussa
    gauss_x = A \ b
    diff_gauss = norm(gauss_x - x, 2)/norm(x, 2)
    # x' obliczony przy pomocy odwrotności A
    inv_x = inv(A)*b
    diff_inv = norm(inv_x - x, 2)/norm(x, 2)
    print(i,"&",cond(A),"&",rank(A),"&",diff_gauss,"&",diff_inv,"\\\\\n\\hline\n")

end
print("\n\n\n")

#Generowanie błędu względnego x dla losowych macierzy rzędu j, uwarunkowaniu z
for z in [0,1,3,7,12,16]
    for j in [5,10,20]
        i = 10^z
        x = [1 for k in 1:j]
        A = matcond(Int(j),Float64(i))
        b = A * x
        # x' obliczony za pomocą metody Gaussa
        gauss_x = A \ b
        diff_gauss = norm(gauss_x - x, 2)/norm(x, 2)
        # x' obliczony przy pomocy odwrotności A
        inv_x = inv(A)*b
        diff_inv = norm(inv_x - x, 2)/norm(x, 2)
        print(j,"&","\$10^{", z, "}\$","&",rank(A),"&",diff_gauss,"&",diff_inv,"\\\\\n\\hline\n")
    end

end