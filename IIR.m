%200029B IIR filter design Assignment
%Bilinear Transformation

%Filter Specification

Omega_s=4800;                                                          % sampling frequency            rad/s
Omega_s1 = 1000;                                                       % lower stopband edge           rad/s
Omega_p1 = 1300;                                                       % lower passband edge           rad/s
Omega_p2 = 1800;                                                       % upper passband edge           rad/s
Omega_s2 = 2000;                                                       % upper stopband edge           rad/s
A_p = 0.1;                                                             % Maximum passband ripple       dB
A_a = 52;                                                              % Minimum stopband attenuation  dB

delta1=(1-10^(-0.05*A_p));

%Convert to Digital frequencies

omega_s1=(2*pi*Omega_s1)/Omega_s;
omega_p1=(2*pi*Omega_p1)/Omega_s;
omega_p2=(2*pi*Omega_p2)/Omega_s;
omega_s2=(2*pi*Omega_s2)/Omega_s;

%Pre-warp frequencies
W_s1 =2*1*tan(omega_s1/2);
W_p1= 2*1*tan(omega_p1/2);
W_p2= 2*1*tan(omega_p2/2);
W_s2= 2*1*tan(omega_s2/2);

W_pass=[W_p1 W_p2];
W_stop=[W_s1 W_s2];

[n,W_n]=cheb1ord(W_pass,W_stop,A_p,A_a, "s");
[b, a] = cheby1 (n,A_p,W_n, "s");

[numd,dend]= bilinear(b,a,1);

[H,omega]=freqz(numd,dend,2048);
figure(1)
subplot(2,1,1)
plot(omega/pi,abs(H));
xlabel('Frequency (\omega/\pi)'),ylabel('|H(e^{j\omega})|')
ylim([0 1])
xlim([0 1])
title('Chebyshew IIR Filter')

subplot(2,1,2)
plot(omega/pi,20*log10(abs(H)));
xlabel('Frequency (\omega/\pi)'),ylabel('|H(e^{j\omega})| (dB)')
ylim([-80 5])
xlim([0 1])

% zoom in to confirm specification met
figure(2)
plot(omega/pi,abs(H));
xlabel('Frequency (\omega/\pi)'),ylabel('|H(e^{j\omega})|')
title('Chebyshev IIR Filter Passband')
%Limit plot to cover passband region
xlim([omega_p1/pi omega_p2/pi])
ylim([1-delta1 1+delta1]);







