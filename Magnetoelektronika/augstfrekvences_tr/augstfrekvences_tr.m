% Toms Sturmanis 131REB339

% sources - Colonel Wm. T.McLyman 
%   "Designing magnetic components
%   for high frequncy DC-DC converters"   

% Push-pull converter design using ferrite RM core

format compact

disp('----------design specification---------------')
Vmin = 22           % input voltage min
Vin = Vmin
Vo = [5 12 12]      % output voltage
Io = [4 0.25 0.25]  % output current
f = 50e3            % frequency
alpha = 0.5        % regulation
eta = 0.97          % efficiency
ttw = 1          % totall dwell time
Bm = 0.11           % operating flux density [T]
RQ = 0.125          % transistor on resistance
Vd = [1 2 2]        % diode voltage drop
winding_tapped_single = [1 0 0]
disp('------------------------------------------')

w_t_s = [winding_tapped_single, % for simpler calculation
     not(winding_tapped_single)];

% 1. calculate the total period
T = 1e6/f

%2. calculate the maximum on time, t_on
t = T/2
tonmax = t - ttw

%3. calculate the maximum on duty ratio, D_max
Dmax = tonmax/T

%4/ calculate the maximum apparent secondary power, P_ts

Po = [Io.*(Vo+Vd).*1.41,  % tapped winding
      Io.*(Vo+Vd)  ].*w_t_s      % single winding
Pts = sum(sum(Po))

%5. calculate the apparent power, P_t
Pt = Pts*(1.41/eta + 1)

%6. calculate the electrical conditions, Ke
Kf = 4      % wave form coefficient
Ke = 0.145*Kf^2*f^2*Bm^2*1e-4

%7. calculate the core geometry, Kg
Kg = Pt/(2*Ke*alpha) 
Kg = Kg*1.25
disp('See engineering design notes no. 4 and 19(pages 56, 58)')

%8. Select from Table 4.2 an RM core comparable in core geometry Kg.
disp('---------------------------')
disp('RM-42316')       %    core number
disp('Magnetics Inc.') %    manufacturer
P = 2500        % magnetic material
MPL = 3.80   % magnetic path length
G = 1.074    % window height
Wtfe = 13    % core weight
Wtcu = 6.73  % copper weight
MLT = 4.17   % mean length turn
Ac = 0.64    % iron area
Wa = 0.454   % window area
Ap = 0.29    % area product
Kg = 0.0178  % core geometry
At = 20.2    % surface area
mh = 2200    % millihenrys per 1000 turns
disp('---------------------------')

%9. calculate the total secondary load power, P_to
PO = Io.*(Vo+Vd)
Pto = sum(PO)

%10. calculate the current density J using window utilization, Ku=0.32
Ku = 0.32   %window utilization factor
J = 1e4*Pt/(Kf*Ku*Bm*f*Ap)

%11. calculate the average primary current, Iin
Iin = Pto/(Vin*eta)

%12. calculate the peak primary current, Ipk
Ipk = Iin/(2*Dmax)

%13. calculate the average primary voltage, Vp
Vp = Vin*2*Dmax - Iin*RQ

%14,22,27,32 calculate the primary and secondary turns, Np

Np = Vp*1e4/(Kf*Bm*f*Ac)
Np = round(Np)

Ns = (Np.*(Vo+Vd)./Vp)*(1 + alpha/100)
Ns = round(Ns)
disp('see engineering note no. 2 (page 55)')

%15. primary wire area
Awp = Ipk(1)*sqrt(Dmax)/J 

%16. calculate the skin depth y
gamma = 6.62/sqrt(f)
disp('see engineering design note no. 1 (page 55)')

%17. calculate the wire area
wireA = pi*gamma^2;
delta = wireA*0.1;
wireA = round([wireA-delta wireA wireA+delta],5)

disp('choose correct Awp and mu*ohm/cm from table 9.1')
Awp = 0.00205
muohm_div_cm_p = 666

disp('correct equations if different schematic')
Aws = [Io(1)*sqrt(Dmax)/J  Io(2)/J  Io(3)/J ]

strands = Aws(1)./0.00259
Aws(1) = 0.00259
muohm_div_cm_s = [666/round(strands) 3402 3402]

disp('choose strands count accordingly')
Sp = 1
Ss = [round(strands) 1 1]

%winding resistance
Rp = MLT*Np*muohm_div_cm_p*1e-6

Rs = MLT*Ns.*(muohm_div_cm_s)*1e-6

%21. calculate the copper loss, P_p
Pp = (Ipk*sqrt(2*Dmax))^2*Rp

Ps = Io.^2.*Rs

%37. window utilization Ku
turns_p = 2*Np*Sp
turns_s = [2*Ns(1)*Ss(1) Ns(2:end).*Ss(2:end)]

N_awg_24 = turns_p
N_awg_23 = turns_s(1)
N_awg_30 =sum( turns_s(2:end))

Ku = (N_awg_24*Awp + N_awg_23*Aws(1)+N_awg_30*Aws(2))/Wa
%38. total copper loss
Pcu = Pp+sum(Ps)
%39.regulation alpha
alpha = Pcu*100/Pto
%40. flux density
Bm = Vp*1e4/(Kf*f*Ac*Np)
%41. wats per kg
WK = 3.18e-4*f^1.51*Bm^2.747
%42. calculate the core
Pfe = WK*Wtfe*1e-3
%43. total loss
Psum = Pfe + Pcu
%44. watt density
lambda = Psum/At
%45. temperature rise [C]
Tr = 450*lambda^0.826