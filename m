Return-Path: <prvs=752cffea0=Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Woody Suwalski <terraluna977@gmail.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v6 06/12] scsi: Reallow SPI domain validation during system suspend
Date: Thu,  9 Aug 2018 12:41:43 -0700
Message-Id: <20180809194149.15285-7-bart.vanassche@wdc.com>
In-Reply-To: <20180809194149.15285-1-bart.vanassche@wdc.com>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

Now that SCSI power management and SPI domain validation use different
mechanisms for blocking SCSI command execution, remove the mechanism
again that prevents system suspend during SPI domain validation.

This patch reverts 203f8c250e21 ("block, scsi: Fix race between SPI
domain validation and system suspend").

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Woody Suwalski <terraluna977@gmail.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/scsi/scsi_lib.c           | 37 +++++++++++++++++++++++++++++--
 drivers/scsi/scsi_sysfs.c         |  1 +
 drivers/scsi/scsi_transport_spi.c | 15 ++-----------
 include/scsi/scsi_device.h        |  1 +
 4 files changed, 39 insertions(+), 15 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index d466f846043f..89f790e73ed6 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1366,6 +1366,7 @@ scsi_prep_state_check(struct scsi_device *sdev, struct request *req)
 			ret = BLKPREP_DEFER;
 		break;
 	case SDEV_SUSPENDED:
+	case SDEV_QUIESCED_SUSPENDED:
 		/* Process RQF_PM requests only. */
 		if (!(req->rq_flags & RQF_PM))
 			ret = BLKPREP_DEFER;
@@ -2683,6 +2684,17 @@ scsi_device_set_state(struct scsi_device *sdev, enum scsi_device_state state)
 		break;
 
 	case SDEV_QUIESCE:
+		switch (oldstate) {
+		case SDEV_RUNNING:
+		case SDEV_QUIESCED_SUSPENDED:
+		case SDEV_OFFLINE:
+		case SDEV_TRANSPORT_OFFLINE:
+			break;
+		default:
+			goto illegal;
+		}
+		break;
+
 	case SDEV_SUSPENDED:
 		switch (oldstate) {
 		case SDEV_RUNNING:
@@ -2694,6 +2706,15 @@ scsi_device_set_state(struct scsi_device *sdev, enum scsi_device_state state)
 		}
 		break;
 
+	case SDEV_QUIESCED_SUSPENDED:
+		switch (oldstate) {
+		case SDEV_QUIESCE:
+			break;
+		default:
+			goto illegal;
+		}
+		break;
+
 	case SDEV_OFFLINE:
 	case SDEV_TRANSPORT_OFFLINE:
 		switch (oldstate) {
@@ -2994,8 +3015,13 @@ scsi_device_suspend(struct scsi_device *sdev)
 	struct request_queue *q = sdev->request_queue;
 	int err;
 
-	if (sdev->sdev_state == SDEV_SUSPENDED)
+	switch (sdev->sdev_state) {
+	case SDEV_SUSPENDED:
+	case SDEV_QUIESCED_SUSPENDED:
 		return 0;
+	default:
+		break;
+	}
 
 	blk_set_pm_only(q);
 
@@ -3011,6 +3037,8 @@ scsi_device_suspend(struct scsi_device *sdev)
 
 	mutex_lock(&sdev->state_mutex);
 	err = scsi_device_set_state(sdev, SDEV_SUSPENDED);
+	if (err)
+		err = scsi_device_set_state(sdev, SDEV_QUIESCED_SUSPENDED);
 	if (err)
 		blk_clear_pm_only(q);
 	mutex_unlock(&sdev->state_mutex);
@@ -3031,8 +3059,13 @@ void scsi_device_unsuspend(struct scsi_device *sdev)
 {
 	mutex_lock(&sdev->state_mutex);
 	blk_clear_pm_only(sdev->request_queue);
-	if (sdev->sdev_state == SDEV_SUSPENDED)
+	switch (sdev->sdev_state) {
+	case SDEV_SUSPENDED:
+	case SDEV_QUIESCED_SUSPENDED:
 		scsi_device_set_state(sdev, SDEV_RUNNING);
+	default:
+		break;
+	}
 	mutex_unlock(&sdev->state_mutex);
 }
 EXPORT_SYMBOL(scsi_device_unsuspend);
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 496c5eff4859..8c152e35ff77 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -37,6 +37,7 @@ static const struct {
 	{ SDEV_DEL, "deleted" },
 	{ SDEV_QUIESCE, "quiesce" },
 	{ SDEV_SUSPENDED, "suspended" },
+	{ SDEV_QUIESCED_SUSPENDED, "quiesced-suspended" },
 	{ SDEV_OFFLINE,	"offline" },
 	{ SDEV_TRANSPORT_OFFLINE, "transport-offline" },
 	{ SDEV_BLOCK,	"blocked" },
diff --git a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
index 16bec4884249..582b18efc3fb 100644
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -26,7 +26,6 @@
 #include <linux/mutex.h>
 #include <linux/sysfs.h>
 #include <linux/slab.h>
-#include <linux/suspend.h>
 #include <scsi/scsi.h>
 #include "scsi_priv.h"
 #include <scsi/scsi_device.h>
@@ -1008,19 +1007,11 @@ spi_dv_device(struct scsi_device *sdev)
 	u8 *buffer;
 	const int len = SPI_MAX_ECHO_BUFFER_SIZE*2;
 
-	/*
-	 * Because this function and the power management code both call
-	 * scsi_device_quiesce(), it is not safe to perform domain validation
-	 * while suspend or resume is in progress. Hence the
-	 * lock/unlock_system_sleep() calls.
-	 */
-	lock_system_sleep();
-
 	if (unlikely(starget->spi_dv_context))
-		goto unlock;
+		return;
 
 	if (unlikely(scsi_device_get(sdev)))
-		goto unlock;
+		return;
 
 	buffer = kzalloc(len, GFP_KERNEL);
 
@@ -1056,8 +1047,6 @@ spi_dv_device(struct scsi_device *sdev)
 	kfree(buffer);
  out_put:
 	scsi_device_put(sdev);
-unlock:
-	unlock_system_sleep();
 }
 EXPORT_SYMBOL(spi_dv_device);
 
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index a2e3edf8be12..a67dc459b70d 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -44,6 +44,7 @@ enum scsi_device_state {
 				 * no commands allowed */
 	SDEV_QUIESCE,		/* Only RQF_DV requests are accepted. */
 	SDEV_SUSPENDED,		/* Only RQF_PM requests are accepted. */
+	SDEV_QUIESCED_SUSPENDED,/* Only RQF_PM requests are accepted. */
 	SDEV_OFFLINE,		/* Device offlined (by error handling or
 				 * user request */
 	SDEV_TRANSPORT_OFFLINE,	/* Offlined by transport class error handler */
-- 
2.18.0
