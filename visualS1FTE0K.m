%% Import section
be2022std = importfile("<<PATH>>", [2, Inf]);
reform_2022_alles_std = importfile("<<PATH>>", [2, Inf]);
reform_2022_bbsz_std = importfile("<<PATH>>", [2, Inf]);
reform_2022_bvs_schalen_bbsz_std = importfile("<<PATH>>", [2, Inf]);
reform_2022_bvs_schalen_std = importfile("<<PATH>>", [2, Inf]);
reform_2022_geen_hc_std = importfile("<<PATH>>", [2, Inf]);
reform_2022_wb_mediaan_std = importfile("<<PATH>>", [2, Inf]);

%% Select only sections needed
T10 = be2022std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim"]);
T11 = reform_2022_bvs_schalen_std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim"]);
T12 = reform_2022_bbsz_std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim"]);
T13 = reform_2022_geen_hc_std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim"]);
T14 = reform_2022_wb_mediaan_std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim"]);
T15 = reform_2022_bvs_schalen_bbsz_std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim"]);
T16 = reform_2022_alles_std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim"]);

%% EMTR calculation
delta_c_i10 = zeros(8501,1);
delta_y_i10 = zeros(8501,1);
delta_c_i11 = zeros(8501,1);
delta_y_i11 = zeros(8501,1);
delta_c_i12 = zeros(8501,1);
delta_y_i12 = zeros(8501,1);
delta_c_i13 = zeros(8501,1);
delta_y_i13 = zeros(8501,1);
delta_c_i14 = zeros(8501,1);
delta_y_i14 = zeros(8501,1);
delta_c_i15 = zeros(8501,1);
delta_y_i15 = zeros(8501,1);
delta_c_i16 = zeros(8501,1);
delta_y_i16 = zeros(8501,1);

for i = 2:1:size(T10, 1)
    delta_c_i10(i, 1) = table2array(T10(i, 4) - T10(i-1, 4));
    delta_y_i10(i, 1) = table2array(T10(i, 1) - T10(i-1, 1));
    delta_c_i11(i, 1) = table2array(T11(i, 4) - T11(i-1, 4));
    delta_y_i11(i, 1) = table2array(T11(i, 1) - T11(i-1, 1));
    delta_c_i12(i, 1) = table2array(T12(i, 4) - T12(i-1, 4));
    delta_y_i12(i, 1) = table2array(T12(i, 1) - T12(i-1, 1));
    delta_c_i13(i, 1) = table2array(T13(i, 4) - T13(i-1, 4));
    delta_y_i13(i, 1) = table2array(T13(i, 1) - T13(i-1, 1));
    delta_c_i14(i, 1) = table2array(T14(i, 4) - T14(i-1, 4));
    delta_y_i14(i, 1) = table2array(T14(i, 1) - T14(i-1, 1));
    delta_c_i15(i, 1) = table2array(T15(i, 4) - T15(i-1, 4));
    delta_y_i15(i, 1) = table2array(T15(i, 1) - T15(i-1, 1));
    delta_c_i16(i, 1) = table2array(T16(i, 4) - T16(i-1, 4));
    delta_y_i16(i, 1) = table2array(T16(i, 1) - T16(i-1, 1));
end

T10.emtr10 = 1 - (delta_c_i10 ./ delta_y_i10);
T11.emtr11 = 1 - (delta_c_i11 ./ delta_y_i11);
T12.emtr12 = 1 - (delta_c_i12 ./ delta_y_i12);
T13.emtr13 = 1 - (delta_c_i13 ./ delta_y_i13);
T14.emtr14 = 1 - (delta_c_i14 ./ delta_y_i14);
T15.emtr15 = 1 - (delta_c_i15 ./ delta_y_i15);
T16.emtr16 = 1 - (delta_c_i16 ./ delta_y_i16);


%% Graph Making

x = T10.ils_earns;
y0 = T10.emtr10; % no ref
y1 = T11.emtr11; % bvs en schijven
y2 = T12.emtr12; % bbsz
y3 = T13.emtr13; % geen hc (dus geen effect)
y4 = T14.emtr14; % wb naar mediaan
y5 = T15.emtr15; % bvs en schijven en bbsz
y6 = T16.emtr16; % alles

% x, y1, 'g', x, y2, 'r', x, y3, 'c',  x, y4, 'm', x, y5, 'y', 

figure
plot(x, y0, 'b', x, y4, 'm')
legend('no reform', 'all reform')