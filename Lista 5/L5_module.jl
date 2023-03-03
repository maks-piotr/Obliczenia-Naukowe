#Autor: Maksymilian Piotrowski

module L5

include("./matrixgen.jl")
using .matrixgen
import LinearAlgebra.norm
export SpecialMatrix,convert_to_regular,readA,readb,readA_and_generate_b,solve_equations,read_solve_save

#Struktura przechowująca specyficzną macierz z listy 5
mutable struct SpecialMatrix
    A::Vector{Matrix{Float64}}
    B::Vector{Matrix{Float64}}
    C::Vector{Matrix{Float64}}
    D::Vector{Matrix{Float64}}
    n::Int64
    l::Int64
    v::Int64
end
#Funkcja zwracająca wartość macierzy SpecialMatrix A w danym miejscu
# Dane:
#	m - macierz SpecialMatrix A
#   i,j - koordynaty wartości do pozyskania
# Wyniki:
#   wartość A[i,j]
function get_matrix_val(m::SpecialMatrix,i::Int64,j::Int64)
    iv = floor(Int,(i-1)/m.l) +1
    jv = floor(Int,(j-1)/m.l) +1
    il = (i-1) % m.l + 1
    jl = (j-1) % m.l + 1
    if (iv == jv)
        return m.A[iv][il,jl]
    elseif (iv == jv+1)
        return m.B[jv][il,jl]
    elseif (iv+1 == jv)
        return m.C[iv][il,jl]
    elseif (iv+2 == jv)
        return m.D[iv][il,jl]
    else
        #println("Niepotrzeban próba dostępu ", i, ", ", j)
        return Float64(0)
    end
end

#Funkcja ustawiwająca wartość macierzy A w danym miejscu
# Dane:
#	m - macierz SpecialMatrix A
#   i,j - koordynaty wartości do zmiany
#   val - wartość która zostanie przypisana do A[i,j]
function set_matrix_val(m::SpecialMatrix,i,j,val)
    iv = floor(Int,(i-1)/m.l) +1
    jv = floor(Int,(j-1)/m.l) +1
    il = (i-1) % m.l + 1
    jl = (j-1) % m.l + 1
    if (iv == jv)
        m.A[iv][il,jl] = val
    elseif (iv == jv+1)
        m.B[jv][il,jl] = val
    elseif (iv+1 == jv)
        m.C[iv][il,jl] = val
    elseif (iv+2 == jv)
        m.D[iv][il,jl] = val
    end
end
#Funkcja zamieniająca miejscami rzędy SpecialMatrix m dzielące wspólne macierze wewnętrzne, lub odległe o 1
#ponadto funkcja zamienia miejscami odpowiadające elementy wektora b
# Dane:
#	m - macierz SpecialMatrix
#   b - wektor prawych stron
#   x,y - numery rzędów do przestawienia
function switch_matrix_rows(m::SpecialMatrix,b::Vector{Float64},x::Int,y::Int)
    if (x>y)
        temp = x
        x = y
        y = temp
    end
    temp = b[x]
    b[x] = b[y]
    b[y] = temp

    ivx = floor(Int,(x-1)/m.l) +1
    ivy = floor(Int,(y-1)/m.l) +1
    ilx = (x-1) % m.l + 1
    ily = (y-1) % m.l + 1
    for j in 1:m.l
        if (ivx == ivy)
            temp = m.A[ivx][ilx,j]
            m.A[ivx][ilx,j] = m.A[ivy][ily,j]
            m.A[ivy][ily,j] = temp

            if (ivx > 1 && ivy > 1)
                temp = m.B[ivx-1][ilx,j]
                m.B[ivx-1][ilx,j] = m.B[ivy-1][ily,j]
                m.B[ivy-1][ily,j] = temp
            end

            if (ivx < m.v && ivy < m.v)
                temp = m.C[ivx][ilx,j]
                m.C[ivx][ilx,j] = m.C[ivy][ily,j]
                m.C[ivy][ily,j] = temp
            end
        elseif (ivy == ivx+1)
            temp = m.A[ivx][ilx,j]
            m.A[ivx][ilx,j] = m.B[ivy-1][ily,j]
            m.B[ivy-1][ily,j] = temp
            
            if (ivx > 1 && ivy > 1)
                m.B[ivx-1][ilx,j] = Float64(0)
            end

            if (ivx < m.v && ivy < m.v)
                temp = m.C[ivx][ilx,j]
                m.C[ivx][ilx,j] = m.A[ivy][ily,j]
                m.A[ivy][ily,j] = temp
            end

            if (ivx < m.v-1 && ivy < m.v-1)
                temp = m.D[ivx][ilx,j]
                m.D[ivx][ilx,j] = m.C[ivy][ily,j]
                m.C[ivy][ily,j] = temp
            end
        end
    end
end

#Funkcja konwertująca SpecialMatrix na zwykłą macierz kwadratową
# Dane:
#	m - macierz SpecialMatrix
# Wyniki:
#   A - macierz kwadratowa
function convert_to_regular(m::SpecialMatrix)
    A = zeros(Float64, m.n, m.n)
    for i in (1:m.n)
        for j in (1:m.n)
            A[i,j] = get_matrix_val(m,i,j)
        end
    end
    return A
end

#Funkcja obliczająca wartość x, taką że Ax = b, dla macierzy A będącej macierzą trójkątną górną
# m - macierz trójkątna A
# b - wektor prawych stron b
function calculate_x(m::SpecialMatrix,b::Vector{Float64})
    x = Vector{Float64}(undef,m.n)
    x[m.n] = b[m.n]/get_matrix_val(m,m.n,m.n)
    for i in m.n-1:-1:1
        s = Float64(0)
        for j in i+1:min(m.n,i+(2*m.l))
            s = s + get_matrix_val(m,i,j)*x[j]
            x[i] = (b[i] - s)/get_matrix_val(m,i,i)
        end
    end
    return x
end

#Funkcja obliczająca wartość y, taką że Ly = b, dla macierzy zawierającej informacje o L
# Dane:
#	m - macierz SpecialMatrix zawierająca informacje o L
#   b - wektor prawych stron b
# Wyniki:
#   y - y takie że Ly = b
function calculate_y_LU(m::SpecialMatrix,b::Vector{Float64})
    y = copy(b)
    for k in 1:(m.n-1)
        for i in k+1:min(m.n,k+(2*m.l))
            y[i] -= y[k]*get_matrix_val(m,i,k)
        end
    end
    return y
end

# Funkcja zwracająca macierz trójkątną górną A' i wektor prawych stron b' równoważne układowi rówań A,b
# Dane:
#	m_in - macierz SpecialMatrix A
#   b_in - wektor prawych stron b
#   pivoting - true: algorytm używa częściowego wyboru elementu głównego,
#              false: algorytm nie używa częściowego wyboru elementu głównego
#
# Wyniki:
#   m - macierz trójkątna górna A'
#   b - wektor prawych stron b'
function gauss(m_in::SpecialMatrix,b_in::Vector{Float64},pivoting::Bool)
    m = deepcopy(m_in)
    b = copy(b_in)
    if (pivoting)
        scope = 2*m.l
    else
        scope = m.l
    end
    
    for k in (1:(m.n-1))
        if (pivoting)
            pivot = k
            for i in k+1:min(m.n,k+m.l)
                if (abs(get_matrix_val(m,i,k)) > abs(get_matrix_val(m,pivot,k)))
                    pivot = i
                end
            end
            if (pivot != k)
                switch_matrix_rows(m,b,k,pivot)
            end
        end

        for i in (k+1):min(m.n,k+m.l)
            l = get_matrix_val(m,i,k)/get_matrix_val(m,k,k)
            for j in (k+1):min(m.n,k+scope)
                set_matrix_val(m,i,j, get_matrix_val(m,i,j) - l*get_matrix_val(m,k,j))
            end
            b[i] = b[i] - l*b[k]
        end
    end
    return (m,b)
end
# Funkcja zwracająca macierz zawierającą informacje o rozkładzie LU dla macierzy A
# Dane:
#	m_in - macierz SpecialMatrix A
#   b_in - wektor prawych stron b
#   pivoting - true: algorytm używa częściowego wyboru elementu głównego,
#              false: algorytm nie używa częściowego wyboru elementu głównego
#
# Wyniki:
#   m - macierz zawierająca informacje o rozkładzie LU
#   b - wektor prawych stron z ewentualnymi przestawieniami elementów
function gauss_LU(m_in::SpecialMatrix,b_in::Vector{Float64},pivoting::Bool)
    m = deepcopy(m_in)
    b = copy(b_in)
    if (pivoting)
        scope = 2*m.l
    else
        scope = m.l
    end
    
    for k in (1:(m.n-1))
        if (pivoting)
            pivot = k
            for i in k+1:min(m.n,k+m.l)
                if (abs(get_matrix_val(m,i,k)) > abs(get_matrix_val(m,pivot,k)))
                    pivot = i
                end
            end
            if (pivot != k)
                switch_matrix_rows(m,b,k,pivot)
            end
        end

        for i in (k+1):min(m.n,k+m.l)
            l = get_matrix_val(m,i,k)/get_matrix_val(m,k,k)
            set_matrix_val(m,i,k,l)
            for j in (k+1):min(m.n,k+scope)
                set_matrix_val(m,i,j, get_matrix_val(m,i,j) - l*get_matrix_val(m,k,j))
            end
            
        end
    end
    return m,b
end
# Funkcja rozwiązująca Ax = b dla danych A,b
# Dane:
#	A - macierz SpecialMatrix
#   b - wektor prawych stron
#   pivoting - true: algorytm używa częściowego wyboru elementu głównego,
#              false: algorytm nie używa częściowego wyboru elementu głównego
#   LU - true: algorytm oblicza x przy pomocy rozkładu LU,
#        false: algorytm oblicza x bez wyznaczania rozkładu LU
#
# Wyniki:
#   x - x takie, że Ax = b
function solve_equations(A::SpecialMatrix,b::Vector{Float64},pivoting::Bool,LU::Bool)
    if (LU)
        #jeśli użyto wersji z częściowym wyborem, to musimy zapamiętać nową kolejność wektora b
        A_LU,b_switched = gauss_LU(A,b,pivoting)
        y = calculate_y_LU(A_LU,b_switched)
        calculated_x = calculate_x(A_LU,y)
    else
        A_triangle,b_triangle = gauss(A,b,pivoting)
        calculated_x = calculate_x(A_triangle,b_triangle)
    end
    return calculated_x
end

# Funkcja czytająca A,b z plików, rozwiązująca Ax = b dla danych A,b i zapisująca wynik do pliku
# Dane:
#	A_file - nazwa pliku zawierającego macierz A
#   b_file - nazwa pliku zawierającego wektor b
#   pivoting - true: algorytm używa częściowego wyboru elementu głównego,
#              false: algorytm nie używa częściowego wyboru elementu głównego
#   LU - true: algorytm oblicza x przy pomocy rozkładu LU,
#        false: algorytm oblicza x bez wyznaczania rozkładu LU
#   out_file - nazwa pliku do którego należy zapisać wynik
#   
# Wyniki:
#   x - x takie, że Ax = b
function read_solve_save(A_file::String,b_file::String,pivoting::Bool,LU::Bool,out_file::String)
    A = readA(A_file)
    b = readb(b_file)
    calculated_x = solve_equations(A,b,pivoting,LU)
    open(out_file, "w") do file
        for i in 1:A.n
            write(file, string(calculated_x[i])*"\n")
        end
    end
    return calculated_x
end

# Funkcja czytająca A, generujaca b, rozwiązująca Ax = b dla danych A,b i zapisująca błąd względny i wynik do pliku
# Dane:
#	A_file - nazwa pliku zawierającego macierz A
#   pivoting - true: algorytm używa częściowego wyboru elementu głównego,
#              false: algorytm nie używa częściowego wyboru elementu głównego
#   LU - true: algorytm oblicza x przy pomocy rozkładu LU,
#        false: algorytm oblicza x bez wyznaczania rozkładu LU
#   out_file - nazwa pliku do którego należy zapisać błąd względny i wynik
#   
# Wyniki:
#   x - x takie, że Ax = b
function read_solve_save(A_file::String,pivoting::Bool,LU::Bool,out_file::String)
    A, b = readA_and_generate_b(A_file)
    calculated_x = solve_equations(A,b,pivoting,LU)

    x = [Float64(1) for k in 1:A.n]
    diff_x = norm(calculated_x - x, 2)/norm(x, 2)
    
    open(out_file, "w") do file
        write(file, string(diff_x)*"\n")
        for i in 1:A.n
            write(file, string(calculated_x[i])*"\n")
        end
    end
    return calculated_x
end


# Funkcja wczytująca macierz SpecialMatrix A z pliku
# Dane:
#	filename - nazwa pliku z macierzą A
#
# Wyniki:
#   A - macierz SpecialMatrix A
function readA(filename::String)
    open(filename) do f
        x = split.(readline(f))
        n = parse.(Int,x[1])
        l = parse.(Int,x[2])
        v = Int64(n/l)
        A = Vector{Matrix{Float64}}(undef,v)
        B = Vector{Matrix{Float64}}(undef,v-1)
        C = Vector{Matrix{Float64}}(undef,v-1)
        #Używana długość D to v-2
        D = Vector{Matrix{Float64}}(undef,v-1)
        for i in (1:(v-1))
            A[i] = zeros(l,l)
            B[i] = zeros(l,l)
            C[i] = zeros(l,l)
            D[i] = zeros(l,l)
        end
        A[v] = zeros(l,l)
        while !eof(f)
            x = split.(readline(f))
            i = parse.(Int,x[1])
            j = parse.(Int,x[2])
            val = parse.(Float64,x[3])
            iv = floor(Int,(i-1)/l) +1
            jv = floor(Int,(j-1)/l) +1
            if (iv == jv)
                A[iv][(i-1) % l + 1, (j-1) % l + 1] = val
            elseif (iv > jv)
                B[jv][(i-1) % l + 1, (j-1) % l + 1] = val
            elseif (iv < jv)
                C[iv][(i-1) % l + 1, (j-1) % l + 1] = val
            end
        end
        return SpecialMatrix(A,B,C,D,n,l,v)
    end
end


# Funkcja mnożąca macierz SpecialMatrix A przez wektor x
# Dane:
#	A - macierz SpecialMatrix
#   x - wektor
#
# Wyniki:
#   b - A*x
function multiply_A_by_x(A::SpecialMatrix,x::Vector{Float64})
    b = zeros(A.n)
    for i in 1:A.n
        for j in max(1,i-A.l):min(A.n,i+A.l)
            b[i] += get_matrix_val(A,i,j)*x[j]
        end
    end
    return b
end

# Funkcja wczytująca macierz SpecialMatrix A z pliku i generująca b t. że b = A*(1,...,1)
# Dane:
#	filename - nazwa pliku z macierzą A
#
# Wyniki:
#   A - macierz SpecialMatrix A
#   b - wektor prawych stron
function readA_and_generate_b(filename::String)
    A = readA(filename)
    x = [Float64(1) for k in 1:A.n]
    b = multiply_A_by_x(A,x)
    return (A,b)
end

# Funkcja testująca czy Ax = b
# Dane:
#	A - SpecialMatrix A
#   x - obliczone rozwiązanie Ax = b
#   b - b na podstawie którego obliczono x
#
# Wyniki:
#   diff - ||b - Ax||/||b||
function test_x_error(A::SpecialMatrix, b::Vector{Float64}, x::Vector{Float64})
    Ax = multiply_A_by_x(A,x)
    diff = norm(b - Ax, 2)/norm(b, 2)
    return diff
end

# Funkcja wczytująca wektor prawych stron b z pliku
# Dane:
#	filename - nazwa pliku z wektorem prawych stron b
#
# Wyniki:
#   b - wektor prawych stron
function readb(filename::String)
    open(filename) do f
        x = readline(f)
        n = parse.(Int,x)
        b = Vector{Float64}(undef,n)
        line = 1
        while !eof(f)
            x = readline(f)
            val = parse.(Float64,x)
            b[line] = val
            line += 1
        end
        return b
    end
end

end
