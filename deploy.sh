
#!/bin/bash

ssh -i /root/.ssh/key.pem root@191.101.251.14 'bash -s' < app.sh
ssh -i /root/.ssh/key.pem root@191.101.251.19 'bash -s' < app.sh
