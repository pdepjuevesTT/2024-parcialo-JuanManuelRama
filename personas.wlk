import abstractos.*
import financieros.Efectivo
class Persona{
    method formasDePago() = [efectivo] + credito + debito
    const property efectivo = new Efectivo(dinero = 0)
    const property debito = []
    const property credito = []
    var pagoPreferido
    const objetos = []
    var property trabajo
    
    method pagoPreferido () = pagoPreferido
    method cantidadCosas() = objetos.size()


    method comprar(objeto){
        if(pagoPreferido.puedeGastar(objeto.precio())){
            objetos.add(objeto)
            pagoPreferido.gastar(objeto.precio())
        }
    }

    method cuotas() = credito.flatMap{x => x.cuotas()}

    method deuda() = credito.sum{tarjeta => tarjeta.deudas()}

    method pagarCuotas(medio){
        if(credito.any{tarjeta => tarjeta.puedePagarCuotas(medio.disponible())}){
            const tarjeta = credito.find{tarjeta => tarjeta.puedePagarCuotas(medio.disponible())}
            medio.gastar(tarjeta.valorCuotaAPagar(medio.disponible()))
            tarjeta.pagarCuota(medio.disponible())
            self.pagarCuotas(medio)
            }       
        
    }

    method cobrarSueldo(){
        const sueldo = new Efectivo(dinero = trabajo.cobrar())
        self.pagarCuotas(sueldo)
        efectivo.ganar(sueldo.disponible())
    }

    method cambiarPagoPreferido(){
        pagoPreferido = self.formasDePago().filter{x => x!= pagoPreferido}.anyOne()
    }
}


class CompradorCompulsivo inherits Persona{
    override method comprar(objeto){
       super(objeto)
        if(!objetos.contains(objeto)){ // Verificamos que no lo haya comrpado regularmente
            const pago = self.formasDePago().find{x=>x.puedeGastar(objeto.costo())} // wollok tira error en caso de no encontrarlo, no hacer nada sería mas indicado
            pago.comprar(objeto)}
    }
}

class PagadorCompulsivo inherits Persona{
    override method cobrarSueldo(){
        super()
        self.pagarCuotas(self.efectivo())
    }
}
