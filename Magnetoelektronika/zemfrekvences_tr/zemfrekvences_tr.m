%%2.1.Dotie lielumi-------------------------------------------------------
% m =         %f��u skaits
U1 = 220;   %prim�rais spriegums [V]
U2 = 40;    %sekund�rais spriegums

P2 = 200;   %jauda izej� [W] 
    
I2 = 5;   %str�va izej� [A]
f = 50;     %frekvence t�klam [Hz]

cosphi2 = 1;   %jaudas koeficients - vairum� gad�jumu = 1
                %slodze ir akt�va

%%2.2.Transformatora str�vu noteik�ana------------------------------------
I_mu_div_I_1a = 0.5 %[0.4 0.5 0.6];  %tipiska attiec�ba

cosphi1 = 1/sqrt(1+I_mu_div_I_1a^2);
eta = 0.89; %lietder�bas koeficients - no grafika

I1 = P2*cosphi2/(U1*eta*cosphi1) %vienf�zes transformatoram

%%2.3.Elektromagn�tisko noslod�u(indukcijas un str�vas bl�vuma) izv�le----

Bs = 1.25 %[1.2 1.25 1.3]indukcija magn�tvada stien� - marka 1511/1211 [T]
Bj = Bs
j = 4e6 % [4.5 4 3.5] str�vas bl�vums tinumu vados [A/m^2]

%2.4.Transformatora serdes stie�a un j�ga ���rsgriezuma noteik�ana--------
beta = 1.8 %[1.2 1.8];  %elektrisko zudumu attiec�ba
Kt = 1.6;               %relat�vie zudumi magn�tvad� t�raud�
delta = 0.5e-3            % , loksnes biezums     [m]

alpha = (2.4/Kt)*(j/Bs)^2*(1/beta)*1e-12 % t�rauda masas attiec�ba

P1 = U1*I1
C = 0.7     %[0.6 0.7]past�v�gais koeficients - stie�tipa/j�gtipa
Ksj = 1.2   % [1.0 - 1.2] j�ga ���rsgriezuma laukums [m^2]
Kaiz = 0.92     %nosaka no tabulas
Ss = C*sqrt(P1*alpha/(f*Bs*j))  %magn�tvada stie�a ���rsgriezums [m^2]
Sj = Ksj*Ss/2                   %j�ga ���rsgriezuma laukums

as = sqrt(Ss/Kaiz)  % malu garumi a, b [m]
bs = as
hj = Sj/(Kaiz*bs)   % j�ga augstums [m]

%%2.5.Tinumu vijumu skaita noteik�ana-------------------------------------
DeltaU = 7      % 7% paz�d siltum�

E1 = U1-DeltaU*U1/200   
E2 = U2+DeltaU*U2/200

w1 = E1/(4.44*f*Bs*Ss)  % vijumu skaits prim�rais
w2 = w1*E2/E1

%%2.6.Tinuma ���rsgriezuma un vada diametra noteik�ana--------------------
q_prim1 = I1/(j*1e-6) %s�kotn�j� v�rt�ba [m^2]
q_prim2 = I2/(j*1e-6)   

q1 = 0.273e-6      % izv�las tuv�ko re�lo ��ersgriezumu un diametru
q2 = 1.21e-6       % no tabulas
d1 = 0.59e-3       
d2 = 1.25e-3
d1iz = 0.64e-3
d2iz = 1.33e-3

%%2.7.  Magn�tvada loga izm�ru izv�le un tinumu novietojums uz------------ 
%       transformatora stie�iem
epsilon1 = 4e-3         % [2 .. 5] att�lums no tinuma l�dz j�gam [m]

syms H

n1 = (H-2*epsilon1)/d1iz;        %viena sl��a vijumu skaits
n2 = (H-2*epsilon1)/d2iz;

m1 = w1/n1;      % ja, vienf�zes ar vienu spoli
m2 = w2/n2;

epsilon0 = 2e-3         % [1 .. 2] izol�cija starp soli un stieni 
epsilon3 = 3e-3         % [3 .. 5] no spoles l�dz j�gam 
delta12  = 1e-3         % [0.1 .. 1] izol�cija starp prim�ro un sekund�ro

delta1 = d1iz^2*w1/(H-2*epsilon1); 
delta2 = d2iz^2*w2/(H-2*epsilon1);

DeltaIz = epsilon0 + delta12 + epsilon3 %kop�jais izol�cijas biezums
b = delta1 + delta2 + epsilon2 + DeltaIz; %serdes loga platums 
                                         %ar taisnst�ra formas spoli
gamma = 2        % [1 .. 3] loga augstuma un platuma attiec�ba 

H = gamma*b;
H = abs(double(solve(H)))

n1 = double(subs(n1))
n2 = double(subs(n2))
m1 = double(subs(m1))
m2 = double(subs(m2))
delta1 = double(subs(delta1))
delta2 = double(subs(delta2))
DeltaIz = double(subs(DeltaIz))
b = double(subs(b))

%%2.8.Tinumu vara masa un elektriskie zudumi------------------------------
lw1 = 2*(as+bs+4*epsilon0+2*delta1) %tinuma vijuma vid�jais garums [m]
lw2 = 2*(as+bs+4*(epsilon0+delta1+delta12)+2*delta2)

Gv1 = 8900*w1*q1*lw1    %tinumu vara masa [kg]
Gv2 = 8900*w2*q2*lw2
Gv = Gv1+Gv2            % vara piln� masa

j1 = I1/q1  %re��ais str�vas bl�vums [A/m^2]
j2 = I2/q2

Pv1 = 2.4*j1^2*Gv1*1e-12    %re��ie elektriskie zudumi [W]
Pv2 = 2.4*j2^2*Gv2*1e-12
Pv = Pv1+Pv2                %pilnie zudumi

%%2.9.Serdes masa un magn�tiskie zudumi-----------------------------------
lj = 2*hj+2*b+as        % j�ga garums
Gts = 7700*H*Ss         % stie�a masa
Gtj = 2*7700*(H+lj)*Sj  % j�ga masa
Gs = Gts + Gtj          % kop�j� masa

Pts = Kt*Bs^2*(f/50)^(1.3)*Gts      %magn�tiskie zudumi serd�
Ptj = Kt*Bj^2*(f/50)^(1.3)*Gtj       %zudumi j�gos
Pt = Pts+Ptj           

%%2.10.Tuk�gaitas str�vas apr��ins
lprims = H      %magn�tisk�s pl�smas ce�a garums
lprimj = H+lj
deltaEkv = 4e-5 %gaisa sprauga [m]
as_times_ws = 10      % �patn�jie mds stien� ==> as*ws = 10 [A/m]
as_times_wj = as_div_ws
n=2             %spraugu skaits serd�
I0 = ((as_times_ws*lprims+as_times_wj*lprimj)*1e2+0.8*n*deltaEkv*Bs*1e6)/ ...
        (sqrt(2)*w1) % [A]
%%2.11.Lietder�bas koeficients--------------------------------------------
eta = P2*cosphi2/(P2*cosphi2+Pv+Pt) % 

%%2.12.Tinumu sprieguma kritumi un pretest�bas----------------------------
ea1 = Pv1/(U1*I1)   %akt�vie sprieguma kritumi
ea2 = Pv2/(U2*I2)

R1 = Pv1/I1^2       %tinumu akt�v� pretest�ba [ohm]
R2 = Pv2/I2^2

%%2.13.Transformatora sil�anas p�rbaude-----------------------------------
Stin = 2*H*(as+bs+4*(delta1+delta2+delta12+epsilon0))   %�r�j�s virsmas 
                                                        %laukumi
Sser = 2*lj*(bs+2*hj)+2*H*(bs+2*hj)+4*bs*hj
Skop = Sser+Stin
alpha0 = 12     % [W/m^2*�C]
theta = (Pv+Pt)/(alpha0*Skop)   %temperat�ra [�C]
