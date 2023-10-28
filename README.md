# Examen Parcial: Mascotas

## Aclaraciones sobre el parcial

- El parcial es **individual** y se entrega **pusheando a este repositorio** como en las entregas anteriores. Recomendamos _ir pusheando cada cierto tiempo_ para evitar inconvenientes, lo ideal es después de cada punto resuelto.
- No se tendrán en cuenta los commits realizados después de la hora de finalización del examen.
- Una vez hecho el _push_ final, **verifiquen en github.com** que haya quedado la versión final. Nosotros corregiremos lo que está en github, si ustedes lo pueden ver ahí entonces nosotros también.
- No olvidarse de **los conceptos aprendidos**: polimorfismo, delegación, buenas abstracciones, no repetir lógica, guardar vs calcular, lanzar excepción cuando un método no puede cumplir con su responsabilidad, etc. Eso es lo que se está evaluando.
- La solución del examen consiste en la **implementación de un programa** que resuelva los requerimientos pedidos y sus **tests automatizados**.
- Este enunciado es acompañado con un archivo `.wtest` que tiene diseñado los test a realizar. Es importante aclarar que:
  - Estos tests se proponen para facilitar el desarrollo. Se puede diseñar otros si así se considera necesario.
  - El conjunto de tests propuesto es suficiente para este examen. Hay casos que no están contemplados por un tema de tiempo (hay muchas combinaciones). No hace falta agregar nuevos, pero tampoco se prohibe hacerlo.
  - Todos los objetos allí usados se asumen como instancias de una clase. Si el diseño de la solución utiliza objetos autodefinidos en algunos casos entonces se debe remover la declaración de la variable y la línea en que se sugiere la instanciación
  - Según el diseño de la solución, es probable que se requiera agregar más objetos a los sugeridos en los tests
  - Los tests están comentados de manera de poder _ir incorporándolos a medida que se avanza_ con la solución del ejercicio


## Contexto

Un grupo de fanáticos de las mascotas quiere un sistema que permita registrar cómo
afectan las mismas al estilo de vida de sus dueños y cuales son los mejores entrenadores
de mascotas.

## 1. Las mascotas

Una mascota influye en muchos aspectos de la vida de un dueño aportando cierto nivel
de amor, seguridad y diversión. 

El nivel de amor va a depender de cuanto afecto le de su dueño, número
que es conocido para cada dueño.

- Perros:
	
	- Amor: Los perros devuelven el doble del afecto que reciben de su dueño: `2 * afecto`. 
	Con excepción de los labradores, que suman 5 puntos de amor extra a lo que aportaría 
	un perro de otra raza: `(2 * afecto) + 5`.
	
	- Diversión: Los perros divierten mucho más a los pequeños que a los grandes, por eso se
	calcula como 100 menos la edad del dueño, todo dividido por 2. `(100 - edad)/2`
	
	- Seguridad: Los perros son los mejores guardianes. El nivel de seguridad es su capacidad
	 de guardia más un extra de 7 unidades en caso que el dueño sea menor de 18 años.
	 El nivel de guardia es un número que depende de cada perro: `guardia + (7 si es menor)`.
	 Para los labradores, sin embargo
	 es distinto. Su nivel de seguridad es el doble que la capacidad de guardia: `2 * guardia`.
	
- Gatos
	- Amor: devuelve un porcentaje determinado para cada gato del afecto recibido de su dueño. 
	- Diversión:  Aporta 20 para los dueños menores de 18 años y 15 para el resto
	- Seguridad: Los gatos no son los mejores animales para aportar a la seguridad aunque algunos
	maullan ante la presencia de humanos funcionando como alarma. Por lo
	tanto el valor de seguridad se configura para cada gato.

- Canarios
 	- Amor: un canario no devuelve amor (o sea, el nivel es 0)
    - Seguridad: No aporta nada en materia de seguridad
	- Diversión: aporta siempre 5 unidades con su bello canto.

### Requerimientos
 Saber los niveles de amor, seguridad y diversión que cada mascota aporta a su dueño

### Escenario de prueba

Mascotas:

	- Spike es un perro común con guardia de 40
	- Pluto es un perro común con guardia de 15
	- Droopy es un perro común con guardia de 30
	- Sam es un perro labrador con guardia de 15
	- Silvestre es un gato que devuelve 80% de amor y su nivel de seguridad es 23
    - Tom es un gato que devuelve 20% de amor y su nivel de seguridad es 12
	- Twitty es un canario
	- Woody es un canario

Dueños:
	
	- Atahualpa tiene 50 años, reparte 10 de afecto a sus mascotas y es dueño de Silvestre y woody  
	- Mercedes tiene 40 años, reparte 20 de afecto a sus mascotas y es dueña de Sam, Spike y droopy
	- Teresa tiene 60 años, reparte 15 de afecto a sus mascotas y es dueña de tweety
	- soledad tiene 16 años, reparte 35 de afecto a sus mascotas y es dueña de tom y pluto
	
Niveles de amor a testear:
	
	- El nivel de amor que Spike le aporta a Mercedes es 40
	- El nivel de amor que Sam le aporta a Mercedes es 45
	- El nivel de amor que Silvestre le aporta a Atahualpa es 8
	- El nivel de amor que Twitty le aporta a Teresa es 0

	
Niveles de diversión a testear:

	- El nivel de diversión que Spike le aporta a Mercedes es 30
	- El nivel de diversión que Sam le aporta a Mercedes es 30
	- El nivel de diversión que Silvestre le aporta a Atahualpa es 15
	- El nivel de diversión que tom le aporta a Soledad es 20
	- El nivel de diversión que Twitty le aporta a Teresa es 5
	

Niveles de diversión a seguridad:
	
	- El nivel de seguridad que Spike le aporta a Mercedes es 40
	- El nivel de seguridad que Pluto le aporta a Soledad es 22
	- El nivel de seguridad que Sam le aporta a Mercedes es 30
	- El nivel de seguridad que Silvestre le aporta a Atahualpa es 23
	- El nivel de seguridad que Twitty le aporta a Teresa es 0
	
## 2. Felicidad del dueño

Se sabe que los dueños pueden tener muchas mascotas las cuales determinan
si éste es o no feliz. 

Un dueño se considera feliz si se siente seguro y alegre

Para sentirse seguro, alcanza con al menos una mascota tenga un nivel de seguridad
mayor a 21.

Para sentirse alegre depende de los siguientes casos:

- Un dueño *sensible* es alegre si la sumatoria del amor recibido por sus mascotas supera
  a la sumatoria de diversión: `sum(amor) > sum(diversion)`
- Un dueño *hipersensible* es alegre si la sumatoria del amor recibido por sus mascotas supera
  a la mitad  de la sumatoria de la diversion: `sum(amor) > sum(diversion)/2`
- Un dueño *cálido* es alegre  si la cantidad de mascotas amorosas ( aportan más de 30 de amor) es de 2 o más: `sum(amorosas) >= 2`  
- Un dueño *intenso* es cálido también, pero la cantidad de mascotas amorosas ( aportan más de 30 de amor)
  para considerarse alegre es 3 o más. 
  Además, para sentirse alegre también necesita que  su mascota más divertida (la que aporta mayor diversión)
  sea también amorosa: `sum(amorosas) >= 3 y mascota mas divertida es amorosa`

### Requerimiento
- Saber si un dueño es feliz o no

### Escenario de prueba

Dado el escenario del punto anterior, y teniendo en cuenta que:

	- Atahualpa es sensible
	- Soledad es hipersensible
	- Mercedes es intensa
	- Teresa es cálida
	
Entonces:

	- Atahualpa no es feliz, porque es seguro pero no alegre
	- Soledad es feliz
	- Teresa no es feliz, porque no es ni segura ni alegre
	- Mercedes es feliz
	
## 3. Entrenamiento

Las mascotas pueden mejorar algunos de los niveles que aportan al recibir entrenamiento.
por parte de su dueño. 

La eficacia del entrenamiento es un número que depende de cada dueño de la siguiente manera:

- Los sensibles e hipersensibles entrenan con una eficiacia que es igual al afecto que le aportan
  a sus mascotas: `afecto`
- Los cálidos entrenan con una eficacia que se calcula como 5 por la cantidad
de mascotas que aportan 30 o más de amor: `5 * cantidad(amorosas)`
 
Cuando se entrena una mascota tiene este efecto:

- Canario: Sin importar la eficacia del entrenamiento un no canario aprende nada nuevo.
- Perro: El nivel de guardián del perro aumenta un 10\% del valor de la eficacia, 
 salvo para los labradores, que aumenta un 15\%. 
- Gato: El porcentaje que utilizan para el cálculo de amor aumenta un 1\% si la eficacia es menor a 20
 si no en 2\%. En el caso de que el porcentaje llegue a 100\%, no aumentará más de eso al entrenar.
 
 Nota: Si modelaron como 20 el afecto de tom, al entrenarlo por soledad el nuevo
 porcentaje quedaría en 22. Si lo modelaron como 0.20 entonces sería 0.22.
 
 Además es importante saber cuantas veces una mascota fue entrenada
 
 Los dueños sensibles, hipersensibles y cálidos pueden entrenar a una mascota siempre y cuando
 el nivel de eficacia supere a 9, mientras que un dueño intenso solo puede entrenar 
 a su mascotas cuando no es feliz.
 
### Requerimientos: 

  - Que un entrenador entrene a todas sus mascotas. 
  - Saber la cantidad de veces que una mascota fue entrenada.

### Escenario de prueba
  
Dado el escenario anterior:

  - Teresa no puede entrenar a sus mascotas porque su nivel de eficacia no llega a 9 (es 0) 
  - Mercedes (intensa) no puede entrenar a sus mascotas porque es feliz 
  - al entrenar Atahualpa a sus mascotas, 
    - silvestre comienza a devolver el 81% del amor
    - tanto silvestre como woody reportan que fueron entrenados una vez
  - al entrenar Atahualpa a sus mascotas por segunda vez, 
    - silvestre comienza a devolver el 82% del amor
    - tanto silvestre como woody reportan que fueron entrenados 2 veces
  - al entrenar soledad a sus mascotas, 
    - tom comienza a devolver el 22% del amor
    - pluto queda con un nivel de guardia de 18.5
    - tanto tom como pluto reportan que fueron entrenados una vez
 - al entrenar Soledad a sus mascotas por segunda vez, 
    - tom comienza a devolver el 24% del amor
    - pluto queda con un nivel de guardia de 22
    - tanto tom como pluto reportan que fueron entrenados 2 veces
 
  
## 4. Club de dueños de mascotas

El club de dueños de mascotas agrupa a varios dueños.
- El conjunto de mascotas seguras está dado por la mascota más segura de cada miembro del club
- El conjunto de los más fánaticos, que está formado por aquellos miembros que tienen 2 o más mascotas

### Requerimientos

- Saber el conjunto de mascotas seguras de un club. 
- El conjunto de los más fánaticos de un club.

### Escenario de prueba
  
  - Dado un club de duenios formado por Atahualpa, Mercedes, Teresa y Soledad 
	  - El conjunto de mascotas seguras está formado por Silvestre, Spike, Tweety y Pluto. 
	  - El conjunto de fanáticos está formado por Atahualpa, Mercedes y Soledad 
	  