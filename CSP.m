[eeg.train.lh, eeg.test.lh] = split_one_class(lh, 0.9);
[eeg.train.rh, eeg.test.rh] = split_one_class(rh, 0.9);
X = vertcat(eeg.train.lh, eeg.train.rh);
[W, lambda, A] = csp_func(train,eeg.train.rh, 3);      % Compute the projection matrix
data_size = size(X);
for i=1:data_size
    x = X(i,:,:);
    x = squeeze(x);   
    Z = W'*x;                         % Transform the X values
    eeg.csp(i,:,:) = Z;
end

X_test = vertcat(eeg.test.lh, eeg.test.rh);
data_test_size = size(X_test);
for i=1:data_test_size(1)
    x_test = X_test(i,:,:);
    x_test = squeeze(x_test);
    Z_test = W'*x_test;
    eeg.csp_test(i,:,:) = Z_test;
end