# Errores de Maven que encontré

| Queja | La línea clave que dijo Maven | La causa | Cómo lo arreglé |
|---|---|---|---|
| 1 | `[FATAL] Non-parseable POM pom.xml: end tag name </project> must match start tag name <dependency>` | Se cerró la dependencia de Jackson con `</project>` en lugar de `</dependency>`. | Cambié `</project>` por `</dependency>` en la línea 28. |
| 2 | `Fatal error compiling: error: release version 21 not supported` | Se configuró `maven.compiler.release` en 21 pero el entorno utiliza Java 17. | Cambié `<maven.compiler.release>21` por `17` en `<properties>`. |
| 3 | `Could not find artifact com.fasterxml.jackson.core:jackson-databind:jar:2.22.30 in central` | Se introdujo una versión inexistente (`2.22.30`) en la propiedad de Jackson. | Cambié `<jackson.version>2.22.30` por `2.22.3` en `<properties>`. |
| 4 | `package com.fasterxml.jackson.core does not exist` en `EstadoDeCuenta.java` | Jackson tenía `<scope>test</scope>`, por lo que no estaba disponible para `src/main/java`. | Eliminé la etiqueta `<scope>test</scope>` de `jackson-databind`. |
| 5 | `Error: Could not find or load main class com.academia.banco.Aplicacion` | El `mainClass` del manifiesto apuntaba a una clase inexistente (`Aplicacion`). | Cambié `com.academia.banco.Aplicacion` por `com.academia.banco.App` en `maven-jar-plugin`. |