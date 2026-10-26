# Justificación

### Separación de responsabilidad y delegación: 
Decidí que el Asistente no conozca los detalles internos de los tipos de abono mediante estructuras condicionales, sino que delegue el comportamiento específico directamente en los objetos fan y vip.

### Encapsulamiento del estado del usuario: 
La variable de descuento VIP (descuentoVip) se mantiene dentro del Asistente, siendo un property, en lugar de getters y setters públicos.

# Conceptos Clave Utilizados

### Polimorfismo
Se usó en la interacción entre el Asistente y sus abonos. Cuando el asistente necesita calcular su descuento o bonificarse, le envía el mismo mensaje a su abono sin importarle cuál de los 2 sea.

Esto evita el acoplamiento y los if por tipo de objeto. Permite que, si el día de mañana se agrega otro bono, solo haya que crear el nuevo objeto que entienda esos mensajes.

### Herencia
Se usa en la jerarquía de bandas, donde Rock, Trap e India heredan de la clase base Banda. También en la excepción NoPuedePagarException que hereda de Exception.

Permite reutilizar el código común y se aprovecha el override para adaptar fórmulas específicas de cada género musical sin duplicar lógica.

### Encapsulamiento
En el manejo de las colecciones y variables internas de las clases, como el historialEntradas de un asistente o el impuestoExtra de la productora.

Oculta el estado interno de los objetos y protege la integridad de los datos, permitiéndonos que las modificaciones y consultas se realicen únicamente a través de los métodos.

### Delegación
Se usó en descuento() del asistente, que delega la responsabilidad del cálculo matemático en el objeto abono pasándose a sí mismo como colaborador.

Asegura que cada objeto resuelva aquello para lo cual tiene la información necesaria.

### Colecciones y métodos de orden superior
Se usa en los reportes de la productora y métodos de los asistentes utilizando operaciones como .sum().

Permite procesar colecciones de objetos de manera declarativa mediante el paso de bloques de código, logrando un código mucho más expresivo, legible y limpio.
