function v = rowNorm(A)
%ROWNORM  norm of each row
%   V = ROWNORM(A) returns the Euclidean norm of each row of A. When A is 
%   an M*N matrix, the output, V, will be a M*1 vector.

if nargin ~= 1
    error('Requires one input arguments.')
end

v = sqrt(sum(A.*A, 2));
