import abstractos.*
class Persona{
    const formasDePago = #{}
    var pagoPreferido
    const objetos = []
    var trabajo
    
    method pagoPreferido () = pagoPreferido
    method cantidadCosas() = objetos.length()

    method efectivo() = formasDePago.find{x => x.medio() == "efectivo"}

    method comprar(objeto){
        if(pagoPreferido.puedeComprar(objeto.precio())){
            objetos.add(objeto)
            pagoPreferido.gastar(objeto.precio())
        }
    }
    method tarjetasCredito() = formasDePago.filter{x => x.medio() == "credito"}

    method cuotas() = self.tarjetasCredito().flatMap{x => x.cuotas()}

    method cuotasAPagar() = self.cuotas().filter{x => x.mes() <= mes.mes()}    

    method cobrarSueldo(){
        var sueldo = trabajo.sueldo()

        // Algo de pagar las cuotas

        self.efectivo().ganar(sueldo)
        
    }

    method cambiarPagoPreferido(otro){
        if(formasDePago.contains(otro))
            pagoPreferido = otro
        else
            throw new Exception(message ="Método de pago disponible")
    }
}


class CompradorCompulsivo inherits Persona{
    override method comprar(objeto){
       super(objeto)
        if(!objetos.contains(objeto)){ // Verificamos que no lo haya comrpado regularmente
            const pago = formasDePago.find{x=>x.puedeComprar(objeto.costo())} // wollok tira error en caso de no encontrarlo, no hacer nada sería mas indicado
            pago.comprar(objeto)}
    }
}

class PagadorCompulsivo inherits Persona{
    override method cobrarSueldo(){
        super()
        //self.pagarCuotas(self.efectivo())
    }
}
