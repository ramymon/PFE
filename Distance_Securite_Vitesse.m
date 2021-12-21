% la distance de sécurité en fonction de la vitesse :
dmin = 5;
f = 0.021;
tr = 1;
v = 0:0.1:50;
d = dmin+tr*v+f*(v.^2);
dcr =2*v;
plot(v,d,'r.-')

hold on
plot(v,dcr,'b.-')
l=legend('Distance inter-véhicules selon l''equation dynamique (m)','Distance inter-véhicules selon le code de la route (m)');
l.FontSize = 9;
set(l,'position',[0.7 0.71 0.2 0.2])
y=ylabel('Distance inter-véhicules (m)');
y.FontSize = 16;
x=xlabel('Vitesse du véhicule (m/s)');
x.FontSize = 16;
grid on