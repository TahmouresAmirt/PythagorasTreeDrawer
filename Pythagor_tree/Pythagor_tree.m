%% This code is provided to draw the Pythagoras tree. 
%  Please follow the wiki to have more details of it.
%  Please run the program and enter the "m" and "n" values to begin. Try different values and enjoy. 
%  Also, you can change the colour theme for different trees.  

clc;
clear;
close all;
m = input('Please enter the length of one side: ');
n = input('Please enter the level of recursion (10 is ok): ');
%% Compute the values
    
d      = sqrt(1+m^2);                  % 
c1     = 1/d;                          % Normalized length 1
c2     = m/d;                          % Normalized length 2
T      = [0 1/(1+m^2);1 1+m/(1+m^2)];  % Translation pattern  
alpha1 = atan2(m,1);                   % Defines the first rotation angle
alpha2 = alpha1-pi/2;                  % Defines the second rotation angle
pi2    = 2*pi;                         % Defines pi2
nEle   = 2^(n+1)-1;                    % Number of elements (square)
M      = zeros(nEle,5);                % Matrice containing the tree
M(1,:) = [0 -1 0 1 1];                 % Initialization of the tree
%% Compute the level of each square
Offset = 0;
for i = 0:n
    tmp = 2^i;
    M(Offset+(1:tmp),5) = i;
    Offset = Offset + tmp;
end
%% Compute the position and size of each square
for i = 2:2:(nEle-1)
    j          = i/2;
    c = cos(M(j,3));
    s = sin(M(j,3));
    mat_rot =[c -s; s c];
    mT         = M(j,4) * mat_rot * T;
    Tx         = mT(1,:) + M(j,1);
    Ty         = mT(2,:) + M(j,2);    
    theta1     = rem(M(j,3)+alpha1,pi2);
    theta2     = rem(M(j,3)+alpha2,pi2);
    M(i  ,1:4) = [Tx(1) Ty(1) theta1 M(j,4)*c1];
    M(i+1,1:4) = [Tx(2) Ty(2) theta2 M(j,4)*c2];
end
%% Display the tree
D = M;
ColorM1 = n;
ColorM2 = n;
ColorM3 = n;
ColorM4 = n;
%% Different colour type
    
if numel(ColorM1) == 1
    ColorM1 = flipud(gray(ColorM1+1));
end
if numel(ColorM2) == 1
    ColorM2 = flipud(winter(ColorM2+1));
end
if numel(ColorM3) == 1
    ColorM3 = flipud(spring(ColorM3+1));
end
if numel(ColorM4) == 1
    ColorM4 = flipud(summer(ColorM4+1));
end
%figure('color','w');
hold on
axis equal
axis off
t0 = 5;
% Drawing loop
for i=1:size(D,1)
    cx    = D(i,1);
    cy    = D(i,2);
    theta = D(i,3);
    si    = D(i,4);   
    cat = cos(theta);
    sat = sin(theta);
    Mat=[cat -sat; sat cat];
    x     = si*[0 1 1 0 0];
    y     = si*[0 0 1 1 0];
    pts   = Mat*[x;y];
   
    fill(cx+pts(1,:),cy+pts(2,:),ColorM1(D(i,5)+1,:));
    t = t0*(exp(-i*0.4));
    pause(t);
    %fill(cx+pts(1,:),cy+pts(2,:),ColorM2(D(i,5)+1,:));
   
   % fill(cx+pts(1,:),cy+pts(2,:),ColorM3(D(i,5)+1,:));
   % fill(cx+pts(1,:),cy+pts(2,:),ColorM4(D(i,5)+1,:));
   
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
