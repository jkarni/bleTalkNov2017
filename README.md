# bleTalkNov2017

```
sudo nano /lib/systemd/system/bluetooth.service
# change ExecStart line to
# ExecStart=/usr/local/libexec/bluetooth/bluetoothd --experimental
sudo systemctl daemon-reload
sudo systemctl restart bluetooth
```
