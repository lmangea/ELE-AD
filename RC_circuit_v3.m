%% 
% *A Mathematical Modeling Example Using a an RC circuit*
% 
% An RC circuit is an electrical device with a resistor (that's the R) and 
% a capacitor (that's the C).  A resistor allows current to flow through it when 
% a voltage is applied, but there's a resulting drop in voltage proportional to 
% the resistance (R) and proportional to the current flowing through it.  A capacitor 
% allows current to flow through it, but over time a charge builds up across the 
% structures inside it and that build up gradually impedes further flow of electrical 
% current.  A capacitor builds up charge proportional to the area under the current 
% versus time curve and inversely proportional to capacitance (C) or else proportional 
% to 1/C.  If a resistor of resistance R and capacitor (as yet uncharged) of capacitance 
% C are connected in series and then connected to a DC voltage source of voltage 
% ${V_s}$, a mathematical model of the resulting voltage measured across the capacitor 
% ${V_c}(t)$ which changes over time $t$ is:  
% 
% $$V_c(t)={V_s}(1-e^{-t/RC})$$
% 
% 
% 
% 
% 
% 
% 
%   
% 
% *Question #1*  Is the proposed equation dimensionally homogeneous?
% 
% a) Yes.  
% 
% b) Only if $RC$ turns out to have units of time such as seconds    
% 
% c) Only if $RC$ is measured in units of 1/ time such as $ \frac{1}{sec}}$ 
% 
% d) Only if $V_s$ and ${V_c}(t)$have the same units to describe their voltage 
% such as Volts
% 
% e) both b and d
% 
% *Question #1 solution material*
%%
mupad
%% 
% *Paste the following into the mupad window:*
% 
% |t:=100*unit::s;|
% 
% |R:=200*unit::Ohm;|
% 
% |C:=5*unit::Farad;|
% 
% |V_s:=12*unit::V;|
% 
% |V_c:=1*unit::V;|
% 
% |Simplify(V_c-V_s*(1-exp(-t/(R*C))));|
% 
% *If the units are correct, then the mupad will generate an answer in consistent 
% units such as 0.7 Volts.*
% 
% *Question #2*  Which of the following plots is the most reasonable representation 
% of the change in voltage measured across the capacitor ${V_c}(t)$over time given 
% the model $V_c(t)={V_s}(1-e^{-t/RC})$
% 
% a) 
% 
% 
% 
%          
% 
% b)
% 
% 
% 
% c) 
% 
% 
% 
% d) None of the above
% 
% **
% 
% *Question #2 solution material*
%%
% Let's say we choose numerical values for the unknowm parameters
R=100; % resistance in Ohms
C=15*10^-6; % capacitance in Farads
V_s=12; % source DC voltage in Volts
V_c= @(t) (V_s)*(1-exp(-t/(R*C)));
step=0.01*R*C;
t=0:step:4*R*C; % choose a range of values to plot
figure(1)
plot(t,V_c(t),'k')
hold on
plot([0 4*R*C],[V_s V_s],'r--') 
ylim([0 13])
xlabel('time (seconds)')
ylabel('voltage across capacitor (Volts)')
%% 
% **
% 
% *Question #3*  Let's say a substantial time has passed such as
% 
% $$t=100RC$$
% 
% and we masure the voltage across the capacitor as 11.9V.  What can we conclude 
% about parameter $V_s$ assuming our model?
% 
% a) $V_s$ is approximately $12 \frac{1}{sec}$   
% 
% b) $V_s$ is approximately 12$ V$
% 
% c)  $V_s$ is approximately $1/12 \frac{1}{V}$
% 
% d) It is not possible to make an estimate within 5% without determining 
% the value of R
%%
syms V_s V_c R C t 
t=100*R*C;
V_c=11.9;
solve(V_c==V_s*(1-exp(-t/(R*C))),V_s)
double(ans)
% We see that the symbolic answer given here is about 0.5
%% 
% **
% 
% *Question #4*  Let's say we have further refined the model so that we now 
% propose $V_c(t)=(1-e^{-t/RC})12.1$Volts
% 
% and we measure the voltage across the capacitor $V_c$ as 0.9 Volts at time 
% $t=0.001sec$  
% 
% and we masure the voltage across the capacitor $V_c$ as 5.5 Volts at time 
% $t=0.01sec$  
% 
% What can we conclude about the product $RC $?
% 
% a) $RC $ is approximately $0.2 sec$   
% 
% b) $RC $ is approximately $2 sec$  
% 
% c) $RC $ is approximately $20 sec$  
% 
% d) The available information is contradictory so more investigation should 
% be done before estimating the value of $RC $ 
%%
% One approach is to solve for the value of RC for each point
syms RC
t=0.001;
V_c=0.72;
solve(V_c==12.1*(1-exp(-t/RC)),RC)
double(ans)
% We see that the answer based on V_c(0.001)=0.72 is close to 0.0166 (about 2% low)
t=0.01;
V_c=5.5;
solve(V_c==12.1*(1-exp(-t/RC)),RC)
double(ans)
% We see that the answer based on V_c(0.01)=5.5 is also close to 0.0166 (about 0.6% low)
% NOTE: I would argue that the point V_c(0.001)=0.72 is not a very reliable one for
% estimating RC if used by itself.  It is so close to another point we have
% V_c(0)=0 so that small errors in measuring V_c(0.001) amplify into large error in RC

% Another approach is to try fitting the curve to both points in a least squares sense
h=@(t,RC) 12.1*(1-exp(-t/RC));
sq_error=@(RC) (5.5-h(0.01,RC))^2+(0.72-h(0.001,RC))^2;
best_RC = fmincon(sq_error,1)
% Again, the answer is very close to 0.0166

% Plot the result as a check on the work
figure(3)
t=0:0.001:best_RC*3;
plot(t, 12.1*(1-exp(-t/best_RC)))
hold on
plot(0.01,5.5,'ro')
plot(0.001,0.72,'ro')
xlabel('time (seconds)')
ylabel('voltage across capacitor (Volts)')
%% 
% **
% 
% *Question #5*  Let's say we have further refined the model so that we now 
% propose 
% 
% $V_c(t)=(1-e^{-t/0.017sec})12.1$Volts
% 
% Estimate the initial rate (at t=0) at which the voltage across the capacitor 
% is increasing.
% 
% a) the rate of change in height is approximately 700 Volts/sec   
% 
% b) the rate of change in height is approximately 2Volts/sec 
% 
% c) the rate of change in height is much faster than (a)
% 
% d)  the rate of change in height is much slower than (b) 
% 
% e) none of the above
%%

% One approach is to try a finite difference
V_c=@(t,tau) 12.1*(1-exp(-t/0.017));
slope = (V_c(0.001)-V_c(0))/0.001
% The answer is very close to 700 Volts/sec
%% 
% **
% 
% *Question #6*  Let's say our current best model of performance of the current 
% design is
% 
% $V_c(t)=(1-e^{-t/0.017sec})12.1$Volts.  Our team has considered the analysis 
% and concluded that the time for the capacitor to go from zero voltage to 80% 
% of 12.1 Volts is too long.  The team wants to cut the time substantially without 
% substantially changing the voltage across the capacitor at long times such as 
% 100$RC$.    One team member proposed to change the design so that another resistor 
% is placed in parallel with the resistor R.  The new resistor has half resistance 
% of the other one $R_{new}=R/2$.   The new capacitor has the substantially higher 
% capacitance compared to the other one $C_{new}=10C$.   The circuit is designed 
% so that the switch is initially closed when the battery is connected at t=0 
% and then the switch opens once the capacitor reaches 75% of 12.1 Volts (that 
% is, when $V_c(t)=0.80*12.1$Volts. Which statement most accurately characterizes 
% this proposed design change?
% 
% 
% 
% 
% 
% a) The new circuit will change the final value of voltage on the capacitor 
% whose capacitance is $C$    
% 
% b) The new circuit will cut the time the capacitor whose capacitance is 
% $C$ takes to reach 80% of 12.1V, but by less than 5%  
% 
% c) The new circuit will cut the time the capacitor whose capacitance is 
% $C$ takes to reach 80% of 12.1V by around a factor of 2 
% 
% d) None of the above
%%
% One approach is to try simulating the behavior of the circuit

% First, model the previous / unmodified design
V_c=0; % initial capacitor voltage
R=100; % resistance in Ohms
C=15*10^-6; % capacitance in Farads
V_s=12.1; % source DC voltage in Volts
delta_t=R*C/100; % thousandths of second steps
t_final=6*R*C; % cover six periods of length RC

for t=0:delta_t:t_final
    I=(V_s-V_c(end))/R; % how a resistor works
    V_c=[V_c V_c(end)+(I/C)*delta_t];
end

figure(5)
plot([0:(length(V_c)-1)]*delta_t,V_c,'k')
hold on
plot([0:(length(V_c)-1)]*delta_t,0.8*V_s*ones(1,length(V_c)),'r--')
xlabel('time (seconds)')
ylabel('Voltage across capacitor')
ylim([0 14])

time_80pct=(max(find(V_c<0.8*V_s)))*delta_t

% Now, model the modified design
V_c=0; % initial capacitor voltage
V_cnew=0; % for the new one -- initial capacitor voltage
R=100; % original resistor
Rnew=R/2; % newly added resistor
C=15*10^-6; % capacitance in Farads
C_new=10*C;
V_s=12.1; % source DC voltage in Volts
delta_t=R*C/100; % thousandths of second steps
t_final=6*R*C; % cover six periods of length RC

t=0;

while V_c(end)<0.75*V_s
    Iold=(V_s-V_c(end))/R;
    Inew=(V_s-V_c(end)-V_cnew(end))/Rnew;
    I=Iold+Inew;
    V_c=[V_c V_c(end)+(I/C)*delta_t];
    V_cnew=[V_cnew V_cnew(end)+(Inew/C_new)*delta_t];
    t=t+delta_t;
end

close_switch=[t, V_c(end)];

for t2=t:delta_t:t_final
    I=(V_s-V_c(end)-V_cnew(end))/R; 
    V_c=[V_c V_c(end)+(I/C)*delta_t];
end

figure(6)
plot([0:(length(V_c)-1)]*delta_t,V_c,'k')
hold on
plot(close_switch(1),close_switch(2),'ro')
plot([0:(length(V_c)-1)]*delta_t,0.8*V_s*ones(1,length(V_c)),'r--')
xlabel('time (seconds)')
ylabel('Voltage across capacitor')
ylim([0 14])

time_80pct_new=(max(find(V_c<0.8*V_s)))*delta_t