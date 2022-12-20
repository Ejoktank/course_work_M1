file = '01_su_euler_2.txt'
set xlabel 'время' font ',14'
set ylabel 'перемещение' font ',14' offset 2
plot file u 1:50 w l title 'в точке 1.7',\
     file u 1:51 w l title 'в точке 3.6',\
     file u 1:52 w l title 'в точке 5.9',\
     file u 1:53 w l title 'в точке 8.7',\
     file u 1:54 w l title 'в точке 11.9',\
     file u 1:55 w l title 'в точке 15.8',\
     file u 1:56 w l title 'в точке 20.3