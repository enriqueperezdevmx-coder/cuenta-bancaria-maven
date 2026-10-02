package com.academia.banco;

import java.math.BigDecimal;

public class App {
    public static void main(String[] args) {
        CuentaBancaria cuenta = new CuentaBancaria("Ana López");
        cuenta.depositar(new BigDecimal("2000.00"));
        for (int i = 1; i <= 4; i++) {
            cuenta.retirar(new BigDecimal("100.00"));
        }
        System.out.println("Estado de cuenta de " + cuenta.getTitular());
        for (Movimiento m : cuenta.getMovimientos()) {
            System.out.printf("  %-10s %10s%n", m.tipo(), m.monto());
        }
        System.out.println("  Saldo:     " + cuenta.getSaldo());
    }
}
