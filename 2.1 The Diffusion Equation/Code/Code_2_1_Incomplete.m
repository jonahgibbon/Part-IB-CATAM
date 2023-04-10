format long
digits(8)

solutions=zeros(9,4);
counter=0;
while counter<=8
    solutions(counter+1,1)=0.125*counter;
    solutions(counter+1,2)=U1(0.125*counter,0.25,0.5*10^(-5));
    solutions(counter+1,3)=U2(0.125*counter,0.25,0.5*10^(-5));
    solutions(counter+1,4)=erfc(0.125*counter);
    counter=counter+1;
end
disp(solutions)
latex(sym(vpa(solutions)))

Counter=1;
T=[0.05 0.1 0.2 0.5 1 2];
%Calculating analytic solutions at different values of t
while Counter<=6
    t=T(Counter);
    solutions=zeros(9,4);
    counter=0;
    while counter<=8
        solutions(counter+1,1)=0.125*counter;
        solutions(counter+1,2)=U1(0.125*counter,t,0.5*10^(-5));
        solutions(counter+1,3)=U2(0.125*counter,t,0.5*10^(-5));
        solutions(counter+1,4)=erfc(0.125*counter/(2*sqrt(t)));
        counter=counter+1;
    end
    figure
    %Plotting the analytic solutions
    plot(solutions(:,1),solutions(:,2:4))
    legend('U1','U2','Semi-Infinte Solution','Location','northeast')
    xlabel('X')
    ylabel('U')
    print(strcat('Image_2_',num2str(Counter)),'-depsc')
    Counter=Counter+1;
end

%HEAT FLUX
%Calculating the heat flux
epsilon=0.5*10^(-5);
T=linspace(0.05,2);
Counter=1;
Flux=zeros(100,4);
Flux(:,1)=T;
while Counter<=100
    k=ceil(sqrt(-log(epsilon*pi^2*T(Counter))/(pi^2*T(Counter))));
    n=k;
    Flux1=0;
    Flux2=exp(-((2*n+1)/2)^2*pi^2*T(Counter));
    while n>=1
        Flux1=Flux1+exp(-n^2*pi^2*T(Counter));
        Flux2=Flux2+exp(-((2*n-1)/2)^2*pi^2*T(Counter));
        n=n-1;
    end
    Flux1=2*Flux1+1;
    Flux2=2*Flux2;
    Flux(Counter,2)=Flux1;
    Flux(Counter,3)=Flux2;
    Flux(Counter,4)=1/sqrt(pi*T(Counter));
    Counter=Counter+1;
end
figure
plot(Flux(:,1),Flux(:,2:4))
legend('Solution 1','Solution 2','Infinite Solution')
xlabel('T')
ylabel('-U_X')
print('Image_2_7','-depsc')

function answer = U1(X,T,epsilon)
    answer=0;
    t=2*lambertw(exp(1)/(pi*epsilon));
    k=ceil((1/(pi))*exp(-1/t)*(sqrt(t/(2*T))));
    n=k;
        while n>=1
        g=-2/(n*pi)*exp((-(n*pi)^2)*T);
        h=sin(n*pi*X);
        answer=answer+g*h;
        n=n-1;
        end
    answer=answer+1-X;
end

function answer = U2(X,T,epsilon)
    answer=0; 
    t=2*lambertw(exp(1)/(pi*epsilon));
    k=1+ceil((1/(pi))*exp(-1/t)*(sqrt(t/(2*T))));
    n=k;
        while n>=1
        g=-4/((2*n-1)*pi)*exp((-((2*n-1)*pi/2)^2)*T);
        h=sin((2*n-1)*pi*X/2);
        answer=answer+g*h;
        n=n-1;
        end
    answer=answer+1;
end