function lam = power_iteration(A, v0, num_iters)
% calculates the largest eigenvalue with the power iteration method
% stores the largest eigenvalue estimate after each iteration
   
    v = v0/norm(v0);
    lam = zeros(1, num_iters);
    
    for i = 1:num_iters
        v = A*v/norm(A*v);
        lam(i) = v'*A*v;
    end
 
end