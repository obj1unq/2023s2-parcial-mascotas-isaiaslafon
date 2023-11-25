class Duenio{
	const mascotas = #{}
	const edad
	const afecto
	var estado
	
	method eficacia(){
		return estado.eficacia(self)
	}
	
	method estado(_estado){
		estado = _estado 
	}
	
	method afecto(){
		return afecto
	}
	
	method edad(){
		return edad
	}
	
	method esMenor(){
		return edad < 18
	}
	
	method feliz(){
		return self.seguro() && self.alegre()
	}
	
	method alegre(){
		return estado.alegre(self)
	}
	
	method seguro(){
		return mascotas.any({mascota => mascota.seguridad(self) > 21})
	}
	
	method mascotasMasSegura(){
		return mascotas.max({mascota => mascota.seguridad(self)})
	}
		
	method esFanatico(){
		return mascotas.size() >= 2
	}
	
	method amorTotal(){
		return mascotas.sum({mascota => mascota.amor(self)})
	}
	
	method diversionTotal(){
		return mascotas.sum({mascota => mascota.diversion(self)})
	}
	
	method cantidadAmorosas(){
		return mascotas.count({mascota => mascota.esAmorosa(self)})
	}
	
	method masDivertidaEsAmorosa(){
		return self.masDivertida().esAmorosa(self)
	}
	
	method masDivertida(){
		return mascotas.max({mascota => mascota.diversion(self)})
	}
	
	method puedeEntrenar(){
		return estado.puedeEntrenar(self)
	}
	
	method entrenar(){
		self.validarEntrenar()
		mascotas.forEach({mascota => mascota.serEntrenada(self)})
	}
		
	method validarEntrenar(){
		if(not self.puedeEntrenar()){
			self.error("No puede entrenar!")
		}
	}
	
}

class AnimoBase{
	method puedeEntrenar(duenio){
		return duenio.eficacia() > 9
	}
}

class AnimoSensible inherits AnimoBase{
	method eficacia(duenio){
		return duenio.afecto()	
	}
	
	method alegre(duenio){
		return duenio.amorTotal() > self.diversionTotal(duenio)
	}	
	
	
	method diversionTotal(duenio){
		return duenio.diversionTotal()
	}
}

class AnimoHipersensible inherits AnimoSensible{
	override method diversionTotal(duenio){
		return super(duenio) / 2
	}
}

class AnimoCalido inherits AnimoBase{
	method alegre(duenio){
		return duenio.cantidadAmorosas() >= self.minimoAmorosas()
	}
	
	method minimoAmorosas(){
		return 2
	}
	
	method eficacia(duenio){
		return 5 * duenio.cantidadAmorosas()
	}
}

class AnimoIntenso inherits AnimoCalido{
	override method alegre(duenio){
		return super(duenio) && duenio.masDivertidaEsAmorosa()
	}
	override method minimoAmorosas(){
		return 3
	}
	
	override method puedeEntrenar(duenio){
		return not duenio.esFeliz()
	}
}

object animoSensible inherits AnimoSensible{}
object animoHipersensible inherits AnimoHipersensible{}
object animoCalido inherits AnimoCalido{}
object animoIntenso inherits AnimoIntenso{}

class Club{
	const miembros = #{}
	
	method mascotasMasSeguras(){
		return miembros.map({duenio => duenio.mascotasMasSegura()}).asSet()
	}

	method masFanaticos(){
		return miembros.filter({duenio => duenio.esFanatico()})
	}		
}

class Mascota{
	var entrenamientos = 0
	
	method entrenamientos(){
		return entrenamientos 
	}
	
	method amor(duenio){
		return duenio.afecto()
	}
	
	method diversion(duenio)
	
	method seguridad(duenio)
	
	method esAmorosa(duenio){
		return self.amor(duenio) > 30
	}
	
	method serEntrenada(duenio){
		entrenamientos += 1
		self.efectoDeEntrenar(duenio)
	}
	
	method efectoDeEntrenar(duenio)
}


class Perro inherits Mascota{
	var guardia
	
	method guardia(){
		return guardia
	}
	override method efectoDeEntrenar(duenio){
		guardia += duenio.eficacia() * self.porcentajeEficacia()
	}
	
	method porcentajeEficacia(){
		return 0.1
	}
	
	override method amor(duenio){
		return 2 * super(duenio)
	}
	
	override method diversion(duenio){
		return (100 - duenio.edad()) / 2
	}
	
	override method seguridad(duenio){
		return guardia + self.extraPorEdad(duenio)
	}
	
	method extraPorEdad(duenio){
		return if(duenio.esMenor()) 7 else 0
	}
}

class PerroLabrador inherits Perro{
	override method porcentajeEficacia(){
		return 0.15
	}
	
	override method amor(duenio){
		return super(duenio) + 5
	}
	
	override method seguridad(duenio){
		return guardia * 2 
	}
}

class Gato inherits Mascota{
	var porcentajeAmor
	const seguridad
	
	method porcentajeAmor(){
		return porcentajeAmor
	}
	
	override method amor(duenio){
		return super(duenio) * porcentajeAmor
	}
	
	override method diversion(duenio){
		return if(duenio.esMenor()) 20 else 15
	}
	
	override method seguridad(duenio){
		return seguridad
	}

	method porcentajeAumentar(duenio){
		return if(duenio.eficacia() < 20) 0.01 else 0.02
	}
	
	override method efectoDeEntrenar(duenio){
		self.aumentarPorcentajeAmor(self.porcentajeAumentar(duenio))
	}
	
	method aumentarPorcentajeAmor(porcentajeAumentar){
		porcentajeAmor = 1.min(porcentajeAmor+porcentajeAumentar)
	}
}

class Canario inherits Mascota{
	override method amor(duenio){
		return 0
	}
	
	override method seguridad(duenio){
		return 0
	}
	
	override method diversion(duenio){
		return 5
	}
	
	override method efectoDeEntrenar(duenio){
		//No hace nada!
	}
}




