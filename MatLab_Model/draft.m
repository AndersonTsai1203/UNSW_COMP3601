%% Generate A, s, e, q
% prime number q
min_q = input("minimum range of q: ");
max_q = input("maximum range of q: ");
for i = min_q:max_q
    q = randi([min_q, max_q], 1, 1);
    if isprime(q) == 1
        break
    end
end

% public key A
A_row = input("Enter Matrix A row size: ");
A_col = input("Enter Matrix A col size: ");
A = zeros(A_row, A_col);
for i = 1:A_row
    for j = 1:A_col
        A(i, j) = randi(q);
    end
end

% private key s
s = zeros(A_col, 1);
for i = 1:A_col
    s(i, 1) = randi(q);  
end

% error e
min_e = input("minimum range of e: ");
max_e = input("maximum range of e: ");
e = zeros(A_row, 1);
for i = 1:A_row
    e(i, 1) = randi([min_e, max_e], 1, 1);
end

%% Generate public key B
B = mod(A * s + e, q);

%% Given Message
M = input("Enter a string of 0 and 1 bit: ");
m_size = length(M);

%% Encode & Decode
decode_message = zeros(1, m_size);
for i = 1:m_size
    %% Encryption (Encoding)
    sampling_size = randi(A_row);
    % Find u (row vector)
    u = zeros(1, A_col);
    for j = 1:sampling_size
        nth_row = randi(A_row);
        
        %u(1, 1:A_col) = u(1, 1:A_col) + A(nth_row, 1:A_col);
    end
    u = mod(u, q);
    
    % Find v (integer)
    v = 0;
    for k = 1:sampling_size
        nth_row = randi(A_row);
        v = v + B(nth_row, 1);   
    end
    v = mod((v - M(i) * floor(q / 2)), q);
    
    %% Decryption (Decoding)
    dec = mod(v - (u(1, 1:A_col) * s(1:A_col, 1)), q);
    if (dec > mod(-q / 4, q) || dec < q / 4)
        D = 0;
    else 
        D = 1;
    end
    decode_message(1, i) = D;
end
decode_message





