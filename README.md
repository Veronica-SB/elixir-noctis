# Elixir Noctis



Sistema de gestión de inventario y pedidos de un banco de sangre vampírico.



Los donantes humanos registran sus donaciones, un equipo de transportistas se encarga de recogerlas y entregarlas, y los clientes vampiros compran bolsas a través de un catálogo. Todo el recorrido de la sangre, desde la donación hasta la entrega, está controlado por estados y reglas de negocio: caducidad, precio dinámico, valoraciones y permisos por rol.



## Stack



- **Backend:** Java + Spring Boot, con Spring Security para la autenticación y los permisos

- **Base de datos:** PostgreSQL

- **Frontend:** Next.js + TypeScript

- **Infraestructura:** Docker



## Funcionalidades



**Cuatro roles con permisos diferenciados**

- *Admin:* asigna transportistas, revisa las donaciones entrantes y consulta un panel de estadísticas

- *Donante:* registra donaciones y sigue su estado y sus valoraciones

- *Transportista:* gestiona recogidas y entregas

- *Cliente:* compra en el catálogo, con carrito persistente, y valora sus pedidos



**Lógica de negocio**

- Recorrido completo de la donación y del pedido mediante máquinas de estados

- Caducidad automática de las bolsas, con rebaja de precio los días previos

- Precio calculado a partir del grupo sanguíneo, la reputación del donante, sus características y la frescura de la bolsa

- Sistema de valoraciones que alimenta la reputación de donantes y transportistas

- Baja de usuarios con anonimización de datos personales



## Cómo ejecutarlo



**Requisitos:** Docker



1. Clona el repositorio y entra en la carpeta:



```bash

git clone git@github.com:Veronica-SB/elixir-noctis.git

cd elixir-noctis

```



2. Copia el archivo de variables de entorno y rellena la contraseña:



```bash

cp .env.example .env

```



3. Levanta la base de datos:



```bash

docker compose up -d

```



4. Ejecuta `esquema.sql` sobre la base de datos `elixir_noctis` para crear las tablas.



## Estado del proyecto



En desarrollo. Actualmente están terminados el diseño funcional, el modelo de datos y la infraestructura de la base de datos.



**Siguientes pasos:** API REST con Spring Boot, autenticación con Spring Security e interfaz en Next.js.

