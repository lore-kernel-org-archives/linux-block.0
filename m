Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([65.50.211.133]:58336 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751247AbdA1JdG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 28 Jan 2017 04:33:06 -0500
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@fb.com>, mst@redhat.com, jasowang@redhat.com
Cc: linux-block@vger.kernel.org,
        virtualization@lists.linux-foundation.org
Subject: [PATCH 3/5] block: make scsi_request and scsi ioctl support optional
Date: Sat, 28 Jan 2017 09:32:51 +0100
Message-Id: <1485592373-29837-4-git-send-email-hch@lst.de>
In-Reply-To: <1485592373-29837-1-git-send-email-hch@lst.de>
References: <1485592373-29837-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

We only need this code to support scsi, ide, cciss and virtio.  And at
least for virtio it's a deprecated feature to start with.

This should shrink the kernel size for embedded device that only use,
say eMMC a bit.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Kconfig                | 5 +++++
 block/Makefile               | 5 +++--
 drivers/block/Kconfig        | 4 ++++
 drivers/block/paride/Kconfig | 1 +
 drivers/ide/Kconfig          | 1 +
 drivers/scsi/Kconfig         | 1 +
 drivers/target/Kconfig       | 1 +
 fs/nfsd/Kconfig              | 1 +
 8 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 8bf114a..9791bb8 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -49,9 +49,13 @@ config LBDAF
 
 	  If unsure, say Y.
 
+config BLK_SCSI_REQUEST
+	bool
+
 config BLK_DEV_BSG
 	bool "Block layer SG support v4"
 	default y
+	select BLK_SCSI_REQUEST
 	help
 	  Saying Y here will enable generic SG (SCSI generic) v4 support
 	  for any block device.
@@ -71,6 +75,7 @@ config BLK_DEV_BSGLIB
 	bool "Block layer SG support v4 helper lib"
 	default n
 	select BLK_DEV_BSG
+	select BLK_SCSI_REQUEST
 	help
 	  Subsystems will normally enable this if needed. Users will not
 	  normally need to manually enable this.
diff --git a/block/Makefile b/block/Makefile
index 6cabe6b..6d7de29 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -7,10 +7,11 @@ obj-$(CONFIG_BLOCK) := bio.o elevator.o blk-core.o blk-tag.o blk-sysfs.o \
 			blk-exec.o blk-merge.o blk-softirq.o blk-timeout.o \
 			blk-lib.o blk-mq.o blk-mq-tag.o blk-stat.o \
 			blk-mq-sysfs.o blk-mq-cpumap.o blk-mq-sched.o ioctl.o \
-			genhd.o scsi_ioctl.o partition-generic.o ioprio.o \
+			genhd.o partition-generic.o ioprio.o \
 			badblocks.o partitions/
 
-obj-$(CONFIG_BOUNCE)	+= bounce.o
+obj-$(CONFIG_BOUNCE)		+= bounce.o
+obj-$(CONFIG_BLK_SCSI_REQUEST)	+= scsi_ioctl.o
 obj-$(CONFIG_BLK_DEV_BSG)	+= bsg.o
 obj-$(CONFIG_BLK_DEV_BSGLIB)	+= bsg-lib.o
 obj-$(CONFIG_BLK_CGROUP)	+= blk-cgroup.o
diff --git a/drivers/block/Kconfig b/drivers/block/Kconfig
index 223ff2f..7a4c787 100644
--- a/drivers/block/Kconfig
+++ b/drivers/block/Kconfig
@@ -69,6 +69,7 @@ config AMIGA_Z2RAM
 config GDROM
 	tristate "SEGA Dreamcast GD-ROM drive"
 	depends on SH_DREAMCAST
+	select BLK_SCSI_REQUEST # only for the generic cdrom code
 	help
 	  A standard SEGA Dreamcast comes with a modified CD ROM drive called a
 	  "GD-ROM" by SEGA to signify it is capable of reading special disks
@@ -114,6 +115,7 @@ config BLK_CPQ_CISS_DA
 	tristate "Compaq Smart Array 5xxx support"
 	depends on PCI
 	select CHECK_SIGNATURE
+	select BLK_SCSI_REQUEST
 	help
 	  This is the driver for Compaq Smart Array 5xxx controllers.
 	  Everyone using these boards should say Y here.
@@ -386,6 +388,7 @@ config BLK_DEV_RAM_DAX
 config CDROM_PKTCDVD
 	tristate "Packet writing on CD/DVD media (DEPRECATED)"
 	depends on !UML
+	select BLK_SCSI_REQUEST
 	help
 	  Note: This driver is deprecated and will be removed from the
 	  kernel in the near future!
@@ -497,6 +500,7 @@ config XEN_BLKDEV_BACKEND
 config VIRTIO_BLK
 	tristate "Virtio block driver"
 	depends on VIRTIO
+	select BLK_SCSI_REQUEST
 	---help---
 	  This is the virtual block driver for virtio.  It can be used with
           lguest or QEMU based VMMs (like KVM or Xen).  Say Y or M.
diff --git a/drivers/block/paride/Kconfig b/drivers/block/paride/Kconfig
index efefb5a..3a15247 100644
--- a/drivers/block/paride/Kconfig
+++ b/drivers/block/paride/Kconfig
@@ -25,6 +25,7 @@ config PARIDE_PD
 config PARIDE_PCD
 	tristate "Parallel port ATAPI CD-ROMs"
 	depends on PARIDE
+	select BLK_SCSI_REQUEST # only for the generic cdrom code
 	---help---
 	  This option enables the high-level driver for ATAPI CD-ROM devices
 	  connected through a parallel port. If you chose to build PARIDE
diff --git a/drivers/ide/Kconfig b/drivers/ide/Kconfig
index 39ea67f..c99a25c 100644
--- a/drivers/ide/Kconfig
+++ b/drivers/ide/Kconfig
@@ -10,6 +10,7 @@ menuconfig IDE
 	tristate "ATA/ATAPI/MFM/RLL support (DEPRECATED)"
 	depends on HAVE_IDE
 	depends on BLOCK
+	select BLK_SCSI_REQUEST
 	---help---
 	  If you say Y here, your kernel will be able to manage ATA/(E)IDE and
 	  ATAPI units. The most common cases are IDE hard drives and ATAPI
diff --git a/drivers/scsi/Kconfig b/drivers/scsi/Kconfig
index a4f6b0d..d4023bf 100644
--- a/drivers/scsi/Kconfig
+++ b/drivers/scsi/Kconfig
@@ -18,6 +18,7 @@ config SCSI
 	depends on BLOCK
 	select SCSI_DMA if HAS_DMA
 	select SG_POOL
+	select BLK_SCSI_REQUEST
 	---help---
 	  If you want to use a SCSI hard disk, SCSI tape drive, SCSI CD-ROM or
 	  any other SCSI device under Linux, say Y and make sure that you know
diff --git a/drivers/target/Kconfig b/drivers/target/Kconfig
index 2573612..e2bc999 100644
--- a/drivers/target/Kconfig
+++ b/drivers/target/Kconfig
@@ -4,6 +4,7 @@ menuconfig TARGET_CORE
 	depends on SCSI && BLOCK
 	select CONFIGFS_FS
 	select CRC_T10DIF
+	select BLK_SCSI_REQUEST # only for scsi_command_size_tbl..
 	default n
 	help
 	Say Y or M here to enable the TCM Storage Engine and ConfigFS enabled
diff --git a/fs/nfsd/Kconfig b/fs/nfsd/Kconfig
index 47febcf..20b1c17 100644
--- a/fs/nfsd/Kconfig
+++ b/fs/nfsd/Kconfig
@@ -104,6 +104,7 @@ config NFSD_SCSILAYOUT
 	depends on NFSD_V4 && BLOCK
 	select NFSD_PNFS
 	select EXPORTFS_BLOCK_OPS
+	select BLK_SCSI_REQUEST
 	help
 	  This option enables support for the exporting pNFS SCSI layouts
 	  in the kernel's NFS server. The pNFS SCSI layout enables NFS
-- 
2.1.4

