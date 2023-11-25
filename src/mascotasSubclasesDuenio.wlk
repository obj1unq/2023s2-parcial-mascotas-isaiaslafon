class Club{
	const property miembros = #{}

	method mascotasMasSeguras(){
		return miembros.map({miembro => miembro.mascotaMasSegura()}).asSet()
	}

	method fanaticos(){
		return miembros.filter({miembro => miembro.esFanatico()})
	}
}

class Duenio{
	const mascotas = #{}
	const property afecto
	const edad

	method esMenor(){
		return edad < 18
	}

	method esFeliz(){
		return self.estaSeguro() and self.estaAlegre()
	}

	method estaSeguro(){
		return mascotas.any({mascota => mascota.seguridad(self) > 21})
	}

	method estaAlegre()

	method entrenarMascotas(){
		self.validarEntrenamiento()
		mascotas.forEach({mascota => mascota.serEntrenada(self)})
	}

	method validarEntrenamiento(){
		if(not self.puedeEntrenar()){
			self.error("No estoy en condiciones de entrenar a nadie...")
		}
	}

	method puedeEntrenar(){
		return self.eficacia() > 9
	}

	method eficacia()
	
	method mascotaMasSegura(){
		return mascotas.max({mascota => mascota.seguridad(self)})
	}

	method esFanatico(){
	 	return mascotas.size() >= 2
	}
}

class DuenioSensible inherits Duenio{
	override method estaAlegre(){
		return self.amorTotal() > self.diversionTotal()
	}

	method amorTotal(){
		return mascotas.sum({mascota => mascota.amor(self)})
	}

	method diversionTotal(){
		return mascotas.sum({mascota => mascota.diversion(self)})
	}

	override method eficacia(){
		return afecto
	}
}

class DuenioHipersensible inherits DuenioSensible{
	override method diversionTotal(){
		return super() / 2
	}
}

class DuenioCalido inherits Duenio{
	method cantidadAmorosas(){
		return mascotas.count({mascota => mascota.esAmorosa(self)})
	}

	override method estaAlegre(){
		return self.cantidadAmorosas() >= self.cantidadMinimaAmorosas()
	}

	method cantidadMinimaAmorosas(){
		return 2
	}

	override method eficacia(){
		return 5 * self.cantidadAmorosas() + if(self.cantidadAmorosas() > 5) 5 else 7
	}
}

class DuenioIntenso inherits DuenioCalido{
	override method estaAlegre(){
		return super() and self.mascotaMasDivertida().esAmorosa(self)
	}

	override method cantidadMinimaAmorosas(){
		return 3
	}

	method mascotaMasDivertida(){
		return mascotas.max({mascota => mascota.diversion(self)})
	}

	override method puedeEntrenar(){
		return not self.esFeliz()
	}
}

class Mascota{
	var entrenamientos = 0

	method amor(humano)

	method diversion(humano)

	method seguridad(humano)

	method esAmorosa(humano){
		return self.amor(humano) > 30
	}

	method serEntrenada(humano){
		self.aplicarEfecto(humano)
		entrenamientos += 1
	}

	method aplicarEfecto(humano)
	
	method entrenamientos(){
		return entrenamientos
	}
}

class PerroBase inherits Mascota{
	var guardia

	override method amor(humano){
		return 2 * humano.afecto()
	}

	override method diversion(humano){
		return (100 - humano.edad()) / 2
	}

	override method seguridad(humano){
		return guardia
	}

	override method aplicarEfecto(humano){
		self.aumentarGuardia(humano.eficacia(self) * self.factorEficacia())
	} 

	method aumentarGuardia(cantidad){
		guardia += cantidad
	}

	method factorEficacia()

	method guardia(){
		return guardia
	}
}

class Perro inherits PerroBase{
	override method seguridad(humano){
		return super(humano) + self.aportePorEdad(humano)
	}

	method aportePorEdad(humano){
		return if(humano.esMenor()) 7 else 0
	}

	override method factorEficacia(){
		return 0.1
	}
}

class PerroLabrador inherits PerroBase{
	override method amor(humano){
		return super(humano) + 5
	}

	override method seguridad(humano){
		return super(humano) * 2
	}

	override method factorEficacia(){
		return 0.15
	}
}

class Gato inherits Mascota{
	var porcentajeAmor
	const seguridad

	override method amor(humano){
		return porcentajeAmor * humano.afecto()
	}

	override method diversion(humano){
		return if (humano.esMenor()) 20 else 15
	}

	override method seguridad(humano){
		return seguridad
	}

	override method aplicarEfecto(humano){
		self.aumentarPorcentajeAmor(self.porcentajeDeEficacia(humano))
	} 

	method porcentajeDeEficacia(humano){
		return if(humano.eficacia(self) < 20) 0.01  else 0.02
	}

	method aumentarPorcentajeAmor(porcentaje){
		porcentajeAmor = 1.min(porcentaje + porcentajeAmor)
	}

	method porcentajeAmor(){
		return porcentajeAmor
	}
}

class Canario inherits Mascota{
	override method amor(humano){
		return 0
	}

	override method seguridad(humano){
		return 0
	}

	override method diversion(humano){
		return 5
	}

	override method aplicarEfecto(humano){
		//No hace nada!
	}
}

