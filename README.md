# DC38338 Wireless Village - Wardriving Script

<p align="center">
  <img src="wireless-village-transparent.png" alt="Wireless Village" width="400"/>
  <img src="defcon-transparent.png" alt="Second Image" width="255"/>
</p>

**Autor:** Dion Mulaj - Th3Mayh3m

Script që automatizon procesin e wardriving duke përdorur GPSD dhe Kismet. Konfiguron WiFi interfaces në monitoring mode, sinkronizon kohën e sistemit me GPS/GLONASS, dhe kap të dhënat e WiFi APs me koordinata gjeografike.

## Requirements

- `gpsd`, `kismet`
- GPS device (`/dev/ttyACM0`)
- WiFi interfaces (`wlan1`, `wlan2`) me monitor mode

## Përdorimi

```bash
chmod +x wireless-village-wardriving.sh
```

```bash
sudo ./wireless-village-wardriving.sh
```
