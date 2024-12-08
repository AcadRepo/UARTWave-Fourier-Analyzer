% % Datos proporcionados (como un vector complejo)
% data = [137+0i, 131+0i, 137+0i, 131+0i, 137+0i, 131+0i, 137+0i, 131+0i];
% 
% % Calcular la FFT de los datos
% fft_result = fft(data);
% 
% % Graficar la FFT
% figure;
% plot(fft_result, "o");  % Graficar los resultados de la FFT
% xlabel('Índice de la frecuencia');
% ylabel('Valor de la FFT');
% title('FFT de los datos');
% grid on;
% 
% % Reconstruir la señal utilizando la IFFT
% reconstructed_signal = ifft(fft_result);
% 
% % Graficar la señal reconstruida
% figure;
% plot(real(reconstructed_signal), 'o-');  % Solo la parte real, ya que es la que tiene sentido en este caso
% xlabel('Índice de la señal');
% ylabel('Amplitud');
% title('Señal reconstruida utilizando la IFFT');
% grid on;

%/////////////////////////////////////////////////////////////////////

matriz=dftmtx(8);
x=[137; 131; 137; 131; 137; 131; 137; 131];
y=matriz*x;
y1=[1072;5.67*1e-38;1.17*1e-38;1.25*1e-38;24.000059127; -1.84*1e-39;0;4.78*1e-38];
y2=[1072;1.4210*1e-14;8.021*1e-15;1.4210*1e-14;24;1.4210*1e-14;8.021*1e-14;1.4210*1e-14]

%Graficar la FFT
figure;
plot(y, 's', 'MarkerSize', 8, 'MarkerFaceColor', 'r'); % Cuadrados rojos rellenos
hold on;
plot(y1, 'd', 'MarkerSize', 8, 'MarkerFaceColor', 'g'); % Rombo verde relleno
plot(y2, '^', 'MarkerSize', 8, 'MarkerFaceColor', 'b'); % Triángulo azul relleno
hold off;

xlabel('Índice de la frecuencia');
ylabel('Valor de la FFT');
title('Comparación de resultados');
grid on;





