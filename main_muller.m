% Autores: Pablo Bermeo
%          Luis Corte
%          Sebastian Criollo
%
% Fecha: 20/11/2021
% Descripcion: Emplear el metodo iterativo de Muller para
% la solucion de ecuaciones no lineales con varias respuestas


%Datos
f = @(x) cos(x) - x.*e.^(x)
v0 = [1, 2, 3]

try

  tic;
  [res,fval,it] = muller(f,v0,itmax=1000,tol=0.001)
  toc;
catch err
  fprintf('Error: %s\n',err.message);
end_try_catch

%Intervalo para graficar
x0 = -3:0.1:2;

  %Grafico
figure(1);
plot(x0, f(x0),'linewidth',2);
title('Problema múltiples soluciones')
legend('Voltaje')
xlabel('x')
ylabel('f(x)')
grid on
