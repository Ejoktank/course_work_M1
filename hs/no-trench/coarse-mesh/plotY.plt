file = '01_su_euler_2.txt'
set xlabel '�����' font ',14'
set ylabel '�����������' font ',14' offset 2
plot file u 1:50 w l title '� ����� 1.7',\
     file u 1:51 w l title '� ����� 3.6',\
     file u 1:52 w l title '� ����� 5.9',\
     file u 1:53 w l title '� ����� 8.7',\
     file u 1:54 w l title '� ����� 11.9',\
     file u 1:55 w l title '� ����� 15.8',\
     file u 1:56 w l title '� ����� 20.3