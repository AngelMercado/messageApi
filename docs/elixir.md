# Elixir

## Variables y pattern matching
En elixir no existen las asignaciones, en su  
lugar existe el patter matching, en el cual antes
de una asignacion realiza una validacion para  
saber si es posible asignar un valor a una variable

``` elixir
#Es posible realizar ambos staments
iex> salary = 20000
iex> 2000 = salary

```

``` elixir
#No es posible realizar el segundo 
#stament

iex>salary=2000
iex>1000=salary

```

patter matching con tuples

En patter matching se requiere que se tenga el mismo numero
de elementos en la asignacion y la variable, es posible usar _
para tomar todos los campos que no esten considerados

``` elixir
iex> {1,2,3}
iex> {x,y,z} = {1,2,3}

```

patter matching tuples that contains atos

``` elixir
iex> responde = {:ok,400,0.13}
iex> {:ok, x ,y} = response
```

las variables que se encuentran en tuplas
pueden se referenciadas por el nombre, tener
en cuenta que si ya existe en una tupla, el  
valor no puede modificarse  

``` elixir
iex> {:ok,x,y}  = {:ok,400,0.13}
iex> x = "random value"
iex> x
```


## Garbage collection

En elixir no es necesario limpiar las variables.
contiene un mecanismo que se encarga de eliminar las variables

# Build in Datatypes

## Numbers
``` elixir
## Integer

5       //decimal
0xfa   //exadecimal
0o37   //octal
0b1010 //binary
4_400_000 //decimales pueden usar guion bajo para realizar las separaciones

## Decimal

2.15
0.1234e5

```

## Items

Son constantes los valores son iguales al nombre
deben empezar con double colom

``` elixir
:ok
:error

#si se asignan a una variable tendra la referencia
#y no tendran el valor string del item
```

## booleans

Las variables boleans son items que tienen el nombre

``` elixir
##
false
true

##
:false
:true

##nil is null
nil
nil == :nill

# ===Falsy:
nil
false

#=== otros valore se consideran truthy


```

## Tuple

Alacenan valores en orden, pueden ser de diferente tipo 
se usan curly breakers, tienen un numero de elementos fijos

``` elixir  

tuple = {:ok, "hi", 10}
IO.put elem(tuple,0)

```

##  List
Almacenan elementos en orden, usa un linkedlist, su tamanio puede 
ir incrementando

``` elixir

list = [1,"hi",:atom]

IO.puts length(list)
IO.puts Enum.at(list,1)

#Contiene head y tail
IO.puts hd(list)
IO.inspect tl(1 \)

```

## Keyword list
Es la convinacion entre lista y tuples, usar cuando se posible
tener keywords repetidos, se pueden usar como opciones en las funciones

``` elixir

value = [href:"example.com", class: "link"]
value = [:hreg => "example.com", :class => "class"]
value = [{:href,"example"},{:class, "link"}]

```

## Maps
Estructuras clave valor, no permiten valores duplicados

``` elixir

value = %{ language: => "Elixir", "platform" => "Eduonix"}

## uso de items como llaves
## aumenta la velocidad en comparaciones

value = %{ language: "Elixir", platform: , "Eduonix" }

## Acceder a valore de un mapa

IO.put value[:language]
IO.put value.platform

## si la una llave no existe el resultado es nil

IO.inspect value[:non_exist]

#Actualizacion de un mapa se optiene nuevo mapa

new_value = %{ value | language: "Erlang", platform: "IDK"}

IO.inspect new_value

```

# String

Son una lista de caracteres

``` elixir

string = "Hi!"

## concatenacion de valores
string = "hi #{2*5}"


# controlando la interpolacion
# permitir interpolacion
s_sigils = ~s( hi #{2*5})
# permitir interpolacion
no_int_sigil = ~S(hi #{2*5} ) 

#concatenacion de 2 variables
concated = s_sigil <> no_int_sigil
IO.inspect string
IO.inspect no_int_sigil
IO.inspect s_sigil
IO.inspect concated

```
# Character list

Es una lista de integer donde cada integer representa  
un caracter

``` elixir

list = 'Hi'

IO.inspect list
IO.inspect [72,73]

##control de interpolacion

~c(hi)

~C(hi) #no permite interpolacion

#convertir character list to string
List.to_string('HI')

#convertir string to character list
String.to_characterlist("HI")
```
## Modulos y funciones

Modulos son utilizados como namespaces para agrupar
funciones

Pueden conterner puntos para indicar jerarquias


Los modulos internamente pertenecen a elixir

Elixir.MyApp.Calc == MyApp.Calc

Las funciones no requiere return la ultima  
sentencia retorna el valor


Para llamar a otra funcion no se requiere realizar  
el llamado a otra anotacion

las funciones del modulo KERNEL puden llamarse directamente
un ejemplo es la funcion length


``` elixir
#definicion de un modulo
defmodule MyApp.Calc do

    #alias ayudan a renombrar modulos

    alias IO, as: DemoId

    #tambien ayuda simplicar nombres


    def plus(a,b) do
        a+b
    end

    #otra forma de definir funciones
    #def plus(a.b), do: a+b

    def mult(a,b) do
        a*b
    end

    defp do_some_stuff do
    
    [1,2,3] |> length |> DemoId.puts
    end

end


defmodule MyApp.SomeOtherMed do

end

```

Ejemplo de llamado de una funcion dentro de otra funcion

``` elixir
Myapp.Calc.plus(1,2) |> Myapp.Calc.plus(3)

```
## Arity de funciones y Guard Clauses

arity -> cuantos argumentos contiene una funcion

add/1
add/2

utilizar al inicio las funciones que utilizan  
patter matching , ya que si se coloca en el top  una
funcion mas general las especificas nunca se ejecutaran


``` elixir

def module Calc do

    def factorial(0) do:1

    #factorial(5)
    #5 * (5-1) * (5-1-1)
    #se pueden utilizar condiciones en las funciones
    #con la clausula when y operadores logicos
    # function to check
    # operadores aritmeticos
    # in operator (validar si una collection contiene un valor)
    #join clauses <>
    # se le llama guard clause
    def factorial(a) when is_integer(a) and a> 0 do
    a * factorial(a-1)
    end

    #fallback function
    #sin las primeros argumentos no son validos
    #se realiza el llamado ala funcion

    def factorial(_) do
    {:error, :invalid_argument}
    end

    ##patter matching en funcion
    ##solo se realiza si el segundo valor es 0
    ##es un ejemplo de como generar un error cuando
    ##existe un valor no valido
    ##_a indica que el valor no es necesario
    def divide(_a,0) do
     {:error, :zero_division}
    end
    
    def divide(a,b) do
    a/b
    end

    def add(a) do
    add a.0
    end

    def add(a,b) do
    a+b
    end

    ##colocar valores predetermindados
    ##permite que algunos valores sean
    ##opcionales
    def add(a,b // 0) do
    end

end
```
# Lambda Function (Anonimous Functions)

``` elixir

#global variable
#no se puede modificar la variable
salt = "random"

# las funciones lambda no pueden
# tener valores por defecto

mad_printer = fn(initial_string) ->
    initial_string |>
    String.reverse |>
    IO.puts
end  

#simplicacion de una funcion lambda con 
#un solo parametro
# las funciones lambda no pueden
# tener valores por defecto
mad_printer = %(
    &1 <> salt |>
    String.reverse |>
    IO.puts
)

#se pueden definir funciones
#con multiples implementations
#dependiendo del valor que se obtenga
#implementacin para parametros vacios
("") -> IO.puts("__NOVAL_")

(initial_string) ->
    initial_string |>
    String.reverse |>
    IO.puts
end  


# lambda funcions puede pasarse como
# parametros de otras funciones

Enum.each ["hello","there","frieds"] , mad_printer

mad_printer.("hello there friends!")

#Especificando el numero de parametros
#al pasar una funcion como parametro

Enum.each ["hello","there","friend"], &IO.puts/1

```

# Intertions
## Patter matching con arreglos

``` elixir
#se asigna el arreglo a list
list= [1,2,3]

#se asigna el primer elemento a head
#los ultimos elementos a list
[head|list] = [1,2,3]

#se asigna 
#a x primer elemento
#a y segundo elemento
#a tail un arreglo con el tercer elemento
[x,y|tail] = [1,2,3]

``` elixir
#implementacion de multiplicacion de elementos

defmodule Calc do
    def mult([]) do: 1
    
    def mult(head | tail) do
        #head es una varibale con el valor
        #la segunda queda pendiente hasta que el
        #arreglo este vacio
        head * mult(tail)
    end

    def map([head | tail],func)do
        [func.(head) | map(tail, fun)]
    end


end

```
``` elixir
#ejemplo implementacion de recursion
#pasando una funcion como parametro

defmodule ListUtils do

    def map([],_fun) do:[]

    def map([head | tail],fun) do
        # se procesa la funcion con head
        # en el tail quedan pendientes los elemtos
        #al final todos los elemtos son procesados por la funcion
        #creando una nueva lista con los valores ya procesados
        [fun.(head) | map(tail,fun)]
    end

    def max([value | [head | tail]]) when value< head do
        max [head | tail]
    end
end

#ejemplo de implementacion

ListUtils.map([2,3,4], &(&1*3)) |>
IO.inspect

```



## Mejoras en el rendimiento de phoniex

1. Utilizar el perfil PROD
MIX_ENV=prod mix phx.server

2. Para diagnostico usar un observer

MIX_ENV=prod iex -S mix phx.server

GRUB_CMDLINE_LINUX_DEFAULT="quiet splash nomodeset"

