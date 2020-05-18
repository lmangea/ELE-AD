
%------------------------------------------------------------------------
%---Charging a RC circuit-----------------------------------------------
%-----------------------------------------------------------------------

clc
close all
clear all

R=0.5e6; % resistance of RC circuit in Ohms
C=1e-6;  % capacitance of RC circuit in Farads
V=50;  % Applied voltage in Volts

tau=R*C;   % time constant of RC circuit

T=3000;   % maximum time limit in millisecond
t=(1:T)./1000;

q=C*V*(1-exp(-t/(R*C)));
I=(V/R).*(exp(-t/(R*C)));
Imax=(V/R);
Qmax=(C*V);

figure (1)
   plot(t,q,'linewidth',2)
   line([tau tau], [0 0.632*Qmax],'color','r','Linestyle','-.')
   line([0 3], [0.632*Qmax 0.632*Qmax],'color','r','Linestyle','--')
   line([0 3], [Qmax Qmax],'color','r','Linestyle','--')
   text(0.55,0.35*Qmax,'\tau = RC , (time constant)','fontSize',14)
   text(0.7,0.67*Qmax,'Q(\tau) = 0.632 Q_{max}','fontSize',14)
   text(0.1,1.04*Qmax,'Q_{max} = CV','fontSize',14)

   axis([0 3 0 1.2*Qmax])
   h=gca; 
   get(h,'FontSize') 
   set(h,'FontSize',14)
   xlabel('t (sec)','fontSize',14);
   ylabel('Q (Coulombs)','fontSize',14);
   title('charge vs time','fontsize',14)
   fh = figure(1);
   set(fh, 'color', 'white'); 
   
   figure(2)
   plot(t,I,'linewidth',2)
   line([tau tau], [0 0.368*Imax],'color','r','Linestyle','-.')
   line([0 3], [0.368*Imax 0.368*Imax],'color','r','Linestyle','--')
   line([0 3], [Imax Imax],'color','r','Linestyle','--')
   text(0.1,0.15*Imax,'\tau = RC','fontSize',14)
   text(0.7,0.42*Imax,'I(\tau) = 0.368 I_{max}','fontSize',14)
   text(0.1,1.05*Imax,'I_{max} = V/R','fontSize',14)

   axis([0 3 0 1.2*V/R])
   h=gca; 
   get(h,'FontSize') 
   set(h,'FontSize',14)
   xlabel('t (sec)','fontSize',14);
   ylabel('I (amp)','fontSize',14);
   title('current vs time','fontsize',14)
   fh = figure(2);
   set(fh, 'color', 'white'); 
   
   %----------------------------------------------------------------------