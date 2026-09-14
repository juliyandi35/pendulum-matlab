%%funcuion code
function xdot=pendulum_2nd_order(t,x)
b=0.05;
m=1;
g=9.81;
L=1;
xdot=zeros(2,1);
xdot(1)=x(2);
xdot(2)=(-b/m)*x(2)-(g/L)+sin(x(1));
end