# Unidad 1: DEINT
> **NOTA** 
Cada versión de *Android Studio* tiene una versión de *Java* específica. Por ende el Gradle también tiene una versión, y todas estas deben de coincidir y *influye* en los proyectos, así que un proyecto con un equipo puede dar fallo en otro por tener la versión de *Android Studio* distinta.

## ¿Qué es una activity?
Es el componente más común de una app, representan las pantallas con una interfaz, que ve el usuario.
Suele estar formada por más de una pantalla que se comunican entre sí, de forma que permita el movimiente entre ellas.
Las activity son independientes ya que cada una tiene su propia interfaz gráfica, también tienes su propio ciclo de vida 
y responden eventos diferentes
 
## Pila Actividades
También conocida como Back Stack, cuando el usuario cambia de Activity, la pantalla muestra la nueva mientras que la que estaba antes, se guarda en la pila, suspendiendose y manteniendo el estado en el que se encontraba, hay dos estados: Pausa o Ejecución.
Cuando el usuario pulsa la flecha atrás, Back, saca la activity de la pila que hay arriba, la actual, y la destruye acabando con el ciclo de vida. 
Para mostrar la que estaba antes, siguiente posición de la pila. reanudando la activity. Este mecanismo de stack se le conoce como LIFO
(LAST IN - LAST OUT). Si la actividad que se destruye es la principal, última, el OS cerrará la app y si se pulsa el botón home entonces la pila de actividades
permanecerá tal cuál estaba. Y la activity actual permanece en pausa.

## Interfaz de una actividad


## Iniciar una actividad
Crear una clase que herede de Activity, mediante la palabra extends, se implementan los métodos de ciclo de vida para determinar bajo que funciones cambia el estado
de nuestra Activity. Estos métodos son llamados callback y serán utilizados por el OS cuando se necesiten, estos también se utilizan para comunicación hacia arriba, 
a un padre, Si una activity se ha configurado como punto de entrada en el intent, se inicia una tarea y se visualiza la activity.
A partir de aquí se puede iniciar otras activity mediante el método startActivity(Intent intent) pasando como argumento un objeto Intent.
La comunicación entre activity y otros componentes se realiza através de intenciones o Intent. Está clase contiene los campos con los datos de la acción y la acción a realizar.

## Ciclo Vida Actividad
Este está controlado por el OS mediante una colección de métodos callback y es responsabilidad del programador hacer que la app sea estable y hacer una 
buena uso/gestión de los recursos. El ciclo de vida es impredecible y viene determinado por la posición en la pila de actividades, además de que el estado servirá 
para determinar la prioridad de la app cuando haya que tener que liberar recursos del sistema.
