import abstractos.mes
class MedioDePago{
    var dinero
    method disponible() = dinero
    method gastar(cantidad){dinero-=cantidad}
    method puedeGastar(cantidad) = dinero>=cantidad
    method ganar(cantidad){dinero += cantidad}
}

class Efectivo inherits MedioDePago{
}

class Debito inherits MedioDePago{
}

class Credito{
    const bancoEmisor
    const property cuotas = []
    method disponible() = bancoEmisor.tope()

    method gastar(cantidad){self.aniadirCuotas(self.cuotaIndividual(cantidad))}
    method puedeGastar(cantidad) = bancoEmisor.tope() >= cantidad

    method deudas() = self.cuotas().filter{x => x.mes() <= mes.mes()}.sum{cuota => cuota.valor()}

    method montoTotal(pago) = pago+ pago*bancoCentral.interes() / 100
    method cuotaIndividual(cantidad) = self.montoTotal(cantidad)/bancoEmisor.cuotas()


    method aniadirCuotas(cuota) {
        (mes.mes()+1 .. 1+mes.mes()+bancoEmisor.cuotas()).forEach{fecha => self.aniadirCuota(fecha, cuota) }
    }

    method aniadirCuota(fecha, valor) {cuotas.add(new Cuota(mes = fecha, valor = valor))}

    method puedePagarCuota(cuota, dinero) = cuota.valor() <=dinero && cuota.mes() <=mes.mes()

    method cuotaAPagar(dinero) = cuotas.find{cuota => self.puedePagarCuota(cuota, dinero)}

    method valorCuotaAPagar(dinero) = self.cuotaAPagar(dinero).valor()

    method pagarCuota(dinero) {cuotas.remove(self.cuotaAPagar(dinero))}

    method puedePagarCuotas(dinero) = cuotas.any{cuota =>self.puedePagarCuota(cuota, dinero)}

}

class CreditoRealista inherits Credito{
    method calcularInteres(fecha, valor) = (1+bancoCentral.interes()/100)*(fecha-mes.mes()) // No se como se calcula el crédito en la vida real
    override method aniadirCuota(fecha, valor) {
        {cuotas.add(new Cuota(mes = fecha, valor = self.calcularInteres(fecha, valor)))}
    }
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
