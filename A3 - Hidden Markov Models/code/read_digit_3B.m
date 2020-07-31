clc; clear;

%names = [ "11.txt"; "13.txt";  "14.txt"; "19.txt"; "31.txt"; "33.txt";"34.txt";"39.txt";"41.txt";"43.txt";"44.txt";"47.txt";"71.txt";"74.txt";"77.txt";"79.txt";"91.txt";"93.txt";"97.txt";"99.txt"; "111.txt";"141.txt";"171.txt";"174.txt";"331.txt";"344.txt";"393.txt"; "413.txt";"434.txt";"449.txt";"477.txt";"711.txt";"747.txt";"779.txt";"914.txt";"933.txt";"949.txt"; "991.txt"];
for i=1:5
    %fileID = fopen(sprintf("1_dev_3B/%s",names(i)), "r");
    
    Train1{i} = readmatrix(sprintf("1_test_3B/%d",i));

    %clear fileID;
end