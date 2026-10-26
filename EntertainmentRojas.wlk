class NoPuedePagarException inherits Exception {}

class Entrada{
    const property banda
    var property fecha
    const precioFijo=1000

    method precioFinal()=precioFijo + productora.impuestoExtra()

}

class Asistente{
    const abono
    var property descuentoVip = 0
    const historialEntradas=[]
    var dineroDisponible

    method descuento(){
        return abono.descuento(self)
    }

    method bonificar(){
        abono.bonificar(self)
    }

    method precioConDescuento(entrada){
        return entrada.precioFinal()*(1-self.descuento())
    }

    method dineroDisponible()=dineroDisponible

    method puedeComprarEntrada(entrada){
        if(dineroDisponible>0){
            self.comprarEntrada(entrada)
        }
        else{
            throw new NoPuedePagarException(message = "no puede pagar la entrada")
        }
    }

    method comprarEntrada(entrada){
        const precio=self.precioConDescuento(entrada)
        dineroDisponible -= precio
        historialEntradas.add(entrada)
    }

    method costoTotal(){
        return historialEntradas.sum({entrada => self.precioConDescuento(entrada)}).asSet()
    }

    method nombreBandas(){ 
        return historialEntradas.asSet().map({entrada => entrada.banda().nombre()})
    }

    method entradasAnioAnterior(){
        const anioAnterior=new Date().year()-1
        return historialEntradas.filter({entrada => entrada.fecha().year()==anioAnterior})
    }

}


object fan{
    method descuento(asistente)=0
    method bonificar(asistente){}
}

object vip{
    method descuento(asistente)=asistente.descuentoVip()

    method bonificar(asistente){
        asistente.descuentoVip(asistente.descuentoVip()+0.01)
    }

}


class Banda{
    const property nombre
    const precioPorTocar = 1000000

    method precioPorTocar()=precioPorTocar
    method calcularPresupuesto() = self.precioPorTocar() + self.gastoExtra()

    method calcularPopularidad()

    method gastoExtra()
}

class Rock inherits Banda{
    const cantSolosGuitarra
    override method gastoExtra()=10000

    override method calcularPopularidad()=100 * cantSolosGuitarra
}

class Trap inherits Banda{
    const tieneIce
    override method gastoExtra()=0

    override method calcularPopularidad(){
        if(tieneIce){
            return 1000
        }
        else{
            return 0
        }
    }

    override method precioPorTocar() = self.calcularPopularidad() * precioPorTocar
}

class Indie inherits Banda{
    const cantInstrumentos

    override method calcularPopularidad() = 3.14 * nombre.size()
    override method gastoExtra()=cantInstrumentos*500
}

object productora{
    var impuestoExtra=0
    method impuestoExtra()=impuestoExtra

    method cambiarImpuesto(nuevoImpuesto){
        impuestoExtra=nuevoImpuesto
    }

    const asistentes = #{}
    const bandas = #{}
    
    method calcularGanaciaTotal()=self.calcularIngresosTotales() - self.calcularPresupuestoTotal()

    method calcularPresupuestoTotal(){
        return bandas.sum({banda => banda.calcularPresupuesto()})
    }

    method calcularIngresosTotales(){
        return asistentes.sum({asistente => asistente.costoTotal()})
    }

    method cantidadEntradasVendidas(){
        return asistentes.sum({asistente=> asistente.historialEntradas().size()})
    }

    method bandaMasPopular(){
        const todasLasEntradas=asistentes.flatMap({asistente=>asistente.historialEntradas()})
        return bandas.max({banda=>todasLasEntradas.count({entrada=>entrada.banda()==banda})})
    }

    method bonificarVips(){
        asistentes.forEach({asistente=>asistente.bonificar()})
    }
}
