%Método de Muller  Ecuaciones con raices multiples.
%       muller(A,b) llenar
%       [res,fval,it] = muller(f,v0)
%       res = raiz
%       fval = valor de la función evaluada
%       it = iteraciones
%       f = función a tratar
%       v0 = vector de valores iniciales
%
%   See also Método de la Secante
%
%   Copyright 2021 Universidad de Cuenca.
%   $Revision: 0.1 $  $Date: 2021/11/20 16:00 $
%   Built-in function

function [res,fval,it] = muller(f,v0,itmax=1000,tol=1e-6)

  %Captura de errores
  if isnumeric(v0) ~= 1
    msgID = 'Vo debe ser de tres valores';
    msg = 'Vector incorrecto';
    error(msgID,msg)
  endif

  if isempty(v0) == 1 || length(v0) ~= 3 || min(size(v0)) ~= 1
    msgID = 'Vo debe tener longitud 3, valores complejos o reales ';
    msg = 'Vector incorrecto';
    error(msgID,msg)
  endif

  if v0(1)==v0(2) || v0(1)==v0(3) || v0(2)==v0(3)
    msgID = 'Los valores deben ser diferentes ';
    msg = 'Vector incorrecto';
    error(msgID,msg)
  endif

  %Desempaquetado de 'v0'
  x0 = v0(1);
  x1 = v0(2);
  x2 = v0(3);

  %Funcion evaluada con v0
  f0 = feval(f,x0);
  f1 = feval(f,x1);
  f2 = feval(f,x2);

  %Método de Muller
  for it=1:itmax
  %Ecuciones propías del método
    h0 = x1 - x0;
    h1 = x2 - x1;
    d0 = (f1 - f0) / h0;
    d1 = (f2 - f1) / h1;
  %Coeficientes
    A = (d1 - d0) / (h1 + h0);
    B = (A*h1) + d1;
    C = f2;

  %Analisis del Discriminante
    if A ~= 0
      d = B^2 - (4*A*C);      %Discriminante

      %Determinación de la raiz real o conjugada
      d1 = B + sqrt(d);
      d2 = B - sqrt(d);

      %Formula general
      if abs(d1) < abs(d2)
        x3 = x2 - (2*C/d2);
      else
        x3 = x2 - (2*C/d1);
      endif

    elseif B ~= 0
      x3 = x2 - (2*C/B);
    else
      msgID = 'El método Muller no ha encontrado una raíz. ';
      msg = 'El resultado de la última iteración es el resultado';
      res = x2;
      fval = y2;
      error(msgID,msg)
      return                  %Criterio de parada(stop)
    endif                     %con los resultados de la
                              %iteracion anterior

    f3 = feval(f,x3);         %Evaluación de la función con
                              %el valor x3 (raiz)

    %Error (convergencia del método de Muller)
    if abs((x3-x2)/x3) < tol
      res = x3;
      fval = f3;
      return                  %Criterio de parada(stop)
    endif                     %con los resultados de la
                              %iteracion actual
    %Valores finales (raiz)
    x0 = x1;
    x1 = x2;
    x2 = x3;

    %Funciónes evaluadas (valores finales)
    f0 = f1;
    f1 = f2;
    f2 = f3;
  endfor
endfunction
