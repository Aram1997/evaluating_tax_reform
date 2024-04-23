%% Import section work
be2022std = importfile("<<PATH>>", [2, Inf]);
reform_2022_alles_std = importfile("<<PATH>>", [2, Inf]);
reform_2022_bbsz_std = importfile("<<PATH>>", [2, Inf]);
reform_2022_bvs_schalen_bbsz_std = importfile("<<PATH>>", [2, Inf]);
reform_2022_bvs_schalen_std = importfile("<<PATH>>", [2, Inf]);
reform_2022_geen_hc_std = importfile("<<PATH>>", [2, Inf]);
reform_2022_wb_mediaan_std = importfile("<<PATH>>", [2, Inf]);

%% Import section unemployed
ube2022std = importfile("<<PATH>>", [2, Inf]);
ureform_2022_alles_std = importfile("<<PATH>>", [2, Inf]);
ureform_2022_bbsz_std = importfile("<<PATH>>", [2, Inf]);
ureform_2022_bvs_schalen_bbsz_std = importfile("<<PATH>>", [2, Inf]);
ureform_2022_bvs_schalen_std = importfile("<<PATH>>", [2, Inf]);
ureform_2022_geen_hc_std = importfile("<<PATH>>", [2, Inf]);
ureform_2022_wb_mediaan_std = importfile("<<PATH>>", [2, Inf]);
%% Select only sections needed
T10 = be2022std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim"]);
T11 = reform_2022_bvs_schalen_std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim"]);
T12 = reform_2022_bbsz_std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim"]);
T13 = reform_2022_geen_hc_std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim"]);
T14 = reform_2022_wb_mediaan_std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim"]);
T15 = reform_2022_bvs_schalen_bbsz_std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim"]);
T16 = reform_2022_alles_std(:, ["ils_earns", "ils_sicee", "ils_tax", "ils_dispy", "ils_taxsim"]);

U10 = ube2022std(:, ["ils_ben", "ils_tax"]);
U11 = ureform_2022_bvs_schalen_std(:, ["ils_ben", "ils_tax"]);
U12 = ureform_2022_bbsz_std(:, ["ils_ben", "ils_tax"]);
U13 = ureform_2022_geen_hc_std(:, ["ils_ben", "ils_tax"]);
U14 = ureform_2022_wb_mediaan_std(:, ["ils_ben", "ils_tax"]);
U15 = ureform_2022_bvs_schalen_bbsz_std(:, ["ils_ben", "ils_tax"]);
U16 = ureform_2022_alles_std(:, ["ils_ben", "ils_tax"]);
%% PTR calculation
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

for i = 1:1:size(T10, 1)
    delta_c_i10(i, 1) = table2array(T10(i, 4)) - table2array(U10(i, 1));
    delta_y_i10(i, 1) = table2array(T10(i, 1));
    delta_c_i11(i, 1) = table2array(T11(i, 4)) - table2array(U10(i, 1));
    delta_y_i11(i, 1) = table2array(T11(i, 1));
    delta_c_i12(i, 1) = table2array(T12(i, 4)) - table2array(U10(i, 1));
    delta_y_i12(i, 1) = table2array(T12(i, 1));
    delta_c_i13(i, 1) = table2array(T13(i, 4)) - table2array(U10(i, 1));
    delta_y_i13(i, 1) = table2array(T13(i, 1));
    delta_c_i14(i, 1) = table2array(T14(i, 4)) - table2array(U10(i, 1));
    delta_y_i14(i, 1) = table2array(T14(i, 1));
    delta_c_i15(i, 1) = table2array(T15(i, 4)) - table2array(U10(i, 1));
    delta_y_i15(i, 1) = table2array(T15(i, 1));
    delta_c_i16(i, 1) = table2array(T16(i, 4)) - table2array(U10(i, 1));
    delta_y_i16(i, 1) = table2array(T16(i, 1));
end

U10.ptr10 = 1 - (delta_c_i10 ./ delta_y_i10);
U11.ptr11 = 1 - (delta_c_i11 ./ delta_y_i11);
U12.ptr12 = 1 - (delta_c_i12 ./ delta_y_i12);
U13.ptr13 = 1 - (delta_c_i13 ./ delta_y_i13);
U14.ptr14 = 1 - (delta_c_i14 ./ delta_y_i14);
U15.ptr15 = 1 - (delta_c_i15 ./ delta_y_i15);
U16.ptr16 = 1 - (delta_c_i16 ./ delta_y_i16);


%% Graph Making

x = T10.ils_earns;
y0 = U10.ptr10; % no ref
y1 = U11.ptr11; % bvs en schijven
y2 = U12.ptr12; % bbsz
y3 = U13.ptr13; % geen hc (dus geen effect)
y4 = U14.ptr14; % wb naar mediaan
y5 = U15.ptr15; % bvs en schijven en bbsz
y6 = U16.ptr16; % alles

% x, y1, 'g', x, y2, 'r', x, y3, 'c',  x, y4, 'm', x, y5, 'y', x, y6, 'k'

figure
plot(x, y0, 'b', x, y6, 'k')
legend('no reform', 'all reform')