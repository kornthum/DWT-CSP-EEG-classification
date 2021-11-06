function [W, lambda, A] = csp_func(x1, x2, dim)

% Compute the covarience matrix
if dim==2
    samp_cov_s1 = cov(x1')      % s1~[c x c] 
    samp_cov_s2 = cov(x2')      % s2~[c x c]
else
    data_size = size(x1);
    num_trial = data_size(1);            % i = number of trials
    sum_s1 = 0; sum_s2 = 0;
    for i=1:num_trial
        samp1 = x1(i,:,:); samp1 = squeeze(samp1);
        samp2 = x2(i,:,:); samp2 = squeeze(samp2);
        s1 = cov(samp1');           % s1~[c x c]
        s2 = cov(samp2');           % s2~[c x c]
        sum_s1 = sum_s1 + s1;
        sum_s2 = sum_s2 + s2;
    end

    % Average corvarience of each class 
    samp_cov_s1 = sum_s1/(num_trial-1);
    samp_cov_s2 = sum_s2/(num_trial-1);
end
dim_s1 = size(samp_cov_s1)
dim_s2 = size(samp_cov_s2)

% Solve the eigenvalue problem s1(W) = D(s2)(W)
[W,L] = eig(samp_cov_s1, samp_cov_s1+samp_cov_s2);     % Mixing matrix W (Spatial filters are columes)
[lambda,ind] = sort(diag(L));                          % Sort eigenvalue in descending order
W = W(:,ind);
A = (inv(W))';
end
