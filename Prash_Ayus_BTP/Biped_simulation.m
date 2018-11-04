%Thigh and leg length
l1 = 0.7; l2 = 0.53;
P0= [0 , 0];
P1= [0 , 0]; P2= [0 , 0]; P4= [0 , 0]; P5= [ 0, 0];
theta = [ pi/4, pi/4, pi/4 , pi/4]

axis(gca, 'equal');
axis([-1 6 0 2]);
grid on;
w=0.01;
x_dot0 = 2;
z = 1.2;
g = 9.81;
Tc = sqrt(z/g)
st_time= 0.21;
origin =[0 0]
stride_length =0.4;
x_0 = -stride_length/2;
a= stride_length;
b = 0.2;
stride_time = Tc*log((-stride_length/2 -Tc*x_dot0)/(stride_length/2 -Tc*x_dot0)); 
i=1;

for step= 1:1:10
if(flag==1) %red =  stance
for t=0:0.01:10

i =i+1;
time(i)=t;
x(i)= x_0*cosh(t/Tc) + Tc*x_dot0*sinh(t/Tc);
x_dot(i) = x_0*sinh(t/Tc)/Tc +x_dot0*cosh(t/Tc);

       
[theta(1), theta(2)] = inverse_kinematics_stance(x(i), z, l1, l2); %stance leg
%[theta(3) theta(4)] = inverse_kinematics(xe5, ye5, a1, a2);


P0 = [origin(1)+x(i) z];
P1 =  P0 + [l1*cos(theta(1)) , -l1*sin(theta(1))];
P2 = P0 +[l1*cos(theta(1)) + l2*cos(theta(1)+theta(2)) , -l1*sin(theta(1)) - l2*sin(theta(1) + theta(2))];

x_swing = -x(i)-a*cos(t/stride_time*pi);
y_swing = z - b*sin(t/stride_time*pi);
[theta(3), theta(4)] = inverse_kinematics_swing(x_swing, y_swing, l1, l2); %stance leg

P4 = P0 + [l1*cos(theta(3)) , -l1*sin(theta(3))];
P5 = P0 + [l1*cos(theta(3)) + l2*cos(theta(3)+theta(4)) , -l1*sin(theta(3))-l2*sin(theta(3) + theta(4))];
%P5 = [x_swing y_swing]
 Traj_identi = viscircles(P5,0.001);
 Traj_identi1 = viscircles(P0,0.001);
 
 line2 = line([P0(1) P1(1)],[P0(2) P1(2)] , 'LineWidth',3 ,'Color','red');
 line3 = line([P1(1) P2(1)],[P1(2) P2(2)], 'LineWidth',2,'Color','red');
 line4 = line([P0(1) P4(1)],[P0(2) P4(2)] , 'LineWidth',3 ,'Color','green');
 line5 = line([P4(1) P5(1)],[P4(2) P5(2)], 'LineWidth',2,'Color','green');
 line6 = line([origin(1) (origin(1) + x(i))],[origin(2) z] , 'LineWidth',1 ,'Color','blue','LineStyle', '--');
theta*180/pi

 pause(0.02);
 %remove previous identifiers
 delete(line2);
 delete(line3);
 delete(line4);
 delete(line5);
 delete(line6);
 
 %plot(time,x)
if(x(i)>stride_length/2)
    flag =0;
     origin = origin + [stride_length 0];
     i=1;
    break;
    
end 
end
else
for t=0:0.01:10
    i =i+1;
time(i)=t;
x(i)= x_0*cosh(t/Tc) + Tc*x_dot0*sinh(t/Tc);
x_dot(i) = x_0*sinh(t/Tc)/Tc +x_dot0*cosh(t/Tc);
   
       
[theta(1), theta(2)] = inverse_kinematics_stance(x(i), z, l1, l2); %stance leg
%[theta(3) theta(4)] = inverse_kinematics(xe5, ye5, a1, a2);


P0 = [origin(1)+x(i) z];
P4 =  P0 + [l1*cos(theta(1)) , -l1*sin(theta(1))];
P5 = P0 +[l1*cos(theta(1)) + l2*cos(theta(1)+theta(2)) , -l1*sin(theta(1)) - l2*sin(theta(1) + theta(2))];

x_swing = -x(i)-a*cos(t/stride_time*pi);
y_swing = z - b*sin(t/stride_time*pi);
[theta(3), theta(4)] = inverse_kinematics_swing(x_swing, y_swing, l1, l2); %stance leg

P1 = P0 + [l1*cos(theta(3)) , -l1*sin(theta(3))];
P2 = P0 + [l1*cos(theta(3)) + l2*cos(theta(3)+theta(4)) , -l1*sin(theta(3))-l2*sin(theta(3) + theta(4))];
%P5 = [x_swing y_swing]
 Traj_identi = viscircles(P2,0.001);
 Traj_identi1 = viscircles(P0,0.001);
 
 line2 = line([P0(1) P1(1)],[P0(2) P1(2)] , 'LineWidth',3 ,'Color','red');
 line3 = line([P1(1) P2(1)],[P1(2) P2(2)], 'LineWidth',2,'Color','red');
 line4 = line([P0(1) P4(1)],[P0(2) P4(2)] , 'LineWidth',3 ,'Color','green');
 line5 = line([P4(1) P5(1)],[P4(2) P5(2)], 'LineWidth',2,'Color','green');
 line6 = line([origin(1) (origin(1) + x(i))],[origin(2) z] , 'LineWidth',1 ,'Color','blue','LineStyle', '--');
theta*180/pi

 pause(0.02);
 %remove previous identifiers
 delete(line2);
 delete(line3);
 delete(line4);
 delete(line5);
 delete(line6);
 
 %plot(time,x)
if(x(i)>stride_length/2)
    
     origin = origin + [stride_length 0];
     i=1;
    flag = 1;
    
    break; 
end
end

 
end
end