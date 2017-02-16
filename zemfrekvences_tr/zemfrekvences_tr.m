%%Dotie lielumi-----------------------------------------------------------
% m =         %fâþu skaits
U1 = 220;   %primârais spriegums [V]
U2 = 40;    %sekundârais spriegums

P2 = 200;   %jauda izejâ [W] 
    
I2 = 5;   %strâva izejâ [A]
f = 50;     %frekvence tîklam [Hz]

cos_phi2 = 1;   %jaudas koeficients - vairumâ gadîjumu = 1
                %slodze ir aktîva

%%Transformatora strâvu noteikðana----------------------------------------
I_mu_div_I_1a = 0.5 %[0.4 0.5 0.6];  %tipiska attiecîba

cos_phi1 = 1/sqrt(1+I_mu_div_I_1a^2);
eta = 0.89; %lietderîbas koeficients - no grafika

I1 = P2*cos_phi2/(U1*eta*cos_phi1) %vienfâzes transformatoram

%%Elektromagnçtisko noslodþu(indukcijas un strâvas blîvuma) izvçle--------

Bs = 1.25 %[1.2 1.25 1.3]indukcija magnçtvada stienî - marka 1511/1211 [T]
j = 4e6 %[4.5 4 3.5]*1e6;strâvas blîvums tinumu vados [A/m^2]

%Transformatora magnçtvada stieòa un jûga ðíçrsgriezuma noteikðana--------
beta = 1.8 %[1.2 1.8];  %elektrisko zudumu attiecîba
Kt = 1.6;               %relatîvie zudumi magnçtvadâ tçraudâ
sigma = 0.5e-3;            % , loksnes biezums     [mm]

alpha = (2.4/Kt)*(j/Bs)^2*(1/beta)*1e-12 % tçrauda masas attiecîba

P1 = U1*I1
C = 0.7     %[0.6 0.7]pastâvîgais koeficients - stieòtipa/jûgtipa
Ksj = 1.2   % [1.0 - 1.2] jûga ðíçrsgriezuma laukums
Kaiz = 0.92     %nosaka no tabulas
Ss = C*sqrt(P1*alpha/(f*Bs*j))  %magnçtvada stieòa ðíçrsgriezums [m^2]
Sj = Ksj*Ss/2                   %jûga ðíçrsgriezuma laukums

as = sqrt(Ss/Kaiz)  %malu garumi a, b [m]
bs = as
hj = Sj/(Kaiz*bs)   %jûga augstums [m]

%%Tinumu vijumu skaita noteikðana----------------------------------------
DeltaU = 7      % 7% pazûd siltumâ

E1 = U1-DeltaU*U1/200   
E2 = U2+DeltaU*U2/200

w1 = E1/(4.44*f*Bs*Ss)  %vijumu skaits primârais
w2 = w1*E2/E1

%%Tinuma ðíçrsgriezuma un vada diametra noteikðana------------------------
q_prim1 = I1/(j*1e-6) %sâkotnçjâ vçrtîba [mm^2]
q_prim2 = I2/(j*1e-6)   

q1 = 0.273      %izvçlas tuvâko reâlo diametru
q2 = 1.21

%%Magnçtvada loga izmçru izvçle un tinumu novietojums uz traansformatora
%%stieòiem
epsilon1 = 4e-3     %att'alums no tinuma lîdz jûgam

n1 = (H-2*epsilon1)/d1iz        %viena slâòa vijumu skaits
n2 = (H-2*epsilon1)/d2iz





