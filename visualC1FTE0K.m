%% Import section
be2022std = importfile("<<PATH>>", [2, Inf]);
reform_2022_alles_std = importfile("<<PATH>>", [2, Inf]);
reform_2022_bbsz_std = importfile("<<PATH>>", [2, Inf]);
reform_2022_bvs_schalen_bbsz_std = importfile("<<PATH>>", [2, Inf]);
reform_2022_bvs_schalen_std = importfile("<<PATH>>", [2, Inf]);
reform_2022_geen_hc_std = importfile("<<PATH>>", [2, Inf]);
reform_2022_wb_mediaan_std = importfile("<<PATH>>", [2, Inf]);

%% Select only sections needed
T10 = be2022std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim", "ils_ben"]);
T11 = reform_2022_bvs_schalen_std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim", "ils_ben"]);
T12 = reform_2022_bbsz_std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim", "ils_ben"]);
T13 = reform_2022_geen_hc_std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim", "ils_ben"]);
T14 = reform_2022_wb_mediaan_std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim", "ils_ben"]);
T15 = reform_2022_bvs_schalen_bbsz_std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim", "ils_ben"]);
T16 = reform_2022_alles_std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim", "ils_ben"]);

%% EMTR calculation
delta_c_i10 = zeros(17002,1);
delta_y_i10 = zeros(17002,1);
delta_c_i11 = zeros(17002,1);
delta_y_i11 = zeros(17002,1);
delta_c_i12 = zeros(17002,1);
delta_y_i12 = zeros(17002,1);
delta_c_i13 = zeros(17002,1);
delta_y_i13 = zeros(17002,1);
delta_c_i14 = zeros(17002,1);
delta_y_i14 = zeros(17002,1);
delta_c_i15 = zeros(17002,1);
delta_y_i15 = zeros(17002,1);
delta_c_i16 = zeros(17002,1);
delta_y_i16 = zeros(17002,1);

for i = 3:2:size(T10, 1)
    delta_c_i10(i, 1) = table2array(T10(i, 4) + T10(i+1, 4) - T10(i-1, 4) - T10(i-2, 4));
    delta_y_i10(i, 1) = table2array(T10(i, 1) - T10(i-2, 1));
    delta_c_i11(i, 1) = table2array(T11(i, 4) + T11(i+1, 4) - T11(i-1, 4) - T11(i-2, 4));
    delta_y_i11(i, 1) = table2array(T11(i, 1) - T11(i-2, 1));
    delta_c_i12(i, 1) = table2array(T12(i, 4) + T12(i+1, 4) - T12(i-1, 4) - T12(i-2, 4));
    delta_y_i12(i, 1) = table2array(T12(i, 1) - T12(i-2, 1));
    delta_c_i13(i, 1) = table2array(T13(i, 4) + T13(i+1, 4) - T13(i-1, 4) - T13(i-2, 4));
    delta_y_i13(i, 1) = table2array(T13(i, 1) - T13(i-2, 1));
    delta_c_i14(i, 1) = table2array(T14(i, 4) + T14(i+1, 4) - T14(i-1, 4) - T14(i-2, 4));
    delta_y_i14(i, 1) = table2array(T14(i, 1) - T14(i-2, 1));
    delta_c_i15(i, 1) = table2array(T15(i, 4) + T15(i+1, 4) - T15(i-1, 4) - T15(i-2, 4));
    delta_y_i15(i, 1) = table2array(T15(i, 1) - T15(i-2, 1));
    delta_c_i16(i, 1) = table2array(T16(i, 4) + T16(i+1, 4) - T16(i-1, 4) - T16(i-2, 4));
    delta_y_i16(i, 1) = table2array(T16(i, 1) - T16(i-2, 1));
end

for i = 2:1:size(T10, 1)
    T10.emtr10 = 1 - (delta_c_i10 ./ delta_y_i10);
    T11.emtr11 = 1 - (delta_c_i11 ./ delta_y_i11);
    T12.emtr12 = 1 - (delta_c_i12 ./ delta_y_i12);
    T13.emtr13 = 1 - (delta_c_i13 ./ delta_y_i13);
    T14.emtr14 = 1 - (delta_c_i14 ./ delta_y_i14);
    T15.emtr15 = 1 - (delta_c_i15 ./ delta_y_i15);
    T16.emtr16 = 1 - (delta_c_i16 ./ delta_y_i16);
end

%% Making comparable

for i = 4:2:size(T10, 1)
    T10.emtrN(i/2) = T10.emtr10(i-1);
    T10.gezBrutInk(i/2) = T10.ils_earns(i-1) + T10.ils_ben(i);
    T11.emtrN(i/2) = T11.emtr11(i-1);
    T11.gezBrutInk(i/2) = T11.ils_earns(i-1) + T11.ils_ben(i);
    T12.emtrN(i/2) = T12.emtr12(i-1);
    T12.gezBrutInk(i/2) = T12.ils_earns(i-1) + T12.ils_ben(i);
    T13.emtrN(i/2) = T13.emtr13(i-1);
    T13.gezBrutInk(i/2) = T13.ils_earns(i-1) + T13.ils_ben(i);
    T14.emtrN(i/2) = T14.emtr14(i-1);
    T14.gezBrutInk(i/2) = T14.ils_earns(i-1) + T14.ils_ben(i);
    T15.emtrN(i/2) = T15.emtr15(i-1);
    T15.gezBrutInk(i/2) = T15.ils_earns(i-1) + T15.ils_ben(i);
    T16.emtrN(i/2) = T16.emtr16(i-1);
    T16.gezBrutInk(i/2) = T16.ils_earns(i-1) + T16.ils_ben(i);
end

%% Graph Making

x = T10.gezBrutInk; % 
y0 = T10.emtrN; % noref
y1 = T11.emtrN; % bvs+schalenref
y2 = T12.emtrN; % bbszref
y3 = T13.emtrN; % hcref
y4 = T14.emtrN; % wbref
y5 = T15.emtrN; % bvs+schalen+bbszref
y6 = T16.emtrN; % allref

% x, y1, 'g', x, y2, 'r', x, y3, 'c',  x, y4, 'm', x, y5, 'y', x, y6, 'k'

figure
plot(x(2:8501, 1), y0(2:8501, 1), 'b', x(2:8501, 1), y6(2:8501, 1), 'k')
legend('no reform', 'all reform')