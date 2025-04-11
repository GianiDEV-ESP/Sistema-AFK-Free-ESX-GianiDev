# 🚧 FiveM ESX - Sistema AFK Avanzado

Este script permite a los jugadores marcarse como AFK (lejos del teclado) de forma realista y automática en servidores **ESX**, ideal para mantener la inmersión y el control del servidor.

---

## 🎯 Características

- ✅ Comando `/afk [motivo]` para entrar en modo AFK.
- ✅ Comando `/afk` para salir del modo AFK.
- 🌫️ El jugador se vuelve **opaco**, **sin colisiones** y **congelado**.
- 🗨️ Se muestra el **motivo** sobre la cabeza del personaje.
- ⛔ Kick automático si un jugador **no se mueve** en X tiempo (configurable) y **no está en modo AFK**.

---

## 🧩 Requisitos

- Framework: **ESX**
- Servidor: **FiveM**

---

## 📦 Instalación

1. Coloca la carpeta del script en tu recurso de servidor
   
2. Asegúrate de iniciar el recurso en tu `server.cfg`:  
```cfg
ensure esx_afk

   
