% Khaled AbouShaban     101042658       PA7

set(0,'DefaultFigureWindowStyle','docked')
close all;
clear all;


R1 = 1;
Cap = 0.25;
R2 = 2;
L = 0.2;
R3 = 10;
alpha = 100;
R4 = 0.1; 
Ro = 1000; 

 C = [0 0 0 0 0 0 0;
     -(Cap) Cap 0 0 0 0 0;
     0 0 -L 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 0;
     0 0 0 0 0 0 0];
 
 G = [1 0 0 0 0 0 0;
     1/R1 -((1/R1) + (1/L)) 1/L 0 0 0 0;
      0 1 -1 0 0 0 0; 0 0 1/R3 0 0 0 -1;
      0 0 0 1 0 0 -alpha;
      0 0 0 1 0 -alpha 0;
      0 0 0 1/R4 -((1/R4) + (1/Ro)) 0 0];
 
 V1 = zeros(100, 1);
 VO = zeros(100, 1);
 V3 = zeros(100, 1);


Volt = 0;


F = [0; 
    0;
    0;
    0;
    0;
    0; 
    0];

 for Vin = -10:1:10       
    Volt = Volt + 1;
    F(1) = Vin;
    
    V = G\F;
    
    V1(Volt) = Vin;
    
    VO(Volt) = V(5);
    
    V3(Volt) = V(3);
    
 
    
end


figure(1)
subplot(2,2,1);
plot(V1, VO, 'r');
hold on;
plot(V1, V3, 'b');
% xlim([0 100])
% ylim([0 40])
xlabel('V_in')
ylabel('V')
legend ('VO','V3')



F = [10; 
    0;
    0;
    0;
    0;
    0; 
    0];

V3 = zeros(100, 1); 
w = zeros(1000, 1);
g = zeros(1000, 1);

for ACf = linspace(0,100,1000)
    
    Volt = Volt+1;
    
    V_f = (G+1j*ACf*C)\F;
    
    w(Volt) = ACf;
    
    V3(Volt) = norm(V_f(5));
    
    g(Volt) = norm(V_f(5))/10;
    

    
end 
   

subplot(2,2,2);
plot(w, V3, 'r')
hold on;
plot(w, g, 'b' )
% xlim([0 100])
% ylim([0 40])
xlabel('w')
ylabel('V')
legend ('VO','V3')


Cap_Arr = zeros(100,1);

G_Arr = zeros(100,1);

for iter = 1:1000
    
    std = 0.5;
    w = pi; 
    C_G = Cap + std*randn();
    
     C(2, 1) = C_G; 
     
     C(2, 2) = -C_G;
     
     C(3, 3) = L;
     
    V_f2 = (G+1i*w*C)\F;
    
    Cap_Arr(iter) = C_G;
    
    G_Arr(iter) = norm(V_f2(5))/10;
    
end



% Histogram Plots

subplot(2,2,3);
histogram(Cap_Arr,10)
% xlim([0.15 0.35])
% ylim([0 300])
xlabel('C');
ylabel('Number'); 


subplot(2,2,4);
histogram(G_Arr,10)
% xlim([7.5 9.5])
% ylim([0 300])
xlabel('Vo / Vi');
ylabel('Number'); 