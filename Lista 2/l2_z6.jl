#Autor: Maksymilian Piotrowski

#funkcja wyliczająca kolejne wartości ciągu x[n+1] = x[n]^2 + c dla 0 <= n < 40
#c - wartość c we wzorze na ciąg
#x0 - wartość x[0]
function rek(c, x0)
    x = [Float64(0) for _ in 1:40]
    x[1] = x0*x0 + c
    for i in 2:40
        x[i] = x[i-1]*x[i-1] + c
    end
    return x
end

odp = [[Float64(0) for _ in 1:40] for _ in 1:7]
odp[1] = rek(-2,1)
odp[2] = rek(-2,2)
odp[3] = rek(-2,1.99999999999999)
odp[4] = rek(-1,1)
odp[5] = rek(-1,-1)
odp[6] = rek(-1, 0.75)
odp[7] = rek(-1,0.25)

print("n,c-2x1,c-2x2,c-2x1.99999999999999,c-1x1,c-1x-1,c-1x0.75,c-1x0.25\n")
print("0,","1,2,1.99999999999999,1,-1,0.75,0.25","\n")
for n in 1:40
    print(n,",",odp[1][n],",",odp[2][n],",",odp[3][n],",",odp[4][n],",",odp[5][n],",",odp[6][n],",",odp[7][n],"\n")
end