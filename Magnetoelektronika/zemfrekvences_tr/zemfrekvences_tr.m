%%2.1.Dotie lielumi-------------------------------------------------------
% m =         %fâþu skaits
U1 = 220;   %primârais spriegums [V]
U2 = 40;    %sekundârais spriegums

P2 = 200;   %jauda izejâ [W] 
    
I2 = 5;   %strâva izejâ [A]
f = 50;     %frekvence tîklam [Hz]

cosphi2 = 1;   %jaudas koeficients - vairumâ gadîjumu = 1
                %slodze ir aktîva

%%2.2.Transformatora strâvu noteikðana------------------------------------
I_mu_div_I_1a = 0.5 %[0.4 0.5 0.6];  %tipiska attiecîba

cosphi1 = 1/sqrt(1+I_mu_div_I_1a^2);
eta = 0.89; %lietderîbas koeficients - no grafika

I1 = P2*cosphi2/(U1*eta*cosphi1) %vienfâzes transformatoram

%%2.3.Elektromagnçtisko noslodþu(indukcijas un strâvas blîvuma) izvçle----

Bs = 1.25 %[1.2 1.25 1.3]indukcija magnçtvada stienî - marka 1511/1211 [T]
Bj = Bs
j = 4e6 % [4.5 4 3.5] strâvas blîvums tinumu vados [A/m^2]

%2.4.Transformatora serdes stieòa un jûga ðíçrsgriezuma noteikðana--------
beta = 1.8 %[1.2 1.8];  %elektrisko zudumu attiecîba
Kt = 1.6;               %relatîvie zudumi magnçtvadâ tçraudâ
delta = 0.5e-3            % , loksnes biezums     [m]

alpha = (2.4/Kt)*(j/Bs)^2*(1/beta)*1e-12 % tçrauda masas attiecîba

P1 = U1*I1
C = 0.7     %[0.6 0.7]pastâvîgais koeficients - stieòtipa/jûgtipa
Ksj = 1.2   % [1.0 - 1.2] jûga ðíçrsgriezuma laukums [m^2]
Kaiz = 0.92     %nosaka no tabulas
Ss = C*sqrt(P1*alpha/(f*Bs*j))  %magnçtvada stieòa ðíçrsgriezums [m^2]
Sj = Ksj*Ss/2                   %jûga ðíçrsgriezuma laukums

as = sqrt(Ss/Kaiz)  % malu garumi a, b [m]
bs = as
hj = Sj/(Kaiz*bs)   % jûga augstums [m]

%%2.5.Tinumu vijumu skaita noteikðana-------------------------------------
DeltaU = 7      % 7% pazûd siltumâ

E1 = U1-DeltaU*U1/200   
E2 = U2+DeltaU*U2/200

w1 = E1/(4.44*f*Bs*Ss)  % vijumu skaits primârais
w2 = w1*E2/E1

%%2.6.Tinuma ðíçrsgriezuma un vada diametra noteikðana--------------------
q_prim1 = I1/(j*1e-6) %sâkotnçjâ vçrtîba [m^2]
q_prim2 = I2/(j*1e-6)   

q1 = 0.273e-6      % izvçlas tuvâko reâlo ðíersgriezumu un diametru
q2 = 1.21e-6       % no tabulas
d1 = 0.59e-3       
d2 = 1.25e-3
d1iz = 0.64e-3
d2iz = 1.33e-3

%%2.7.  Magnçtvada loga izmçru izvçle un tinumu novietojums uz------------ 
%       transformatora stieòiem
epsilon1 = 4e-3         % [2 .. 5] attâlums no tinuma lîdz jûgam [m]

syms H

n1 = (H-2*epsilon1)/d1iz;        %viena slâòa vijumu skaits
n2 = (H-2*epsilon1)/d2iz;

m1 = w1/n1;      % ja, vienfâzes ar vienu spoli
m2 = w2/n2;

epsilon0 = 2e-3         % [1 .. 2] izolâcija starp soli un stieni 
epsilon3 = 3e-3         % [3 .. 5] no spoles lîdz jûgam 
delta12  = 1e-3         % [0.1 .. 1] izolâcija starp primâro un sekundâro

delta1 = d1iz^2*w1/(H-2*epsilon1); 
delta2 = d2iz^2*w2/(H-2*epsilon1);

DeltaIz = epsilon0 + delta12 + epsilon3 %kopçjais izolâcijas biezums
b = delta1 + delta2 + epsilon2 + DeltaIz; %serdes loga platums 
                                         %ar taisnstûra formas spoli
gamma = 2        % [1 .. 3] loga augstuma un platuma attiecîba 

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
lw1 = 2*(as+bs+4*epsilon0+2*delta1) %tinuma vijuma vidçjais garums [m]
lw2 = 2*(as+bs+4*(epsilon0+delta1+delta12)+2*delta2)

Gv1 = 8900*w1*q1*lw1    %tinumu vara masa [kg]
Gv2 = 8900*w2*q2*lw2
Gv = Gv1+Gv2            % vara pilnâ masa

j1 = I1/q1  %reâïais strâvas blîvums [A/m^2]
j2 = I2/q2

Pv1 = 2.4*j1^2*Gv1*1e-12    %reâïie elektriskie zudumi [W]
Pv2 = 2.4*j2^2*Gv2*1e-12
Pv = Pv1+Pv2                %pilnie zudumi

%%2.9.Serdes masa un magnçtiskie zudumi-----------------------------------
lj = 2*hj+2*b+as        % jûga garums
Gts = 7700*H*Ss         % stieòa masa
Gtj = 2*7700*(H+lj)*Sj  % jûga masa
Gs = Gts + Gtj          % kopçjâ masa

Pts = Kt*Bs^2*(f/50)^(1.3)*Gts      %magnçtiskie zudumi serdç
Ptj = Kt*Bj^2*(f/50)^(1.3)*Gtj       %zudumi jûgos
Pt = Pts+Ptj           

%%2.10.Tukðgaitas strâvas aprçíins
lprims = H      %magnçtiskâs plûsmas ceïa garums
lprimj = H+lj
deltaEkv = 4e-5 %gaisa sprauga [m]
as_times_ws = 10      % îpatnçjie mds stienî ==> as*ws = 10 [A/m]
as_times_wj = as_div_ws
n=2             %spraugu skaits serdç
I0 = ((as_times_ws*lprims+as_times_wj*lprimj)*1e2+0.8*n*deltaEkv*Bs*1e6)/ ...
        (sqrt(2)*w1) % [A]
%%2.11.Lietderîbas koeficients--------------------------------------------
eta = P2*cosphi2/(P2*cosphi2+Pv+Pt) % 

%%2.12.Tinumu sprieguma kritumi un pretestîbas----------------------------
ea1 = Pv1/(U1*I1)   %aktîvie sprieguma kritumi
ea2 = Pv2/(U2*I2)

R1 = Pv1/I1^2       %tinumu aktîvâ pretestîba [ohm]
R2 = Pv2/I2^2

%%2.13.Transformatora silðanas pârbaude-----------------------------------
Stin = 2*H*(as+bs+4*(delta1+delta2+delta12+epsilon0))   %ârçjâs virsmas 
                                                        %laukumi
Sser = 2*lj*(bs+2*hj)+2*H*(bs+2*hj)+4*bs*hj
Skop = Sser+Stin
alpha0 = 12     % [W/m^2*°C]
theta = (Pv+Pt)/(alpha0*Skop)   %temperatûra [°C]
