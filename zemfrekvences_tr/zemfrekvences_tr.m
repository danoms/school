%%Dotie lielumi-----------------------------------------------------------
% m =         %f��u skaits
U1 = 220;   %prim�rais spriegums [V]
U2 = 40;    %sekund�rais spriegums

P2 = 200;   %jauda izej� [W] 
    
I2 = 5;   %str�va izej� [A]
f = 50;     %frekvence t�klam [Hz]

cos_phi2 = 1;   %jaudas koeficients - vairum� gad�jumu = 1
                %slodze ir akt�va

%%Transformatora str�vu noteik�ana----------------------------------------
I_mu_div_I_1a = 0.5 %[0.4 0.5 0.6];  %tipiska attiec�ba

cos_phi1 = 1/sqrt(1+I_mu_div_I_1a^2);
eta = 0.89; %lietder�bas koeficients - no grafika

I1 = P2*cos_phi2/(U1*eta*cos_phi1) %vienf�zes transformatoram

%%Elektromagn�tisko noslod�u(indukcijas un str�vas bl�vuma) izv�le--------

Bs = 1.25 %[1.2 1.25 1.3]indukcija magn�tvada stien� - marka 1511/1211 [T]
j = 4e6 %[4.5 4 3.5]*1e6;str�vas bl�vums tinumu vados [A/m^2]

%Transformatora magn�tvada stie�a un j�ga ���rsgriezuma noteik�ana--------
beta = 1.8 %[1.2 1.8];  %elektrisko zudumu attiec�ba
Kt = 1.6;               %relat�vie zudumi magn�tvad� t�raud�
sigma = 0.5e-3;            % , loksnes biezums     [mm]

alpha = (2.4/Kt)*(j/Bs)^2*(1/beta)*1e-12 % t�rauda masas attiec�ba

P1 = U1*I1
C = 0.7     %[0.6 0.7]past�v�gais koeficients - stie�tipa/j�gtipa
Ksj = 1.2   % [1.0 - 1.2] j�ga ���rsgriezuma laukums
Kaiz = 0.92     %nosaka no tabulas
Ss = C*sqrt(P1*alpha/(f*Bs*j))  %magn�tvada stie�a ���rsgriezums [m^2]
Sj = Ksj*Ss/2                   %j�ga ���rsgriezuma laukums

as = sqrt(Ss/Kaiz)  %malu garumi a, b [m]
bs = as
hj = Sj/(Kaiz*bs)   %j�ga augstums [m]

%%Tinumu vijumu skaita noteik�ana----------------------------------------
DeltaU = 7      % 7% paz�d siltum�

E1 = U1-DeltaU*U1/200   
E2 = U2+DeltaU*U2/200

w1 = E1/(4.44*f*Bs*Ss)  %vijumu skaits prim�rais
w2 = w1*E2/E1

%%Tinuma ���rsgriezuma un vada diametra noteik�ana------------------------
q_prim1 = I1/(j*1e-6) %s�kotn�j� v�rt�ba [mm^2]
q_prim2 = I2/(j*1e-6)   

q1 = 0.273      %izv�las tuv�ko re�lo diametru
q2 = 1.21

%%Magn�tvada loga izm�ru izv�le un tinumu novietojums uz traansformatora
%%stie�iem
epsilon1 = 4e-3     %att'alums no tinuma l�dz j�gam

n1 = (H-2*epsilon1)/d1iz        %viena sl��a vijumu skaits
n2 = (H-2*epsilon1)/d2iz





