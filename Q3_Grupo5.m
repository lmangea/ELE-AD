figure(1) % A figura 1 irá representar uma fonte de pulsos de uma função degrau e pulso permanece constante 
%até o instante t=10^-6s.
n=1;
for t=0:0.1:2000; % essa função representa o intervalo de tempo que será apresentado no gráfico
x(n)=t;
if x(n)<=1000
x(n);
y(n)=1;
else if x(n)>=1000
y(n)=0;
end
end
n=n+1;
end % todo os comandos apresentados são para controlar a função degrau
plot (x*10^-2,y) % esse comando irá efetivamente mostrar o gráfico tempo(µs) x tensão (volts)
xlabel('tempo em µs')
ylabel('tensão de entrada')
% O código acima descreve a tensão inicial do pulso.

figure(2) % Gráfico da tensão de saída 
Vs=1; % Vs descreverá a tensão de entrada do pulso que escolhemos ( a função degrau )
R=200*10^3; % Resistência em série com o indutor em Ohms
L=150*10^-3; % O valor da indutância do indutor em Henry
t=[0:0.5*10^-6:10*10^-6]; % intervalo de tempo que analisaremos a tensão do indutor que irá ate 10^10-6 s
Vl=Vs*(exp(-1*t/(L/R))); % Equação da tensão de saída
plot(t,Vl) % Plotar o gráfico tensão de saída (V) x Tempo (µs)
xlabel ("tempo(s)");
ylabel ("Tensao de saida (Vl)");


figure(3) % Gráfico da corrente de saída do indutor
Vs=1;
R=200*10^3;
L=150*10^-3;
t=[0:0.5*10^-6:10*10^-6];
Il=(Vs/R)-(Vs/R)*(exp(-1*t/(L/R))); % Equação da corrente do indutor
plot(t,Il*10^6) % Plotar o gráfico da corrente do indutor (A) x Tempo (µs)
xlabel("tempo(s)");
ylabel("Corrente de saida Il (A)");

% A questão 7.89 do livro base descreve sobre um circuito RL que para ser diferenciador deve possuir características específicas 
% Ao resolvermos o circuito encontramos que L<200 mH, com isso, o valor utilizado no exercício foi L=150 mH,
% Ao analisarmos o circuito percebemos que a sua estrutura é diferente, visto que num circuito RC, fica o capacitor e logo após o resistor
% porém quando usamos um circuito RL, primeiro vem o resistor e logo após o capacitor.
% Os gráficos de RC e RL são parecidos 
% Os circuitos RL e RC podem ser observados no https://www.multisim.com/content/VQSqTNwUmV4zpBgtFFVcwg/ckt-rl-dif/, https://www.multisim.com/content/jnsHN6gfk9rbqmWaa5CqLo/rc-unit-pulse-response-differentiator-output/, respectivamente.