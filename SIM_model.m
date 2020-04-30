%SIM model, from Godley and Lavoie, Monetary Economics, ch. 3

%Created by Marco Veronese Passarella on 30 April 2020

%Close and clear everything
close all
clear all

%Define number of periods
nPeriods = 65;      

% Identify parameters
theta = 0.2;        % Tax rate
alpha1 = 0.6;       % Marginal propensity to consume out of income
alpha2 = 0.4;       % Marginal propensity to consume out of wealth

% Create variables
C = zeros(nPeriods,1);     % Consumption
Y = zeros(nPeriods,1);     % Output (national income)
YD = zeros(nPeriods,1);    % Disposable income
tax = zeros(nPeriods,1);   % Tax revenue
Hs = zeros(nPeriods,1);    % Money supply
Hh = zeros(nPeriods,1);    % Money demand
N = zeros(nPeriods,1);     % Labour
W = ones(nPeriods,1);      % Wages
G = zeros(nPeriods,1);     % Government spending
S = zeros(nPeriods,1);     % Saving (change in wealth)

%Create time loop
for t = 2:nPeriods
    
    for j = 1:20
    
        % Government spending (exogenous)
        if t>=14 G(t)=20;
                
        C(t) = alpha1*YD(t) + alpha2*Hh(t-1);
        Y(t) = C(t) + G(t);
        N(t) = Y(t)/W(t);
        tax(t) = theta*W(t)*N(t);                                       
        YD(t) = W(t)*N(t) - tax(t);                                     
        Hs(t) = Hs(t-1) + G(t) - tax(t);                                     
        S(t) = YD(t) - C(t);
        Hh(t) = Hh(t-1) + S(t);                                                                            
                
        end
    end
end


% Plots
periods = (1:nPeriods)';

subplot(2,1,1)
plot(periods, YD, 'r', periods, C, '--g', 'linewidth', 2)
legend('Disposable Income YD', 'Consumption C')
legend('location', 'east')
title('Figure 3.2 Disposable income and consumption starting from scratch') 

subplot(2,1,2)
yyaxis right
plot(periods, Hs, 'b', 'linewidth', 2)
yyaxis left
plot(periods, S, '-.r', 'linewidth', 2)
legend('Wealth level H (money stock)', 'Household saving (change in H)')
legend('location', 'east')
title('Figure 3.3 Wealth change and wealth level, starting from scratch')