Return-Path: <yyt168@gmail.com>
MIME-Version: 1.0
In-Reply-To: <0800e150-34aa-1487-a367-fcd804fc2122@mellanox.com>
References: <CADL4p-rRJ6ydSuYBsjUOOE88ZUF5g_akY5Eb-bnA4ZsodhLEDQ@mail.gmail.com>
 <CADL4p-r918miLJZeOviG5+OUeYGwML65SpuEwZ8=AmfNkUHHMQ@mail.gmail.com> <0800e150-34aa-1487-a367-fcd804fc2122@mellanox.com>
From: Tony Yang <yyt168@gmail.com>
Date: Wed, 15 Nov 2017 07:56:46 +0800
Message-ID: <CADL4p-rSpNB4dE=1qQ+Th0hwD=C+ibFEOP09Lhhe14xHcF0obw@mail.gmail.com>
Subject: Re: kernel 4.14 how to install Mellanox connectx-3 infiniband driver?
To: Max Gurtovoy <maxg@mellanox.com>
Cc: Jens Axboe <axboe@kernel.dk>, Keith Busch <keith.busch@intel.com>, linux-block@vger.kernel.org,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
List-ID: <linux-block@vger.kernel.org>

Thanks All,

I from
  git://git.infradead.org/nvme.git nvme-4.15 download the nvme ,then
compile with CONFIG_MLX4_INFINIBAND.Now I encountered a problem that
can not find service opensmd and openibd, how to solve, thank you

[root@cesdb01 nvme-4.15]# uname -r
4.13.0-rc7+

[root@cesdb01 ~]# pwd
/root
[root@cesdb01 ~]# cd /u01/soft/u01/soft/4.15/nvme-4.15/
[root@cesdb01 nvme-4.15]# grep -i nvme .config
CONFIG_NVME_CORE=m
CONFIG_BLK_DEV_NVME=m
CONFIG_NVME_FABRICS=m
CONFIG_NVME_RDMA=m
CONFIG_NVME_FC=m
CONFIG_NVME_TARGET=m
CONFIG_NVME_TARGET_LOOP=m
CONFIG_NVME_TARGET_RDMA=m
CONFIG_NVME_TARGET_FC=m
CONFIG_NVME_TARGET_FCLOOP=m
CONFIG_RTC_NVMEM=y
CONFIG_NVMEM=y
[root@cesdb01 nvme-4.15]# grep -i mellanox .config
CONFIG_NET_VENDOR_MELLANOX=y
[root@cesdb01 nvme-4.15]# grep -i ib .config
CONFIG_GENERIC_CALIBRATE_DELAY=y
CONFIG_ARCH_HIBERNATION_POSSIBLE=y
CONFIG_ARCH_SUSPEND_POSSIBLE=y
CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
CONFIG_USELIB=y
CONFIG_BLK_DEV_BSGLIB=y
CONFIG_ARCH_HIBERNATION_HEADER=y
CONFIG_HIBERNATE_CALLBACKS=y
CONFIG_HIBERNATION=y
CONFIG_ACPI_REV_OVERRIDE_POSSIBLE=y
CONFIG_ACPI_CPPC_LIB=y
CONFIG_X86_SPEEDSTEP_LIB=m
CONFIG_HOTPLUG_PCI_ACPI_IBM=m
CONFIG_YENTA_TOSHIBA=y
CONFIG_IP_FIB_TRIE_STATS=y
# CONFIG_NFT_FIB_IPV4 is not set
# CONFIG_NFT_FIB_IPV6 is not set
CONFIG_IP_DCCP_TFRC_LIB=y
CONFIG_BT_HCIBTUSB=m
CONFIG_BT_HCIBTUSB_BCM=y
CONFIG_BT_HCIBTUSB_RTL=y
CONFIG_BT_HCIBTSDIO=m
CONFIG_BT_HCIBCM203X=m
CONFIG_BT_HCIBPA10X=m
CONFIG_BT_HCIBFUSB=m
CONFIG_FIB_RULES=y
CONFIG_LIB80211=m
# CONFIG_LIB80211_DEBUG is not set
CONFIG_CEPH_LIB=m
# CONFIG_CEPH_LIB_PRETTYDEBUG is not set
CONFIG_CEPH_LIB_USE_DNS_RESOLVER=y
# CONFIG_IBM_ASM is not set
# CONFIG_CXL_LIB is not set
CONFIG_SCSI_SAS_LIBSAS=m
CONFIG_LIBFC=m
CONFIG_LIBFCOE=m
CONFIG_PATA_TOSHIBA=m
CONFIG_TCM_IBLOCK=m
# Distributed Switch Architecture drivers
CONFIG_CHELSIO_LIB=m
CONFIG_MLX5_CORE_IPOIB=y
CONFIG_PHYLIB=y
CONFIG_BCM_NET_PHYLIB=m
# CONFIG_LIBERTAS is not set
# CONFIG_LIBERTAS_THINFIRM is not set
CONFIG_RT2800_LIB=m
CONFIG_RT2800_LIB_MMIO=m
CONFIG_RT2X00_LIB_MMIO=m
CONFIG_RT2X00_LIB_PCI=m
CONFIG_RT2X00_LIB_USB=m
CONFIG_RT2X00_LIB=m
CONFIG_RT2X00_LIB_FIRMWARE=y
CONFIG_RT2X00_LIB_CRYPTO=y
CONFIG_RT2X00_LIB_LEDS=y
CONFIG_RT2X00_LIB_DEBUGFS=y
CONFIG_SERIO_LIBPS2=y
# CONFIG_GPIOLIB is not set
CONFIG_SENSORS_IBMAEM=m
CONFIG_SENSORS_IBMPEX=m
CONFIG_IB700_WDT=m
CONFIG_IBMASR=m
CONFIG_SSB_POSSIBLE=y
CONFIG_SSB_PCIHOST_POSSIBLE=y
CONFIG_SSB_SDIOHOST_POSSIBLE=y
CONFIG_SSB_DRIVER_PCICORE_POSSIBLE=y
CONFIG_BCMA_POSSIBLE=y
CONFIG_BCMA_HOST_PCI_POSSIBLE=y
CONFIG_DVB_USB_DIB3000MC=m
CONFIG_DVB_USB_DIBUSB_MB=m
# CONFIG_DVB_USB_DIBUSB_MB_FAULTY is not set
CONFIG_DVB_USB_DIBUSB_MC=m
CONFIG_DVB_USB_DIB0700=m
CONFIG_DVB_DIB3000MB=m
CONFIG_DVB_DIB3000MC=m
CONFIG_DVB_DIB7000M=m
CONFIG_DVB_DIB7000P=m
CONFIG_DVB_DIB8000=m
CONFIG_DVB_TUNER_DIB0070=m
CONFIG_DVB_TUNER_DIB0090=m
# CONFIG_DRM_HISI_HIBMC is not set
# CONFIG_DRM_LIB_RANDOM is not set
# CONFIG_FB_SVGALIB is not set
# CONFIG_FB_IBM_GXT4500 is not set
CONFIG_SND_OPL3_LIB=m
CONFIG_SND_OPL3_LIB_SEQ=m
# CONFIG_SND_OPL4_LIB_SEQ is not set
CONFIG_SND_VX_LIB=m
CONFIG_SND_OXYGEN_LIB=m
# CONFIG_SND_SONICVIBES is not set
CONFIG_SND_FIREWIRE_LIB=m
# CONFIG_USB_TRANCEVIBRATOR is not set
# CONFIG_MMC_TOSHIBA_PCI is not set
# CONFIG_ACCESSIBILITY is not set
CONFIG_INFINIBAND=m
CONFIG_INFINIBAND_USER_MAD=m
CONFIG_INFINIBAND_USER_ACCESS=m
CONFIG_INFINIBAND_USER_MEM=y
CONFIG_INFINIBAND_ON_DEMAND_PAGING=y
CONFIG_INFINIBAND_ADDR_TRANS=y
CONFIG_INFINIBAND_ADDR_TRANS_CONFIGFS=y
CONFIG_INFINIBAND_MTHCA=m
CONFIG_INFINIBAND_MTHCA_DEBUG=y
CONFIG_INFINIBAND_CXGB3=m
# CONFIG_INFINIBAND_CXGB3_DEBUG is not set
CONFIG_INFINIBAND_CXGB4=m
# CONFIG_INFINIBAND_I40IW is not set
CONFIG_MLX4_INFINIBAND=m
CONFIG_MLX5_INFINIBAND=m
CONFIG_INFINIBAND_NES=m
# CONFIG_INFINIBAND_NES_DEBUG is not set
CONFIG_INFINIBAND_OCRDMA=m
# CONFIG_INFINIBAND_VMWARE_PVRDMA is not set
CONFIG_INFINIBAND_USNIC=m
CONFIG_INFINIBAND_IPOIB=m
CONFIG_INFINIBAND_IPOIB_CM=y
CONFIG_INFINIBAND_IPOIB_DEBUG=y
# CONFIG_INFINIBAND_IPOIB_DEBUG_DATA is not set
CONFIG_INFINIBAND_SRP=m
CONFIG_INFINIBAND_SRPT=m
CONFIG_INFINIBAND_ISER=m
CONFIG_INFINIBAND_ISERT=m
# CONFIG_INFINIBAND_OPA_VNIC is not set
# CONFIG_INFINIBAND_RDMAVT is not set
# CONFIG_INFINIBAND_BNXT_RE is not set
CONFIG_RTC_LIB=y
CONFIG_RTC_MC146818_LIB=y
CONFIG_RTLLIB=m
CONFIG_RTLLIB_CRYPTO_CCMP=m
CONFIG_RTLLIB_CRYPTO_TKIP=m
CONFIG_RTLLIB_CRYPTO_WEP=m
CONFIG_TOSHIBA_BT_RFKILL=m
# CONFIG_TOSHIBA_HAPS is not set
# CONFIG_TOSHIBA_WMI is not set
# CONFIG_IBM_RTL is not set
# CONFIG_LIBNVDIMM is not set
CONFIG_ISCSI_IBFT_FIND=y
CONFIG_ISCSI_IBFT=m
# EFI (Extensible Firmware Interface) Support
CONFIG_SQUASHFS_ZLIB=y
CONFIG_PSTORE_ZLIB_COMPRESS=y
# CONFIG_SECURITY_INFINIBAND is not set
# Library routines
CONFIG_LIBCRC32C=m
CONFIG_ZLIB_INFLATE=y
CONFIG_ZLIB_DEFLATE=y
CONFIG_MPILIB=y
[root@cesdb01 nvme-4.15]#

[root@cesdb01 nvme-4.15]# ifconfig -a
eno1: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        inet 192.168.70.21  netmask 255.255.255.0  broadcast 192.168.70.255
        inet6 fe80::a94:efff:fe1d:dccb  prefixlen 64  scopeid 0x20<link>
        ether 08:94:ef:1d:dc:cb  txqueuelen 1000  (Ethernet)
        RX packets 3633  bytes 512538 (500.5 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 3063  bytes 592889 (578.9 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 16

eno2: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether 08:94:ef:1d:dc:cc  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 17

eno3: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether 08:94:ef:1d:dc:cd  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 16

eno4: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether 08:94:ef:1d:dc:ce  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0
        device interrupt 17

enp0s20u1u5: flags=4163<UP,BROADCAST,RUNNING,MULTICAST>  mtu 1500
        ether 0a:94:ef:1d:dc:d2  txqueuelen 1000  (Ethernet)
        RX packets 980  bytes 27587 (26.9 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ens4d1: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        ether 50:65:f3:87:f7:92  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

ib0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 4092
Infiniband hardware address can be incorrect! Please read BUGS section
in ifconfig(8).
        infiniband
80:00:02:18:FE:80:00:00:00:00:00:00:00:00:00:00:00:00:00:00
txqueuelen 256  (InfiniBand)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

lo: flags=73<UP,LOOPBACK,RUNNING>  mtu 65536
        inet 127.0.0.1  netmask 255.0.0.0
        inet6 ::1  prefixlen 128  scopeid 0x10<host>
        loop  txqueuelen 1000  (Local Loopback)
        RX packets 948  bytes 78396 (76.5 KiB)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 948  bytes 78396 (76.5 KiB)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

virbr0: flags=4099<UP,BROADCAST,MULTICAST>  mtu 1500
        inet 192.168.122.1  netmask 255.255.255.0  broadcast 192.168.122.255
        ether 52:54:00:19:ce:5c  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

virbr0-nic: flags=4098<BROADCAST,MULTICAST>  mtu 1500
        ether 52:54:00:19:ce:5c  txqueuelen 1000  (Ethernet)
        RX packets 0  bytes 0 (0.0 B)
        RX errors 0  dropped 0  overruns 0  frame 0
        TX packets 0  bytes 0 (0.0 B)
        TX errors 0  dropped 0 overruns 0  carrier 0  collisions 0

[root@cesdb01 nvme-4.15]# service opensmd start
Redirecting to /bin/systemctl start  opensmd.service
Failed to start opensmd.service: Unit opensmd.service failed to load:
No such file or directory.

2017-11-10 0:09 GMT+08:00 Max Gurtovoy <maxg@mellanox.com>:
>
>
> On 11/9/2017 5:20 PM, Tony Yang wrote:
>>
>> Hi, All
>>     I downloaded the nvme with multipath kernel, The kernel version is
>> 4.14, I encountered a problem, I use Mellanox connectx-3 infiniband
>> driver. Because the 4.14 kernel version is too new to install
>> infiniband driver, does anyone encounter with me The same situation?
>> How to solve? Thank you for your help.
>>
>
> Are you talking about MLNX_OFED ? what do you mean infiniband driver ?
