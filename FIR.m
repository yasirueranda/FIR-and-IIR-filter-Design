%200029B FIR filter design Assignment
%Kaiser window method

%Filter Specification

Omega_s=4800;                                                          % sampling frequency            rad/s
Omega_s1 = 1000;                                                       % lower stopband edge           rad/s
Omega_p1 = 1300;                                                       % lower passband edge           rad/s
Omega_p2 = 1800;                                                       % upper passband edge           rad/s
Omega_s2 = 2000;                                                       % upper stopband edge           rad/s
A_p = 0.1;                                                             % Maximum passband ripple       dB
A_a = 52;                                                              % Minimum stopband attenuation  dB

d_p = (10^(A_p/20) - 1)/(10^(A_p/20) + 1);                             %Maximum passband ripple        Linear
d_s = 10^(-A_a/20);                                                    %stopband attenuation           Linear

fcuts = [Omega_s1 Omega_p1 Omega_p2 Omega_s2];
mags = [0 1 0];
devs = [d_s d_p d_s];

[M,Wn,beta,ftype] = kaiserord(fcuts,mags,devs,Omega_s);                       %M is order of the filter
N=M+1;                                                                    %Length of the window

% Generate bandpass filter coefficients using Kaiser window
h = fir1(M,Wn, 'bandpass', kaiser(N,beta));

%Compute frequency reponse for FIR filter
Nfreqs=2048;
[H,omega]=freqz(h,1,Nfreqs);

%Impulse Reponse
figure(1)
stem([0:N-1],h)
xlabel('Time(samples)')
ylabel('h[n]')
title('Impulse response')

%Magnitude Reponse
figure(2)
subplot(2,1,1)
plot(omega/pi,abs(H));
xlabel('Frequency (\omega/\pi)'),ylabel('|H(e^{j\omega})|')
ylim([0 1])
xlim([0 1])
title('FIR filter Magnitude Reponse')

subplot(2,1,2)
plot(omega/pi,20*log10(abs(H)));
xlabel('Frequency (\omega/\pi)'),ylabel('|H(e^{j\omega})| (dB)')
ylim([-80 5])
xlim([0 1])

% Magnitude reponse in passband
figure(3)
plot(omega/pi,abs(H));
xlabel('Frequency (\omega/\pi)'),ylabel('|H(e^{j\omega})|')
title('FIR Passband Magnitude Response')
%Limit plot to cover passband region
xlim([(2*pi*Omega_p1)/Omega_s/pi (2*pi*Omega_p2)/Omega_s/pi])
ylim([1-d_p 1+d_p]);

