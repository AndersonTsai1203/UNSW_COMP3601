A_row = 256;
A_col = 4;
min_q = 1;
max_q = 128;
min_e = -1;
max_e = 1;
M = [0 1 0 0 0 0 0 1];

test = 10000;
counter = 0;
for a = 1:test 
    %% Generate A, s, e, q
    % prime number q
    for i = min_q:max_q
        q = randi([min_q, max_q], 1, 1);
        if isprime(q) == 1
            break
        end
    end

    % public key A
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
    e = round(e_size .* rand(A_row, 1) + min_e);

    %% Generate public key B
    B = mod(A * s + e, q);

    %% Given Message
    m_size = length(M);

    %% Encode & Decode
    decode_message = zeros(1, m_size);
    for i = 1:m_size
        %% Encryption (Encoding)
        sampling_size = A_row / 4;
        % Find u (row vector) & v (integer)
        u = zeros(1, A_col);
        v = 0;
        for j = 1:sampling_size
            nth_row = randi(A_row);

            u(1, 1:A_col) = u(1, 1:A_col) + A(nth_row, 1:A_col);
            v = v + B(nth_row, 1);
        end
        u = mod(u, q);
        v = mod((v - floor(q / 2 * M(i))), q);

        %% Decryption (Decoding)
        dec = mod(v - (u * s), q);
        if (dec > mod(-q / 4, q) || dec < (q / 4))
            D = 0;
        else 
            D = 1;
        end
        decode_message(1, i) = D;
    end
    if (decode_message == M)
        counter = counter + 1;
    end
end
success = counter / test * 100