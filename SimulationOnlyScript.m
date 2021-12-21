c = menu('Votre choix','Simulation du modèle de véhicule  tout seul','Simulation du modèle de véhicule  en presence du véhicule de tete','Sortir');
switch c
    case 1
choice = menu('Simulation :','Boucle ouverte (régime libre)','Stabilisation en boucle fermé sans observateur','Stabilisation en boucle fermé avec observateur','Poursuite de trajectoire sans observateur','Sortir');
switch choice
    case 1    
   SimLibre % Simulation en boucle ouverte  
    case 2 
   SimBF    % Simulation en boucle fermé 
    case 3
   SimLBFObser     % Simulation en boucle fermé avec observateur  :

    case 4
   SimuPoursuite % Simulation en boucle fermée (poursuite) sans observateur observateur  :
end
    case 2
 choice = menu('Simulation :','Simulation sans observateur','Simulation avec observateur (à faire)','Sortir');
  switch choice
    case 1    
   SimulerTous 
    case 2 
   SimulationAvecObservateur         
  end  
end