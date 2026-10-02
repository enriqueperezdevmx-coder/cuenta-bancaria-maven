package com.academia.banco;

import static org.junit.jupiter.api.Assertions.assertEquals;
import java.math.BigDecimal;
import org.junit.jupiter.api.Test;

class DepositoTest {

    @Test
    void unaCuentaNuevaEmpiezaEnCero() {
        CuentaBancaria cuenta = new CuentaBancaria("Ana");
        assertEquals(new BigDecimal("0.00"), cuenta.getSaldo());
    }

    @Test
    void depositarSumaAlSaldo() {
        CuentaBancaria cuenta = new CuentaBancaria("Ana");
        cuenta.depositar(new BigDecimal("100.00"));
        cuenta.depositar(new BigDecimal("50.00"));
        assertEquals(new BigDecimal("150.00"), cuenta.getSaldo());
    }
}
