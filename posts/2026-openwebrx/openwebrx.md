# OpenWebRX

So it turns out that the `stable` docker image doesn't support RTLSDRv4 sticks, only v3, so you need to use `latest`. This information is correct as of 06/02/2026.

```yaml
services:
  openwebrx:
    image: jketterl/openwebrx:latest
    container_name: openwebrx
    privileged: true
    volumes:
      - ./openwebrx/settings:/var/lib/openwebrx
      - ./openwebrx/etc:/etc/openwebrx
    ports:
      - 8073:8073
    devices:
      - /dev/bus/usb:/dev/bus/usb
    environment:
      - OPENWEBRX_SDR_DEVICE=soapy=driver=rtlsdr,serial=00000001
      - OPENWEBRX_ADMIN_USER=admin
      - OPENWEBRX_ADMIN_PASSWORD=admin
    tmpfs:
      - /tmp/openwebrx
    restart: unless-stopped
```

remember to `sudo rmmod --force dvb_usb_rtl28xxu` before running `docker compose up -d`

