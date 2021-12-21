function [ P,S ] = Stableornot(r, A )
%  Description: 
% Cherche la matrice P definit positive pour voir si le systeme est stable.
% A  matrice tridimentionnelle(tableau tridimentionnel) de dimension 3
% qui represente le modele de Takagi-Sogeno
% r : nombre de modeles locaux (nombre de règles)
% S = 1 : si le systeme est stable.
% S = 0 : si le systeme est instable.
n = size(A(:,:,1),1); %nbre d'état par rapport aux lignes A1
%%
setlmis([]) %le debut de LMI.
P = lmivar(1,[n 1]); %declarer une variable P

%la boucle for remplace l'ecriture des termes ci-dessus
nb = 0; %initialisation, nb = i : LMI(i)
for i=1:r
    nb = nb+1;
   lmiterm([nb 1 1 P],1,A(:,:,i),'s')
end   
%Pour assurer que P est definit positive. I<P
lmiterm([-(nb+1) 1 1 P],1,1);    %LMI nb+1: P
lmiterm([(nb+1) 1 1 0],1) ;      %LMI nb+1: I
lmis = getlmis; % La fin de LMI.
%%
%find a feasible decision vector
[t,xfeas] = feasp(lmis,[zeros(1,4) 1]);
if t<= 0 
P = dec2mat(lmis,xfeas,P);
%%
disp ("=================================");
disp ("la solution est :");
disp(P);
disp ("les valeur propre de P");
disp(eig(P));
disp ("*************************");
try chol(P);
    disp('le systeme est stable.')
    S=1;
catch 
    disp('le systeme est instable')
    S=0;
end    
disp ("*************************");
else 
    disp('Nothing to Say') 
    K=NaN;
    S=0;
end
end