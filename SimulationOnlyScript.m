c = menu('Votre choix','Simulation du mod�le de v�hicule  tout seul','Simulation du mod�le de v�hicule  en presence du v�hicule de tete','Sortir');
switch c
    case 1
choice = menu('Simulation :','Boucle ouverte (r�gime libre)','Stabilisation en boucle ferm� sans observateur','Stabilisation en boucle ferm� avec observateur','Poursuite de trajectoire sans observateur','Sortir');
switch choice
    case 1    
   SimLibre % Simulation en boucle ouverte  
    case 2 
   SimBF    % Simulation en boucle ferm� 
    case 3
   SimLBFObser     % Simulation en boucle ferm� avec observateur  :

    case 4
   SimuPoursuite % Simulation en boucle ferm�e (poursuite) sans observateur observateur  :
end
    case 2
 choice = menu('Simulation :','Simulation sans observateur','Simulation avec observateur (� faire)','Sortir');
  switch choice
    case 1    
   SimulerTous 
    case 2 
   SimulationAvecObservateur         
  end  
end