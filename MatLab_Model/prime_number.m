min_q = input("minimum range of q: ");
max_q = input("maximum range of q: ");


p1 = primes(max_q);
p2 = primes(min_q);
p1_size = size(p1);
p2_size = size(p2);
p3 = p1(p2_size(2)+1:p1_size(2));
p3_size = size(p3);

FID = fopen('test.txt', 'w');
if FID == -1, error('oops'); end

for i = 1:4:p3_size(2)
   % if mod(i, 10) == 0
   %     fprintf(FID, '\n');
   % end
    fprintf(FID, '%s\n', dec2bin(p3(i), 16));
end

fclose(FID);
%save('config2.txt', p3, '-ascii')

