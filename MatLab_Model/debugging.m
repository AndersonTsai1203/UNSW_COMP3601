min_q = input("minimum range of q: ");
max_q = input("maximum range of q: ");
for i = min_q:max_q
    q = randi([min_q, max_q], 1, 1);
    if isprime(q) == 1
        break
    end
end
q

A_row = input("Enter Matrix A row size: ");
A_col = input("Enter Matrix A col size: ");
A = zeros(A_row, A_col);
for i = 1:A_row
    for j = 1:A_col
        A(i, j) = randi(q);
    end
end
A

s = zeros(A_col, 1);
for i = 1:A_col
    s(i, 1) = randi(q);  
end
s

min_e = input("minimum range of e: ");
max_e = input("maximum range of e: ");
e = zeros(A_row, 1);
for i = 1:A_row
    e(i, 1) = randi([min_e, max_e], 1, 1);
end

B1 = mod(A * s + e, q)

B = zeros(A_row, 1);
for i = 1:A_row
    for j = 1:A_col
        b = mod((A(i, j) .* s(j, 1) + e(j, 1)), q);
    end
    B(i, 1) = b;
end
B
u = zeros(1, A_col);
d = A(2, 1:A_col)
c = u(1, 1:A_col) + A(2, 1:A_col)

