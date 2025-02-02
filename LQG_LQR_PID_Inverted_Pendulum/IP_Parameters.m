clc; clear;
%% Actuator Parameters
r = 0.006;
Rm = 12.5;
kb = 0.031;
kt = 0.031;
%% System Parameters
%All Units Are STI

M=2.4; %Mass of the Cart
m=0.23; %Mass of the Pendulum
l=0.36; %Length of the Rod
mu=0.1; %Friction Coefficientbetween the Cart& base
g=9.81; %Gravitational Force
D=1; %Length of the Track
%% System Dynamics in SS

A=[0 1 0 0;
    -g*(M+m)/(M*l) 0 0 mu/(M*l);
    0 0 0 1;
    m*g/M 0 0 -mu/M];

B =[0;-1/(M*l);0;1/M];

C=[1 0 1 0;
    0 0 1 0];

D=[0;0];

sys=ss(A,B,C,D)

%% LQR Controller Design

Q=[15000 0 0 0   %Penalize Theta
   0 0.1 0 0        %Penalize Angular velocity
   0 0 1 0    %Penalize Distance covered by cart
   0 0 0 0.1];       %Penalize Cart Velocity

 R=[0.07];        %Penalize Force Exerted

 Kr=lqr(A,B,Q,R)

% sysnew=ss((A-B*K),B,C,D)
%t=0:0.05:10;
%IC=[10;0;0;0]
%[y,t,x]=initial(sys,IC,t)

%% Kalman Filter Desgin

%Vd=0.001;
%Vn=0.001*eye(2);
%Kf=(lqr(A',C',Vd,Vn))'
%sysKF=ss(A-Kf*C,[B Kf],eye(4),0*[B Kf])
%[kalmf,L,P]=kalman(sys,Vd,Vn)

%% LQG Controller Design

QXU = [100500   0    0    0   0;
        0   1    0    0   0;
        0   0   0.01    0   0;
        0   0    0    1   0;
        0   0    0    0 0.001];

QI = eye(2) %for LQG servo controller %no. of outputs

% Process noise covariance (Qw)
Qw = diag([1e-4, 1e-3, 1e-4, 1e-3]);

% Measurement noise covariance (Rv)
Rv = diag([1e-4, 1e-5]);

% Combine into QWV matrix
QWV = blkdiag(Qw, Rv);

reg=lqg(sys,QXU,QWV,QI)


    