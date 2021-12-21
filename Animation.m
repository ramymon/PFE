% Pour voir l'animation il faut des données (executer Mainscript+Data+Simulation)
figure('Units','normalized','Position',[0 0 1 1])
L = 4 ; B = 1 ;
O = [0 -0.5 ; L -0.5 ; L B-0.5 ; 0 B-0.5; 0 -0.5] ;
VoitureT = O ;
VoitureS = O ;

 pathT = xt.signals.values;
 l=length(pathT);
mm =linspace( -60,pathT(l),floor(l/4));
mmm=zeros(length(mm),1 );
nn =linspace( -60,pathT(l),floor(l));
nnn =ones(length(nn),1 );
 pathS = xs.signals.values;
 hold on
for i = 1:2100
    
plot(VoitureS(:,1)+pathS(i),VoitureS(:,2),'b')
hold on
plot(VoitureT(:,1)+pathT(i),VoitureT(:,2),'r');
l=legend('la vitess du vehicule suiveur :  ['+string(round((Vs.signals.values(i))*3.6,2))+'Km/h].','la vitess du vehicule de tete :   ['+string(round((Vt.signals.values(i))*3.6,2))+'Km/h].');
l.FontSize = 18;
x=xlabel('la distance inter vehiculaire  ['+string(dist.signals.values(i))+']  m');
x.FontSize = 18;

hold on
plot(nn,nnn,'k*-')
hold on
plot(nn,1.2*nnn,'k*-')

hold on
plot(nn,-nnn,'k*-')
hold on
plot(nn,-1.2*nnn,'k*-')
hold on
plot(mm,mmm,'g>--')
clc
disp('la vitess du vehicule de tete')
disp(Vt.signals.values(i))
disp('===================================')
disp('la vitess du vehicule suiveur')
disp(Vs.signals.values(i))
disp('===================================')
disp('la distance inter vehiculaire')
disp(dist.signals.values(i))
disp('===================================')
hold off
      
axis([-60+pathT(i) pathT(i)+7 -5 5])
drawnow
pause(0.1)
    
end