function [ L ] = Observateurflou(r,A,C)
% Cette fonction calucle les gain L de l'observateur qui assure que la paire A',C' stable
% A et B matrices tridimentionnelle(tableau tridimentionnel) de dimension 3
% qui represente le modele de Takagi-Sogeno
% r : nombre de modele locaux /nombre de regles

n = size(A(:,:,1),1); %nbre d'état par rapport aux lignes A1
p = size(C(:,:,1),1); %nbre de sorties / ou colomne de C1 (m =1)
N = struct('matrix',{zeros(n,p)});
L = struct('matrix',{zeros(n,p)});
%%
setlmis([]); %le debut de LMI.

P = lmivar(1,[n 1]); % X symetrique pleinne (n*n)
M = lmivar(1,[n 1]); % M symetrique pleinne (n*n)
for i=1:r
N(i).matrix = lmivar(2,[n p]); %rectangulaire (m*n)
end

lmiterm([1 1 1 0],1)    % LMI#n°1 I<X:I
lmiterm([-1 1 1 P],1,1) % LMI#n°1 I<X:X
lmiterm([1 1 1 0],1)    % LMI#n°1 I<M:I
lmiterm([-1 1 1 M],1,1) % LMI#n°1 I<M:M

nb = 0;
 for i=1:r
   j=i+1; %initialisation de j
   while(j<=r)
      nb=i+j; 
      lmiterm([nb 1 1 P],1,A(:,:,i),'s') % Ai'P+P.Ai
      lmiterm([nb 1 1 P],1,A(:,:,j),'s') % Aj'P+P.Aj
      lmiterm([nb 1 1 N(j).matrix],-1,C(:,:,i),'s') % -Nj'.Bi'-Bi.Nj      ...  LMI#n°3/nombres LMI égale:2nl-3=1
      lmiterm([nb 1 1 N(i).matrix],-1,C(:,:,j),'s') % -Ni'.Bj'-Bj.Ni
      lmiterm([nb 1 1 M],-1,1) % -M1
      j=j+1; %incrémentation de j
   end
 end
 
 for i=1:r
 nb = nb+1;     
 lmiterm([nb 1 1 P],1,A(:,:,i),'s') %Ai'.P+P.Ai
 lmiterm([nb 1 1 N(i).matrix],-1,C(:,:,i),'s') %-Ci'.Ni'-Ni.Ci
 lmiterm([nb 1 1 M],(r-1),1)
end    
lmis = getlmis; % La fin de LMI.  
%% finding matrix variables X and Ni if feasible(tmin<0)
  [t,xfeas] = feasp(lmis,[zeros(1,4) 1]);
%%
if t<= 0   
  P = dec2mat(lmis,xfeas,P);
   for i=1:r
N(i).matrix = dec2mat(lmis,xfeas,N(i).matrix);
   end
M = inv(P);
P = M;
for i=1:r
L(i).matrix = P*(N(i).matrix);
end
%%
disp ("=====================================");
disp ("Les gains de l'observateurs sont");
for i=1:r
disp ("=====================================");
disp (["L" i]);
disp(L(i).matrix)
end
disp ("=====================================");
else 
    disp ("Le systeme LMI ne peut pas etre resolu");
    L = NaN;
end
end