%Formats the output
format short g
digits(5)
data=Euler(0,1,1,1/10)
%Creates Latex code for the table
latex(sym(vpa(data)))
data=RK4(0,1,0,0.1)
latex(sym(vpa(data)))
function data = Euler(x_0,x_n,y_0,h)
%Creates a table to be filled
    data=zeros(ceil((x_n-x_0)/h)+1,5);
    data(1,:)=[x_0,y_0,y(x_0),y_0-y(x_0),0];
    counter=2;
%Iterates through the rows filling them
    while counter<=ceil((x_n-x_0)/h)+1
        data(counter,:)=[(counter-1)*h+x_0,...
            data(counter-1,2)+h*f((counter-2)*h+x_0,data(counter-1,2)),...
            y((counter-1)*h+x_0),...
            data(counter-1,2)+h*f((counter-2)*h+x_0,data(counter-1,2))-...
            y((counter-1)*h+x_0),...
            (data(counter-1,2)+h*f((counter-2)*h+x_0,data(counter-1,2))-...
            y((counter-1)*h+x_0))/data(counter-1,4)];
        counter=counter+1;
    end
end
function data = RK4(x_0,x_n,y_0,h)
%Follows a similar idea to the Euler function
    data=zeros(ceil((x_n-x_0)/h)+1,5);
    data(1,:)=[x_0,y_0,y(x_0),y_0-y(x_0),0];
    counter=2;
    while counter<=ceil((x_n-x_0)/h)+1
        k1=h*f((counter-2)*h+x_0,data(counter-1,2));
        k2=h*f((counter-2+1/2)*h+x_0,data(counter-1,2)+1/2*k1);
        k3=h*f((counter-2+1/2)*h+x_0,data(counter-1,2)+1/2*k2);
        k4=h*f((counter-2+1)*h+x_0,data(counter-1,2)+k3);
        data(counter,:)=[(counter-1)*h+x_0,...
            data(counter-1,2)+1/6*(k1+2*k2+2*k3+k4),...
            y((counter-1)*h+x_0),...
            data(counter-1,2)+1/6*(k1+2*k2+2*k3+k4)-y((counter-1)*h+x_0),...
            (data(counter-1,2)+1/6*(k1+2*k2+2*k3+k4)-y((counter-1)*h+x_0))/...
            data(counter-1,4)];
        counter=counter+1;
    end
end
%These two functions were created to stop repeatedly defining them
function z = f(x,y)
    z = 2*y/(1+x);
end
function z = y(x)
    z= -2*exp(-4*x)+2*exp(-2*x);
end