#/bin/sh

wget http://www.st.com/st-web-ui/static/active/en/st_prod_software_internet/resource/technical/software/firmware/stsw-stm32068.zip
unzip stsw-stm32068.zip
make
cp ./STM32F4-Discovery_FW_V1.1.0/Project/Demonstration/stm32f4xx_conf.h .
