Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa1.hgst.iphmx.com ([68.232.141.245]:1352 "EHLO
        esa1.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726744AbeHIWIa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 9 Aug 2018 18:08:30 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        Ming Lei <ming.lei@redhat.com>,
        Jianchao Wang <jianchao.w.wang@oracle.com>,
        Hannes Reinecke <hare@suse.com>,
        Johannes Thumshirn <jthumshirn@suse.de>,
        Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v6 04/12] scsi: Introduce the SDEV_SUSPENDED device status
Date: Thu,  9 Aug 2018 12:41:41 -0700
Message-Id: <20180809194149.15285-5-bart.vanassche@wdc.com>
In-Reply-To: <20180809194149.15285-1-bart.vanassche@wdc.com>
References: <20180809194149.15285-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Instead of using the SDEV_QUIESCE state for both SCSI domain validation
and runtime suspend, use the SDEV_QUIESCE state only for SCSI domain
validation. Keep using scsi_device_quiesce() and scsi_device_unquiesce()
for SCSI domain validation. Add new functions scsi_device_suspend() and
scsi_device_unsuspend() for power management. Rename scsi_device_resume()
into scsi_device_unquiesce() to avoid confusion.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 drivers/scsi/scsi_lib.c           | 138 ++++++++++++++++++++++++------
 drivers/scsi/scsi_pm.c            |   6 +-
 drivers/scsi/scsi_sysfs.c         |   1 +
 drivers/scsi/scsi_transport_spi.c |   2 +-
 include/scsi/scsi_device.h        |  13 +--
 5 files changed, 125 insertions(+), 35 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 4d7411a7985f..eb914d8e17fd 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -1365,6 +1365,11 @@ scsi_prep_state_check(struct scsi_device *sdev, struct request *req)
 		if (!(req->rq_flags & (RQF_PM | RQF_DV)))
 			ret = BLKPREP_DEFER;
 		break;
+	case SDEV_SUSPENDED:
+		/* Process RQF_PM requests only. */
+		if (!(req->rq_flags & RQF_PM))
+			ret = BLKPREP_DEFER;
+		break;
 	case SDEV_CANCEL:
 		/* Only allow RQF_PM requests. */
 		if (!(req->rq_flags & RQF_PM))
@@ -2669,6 +2674,7 @@ scsi_device_set_state(struct scsi_device *sdev, enum scsi_device_state state)
 		case SDEV_OFFLINE:
 		case SDEV_TRANSPORT_OFFLINE:
 		case SDEV_QUIESCE:
+		case SDEV_SUSPENDED:
 		case SDEV_BLOCK:
 			break;
 		default:
@@ -2677,6 +2683,7 @@ scsi_device_set_state(struct scsi_device *sdev, enum scsi_device_state state)
 		break;
 
 	case SDEV_QUIESCE:
+	case SDEV_SUSPENDED:
 		switch (oldstate) {
 		case SDEV_RUNNING:
 		case SDEV_OFFLINE:
@@ -2970,19 +2977,103 @@ static void scsi_wait_for_queuecommand(struct scsi_device *sdev)
 }
 
 /**
- *	scsi_device_quiesce - Block user issued commands.
- *	@sdev:	scsi device to quiesce.
+ * scsi_device_suspend - only process RQF_PM requests
+ * @sdev: scsi device to suspend.
+ *
+ * This works by trying to transition to the SDEV_SUSPENDED state (which must be
+ * a legal transition).  When the device is in this state, only RQF_DV
+ * requests will be accepted, all others will be deferred.
+ *
+ * Must be called with user context, may sleep.
+ *
+ * Returns zero if unsuccessful or an error if not.
+ */
+int
+scsi_device_suspend(struct scsi_device *sdev)
+{
+	struct request_queue *q = sdev->request_queue;
+	int err;
+
+	if (sdev->sdev_state == SDEV_SUSPENDED)
+		return 0;
+
+	blk_set_preempt_only(q);
+
+	blk_mq_freeze_queue(q);
+	/*
+	 * Ensure that the effect of blk_set_preempt_only() will be visible
+	 * for percpu_ref_tryget() callers that occur after the queue
+	 * unfreeze even if the queue was already frozen before this function
+	 * was called. See also https://lwn.net/Articles/573497/.
+	 */
+	synchronize_rcu();
+	blk_mq_unfreeze_queue(q);
+
+	mutex_lock(&sdev->state_mutex);
+	err = scsi_device_set_state(sdev, SDEV_SUSPENDED);
+	if (err)
+		blk_clear_preempt_only(q);
+	mutex_unlock(&sdev->state_mutex);
+
+	return err;
+}
+EXPORT_SYMBOL(scsi_device_suspend);
+
+/**
+ * scsi_device_unsuspend - unsuspend processing non-RQF_DV requests
+ * @sdev: scsi device to unsuspend.
  *
- *	This works by trying to transition to the SDEV_QUIESCE state
- *	(which must be a legal transition).  When the device is in this
- *	state, only special requests will be accepted, all others will
- *	be deferred.  Since special requests may also be requeued requests,
- *	a successful return doesn't guarantee the device will be 
- *	totally quiescent.
+ * Moves the device from suspended back to running and restarts the queues.
  *
- *	Must be called with user context, may sleep.
+ * Must be called with user context, may sleep.
+ */
+void scsi_device_unsuspend(struct scsi_device *sdev)
+{
+	mutex_lock(&sdev->state_mutex);
+	blk_clear_preempt_only(sdev->request_queue);
+	if (sdev->sdev_state == SDEV_SUSPENDED)
+		scsi_device_set_state(sdev, SDEV_RUNNING);
+	mutex_unlock(&sdev->state_mutex);
+}
+EXPORT_SYMBOL(scsi_device_unsuspend);
+
+static void
+device_suspend_fn(struct scsi_device *sdev, void *data)
+{
+	scsi_device_suspend(sdev);
+}
+
+void
+scsi_target_suspend(struct scsi_target *starget)
+{
+	starget_for_each_device(starget, NULL, device_suspend_fn);
+}
+EXPORT_SYMBOL(scsi_target_suspend);
+
+static void
+device_unsuspend_fn(struct scsi_device *sdev, void *data)
+{
+	scsi_device_unsuspend(sdev);
+}
+
+void
+scsi_target_unsuspend(struct scsi_target *starget)
+{
+	starget_for_each_device(starget, NULL, device_unsuspend_fn);
+}
+EXPORT_SYMBOL(scsi_target_unsuspend);
+
+/**
+ * scsi_device_quiesce - only process RQF_DV requests
+ * @sdev: scsi device to quiesce.
  *
- *	Returns zero if unsuccessful or an error if not.
+ * This works by trying to transition to the SDEV_QUIESCE state (which must be
+ * a legal transition).  When the device is in this state, only RQF_DV
+ * requests will be accepted, all others will be deferred.
+ *
+ * Must be called with user context, may sleep.
+ *
+ * Returns zero if unsuccessful or an error if not.
  */
 int
 scsi_device_quiesce(struct scsi_device *sdev)
@@ -3022,20 +3113,15 @@ scsi_device_quiesce(struct scsi_device *sdev)
 EXPORT_SYMBOL(scsi_device_quiesce);
 
 /**
- *	scsi_device_resume - Restart user issued commands to a quiesced device.
- *	@sdev:	scsi device to resume.
+ * scsi_device_unquiesce - unquiesce processing non-RQF_DV requests
+ * @sdev: scsi device to unquiesce.
  *
- *	Moves the device from quiesced back to running and restarts the
- *	queues.
+ * Moves the device from quiesced back to running and restarts the queues.
  *
- *	Must be called with user context, may sleep.
+ * Must be called with user context, may sleep.
  */
-void scsi_device_resume(struct scsi_device *sdev)
+void scsi_device_unquiesce(struct scsi_device *sdev)
 {
-	/* check if the device state was mutated prior to resume, and if
-	 * so assume the state is being managed elsewhere (for example
-	 * device deleted during suspend)
-	 */
 	mutex_lock(&sdev->state_mutex);
 	WARN_ON_ONCE(!sdev->quiesced_by);
 	sdev->quiesced_by = NULL;
@@ -3044,7 +3130,7 @@ void scsi_device_resume(struct scsi_device *sdev)
 		scsi_device_set_state(sdev, SDEV_RUNNING);
 	mutex_unlock(&sdev->state_mutex);
 }
-EXPORT_SYMBOL(scsi_device_resume);
+EXPORT_SYMBOL(scsi_device_unquiesce);
 
 static void
 device_quiesce_fn(struct scsi_device *sdev, void *data)
@@ -3060,17 +3146,17 @@ scsi_target_quiesce(struct scsi_target *starget)
 EXPORT_SYMBOL(scsi_target_quiesce);
 
 static void
-device_resume_fn(struct scsi_device *sdev, void *data)
+device_unquiesce_fn(struct scsi_device *sdev, void *data)
 {
-	scsi_device_resume(sdev);
+	scsi_device_unquiesce(sdev);
 }
 
 void
-scsi_target_resume(struct scsi_target *starget)
+scsi_target_unquiesce(struct scsi_target *starget)
 {
-	starget_for_each_device(starget, NULL, device_resume_fn);
+	starget_for_each_device(starget, NULL, device_unquiesce_fn);
 }
-EXPORT_SYMBOL(scsi_target_resume);
+EXPORT_SYMBOL(scsi_target_unquiesce);
 
 /**
  * scsi_internal_device_block_nowait - try to transition to the SDEV_BLOCK state
diff --git a/drivers/scsi/scsi_pm.c b/drivers/scsi/scsi_pm.c
index b44c1bb687a2..6300e168701d 100644
--- a/drivers/scsi/scsi_pm.c
+++ b/drivers/scsi/scsi_pm.c
@@ -57,11 +57,11 @@ static int scsi_dev_type_suspend(struct device *dev,
 	/* flush pending in-flight resume operations, suspend is synchronous */
 	async_synchronize_full_domain(&scsi_sd_pm_domain);
 
-	err = scsi_device_quiesce(to_scsi_device(dev));
+	err = scsi_device_suspend(to_scsi_device(dev));
 	if (err == 0) {
 		err = cb(dev, pm);
 		if (err)
-			scsi_device_resume(to_scsi_device(dev));
+			scsi_device_unsuspend(to_scsi_device(dev));
 	}
 	dev_dbg(dev, "scsi suspend: %d\n", err);
 	return err;
@@ -74,7 +74,7 @@ static int scsi_dev_type_resume(struct device *dev,
 	int err = 0;
 
 	err = cb(dev, pm);
-	scsi_device_resume(to_scsi_device(dev));
+	scsi_device_unsuspend(to_scsi_device(dev));
 	dev_dbg(dev, "scsi resume: %d\n", err);
 
 	if (err == 0) {
diff --git a/drivers/scsi/scsi_sysfs.c b/drivers/scsi/scsi_sysfs.c
index 7943b762c12d..496c5eff4859 100644
--- a/drivers/scsi/scsi_sysfs.c
+++ b/drivers/scsi/scsi_sysfs.c
@@ -36,6 +36,7 @@ static const struct {
 	{ SDEV_CANCEL, "cancel" },
 	{ SDEV_DEL, "deleted" },
 	{ SDEV_QUIESCE, "quiesce" },
+	{ SDEV_SUSPENDED, "suspended" },
 	{ SDEV_OFFLINE,	"offline" },
 	{ SDEV_TRANSPORT_OFFLINE, "transport-offline" },
 	{ SDEV_BLOCK,	"blocked" },
diff --git a/drivers/scsi/scsi_transport_spi.c b/drivers/scsi/scsi_transport_spi.c
index bf6b18768e79..16bec4884249 100644
--- a/drivers/scsi/scsi_transport_spi.c
+++ b/drivers/scsi/scsi_transport_spi.c
@@ -1048,7 +1048,7 @@ spi_dv_device(struct scsi_device *sdev)
 	mutex_unlock(&spi_dv_mutex(starget));
 	spi_dv_pending(starget) = 0;
 
-	scsi_target_resume(starget);
+	scsi_target_unquiesce(starget);
 
 	spi_initial_dv(starget) = 1;
 
diff --git a/include/scsi/scsi_device.h b/include/scsi/scsi_device.h
index 440834f4252e..a2e3edf8be12 100644
--- a/include/scsi/scsi_device.h
+++ b/include/scsi/scsi_device.h
@@ -42,9 +42,8 @@ enum scsi_device_state {
 				 * Only error handler commands allowed */
 	SDEV_DEL,		/* device deleted 
 				 * no commands allowed */
-	SDEV_QUIESCE,		/* Device quiescent.  No block commands
-				 * will be accepted, only specials (which
-				 * originate in the mid-layer) */
+	SDEV_QUIESCE,		/* Only RQF_DV requests are accepted. */
+	SDEV_SUSPENDED,		/* Only RQF_PM requests are accepted. */
 	SDEV_OFFLINE,		/* Device offlined (by error handling or
 				 * user request */
 	SDEV_TRANSPORT_OFFLINE,	/* Offlined by transport class error handler */
@@ -415,9 +414,13 @@ extern void sdev_evt_send(struct scsi_device *sdev, struct scsi_event *evt);
 extern void sdev_evt_send_simple(struct scsi_device *sdev,
 			  enum scsi_device_event evt_type, gfp_t gfpflags);
 extern int scsi_device_quiesce(struct scsi_device *sdev);
-extern void scsi_device_resume(struct scsi_device *sdev);
+extern void scsi_device_unquiesce(struct scsi_device *sdev);
 extern void scsi_target_quiesce(struct scsi_target *);
-extern void scsi_target_resume(struct scsi_target *);
+extern void scsi_target_unquiesce(struct scsi_target *);
+extern int scsi_device_suspend(struct scsi_device *sdev);
+extern void scsi_device_unsuspend(struct scsi_device *sdev);
+extern void scsi_target_suspend(struct scsi_target *);
+extern void scsi_target_unsuspend(struct scsi_target *);
 extern void scsi_scan_target(struct device *parent, unsigned int channel,
 			     unsigned int id, u64 lun,
 			     enum scsi_scan_mode rescan);
-- 
2.18.0
