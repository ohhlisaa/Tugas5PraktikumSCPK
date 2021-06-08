namaNasabah = {'Sofia' 'Lisa' 'Malik' 'Zayn'};
data = [ 200 90 50
         150 85 40
         100 70 30
         50 55 20];
%batas kriteria
maksGaji = 200;
maksJenisPekerjaan = 100;
maksUsia = 60;

data(:,1) = data(:,1) / maksGaji;
data(:,2) = data(:,2) / maksJenisPekerjaan;
data(:,3) = data(:,3) / maksUsia;

relasiAntarKriteria = [ 1     2     2
                        0     1     4
                        0     0     1];
        
TFN = {[-100/3 0     100/3]     [3/100  0     -3/100]
       [0      100/3 200/3]     [3/200  3/100 0     ]
       [100/3  200/3 300/3]     [3/300  3/200 3/100 ]
       [200/3  300/3 400/3]     [3/400  3/300 3/200 ]};
   
[RasioKonsistensi] = HitungKonsistensiAHP(relasiAntarKriteria)

if RasioKonsistensi < 0.10
    % Metode Fuzzy AHP
    [bobotAntarKriteria, relasiAntarKriteria] = FuzzyAHP(relasiAntarKriteria, TFN);    

    % Hitung nilai skor akhir 
    ahp = data * bobotAntarKriteria';
    
    disp('Hasil Perhitungan dengan metode Fuzzy AHP')
    disp('Nama Nasabah, Skor Akhir, Kesimpulan')
end
    for i = 1:size(ahp, 1)
        if ahp(i) < 0.6
            status = 'Kurang';
        elseif ahp(i) < 0.7
            status = 'Cukup';
        elseif ahp(i) < 0.8
            status = 'Baik';
        else
            status = 'Sangat Baik';
        end
        
        disp([char(namaNasabah(i)), blanks(13 - cellfun('length',namaNasabah(i))), ', ', ... 
             num2str(ahp(i)), blanks(10 - length(num2str(ahp(i)))), ', ', ...
             char(status)])
    end
