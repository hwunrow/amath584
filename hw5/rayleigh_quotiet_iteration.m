function lam = rayleigh_quotiet_iteration(A, v0, num_iters)
% calculates the eigenvalues with the raleigh_quotiet iteration method
    
    v = v0;
    lam = zeros(1, num_iters+1);
    lam(1) = v'*A*v;
    n = width(A);
    I = eye(n);
    
    for i = 1:num_iters
        w = (A - lam(i)*I)\v;
        v = w/norm(w);
        lam(i+1) = v'*A*v;
    end
end
