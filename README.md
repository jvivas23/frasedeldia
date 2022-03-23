# frasedeldia

Proyecto de flutter que muestra al iniciar sesión en la app una frase del día. Para este proyecto se utilizo el patrón  BLoC,
este es un sistema de gestión de estado para Flutter recomendado por los desarrolladores de Google. Para facilitarme la implementación del patrón BLoC 
se utilizo flutter_bloc(https://pub.dev/packages/flutter_bloc).

# Estructura del proyecto
La app cuenta con dos packages:
  -packages  
    - authentication_repository. Paquete duro de dart, este paquete tiene los métodos login y logout. 
    - user_repository. Paquete puro de dart, este paquete es el responsable del modelo del usuario y la forma para intecturar con el usuario actual. En este ejemplo, solo tiene la propiedad id.

Dentro de lib.
-lib
    - app.dart
    - main.dart
    - authentication //Es el responsable de reaccionar a los cambios de estado y mediante esos estados sabemos si tenemos que pintar la pantalla de login o home.
        - authentication.dart
        -bloc
        - authentication_bloc.dart
        - authentication_event.dart
        - authentication_state.dart
    - login
        - login.dart
        -bloc
            -login_bloc.dart 
            -login_event.dart
            -login_state.dart
        -models
            -email.dart
            -models.dart
            -password.dart
        -view
            -login_form.dart
            -login_page.dart
            -view.dart
    - quote
        - quote.dart
        -bloc
            -quote_bloc.dart
            -quote_event.dart
            -quote_state.dart
        -models
            -models.dart
            -quote.dart
        -view
            -quote_page.dart
            -view.dart
    - quote_api
        - quote_api.dart
    - splash
        -splash.dart
        -view
            -splash_page.dart

# Instalación 
1.- Ir a la carpeta apk, esta carpeta contiene el instalador 'app-release-frasedeldia.apk' para android o
descargar mediante esta url https://drive.google.com/file/d/1wlmYsFHltscicR_55tKOuSmFhKu3ZeHH/view?usp=sharing
2.- Si por alguna razón no se puede instalar el apk, seguir los siguientes pasos para deshabilitar la configuración de play protect. 
    1.- Abrir Play Store
    2.- Tocar el icono de tu cuenta
    3.- Seleccionar la opción "Play Protect" 
    4.- Tocar el icono de Configuración
    5.- Deshabilitar la opción 'Analizar las apps con Play Protect'

# Pantalla Iniciar sesión
La pantalla ofrece dos formas para iniciar sesión.
    1.- Usando la combinación de email y contraseña con estas credenciales.
        - Email:test@vivasdev.com
        - Password: 123456
    2.- Si el dispositivo lo soporta se mostrará un botón para iniciar con biométrico.

# Pantalla para mostrar la frase del día
Luego de iniciar sesión se mostrará la frase del día junto con el título y imágen dentro del widget card.
Además se mostrará un userid similar al id de un servicio de backend. 
Finalmente un botón para cerrar sesión.

    