function [train, test] = split_one_class(x, percent)
data_size = size(x);
i = data_size(1);               % i = number of trials

i_tr = round(i*percent);
i_te = i - i_tr;

train = x(1:i_tr,:,:);
test = x(i_tr+1 : i_tr + i_te,:,:);
end