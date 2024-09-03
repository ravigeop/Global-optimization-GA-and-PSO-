x=0:pi/10:2*pi;
y=x.^2;
H=area(x,y);
h=get(H,'children');
set(h,'FaceAlpha',0.3); %#Tada!