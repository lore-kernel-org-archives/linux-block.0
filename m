Return-Path: <Adam.Manzanares@wdc.com>
From: Adam Manzanares <adam.manzanares@hgst.com>
To: <axboe@kernel.dk>, <hare@suse.de>, <mchristi@redhat.com>,
	<dan.j.williams@intel.com>, <martin.petersen@oracle.com>,
	<toshi.kani@hpe.com>, <damien.lemoal@hgst.com>, <ming.lei@canonical.com>,
	<tj@kernel.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-ide@vger.kernel.org>, Adam Manzanares <adam.manzanares@wdc.com>
Subject: [PATCH v7 4/4] ata: set ncq_prio_enabled iff device has support
Date: Tue, 6 Dec 2016 09:18:05 -0800
Message-ID: <1481044685-2803-5-git-send-email-adam.manzanares@hgst.com>
In-Reply-To: <1481044685-2803-1-git-send-email-adam.manzanares@hgst.com>
References: <1481044685-2803-1-git-send-email-adam.manzanares@hgst.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: Adam.Manzanares@wdc.com
List-ID: <linux-block@vger.kernel.org>

From: Adam Manzanares <adam.manzanares@wdc.com>

We previously had a check to see if the device has support for
prioritized ncq commands and a check to see if a device flag
is set, through a sysfs variable, in order to send a prioritized
command.

This patch only allows the sysfs variable to be set if the device
supports prioritized commands enabling one check in ata_build_rw_tf
in order to determine whether or not to send a prioritized command.

This patch depends on ata: ATA Command Priority Disabled By Default

tj: Minor subject and formatting updates.

Signed-off-by: Adam Manzanares <adam.manzanares@wdc.com>
---
 drivers/ata/libata-core.c |  3 +--
 drivers/ata/libata-scsi.c | 21 +++++++++++++++------
 2 files changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/ata/libata-core.c b/drivers/ata/libata-core.c
index f6a631a..324e76e 100644
--- a/drivers/ata/libata-core.c
+++ b/drivers/ata/libata-core.c
@@ -787,8 +787,7 @@ int ata_build_rw_tf(struct ata_taskfile *tf, struct ata_device *dev,
 		if (tf->flags & ATA_TFLAG_FUA)
 			tf->device |= 1 << 7;
 
-		if ((dev->flags & ATA_DFLAG_NCQ_PRIO) &&
-		    (dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLE)) {
+		if (dev->flags & ATA_DFLAG_NCQ_PRIO_ENABLE) {
 			if (class == IOPRIO_CLASS_RT)
 				tf->hob_nsect |= ATA_PRIO_HIGH <<
 						 ATA_SHIFT_PRIO;
diff --git a/drivers/ata/libata-scsi.c b/drivers/ata/libata-scsi.c
index 328a601..c24cbf1 100644
--- a/drivers/ata/libata-scsi.c
+++ b/drivers/ata/libata-scsi.c
@@ -317,17 +317,26 @@ static ssize_t ata_ncq_prio_enable_store(struct device *device,
 
 	ap = ata_shost_to_port(sdev->host);
 
-	spin_lock_irqsave(ap->lock, flags);
 	dev = ata_scsi_find_dev(ap, sdev);
-	if (unlikely(!dev)) {
-		rc = -ENODEV;
-		goto unlock;
+	if (unlikely(!dev))
+		return  -ENODEV;
+
+	if (!(dev->flags & ATA_DFLAG_NCQ_PRIO)) {
+		if (ata_id_has_ncq_prio(dev->id))
+			ata_dev_config_ncq_prio(dev);
 	}
 
-	if (input)
+	spin_lock_irqsave(ap->lock, flags);
+	if (input) {
+		if (!(dev->flags & ATA_DFLAG_NCQ_PRIO)) {
+			rc = -EOPNOTSUPP;
+			goto unlock;
+		}
+
 		dev->flags |= ATA_DFLAG_NCQ_PRIO_ENABLE;
-	else
+	} else {
 		dev->flags &= ~ATA_DFLAG_NCQ_PRIO_ENABLE;
+	}
 
 unlock:
 	spin_unlock_irqrestore(ap->lock, flags);
-- 
2.7.4
