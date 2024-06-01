# Resumen

Aqui es donde ire poniendo mis configuraciones personales por si algun día me 
cambio de maquina y le instalo linux, esta guia esta destinada para que sea mas 
facil el seguimiento de la instalacion de Arco linux, todo de esta distro ya 
esta listo para descargartela y instalartela lo antes posible, tomare como 
referencia las dotfiles de saroci y otras configuraciones que ma allan llamado 
la atención.

# Instalación de Arco linux

Arco linux es facil de instalar a diferencia de Arch linux ya de que tienes la 
ayuda de calamares el instalador que te facilita la vida al momento de instalar
una distro, antes de continuar es mejor hasegurarce de que tenemos internet

```bash
pacman -S networkmanager
```

La mayoria de cosas ya estan listas para ser usadas en la distribucion B pero 
puedes probar la distribucion D que es un poco mas avanzada.

Ahora nesicitamos estar seguros de que tenemos internet y haremos uso de 
networkmanager pero si no lo tienes instalado intentaremos otra cosa

```bash
# Lista las redes disponibles
nmcli device wifi list
# Conéctate a tu red
nmcli device wifi connect TU_SSID password TU_CONTRASEÑA
```

Échale un vistazo a
[esta página](https://wiki.archlinux.org/index.php/NetworkManager#nmcli_examples)
para otras opciones proporcionadas por *nmcli*. 

# Inicio de sesión y gestor de ventanas

Primero, necesitamos una forma de iniciar sesión y abrir programas como
navegadores y terminales, así que empezaremos instalando
**[lighdm](https://wiki.archlinux.org/index.php/LightDM)**
y **[qtile](https://wiki.archlinux.org/index.php/Qtile)**.
*lightdm* no funcionará si no instalamos también un
**[greeter](https://wiki.archlinux.org/index.php/LightDM#Greeter)**.
También necesitamos
**[xterm](https://wiki.archlinux.org/index.php/Xterm)**
porque esa es la terminal que *qtile* abre por defecto, hasta que lo cambiemos
en el archivo de configuración. Para editar archivos de configuración
necesitaremos también un editor de texto, puedes usar
**[vscode](https://wiki.archlinux.org/index.php/Visual_Studio_Code)**
o directamente
**[neovim](https://wiki.archlinux.org/index.php/Neovim)**
si tienes experiencia previa, si no no lo recomiendo. Por último necesitamos un
navegador.

```bash
sudo pacman -S lightdm lightdm-gtk-greeter qtile xterm code firefox
```

Activa el servicio de *lightdm* y reinicia el ordenador, deberías poder iniciar
sesión en Qtile a través de *lightdm*.

```bash
sudo systemctl enable lightdm
reboot
```

Estos pasos de inicio de sesion son solo para aquellos que tienen una 
distribucion mas limpia, No es nesesario seguirlos todos si ya tienes todo un 
entorno de escritorio instalado y funcional

# Configuración básica de Qtile

Ahora que estás dentro de Qtile, deberías conocer algunos de los atajos de
teclado que vienen por defecto.

| Atajo                | Acción                              |
| -------------------- | ----------------------------------- |
| **mod + enter**      | abrir xterm                         |
| **mod + k**          | ventana siguiente                   |
| **mod + j**          | ventana anterior                    |
| **mod + w**          | cerrar ventana                      |
| **mod + [12345678]** | ir al espacio de trabajo [12345678] |
| **mod + ctrl + r**   | reiniciar qtile                     |
| **mod + ctrl + q**   | cerrar sesión                       |

Antes de hacer nada, si no tienes la distribución del teclado en inglés,
deberías cambiarla usando *setxkbmap*. Abre *xterm* con **mod + enter**, y
cambia la distribución a español, pero el español latam es ligeramente diferente:

```bash
setxkbmap es
```

Si usaste calamares en la instalacion pedes saltarte este paso ya que de estara
todo configurado a tus preferencias

Por defecto, no hay menú, tienes que lanzar programas a través de *xterm*. En
este punto puedes instalar otro emulador de terminal si lo prefieres:

```bash
# Instala otro de tu preferencia
sudo pacman -S alacritty
```


Abre el archivo de configuración de Qtile:

```bash
code ~/.config/qtile/config.py
```

Al principio, después de los imports, encontrarás una lista llamada *keys*, que
contiene la línea siguiente:

```python
Key([mod], "Return", lazy.spawn("xterm")),
```

Edítala para lanzar el emulador de terminal que has instalado:

```python
Key([mod], "Return", lazy.spawn("alacritty")),
```

Instala un menú como
**[dmenu](https://wiki.archlinux.org/index.php/Dmenu)**
o **[rofi](https://wiki.archlinux.org/index.php/Rofi)**:

```bash
sudo pacman -S rofi
```

Después añade atajos de teclado para el menú:

```python
Key([mod], "m", lazy.spawn("rofi -show run")),
Key([mod, 'shift'], "m", lazy.spawn("rofi -show")),
```

Reinicia Qtile con **mod + control + r**. Deberías poder abrir el menú y el
emulador de terminal usando los atajos de teclado que acabas de definir. Si has
instalado *rofi*, puedes cambiar su tema:

```bash
sudo pacman -S which
rofi-theme-selector
```


Eso es todo en cuanto a Qtile, puedes empezar a trastear con su configuración y
personalizarlo. Écha un vistazo a mi la configuración de sarosi
[aquí](https://github.com/antoniosarosi/dotfiles/tree/master/.config/qtile).
Pero antes de eso recomiendo configurar utilidades básicas como audio, batería,
montaje de unidades de almacenamiento, etc.

# Utilidades básicas del sistema

En esta sección vamos a ver algunos programas que casi todo el mundo necesita en
su sistema. Pero recuerda que los cambios que haremos no son permanentes,
[esta sección](#xprofile) describe cómo conseguir que lo sean.

## Fondo de pantalla

Lo primero es lo primero, tu pantalla se ve negra y vacía, así que probablemente
quieras un fondo más bonito para no sentirte tan deprimido. Puedes abrir
*firefox* usando *rofi* y descargar un fondo de pantalla. Después instala
**[feh](https://wiki.archlinux.org/index.php/Feh)** o
**[nitrogen](https://wiki.archlinux.org/index.php/Nitrogen)**
y pon tu fondo:

```bash
sudo pacman -S feh
feh --bg-scale ruta/al/fondo/de/pantalla
```

## Fuentes

Las fuentes en Arch son básicamente un meme, antes de que te den problemas
puedes simplemente instalar estos paquetes:

```bash
sudo pacman -S ttf-dejavu ttf-liberation noto-fonts
```

Para listar todas las fuentes disponibles:

```bash
fc-list
```

## Lector de PDF

El mejor lector de pdf que he encontrado es zathura
```bash
sudo pacman -S zathura zathura-pdf-mupdf
```

## Audio

En este punto, no hay audio, necesitamos
**[pulseaudio](https://wiki.archlinux.org/index.php/PulseAudio)**.
Recomiendo instalar un programa gráfico para manejar el audio como
**[pavucontrol](https://www.archlinux.org/packages/extra/x86_64/pavucontrol/)**,
porque todavía no tenemos atajos de teclado para ello.

```bash
sudo pacman -S pulseaudio pavucontrol
```

En Arch,
[pulseaudio está activado por defecto](https://wiki.archlinux.org/index.php/PulseAudio#Running),
pero puede que tengas que reiniciar para que *pulseaudio* arranque. Después de
reiniciar, abre *pavucontrol* usando *rofi*, activa el audio (porque está en
"mute") y debería estar todo correcto.

Ahora puedes establecer atajos de teclado para *pulseaudio*, abre el archivo de
configuración de Qtile y añade esto:


```python
# Volumen
Key([], "XF86AudioLowerVolume", lazy.spawn(
    "pactl set-sink-volume @DEFAULT_SINK@ -5%"
)),
Key([], "XF86AudioRaiseVolume", lazy.spawn(
    "pactl set-sink-volume @DEFAULT_SINK@ +5%"
)),
Key([], "XF86AudioMute", lazy.spawn(
    "pactl set-sink-mute @DEFAULT_SINK@ toggle"
)),
```

Aunque para una mejor experiencia en la línea de comandos, recomiendo usar
**[pamixer](https://www.archlinux.org/packages/community/x86_64/pamixer/)**:

```bash
sudo pacman -S pamixer
```

Con ello puedes convertir los atajos de teclado en:

```python
# Volumen
Key([], "XF86AudioLowerVolume", lazy.spawn("pamixer --decrease 5")),
Key([], "XF86AudioRaiseVolume", lazy.spawn("pamixer --increase 5")),
Key([], "XF86AudioMute", lazy.spawn("pamixer --toggle-mute")),
```

Reinicia Qtile con **mod + control + r** y prueba los atajos. Si estás en un
portátil, probablemente también necesites controlar el brillo de tu pantalla,
para ello recomiendo
**[brightnessctl](https://www.archlinux.org/packages/community/x86_64/brightnessctl/)**:

```bash
sudo pacman -S brightnessctl
```

Puedes añadir estos atajos y volver a reiniciar Qtile:

```python
# Brillo
Key([], "XF86MonBrightnessUp", lazy.spawn("brightnessctl set +10%")),
Key([], "XF86MonBrightnessDown", lazy.spawn("brightnessctl set 10%-")),
```

## Monitores

Si tienes múltiples monitores, seguramente quieras usarlos todos. Así es como
funciona **[xrandr](https://wiki.archlinux.org/index.php/Xrandr)**:

```bash
# Lista todas las salidas y resoluciones disponibles
xrandr
# Formato común para un portátil con monitor extra
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x1080 --output HDMI-1 --mode 1920x1080 --pos 0x0
```

Es necesario especificar la posición de cada salida, si no se utilizará 0x0, y
todas las salidas estarán solapadas. Ahora bien, si no quieres calcular píxeles
y demás necesitas una interfaz gráfica como
**[arandr](https://www.archlinux.org/packages/community/any/arandr/)**:

```bash
sudo pacman -S arandr
```

Ábrela con *rofi*, ordena las pantallas como quieras, y después puedes guardar
la disposición de las mismas, lo cual simplemente te dará un script con el
comando exacto de *xrandr* que necesitas. Guarda ese script, pero todavía no
le des al botón de aplicar.

Para un sistema con múltiples monitores deberías crear una instancia de *Screen*
por cada uno de ellos en la configuración de Qtile.

Encontrarás una lista llamada *screens* en la configuración de Qtile que
contiene solo un objeto inicializado con una barra en la parte de abajo.
Dentro de esa barra puedes ver los widgets con los que viene por defecto.

Añade tantas pantallas como necesites y copia-pega los widgets, más adelante
podrás personalizarlos. Ahora puedes volver a *arandr*, darle click en "apply"
y reiniciar el gestor de ventanats.

Con esto tus monitores deberían funcionar.

Por mi experiencia no he tenido la oportunidad de usar esta seccion

## Almacenamiento

Otra utilidad básica que podrías necesitar es montar de forma automática
unidades de almacenamiento externas. Para ello uso
**[udisks](https://wiki.archlinux.org/index.php/Udisks)**
y **[udiskie](https://www.archlinux.org/packages/community/any/udiskie/)**.
*udisks* es una dependencia de *udiskie*, así que solo instalaremos este
último. Instala también el paquete
**[ntfs-3g](https://wiki.archlinux.org/index.php/NTFS-3G)**
para leer y escribir en discos NTFS:

```bash
sudo pacman -S udiskie ntfs-3g
```

## Redes

Hemos configurado la red a través de *nmcli*, pero un programa gráfico es más
cómodo. Yo uso
**[nm-applet](https://wiki.archlinux.org/index.php/NetworkManager#nm-applet)**:

```bash
sudo pacman -S network-manager-applet
```

## Systray

Por defecto, tenemos una "bandeja del sistema" en Qtile, pero no hay nada
ejecutándose en ella. Puedes lanzar los programas que acabamos de instalar así:

```bash
udiskie -t &
nm-applet &
```

Ahora deberías ver unos iconos en la barra, puedes clicar en ellos para
configurar la red y discos. Puedes instalar también iconos para la batería y
el volumen:

```bash
sudo pacman -S volumeicon cbatticon
volumeicon &
cbatticon &
```

## Notificaciones

Me gusta tener notificaciones en el escritorio también, para ello tienes que
instalar
[**libnotify**](https://wiki.archlinux.org/index.php/Desktop_notifications#Libnotify)
y [**notification-daemon**](https://www.archlinux.org/packages/community/x86_64/notification-daemon/):

```bash
sudo pacman -S libnotify notification-daemon
```

En nuestro caso,
[esto es lo que tenemos que hacer para tener notificaciones](https://wiki.archlinux.org/index.php/Desktop_notifications#Standalone):

```bash
# Crea este fichero con nano o vim
sudo nano /usr/share/dbus-1/services/org.freedesktop.Notifications.service
# Pega estas líneas
[D-BUS Service]
Name=org.freedesktop.Notifications
Exec=/usr/lib/notification-daemon-1.0/notification-daemon
```

Pruébalo:

```bash
notification-send "Hola Mundo"
```

Aunque este paso no es nesesario si ya tienes xfce4-notifyd

## Xprofile

Como he mencionado antes, estos cambios no son permanentes. Para que lo sean
necesitamos un par de cosas. Primero instala
**[xinit](https://wiki.archlinux.org/index.php/Xinit)**:

```bash
sudo pacman -S xorg-xinit
```

Ahora puedes usar *~/.xprofile* para lanzar programas antes de que se ejecute
el gestor de ventanas:

```bash
touch ~/.xprofile
```

Por ejemplo, si escribes esto en tu *~/.xprofile*:

```bash
xrandr --output eDP-1 --primary --mode 1920x1080 --pos 0x1080 --output HDMI-1 --mode 1920x1080 --pos 0x0 &
setxkbmap es &
nm-applet &
udiskie -t &
volumeicon &
cbatticon &
```

Cada vez que inicias sesión tendrás los iconos de la bandeja del sistema, tu
distribución de teclado y monitores configurados.

# Otras configuraciones y herramientas

## AUR helper

Ahora que ya tienes un poco de software que te permite usar tu PC sin perder
la paciencia, es hora de hacer cosas más interesantes. Primero, instala un
**[AUR helper](https://wiki.archlinux.org/index.php/AUR_helpers)**, yo uso
**[yay](https://github.com/Jguer/yay)**:

```bash
sudo pacman -S base-devel git
cd /opt/
sudo git clone https://aur.archlinux.org/yay-git.git
sudo chown -R username:username yay-git/
cd yay-git
makepkg -si
```

Con acceso al *Arch User Repository*, puedes instalar prácticamente
todo el software de este planeta que haya sido pensado para correr en Linux. 
Usar yay-git o yay-bin es una eleccion personal, puede que ya venga instalado.

## Media Transfer Protocol

Si quieres conectar tu teléfono usando un cable USB, necesitarás una
implementación de MTP y alguna interfaz de línea de comandos como
[esta](https://aur.archlinux.org/packages/simple-mtpfs/):

```bash
sudo pacman -S libmtp
yay -S simple-mtpfs

# Lista todos los dispositivos conectados
simple-mtpfs -l
# Monta el primer dispositivo de la lista anterior
simple-mtpfs --device 1 /mount/point
```

## Explorador de archivos

Hasta ahora siempre hemos manejado los ficheros a través de la terminal, pero
puedes instalar un explorador de archivos. Para uno gráfico, recomiendo
**[thunar](https://wiki.archlinux.org/index.php/Thunar)**,
y para uno basado en terminal,
**[ranger](https://wiki.archlinux.org/index.php/Ranger)**, aunque este último
está pensado para usuarios de vim, usalo solo si sabes moverte en vim.

## Basura

Si no quieres usar *rm* constantemente y arriesgarte a perder ficheros,
necesitas un sistema de basura. Por suerte, es bastante sencillio de hacer
[usando alguna de estas herramientas](https://wiki.archlinux.org/index.php/Trash_management#Trash_creation)
como **[glib2](https://www.archlinux.org/packages/core/x86_64/glib2/)**,
y para interfaces gráficas como *thunar* necesitas **[gvfs](https://www.archlinux.org/packages/extra/x86_64/gvfs/)**:

```bash
sudo pacman -S glib2 gvfs
# Uso
gio trash path/to/file
# Vaciar papelera
gio trash --empty
```

Con *thunar* puedes abrir la basura desde el panel izquierdo, pero desde la
línea de comandos puedes hacer:

```bash
ls ~/.local/share/Trash/files
```


########### 



## Tema de GTK

El momento que has estado esperando ha llegado, finalmente vas a instalar un
tema oscuro. Yo uso *Material Black Colors*, puedes descargar una versión
[aquí](https://www.gnome-look.org/p/1316887/), con sus respectivos iconos
[aquí](https://www.pling.com/p/1333360/).

Sugiero empezar con
*Material-Black-Blueberry* y *Material-Black-Blueberry-Suru*. Puedes encontrar
otros temas para GTK
[en esta página](https://www.gnome-look.org/browse/cat/135/).
Una vez tengas descargados los temas, puedes hacer esto:

```bash
# Asumiendo que has descargado Material-Black-Blueberry
cd Downloads/
sudo pacman -S unzip
unzip Material-Black-Blueberry.zip
unzip Material-Black-Blueberry-Suru.zip
rm Material-Black*.zip

# Haz tu tema visible a GTK
sudo mv Material-Black-Blueberry /usr/share/themes
sudo mv Material-Black-Blueberry-Suru /usr/share/icons
```

Ahora edita **~/.gtkrc-2.0** y **~/.config/gtk-3.0/settings.ini** añdiendo
estas líneas:

```ini
# ~/.gtkrc-2.0
gtk-theme-name = "Material-Black-Blueberry"
gtk-icon-theme-name = "Material-Black-Blueberry-Suru"

# ~/.config/gtk-3.0/settings.ini
gtk-theme-name = Material-Black-Blueberry
gtk-icon-theme-name = Material-Black-Blueberry-Suru
```

La próxima vez que inicies sesión verás los cambios aplicados. Puedes instalar
también un tema de cursor distinto, para ello necesitas
**[xcb-util-cursor](https://www.archlinux.org/packages/extra/x86_64/xcb-util-cursor/)**.
El tema que yo uso es
[Breeze](https://www.gnome-look.org/p/999927/), descárgalo, y después:

```bash
sudo pacman -S xcb-util-cursor
cd Downloads/
tar -xf Breeze.tar.gz
sudo mv Breeze /usr/share/icons
```

Edita **/usr/share/icons/default/index.theme** añadiendo esto:

```ini
[Icon Theme]
Inherits = Breeze
```

Ahora vuelve a editar **~/.gtkrc-2.0** y **~/.config/gtk-3.0/settings.ini**:

```ini
# ~/.gtkrc-2.0
gtk-cursor-theme-name = "Breeze"

# ~/.config/gtk-3.0/settings.ini
gtk-cursor-theme-name = Breeze
```

Asegurate de escribir bien los nombres de los temas e iconos, deben ser
exactamente los nombres de los directorios donde se encuentran, los que
ofrece esta salida:

```bash
ls /usr/share/themes
ls /usr/share/icons
```

Recuerda que solo verás los cambios si inicias sesión de nuevo. También hay
herramientas gráficas para cambiar temas, yo simplemente prefiero la forma
tradicional de editar ficheros, pero puedes usar
**[lxappearance](https://www.archlinux.org/packages/community/x86_64/lxappearance/)**,
que es un programa independiente del entorno de escritorio para realizar esta
tarea, y te permie previsualizar los temas.

```bash
sudo pacman -S lxappearance
```

Finalmente, si quieres transparencia y demás instala un compositor:

```bash
sudo pacman -S picom
# Pon esto en ~/.xprofile
picom &
```

## Tema de Qt

## Qt

Los temas de GTK no se aplican a programas Qt, pero puedes usar
[**Kvantum**](https://archlinux.org/packages/?name=kvantum-qt5) para cambiar
los temas por defecto:

```bash
sudo pacman -S kvantum-qt5
echo "export QT_STYLE_OVERRIDE=kvantum" >> ~/.profile
```

## Tema de lightdm

También podemos cambiar el tema de *lightdm* para que mole más, ¿por qué no?
Necesitamos otro *greeter* y algún tema, en concreto
**[lightdm-webkit2-greeter](https://www.archlinux.org/packages/community/x86_64/lightdm-webkit2-greeter/)**
y  **[lightdm-webkit-theme-aether](https://aur.archlinux.org/packages/lightdm-webkit-theme-aether/)**:

```bash
sudo pacman -S lightdm-webkit2-greeter
yay -S lightdm-webkit-theme-aether
```

Estas son las configuraciones que tienes que hacer:

```ini
# /etc/lightdm/lightdm.conf
[Seat:*]
# ...
# Descomenta esta línea y pon este valor
greeter-session = lightdm-webkit2-greeter
# ...

# /etc/lightdm/lightdm-webkit2-greeter.conf
[greeter]
# ...
webkit_theme = lightdm-webkit-theme-aether
```

Listo.

## Multimedia

Consulta
[esta página](https://wiki.archlinux.org/index.php/List_of_applications/Multimedia)
para ver la variedad de programas multimedia disponibles.

### Imágenes

Para ver imágenes, de los programas gráficos que he probado
[geeqie](https://www.archlinux.org/packages/extra/x86_64/geeqie/) es el mejor:

```bash
sudo pacman -S geeqie
```

### Vídeo y audio

Aquí sin duda el clásico
[vlc](https://wiki.archlinux.org/index.php/VLC_media_player_(Espa%C3%B1ol))
es lo que necesitamos:

```bash
sudo pacman -S vlc
```

## Empieza a hackear

Con todo lo que has hecho hasta ahora ya tienes todas las herramientas para
empezar a trastear con las configuraciones y hacer de tu entorno de escritorio,
bueno, *tu* entorno de escritorio. Lo que recomiendo es empezar añadiendo
atajaos de teclado para programas típicos como *firefox*, un editor de texto,
explorador de archivos, etc.

Una vez te sientas cómodo con Qtile, puedes instalar otros gestores de ventanas
y tendrás más sesiones disponibles al iniciar sesión con *lightdm*.

Aqui tienes una lista con las configuraciones de mis gestores de ventanas,
cada uno tiene su documentación propia:

- [Qtile](https://github.com/antoniosarosi/dotfiles/tree/master/.config/qtile/README.es.md)
- [Spectrwm](https://github.com/antoniosarosi/dotfiles/tree/master/.config/spectrwm/README.es.md)
- [Openbox](https://github.com/antoniosarosi/dotfiles/tree/master/.config/openbox/README.es.md)
- [Xmonad](https://github.com/antoniosarosi/dotfiles/tree/master/.config/xmonad/README.es.md)
- [Dwm](https://github.com/antoniosarosi/dwm)

# Galería

## [Qtile](https://github.com/antoniosarosi/dotfiles/tree/master/.config/qtile)
![Qtile](.screenshots/qtile.png)

## [Spectrwm](https://github.com/antoniosarosi/dotfiles/tree/master/.config/spectrwm)
![Spectrwm](.screenshots/spectrwm.png)

## [Openbox](https://github.com/antoniosarosi/dotfiles/tree/master/.config/openbox)
![Openbox](.screenshots/openbox.png)

## [Xmonad](https://github.com/antoniosarosi/dotfiles/tree/master/.config/xmonad)
![Xmonad](.screenshots/xmonad.png)

## [Dwm](https://github.com/antoniosarosi/dwm)
![Dwm](.screenshots/dwm.png)

# Atajos de teclado

Estos son algunos atajos de teclado comunes a todos mis gestores de ventanas:


## Ventanas

| Atajo                   | Acción                                       |
| ----------------------- | -------------------------------------------- |
| **mod + j**             | siguiente ventana                            |
| **mod + k**             | ventana previa                               |
| **mod + shift + h**     | aumentar master                              |
| **mod + shift + l**     | decrementar master                           |
| **mod + shift + j**     | mover ventana abajo                          |
| **mod + shift + k**     | mover ventana arriba                         |
| **mod + shift + f**     | pasar ventana a flotante                     |
| **mod + tab**           | cambiar la disposición de las ventanas       |
| **mod + [1-9]**         | cambiar al espacio de trabajo N (1-9)        |
| **mod + shift + [1-9]** | mandar ventana al espacio de trabajo N (1-9) |
| **mod + punto**         | enfocar siguiente monitor                    |
| **mod + coma**          | enfocar monitor previo                       |
| **mod + w**             | cerrar ventana                               |
| **mod + ctrl + r**      | reiniciar gestor de ventana                  |
| **mod + ctrl + q**      | cerrar sesión                                |

Los siguientes atajos de teclado funcionarán solo si instalas los programas que
lanzan:

```bash
sudo pacman -S rofi thunar firefox alacritty redshift scrot
```

Para configurar *rofi*,
[lee este README](https://github.com/antoniosarosi/dotfiles/tree/master/.config/rofi/README.es.md),
y para *alacritty*, [este](https://github.com/antoniosarosi/dotfiles/tree/master/.config/alacritty/README.es.md).

## Apps

| Atajo               | Acción                                 |
| ------------------- | -------------------------------------- |
| **mod + m**         | lanzar rofi                            |
| **mod + shift + m** | navegación (rofi)                      |
| **mod + b**         | lanzar navegador (firefox)             |
| **mod + e**         | lanzar explorador de archivos (thunar) |
| **mod + return**    | lanzar terminal (alacritty)            |
| **mod + r**         | redshift                               |
| **mod + shift + r** | parar redshift                         |
| **mod + s**         | captura de pantalla (scrot)            |

# Software

## Utilidades básicas

| Software                                                                                            | Utilidad                                      |
| --------------------------------------------------------------------------------------------------- | --------------------------------------------- |
| **[networkmanager](https://wiki.archlinux.org/index.php/NetworkManager)**                           | Autoexplicativo                               |
| **[network-manager-applet](https://wiki.archlinux.org/index.php/NetworkManager#nm-applet)**         | *NetworkManager* systray                      |
| **[pulseaudio](https://wiki.archlinux.org/index.php/PulseAudio)**                                   | Autoexplicativo                               |
| **[pavucontrol](https://www.archlinux.org/packages/extra/x86_64/pavucontrol/)**                     | *pulseaudio* GUI                              |
| **[pamixer](https://www.archlinux.org/packages/community/x86_64/pamixer/)**                         | *pulseaudio* CLI                              |
| **[brightnessctl](https://www.archlinux.org/packages/community/x86_64/brightnessctl/)**             | Brillo para portátiles                        |
| **[xinit](https://wiki.archlinux.org/index.php/Xinit)**                                             | Inicia programas antes del gestor de ventanas |
| **[libnotify](https://wiki.archlinux.org/index.php/Desktop_notifications)**                         | Notificaciones de escritorio                  |
| **[notification-daemon](https://www.archlinux.org/packages/community/x86_64/notification-daemon/)** | Autoexplicativo                               |
| **[udiskie](https://www.archlinux.org/packages/community/any/udiskie/)**                            | Montar discos automáticamente                 |
| **[ntfs-3g](https://wiki.archlinux.org/index.php/NTFS-3G)**                                         | Leer y escribir NTFS                          |
| **[arandr](https://www.archlinux.org/packages/community/any/arandr/)**                              | GUI para *xrandr*                             |
| **[cbatticon](https://www.archlinux.org/packages/community/x86_64/cbatticon/)**                     | Systray para la batería                       |
| **[volumeicon](https://www.archlinux.org/packages/community/x86_64/volumeicon/)**                   | Systray para el volumen                       |
| **[glib2](https://www.archlinux.org/packages/core/x86_64/glib2/)**                                  | Basura                                        |
| **[gvfs](https://www.archlinux.org/packages/extra/x86_64/gvfs/)**                                   | Basura para GUIs                              |

## Fuentes, temas y GTK

| Software                                                                               | Utilidad                               |
| -------------------------------------------------------------------------------------- | -------------------------------------- |
| **[Picom](https://wiki.archlinux.org/index.php/Picom)**                                | Compositor para Xorg                   |
| **[UbuntuMono Nerd Font](https://aur.archlinux.org/packages/nerd-fonts-ubuntu-mono/)** | Nerd Font para iconos                  |
| **[Material Black](https://www.gnome-look.org/p/1316887/)**                            | Tema e iconos para GTK                 |
| **[lxappearance](https://www.archlinux.org/packages/community/x86_64/lxappearance/)**  | GUI para cambiar temas                 |
| **[nitrogen](https://wiki.archlinux.org/index.php/Nitrogen)**                          | GUI para establecer fondos de pantalla |
| **[feh](https://wiki.archlinux.org/index.php/Feh)**                                    | CLI para establecer fondos de pantalla |

## Apps

| Software                                                              | Utilidad                           |
| --------------------------------------------------------------------- | ---------------------------------- |
| **[alacritty](https://wiki.archlinux.org/index.php/Alacritty)**       | Emulador de Terminal               |
| **[thunar](https://wiki.archlinux.org/index.php/Thunar)**             | Gestor de archivos gráfico         |
| **[ranger](https://wiki.archlinux.org/index.php/Ranger)**             | Gestor de archivos de terminal     |
| **[neovim](https://wiki.archlinux.org/index.php/Neovim)**             | Editor de texto basado en terminal |
| **[rofi](https://wiki.archlinux.org/index.php/Rofi)**                 | Menú y navegación                  |
| **[scrot](https://wiki.archlinux.org/index.php/Screen_capture)**      | Captura de pantalla                |
| **[redshift](https://wiki.archlinux.org/index.php/Redshift)**         | Cuida tus ojos                     |
| **[trayer](https://www.archlinux.org/packages/extra/x86_64/trayer/)** | Systray                            |
