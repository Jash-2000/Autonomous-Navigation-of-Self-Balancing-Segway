%%%%%%%%%%%%%%%%
% Bacteria cell to cell attraction function
function [Jar]=bact_cellcell_attract_func(x,theta,S, scale)  
% Calculates the cell-to-cell interaction function, given locations of all bacteria
% for all the S number of bacteria.

% if flag==2  % Test to see if main program indicated cell-cell attraction
% 	Jar=0;
% 	return
% end

depthattractant=0.005;  % Sets magnitude of secretion of attractant by a cell
widthattractant=0.1;  % Sets how the chemical cohesion signal diffuses (smaller makes it diffuse more)

heightrepellant=0.1*depthattractant; % Sets repellant (tendency to avoid nearby cell)
widthrepellant=0.1;  % Makes small area where cell is relative to diffusion of chemical signal
Jar=0;
x = (x - scale(1, :))./scale(2, :); % Normalize the different parameters 

for j=1:S		
	% Set how the cell attracts other cells via secretions of diffusable attractants
    Ja=-depthattractant*exp(-widthattractant*((x - theta(j, :))*(x - theta(j, :))'));
	Jr=+heightrepellant*exp(-widthrepellant*((x - theta(j, :))*(x - theta(j, :))'));
	Jar=Jar+Ja+Jr;

end

