object exceptionTalleInvalido inherits Exception {}

class RemeraLisa {

	var property talle = 0
	var property colorBase = null

	method costoBaseTalle() {
		if (talle >= 32 and talle <= 40) {
			return 80
		} else if (talle >= 41 and talle <= 48) {
			return 100
		} else {
			throw exceptionTalleInvalido
		}
	}
	
	method costoBaseColor() = colorBase.valor(self.costoBaseTalle())

	method costo() = self.costoBaseTalle() + self.costoBaseColor()
	
	method descuento() = 10 / 100 * self.costo()
	
}

class RemeraBordada inherits RemeraLisa {
	
	var property coloresBordado = []
	
	method costoBordado() {
		if (coloresBordado.size() <= 1) {
			return 20
		} else {
			return coloresBordado.size() * 10
		}
	}
	
	override method costo() = super() + self.costoBordado()
	 
	override method descuento() = 0
	
}


class RemeraSublimada inherits RemeraLisa {
	
	var property alto = 0
	var property ancho = 0
	var property marcaEstampada = null
	
	method costoSublimado() = (alto * ancho * 0.5) + marcaEstampada.derechosDeAutor()
	
	override method costo() = super() + self.costoSublimado()
	
	override method descuento() = if (marcaEstampada.hayConvenio()) (20/100 * self.costo()) else super()
	
}
