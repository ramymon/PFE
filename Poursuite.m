function [ K,M ] = Poursuite( A,B,C,r )
% Description :
% Cette fonction calucle les gain K et M qui assure que la paire A,B stable
% et la poursuite de la consigne.
% A, B et C matrices tridimentionnelle(tableau tridimentionnel) de dimension 3
% qui represente le modele de Takagi-Sogeno
% r : nombre de modele locaux /nombre de regles
%% creer un etat augmenté
% Dimensions:
n = size(A(:,1),1); % nombre d'états par rapport aux lignes A1.
m = size(B(:,1),2); % nombre d'entrées(ou colomnes) de B1 (systeme SISO : m =1 ).
p = size(C(:,1),1); % nombre de sorties(ou lignes) de C1 (systeme SISO : p =1).

%% creer des modeles vides
for i=1:r
Ap(i).sys = zeros(n+p,n+p);
Bp(i).sys = zeros(n+p,m);
K(i).sys = zeros(m,n);
M(i).sys = zeros(m,p);
end
%% Systeme augmenté :
for i=1:r
Ap(i).sys = [A(:,:,i) zeros(n,p);-C(:,:,i) zeros(p,p)];
Bp(i).sys = [B(:,:,i); zeros(p,m)];
end

Aa=cat(3,Ap(1:r).sys);
Ba=cat(3,Bp(1:r).sys);
%% Application de la même approche :
 Kp = GainfindV2(r,Aa,Ba,0);
if isstruct(Kp)
for i=1:r
S = Kp(i).matrix;
K(i).sys = S(:,1:n);
M(i).sys = S(:,n+1:n+p);
end
%%
disp ("=====================================");
disp ("Les gains qui assure la stabilié sont");
for i=1:r
disp ("=====================================");
disp (["K" i]);
disp(K(i).sys)
end
disp ("=====================================");
%%
disp ("=====================================");
disp ("Les gains qui assure la stabilié sont");
for i=1:r
disp ("=====================================");
disp (["M" i]);
disp(M(i).sys)
end
disp ("=====================================");
end

end

