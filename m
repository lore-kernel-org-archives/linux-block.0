Return-Path: <linux-ide-owner@vger.kernel.org>
From: tom.ty89@gmail.com
To: tj@kernel.org
Cc: linux-ide@vger.kernel.org, linux-scsi@vger.kernel.org,
	linux-block@vger.kernel.org, Tom Yan <tom.ty89@gmail.com>
Subject: [PATCH v2 2/2] libata-core: do not set dev->max_sectors for LBA48 devices
Date: Tue,  9 Aug 2016 22:45:47 +0800
Message-Id: <10c4d38005e24bb477b5182d4fc17879139f14d9.1470753817.git.tom.ty89@gmail.com>
In-Reply-To: <5eceeb9ad825beb87db03b0989f746dfbe0cf3fe.1470753817.git.tom.ty89@gmail.com>
References: <5eceeb9ad825beb87db03b0989f746dfbe0cf3fe.1470753817.git.tom.ty89@gmail.com>
Sender: linux-ide-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

From: Tom Yan <tom.ty89@gmail.com>

Currently block layer limit max_hw_sectors is set to
ATA_MAX_SECTORS_LBA48 (65535), for devices with LBA48 support.

However, block layer limit max_sectors (which is the effective
one; also adjustable, upper-bounded by max_hw_sectors) is set to
BLK_DEF_MAX_SECTORS (currently 2560) by the scsi disk driver,
since libata's SATL does not report an Optimal Transfer Length.

This does not make much sense, especially when the current
BLK_DEF_MAX_SECTORS appears to be unsafe for some ATA devices
(see ATA_HORKAGE_MAX_SEC_1024). Truth is, the current value
appears to be arbitrary anyway. See commit d2be537c3ba3
("block: bump BLK_DEF_MAX_SECTORS to 2560").

Therefore, avoid setting dev->max_sectors when it is strictly
necessary. Leave it as 0 otherwise, so that both block layer
limits will remain as SCSI_DEFAULT_MAX_SECTORS (currently 1024).

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index 0749f71..07259d8 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -2610,10 +2610,8 @@ int ata_dev_configure(struct ata_device *dev)
 				     dma_dir_string);
 	}
 
-	/* determine max_sectors */
-	dev->max_sectors = ATA_MAX_SECTORS;
-	if (dev->flags & ATA_DFLAG_LBA48)
-		dev->max_sectors = ATA_MAX_SECTORS_LBA48;
+	if (!(dev->flags & ATA_DFLAG_LBA48))
+		dev->max_sectors = ATA_MAX_SECTORS;
 
 	/* Limit PATA drive on SATA cable bridge transfers to udma5,
 	   200 sectors */
-- 
2.9.2

