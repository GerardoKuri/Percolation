clear all;
clc;

%Se crean vectores vac�os para poder graficar resultados del an�lisis de
%percolaci�n, C = Porcentaje de percolaci�n exitosa, I=Probabilidad de
%bloqueo evaluada
C=zeros(100,1);
I=zeros(100,1);
X=0;
%Camino(10,40);
%display(M);
%Se itera 100 veces para escalar de manera constante la probabilidad de
%bloqueo y se iteran un total de 1000 veces matrices con ese porcentaje
for i=1:100
    X=0;
    for j=1:1000
        X=Camino(5,i)+X;
    end
    x=X/10;
    C(i,1)=x;
    I(i,1)=i;
    plot(I,C);
end



%Funci�n recibe como primer par�metro la dimensionalidad cuadrada de la
%matriz y como segundo el porcentaje de probabilidad de bloqueo de los
%valores. Funci�n devuelve verdadero si la matriz percola o falso si no.
function C = Camino(n,p)
%C salida de matriz que indica si hubo percolaci�n
C=0;
%Contruyendo matriz
M = mat_init_(n,p);
L = length(M);
%Bandera que indica que existe un posible camino 
x=0;
%Bandera que indica que se encontr� un camino
F=0;
for i = 1:L
    %contador que sirve como indicador de fila del valor que se est�
    %evaluando
    cont=1;
    x = 0;
    if (M(1,i) == 0 & F ~= 1)
        M(1,i)= 2;
        %Se levanta bandera para buscar camino por "entrada" de la primera
        %fila
        x = 1;
        %Se guarda posici�n de entrada
        Act = i;
        %Mientras la bandera est� arriba se buscar� camino de percolaci�n
        while x == 1
            %Se evaluan valores aleda�os al actual, si se encuentra se
            %actualiza valor actual
            if M(cont+1,Act) == 0
                M(cont+1,Act) = 2;
                cont = cont+1;
            elseif (cont ~= 1) 
                if M(cont,Act) == 0
                    M(cont,Act) = 2;
                    cont = cont+1;
                elseif  M(cont,Act-1) == 0
                    M(cont,Act-1) = 2;
                    Act = Act-1;
                elseif M(cont,Act+1) == 0
                    M(cont,Act+1) = 2;
                    Act = Act+1;
                elseif M(cont-1,Act-1) == 0
                    M(cont,Act-1) = 2;
                    Act = Act-1;
                    cont = cont-1;  
                elseif M(cont-1,Act+1) == 0
                    M(cont,Act+1) = 2;
                    Act = Act+1;
                    cont = cont-1; 
                %No se encontr� valor aleda�o igual a 0, se baja bandera    
                else
                    x = 0;
                end
            else 
                x = 0;
            end
            %Se evalua si la posici�n actual lleg� hasta la �ltima fila
            if cont == L-2
                %Se levanta bandera de camino
                F = 1;
                x = 2;
                C = 1;
                display(M);
            %Si no se encuentra camino se reinicia la matriz a la original
            elseif x == 0
                for i = 1:L-2
                    for j = 1:L-1
                        if M(i,j) == 2
                            M(i,j)=0;
                        end
                    end
                end
                F = 0;
            end
        end
    end
end
end


%funci�n recibe como primer par�metro la dimensionalidad cuadrada de la
%matriz y como segundo par�metro el porcentaje esperado de bloqueo
function M = mat_init_(n,p)
%Se crea matriz de tama�o nxn y se llena de valores aleatorios con valores
%entre 0 y 1
M = rand(n,n);
p=p/100;
%Se utiliza el par�metro del porcentaje para binarizar los valores creados
for i=1:n*n
    if M(i) > (1-p)
        M(i) = 1;
    else 
        M(i) = 0;
    end
end
%Se crea un vector de unos para as� concatenarlos a la matriz resultante
%como columnas en sus extremos con el fin de ser utilizados como l�mites
Vec = ones(n,1);
M = [Vec,M,Vec];
end

