%% config 1
A_row = 256;
A_col = 4;
min_q = 1;
max_q = 128;
min_e = -1;
max_e = 1;
M = [0 1 0 0 0 0 0 1];

success = 0;
for a = 1:10000
    for i = min_q:max_q
        q = randi([min_q, max_q], 1, 1);
        if isprime(q) == 1
            break
        end
    end

    A = zeros(A_row, A_col);
    for i = 1:A_row
        for j = 1:A_col
           A(i, j) = randi(q);
        end
    end

    s = zeros(A_col, 1);
    for i = 1:A_col
        s(i, 1) = randi(q);
    end

    e = zeros(A_row, 1);
    for i = 1:A_row
        e(i, 1) = randi([min_e, max_e], 1, 1);
    end

    B = zeros(A_row, 1);
    for i = 1:A_row
        for j = 1:A_col
            b = mod((A(i, j) .* s(j, 1)), q) + e(j, 1);
        end
        B(i, 1) = b;
    end

    m_size = length(M);

    decode_message = zeros(1, m_size);
    for i = 1:m_size
        sampling_size = randi(A_row);

        u = zeros(1, A_col);
        for j = 1:sampling_size
            nth_row = randi(A_row);
            u(1, 1:A_col) = u(1, 1:A_col) + A(nth_row, 1:A_col);
        end
        u = mod(u, q);

        v = 0;
        for k = 1:sampling_size
            nth_row = randi(A_row);
            v = v + B(nth_row, 1);   
        end
        v = mod((v - M(i) * floor(q / 2)), q);


        dec = mod(v - (u(1, 1:A_col) * s(1:A_col, 1)), q);
        if (dec > (-q / 4) && dec < (q / 4))
            D = 1;
        else 
            D = 0;
        end
        decode_message(1, i) = D;
    end
    
    flag = isequaln(decode_message, M);
    if (flag == 1)
       success = success + 1;
    end
end

successful_rate = success / 10000 * 100;

if (successful_rate == 100)
    fprintf('Tests successful: 10000 tests run, successful rate was %.2f%%\n', successful_rate);
else
    fprintf('Tests failed: 10000 tests run, successful rate was %.2f%%\n', successful_rate);
end






