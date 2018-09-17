Return-Path: <bvanassche@acm.org>
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	"Martin K . Petersen" <martin.petersen@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v7 3/7] block, scsi: Introduce blk_pm_runtime_exit()
Date: Mon, 17 Sep 2018 13:11:17 -0700
Message-Id: <20180917201124.26161-5-bvanassche@acm.org>
In-Reply-To: <20180917201124.26161-1-bvanassche@acm.org>
References: <20180917201124.26161-1-bvanassche@acm.org>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

Since it is possible to unbind a SCSI ULD and since unbinding
removes the association between a request queue and struct device,
the q->dev pointer has to be reset during unbind. Hence introduce
a function in the block layer that clears request_queue.dev.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 block/blk-pm.c         | 18 ++++++++++++++++++
 drivers/scsi/sd.c      |  9 ++++-----
 drivers/scsi/sr.c      |  3 ++-
 include/linux/blk-pm.h |  2 ++
 4 files changed, 26 insertions(+), 6 deletions(-)

diff --git a/block/blk-pm.c b/block/blk-pm.c
index 9b636960d285..bf8532da952d 100644
--- a/block/blk-pm.c
+++ b/block/blk-pm.c
@@ -40,6 +40,24 @@ void blk_pm_runtime_init(struct request_queue *q, struct device *dev)
 }
 EXPORT_SYMBOL(blk_pm_runtime_init);
 
+/**
+ * blk_pm_runtime_exit - runtime PM exit routine
+ * @q: the queue of the device
+ *
+ * This function should be called from the device_driver.remove() callback
+ * function to avoid that further calls to runtime power management functions
+ * occur.
+ */
+void blk_pm_runtime_exit(struct request_queue *q)
+{
+	if (!q->dev)
+		return;
+
+	pm_runtime_get_sync(q->dev);
+	q->dev = NULL;
+}
+EXPORT_SYMBOL(blk_pm_runtime_exit);
+
 /**
  * blk_pre_runtime_suspend - Pre runtime suspend check
  * @q: the queue of the device
diff --git a/drivers/scsi/sd.c b/drivers/scsi/sd.c
index 64514e8359e4..956b918b6114 100644
--- a/drivers/scsi/sd.c
+++ b/drivers/scsi/sd.c
@@ -3408,12 +3408,11 @@ static int sd_probe(struct device *dev)
  **/
 static int sd_remove(struct device *dev)
 {
-	struct scsi_disk *sdkp;
-	dev_t devt;
+	struct scsi_disk *sdkp = dev_get_drvdata(dev);
+	struct scsi_device *sdp = sdkp->device;
+	dev_t devt = disk_devt(sdkp->disk);
 
-	sdkp = dev_get_drvdata(dev);
-	devt = disk_devt(sdkp->disk);
-	scsi_autopm_get_device(sdkp->device);
+	blk_pm_runtime_exit(sdp->request_queue);
 
 	async_synchronize_full_domain(&scsi_sd_pm_domain);
 	async_synchronize_full_domain(&scsi_sd_probe_domain);
diff --git a/drivers/scsi/sr.c b/drivers/scsi/sr.c
index 4f07b3410595..111ad9f8b449 100644
--- a/drivers/scsi/sr.c
+++ b/drivers/scsi/sr.c
@@ -1015,8 +1015,9 @@ static void sr_kref_release(struct kref *kref)
 static int sr_remove(struct device *dev)
 {
 	struct scsi_cd *cd = dev_get_drvdata(dev);
+	struct scsi_device *sdev = cd->device;
 
-	scsi_autopm_get_device(cd->device);
+	blk_pm_runtime_exit(sdev->request_queue);
 
 	del_gendisk(cd->disk);
 	dev_set_drvdata(dev, NULL);
diff --git a/include/linux/blk-pm.h b/include/linux/blk-pm.h
index b80c65aba249..6d654f41acbf 100644
--- a/include/linux/blk-pm.h
+++ b/include/linux/blk-pm.h
@@ -11,6 +11,7 @@ struct request_queue;
  */
 #ifdef CONFIG_PM
 extern void blk_pm_runtime_init(struct request_queue *q, struct device *dev);
+extern void blk_pm_runtime_exit(struct request_queue *q);
 extern int blk_pre_runtime_suspend(struct request_queue *q);
 extern void blk_post_runtime_suspend(struct request_queue *q, int err);
 extern void blk_pre_runtime_resume(struct request_queue *q);
@@ -19,6 +20,7 @@ extern void blk_set_runtime_active(struct request_queue *q);
 #else
 static inline void blk_pm_runtime_init(struct request_queue *q,
 				       struct device *dev) {}
+static inline void blk_pm_runtime_exit(struct request_queue *q) {}
 #endif
 
 #endif /* _BLK_PM_H_ */
-- 
2.18.0
