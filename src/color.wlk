class ColorBasico {
	
	// Si es basico no hay adicional
	method valor(unCosto) = 0
	
}

class Color inherits ColorBasico {
	
	// Un 10% mas del costo base
	override method valor(unCosto) = unCosto * 10 / 100
	
}
