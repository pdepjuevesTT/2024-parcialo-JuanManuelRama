import abstractos.mes
class MedioDePago{
    method disponible()
    method gastar(cantidad)
    method puedeGastar(cantidad) = self.disponible()>=cantidad
    method ganar(cantidad)
}

class MedioDePagoInstantaneo inherits MedioDePago{
    var dinero
    override method disponible() = dinero
    override method gastar(cantidad) {dinero-=cantidad}
    override method ganar(cantidad) {dinero+=cantidad}
}

class Credito inherits MedioDePago{
    const bancoEmisor
    const property cuotas = []
    override method disponible() = bancoEmisor.tope()
    override method ganar(cantidad) {}

    override method gastar(cantidad){self.aniadirCuotas(self.cuotaIndividual(cantidad))}

    method deudas() = self.cuotas().filter{x => x.mes() <= mes.mes()}.sum{cuota => cuota.valor()}

    method montoTotal(pago) = pago+ pago*bancoCentral.interes() / 100
    method cuotaIndividual(cantidad) = self.montoTotal(cantidad)/bancoEmisor.cuotas()


    method rangoCuotas() = mes.mes()+1..mes.mes()+bancoEmisor.cuotas()+1

    method aniadirCuotas(cuota) {self.rangoCuotas().forEach{fecha => self.aniadirCuota(fecha, cuota)}}

    method aniadirCuota(fecha, valor) {cuotas.add(new Cuota(mes = fecha, valor = valor))}

    method puedePagarCuota(cuota, dinero) = cuota.valor() <=dinero && cuota.mes() <=mes.mes()

    method cuotaAPagar(dinero) = cuotas.find{cuota => self.puedePagarCuota(cuota, dinero)}

    method valorCuotaAPagar(dinero) = self.cuotaAPagar(dinero).valor()

    method pagarCuota(dinero) {cuotas.remove(self.cuotaAPagar(dinero))}

    method puedePagarCuotas(dinero) = cuotas.any{cuota =>self.puedePagarCuota(cuota, dinero)}

}

class CreditoRealista inherits Credito{
    method calcularInteres(fecha, valor) = (1+bancoCentral.interes()/100)*(fecha-mes.mes()) // No se como se calcula el crédito en la vida real
    override method aniadirCuota(fecha, valor) {{cuotas.add(new Cuota(mes = fecha, valor = self.calcularInteres(fecha, valor)))}}
}

class Cuota{
    const property mes
    const property valor
}

class Banco{
    var property tope
    var property cuotas
}

object bancoCentral{
    var property interes = 50
}
