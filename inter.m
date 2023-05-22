clc 
clear 
close all 

%%Interpolación de los datos, sn valores atípicos 
%%cubic spline

dataVA = importfile1("C:\Users\hanni\Desktop\Matlab\data_VA.csv", [1, Inf]);
%Trabajo previo%%
% x = 1:size(dataVA, 2); %RECUERDA el num de comlunas son tus values en x 
% xq = linspace(1, size(dataVA, 2), 752); 
% 
% figure
% hold on
% 
% for i = 1:size(dataVA, 1)
%     y = dataVA(i, :)'; % transpuesta-->columa
%     s = spline(x, y, xq);
% %      plot(x, y, 'LineWidth', 1.5, 'Color', '#FF99CC');
%     plot(xq, s, 'LineWidth', 1.5, 'LineStyle', ':', 'Color', '#6666CC');
% end
% 
% hold off
% legend('Spline');

%Interpolation datos sin valores atípicos 
%70 frames
%752 longitud de X --> "time"

dataVA = importfile2('C:\Users\hanni\Desktop\Matlab\data_VA.csv', [1, Inf]);

numframes = 80; % numero de nuevos frames
data_int = zeros(size(dataVA,1),numframes);

for k=1:size(dataVA,1)
    data = dataVA(k, :); % Trayectoria de la cuerda a lo largo del tiempo
    y = 1:size(dataVA,2); % Tomamos los primeros valores de cada frame para crear frames intermedios
    yq = linspace(1, size(dataVA, 2), numframes); % Nuevos frames

    data_int(k,:) = spline(y,data,yq); % Frames y frames intermedios creados por interpolación
end
% 
figure 
plot(data_int')
xlabel('Frames')
ylabel('Amplitud')
title('Data interpolada sin valores atípicos')

% data_int -> contiene n_frames frames por 752 datos
% obtenidos por interpolación

x = 1:size(data_int,1);
y = 1:size(data_int,2);

[X,Y] = meshgrid(x,y);
Z = data_int';
C=X.*Y;
figure
mesh(X, Y, Z,'FaceColor','texturemap', 'EdgeColor','interp','MeshStyle','both','BackFaceLighting','lit')
xlabel('Tiempo')
ylabel('Frames')
zlabel('Amplitud')
title('Mesh Plot')
rotate3d on 


%Implementando la función SURF 
%surf plot
figure
surf(x, y, Z,C,"FaceColor","interp","EdgeColor",[.4 .4 .4],"LineStyle",":")
set(gcf, 'Renderer', 'opengl')
title('Surf Plot')
xlabel('Tiempo')
ylabel('Frames')
zlabel('Amplitud')
colormap("hsv")  
light('Position', [0, 0, 1])


 



