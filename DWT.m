channel = {};
for i=1:22
    channel = [channel, sprintf('channel_%d', i)];
end

data = struct();
data.time = eeg.time/eeg.fs;
wname = 'db4';
det = ['d3', 'd4'];
x = 0;

for tr=1+x:72+x
    clear data;
    for num_ch=1:22
        signal = eeg.data.lh(tr-x,:,num_ch);
        [c,l] = wavedec(signal,4,wname);
        cd = detcoef(c,l, "dcells");
        data.(channel{num_ch}).d4 = cd{4};
        data.(channel{num_ch}).d3 = cd{3};
    end
    
    x_plot = [];
    
    for ch = 1:22
        log_data = [data.(channel{ch}).d4];
        x_plot = [x_plot; log_data];
    end
    lh(tr, :, :) = x_plot;
end