%startup_rvc
clear;close;
t1=2;%?2cm
t2=2.5;
 %     theta d a alpha
l1=Link('alpha',0,'a',0,'theta',0,'qlim',[0,t1],'modified' );
l2=Link('alpha',-pi/2,'a',0,'theta',-pi/2,'qlim',[0,t1],'modified');
l3=Link('alpha',-pi/2,'a',0,'theta',-pi/2,'qlim',[0,t1],'modified');
l4=Link('alpha',0,'a',0,'d',0,'qlim',[-pi/5,-pi/6],'modified');
l5=Link('alpha',0,'a',12.5,'theta',0,'qlim',[-0,0],'modified');
dobot1=SerialLink([l1,l2,l3,l4,l5],'name','1');
dobot1.base=transl(-1.5,-12.5,6.5);
dobot1.plotopt={'workspace',[-20,20,-20,20,0,7*t1]};
set(gca,'FontName','Times New Roman','Fontsize',18);
view(113,23);
dobot1.teach;
hold on;

n=10000;
trans_min2=-1;
trans_max2=1;
xmin=-2;
xmax=2;
zmin=0;
zmax=1;
trans12=trans_min2+(trans_max2-trans_min2)*rand(n,1);
trans22=xmin+(xmax-xmin)*rand(n,1);
trans32=zmin+(zmax-zmin)*rand(n,1);
plot3(trans12,trans22,trans32,'r.');%
set(gca,'FontName','Times New Roman','Fontsize',18);

hold on;
n=10000;
trans_min=0;
trans_max=t1;
rot_min=-35;
rot_max=-35;
trans1=trans_min+(trans_max-trans_min)*rand(n,1);
trans2=trans_min+(trans_max-trans_min)*rand(n,1);
trans3=trans_min+(trans_max-trans_min)*rand(n,1);
theta1=(rot_min+(rot_max-rot_min)*rand(n,1))*pi/180;
trans4=0*rand(n,1);

qq=[trans1,trans2,trans3,theta1,trans4];
Mricx=dobot1.fkine(qq);
Mricx = Mricx.double;
x=reshape(Mricx(1,4,:),n,1);
y=reshape(Mricx(2,4,:),n,1);
z=reshape(Mricx(3,4,:),n,1);
plot3(x,y,z,'b.');%
hold on;

r1=Link('alpha',0,'a',0,'theta',0,'qlim',[0,t2],'modified' );
r2=Link('alpha',pi/2,'a',0,'theta',-pi/2,'qlim',[0,t2],'modified');
r3=Link('alpha',-pi/2,'a',0,'theta',-pi/2,'qlim',[0,t2],'modified');
r4=Link('alpha',0,'a',0,'d',0,'qlim',[pi/6,pi/5],'modified');
r5=Link('alpha',0,'a',17+1.3,'theta',0,'qlim',[-0,0],'modified');
dobot2=SerialLink([r1,r2,r3,r4,r5],'name','r');
dobot2.base=transl(-1.5,15,10);
% dobot2.plotopt={'workspace',[-20,20,-20,20,0,7*t1]};
% view(113,23);
% dobot2.teach;
% 
% hold on;
n=10000;
trans_min1=0;
trans_max1=t2;
rot_min1=35;
rot_max1=35;
trans11=trans_min1+(trans_max1-trans_min1)*rand(n,1);
trans21=trans_min1+(trans_max1-trans_min1)*rand(n,1);
trans31=trans_min1+(trans_max1-trans_min1)*rand(n,1);
theta11=(rot_min1+(rot_max1-rot_min1)*rand(n,1))*pi/180;
trans41=0*rand(n,1);

qq1=[trans11,trans21,trans31,theta11,trans41];
Mricx1=dobot2.fkine(qq1);
Mricx1 = Mricx1.double;
x1=reshape(Mricx1(1,4,:),n,1);
y1=reshape(Mricx1(2,4,:),n,1);
z1=reshape(Mricx1(3,4,:),n,1);
plot3(x1,y1,z1,'g.');%

%º∆À„÷ÿµ˛¬ 
xmin = max(min(x),min(x1));
xmax = min(max(x),max(x1));
ymin = max(min(y),min(y1));
ymax = min(max(y),max(y1));
zmin = max(min(z),min(z1));
zmax = min(max(z),max(z1));
if xmin<xmax && ymin<ymax && zmin<zmax
    x3min = max(xmin,-1);
    x3max = min(xmax,1);
    y3min = max(ymin,-2);
    y3max = min(ymax,2);
    z3min = max(zmin,0);
    z3max = min(zmax,1);
    v3=(x3max-x3min)*(y3max-y3min)*(z3max-z3min);
    if x3min<x3max && y3min<y3max && z3min<z3max
        v3=(x3max-x3min)*(y3max-y3min)*(z3max-z3min);
        cover_rate=v3/8;
        %fprintf(cover_rate);
        %fprintf(x3max,x3min,y3max,y3min,z3max,z3min);
    end
end