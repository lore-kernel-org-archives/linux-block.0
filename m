Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Adrian Hunter <adrian.hunter@intel.com>,
	"James E.J. Bottomley" <jejb@linux.vnet.ibm.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	linux-scsi@vger.kernel.org
Subject: [RFC PATCH V2 12/17] SCSI: create admin queue for each host
Date: Sat, 11 Aug 2018 15:12:15 +0800
Message-Id: <20180811071220.357-13-ming.lei@redhat.com>
In-Reply-To: <20180811071220.357-1-ming.lei@redhat.com>
References: <20180811071220.357-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

The created admin queue will be used to send internal admin commands,
so we can simplify the sync between some admin commands and IO requests,
typical examples are system suspend and runtime PM.

Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Adrian Hunter <adrian.hunter@intel.com>
Cc: "James E.J. Bottomley" <jejb@linux.vnet.ibm.com>
Cc: "Martin K. Petersen" <martin.petersen@oracle.com>
Cc: linux-scsi@vger.kernel.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/scsi/hosts.c     |   9 ++++
 drivers/scsi/scsi_lib.c  | 117 +++++++++++++++++++++++++++++++++++++++++------
 drivers/scsi/scsi_priv.h |   1 +
 3 files changed, 114 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/hosts.c b/drivers/scsi/hosts.c
index 3771e59a9fae..e09f9e5a75da 100644
--- a/drivers/scsi/hosts.c
+++ b/drivers/scsi/hosts.c
@@ -242,6 +242,9 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 
 	shost->dma_dev = dma_dev;
 
+	if (!scsi_init_admin_queue(shost))
+		goto out_remove_tags;
+
 	/*
 	 * Increase usage count temporarily here so that calling
 	 * scsi_autopm_put_host() will trigger runtime idle if there is
@@ -309,6 +312,9 @@ int scsi_add_host_with_dma(struct Scsi_Host *shost, struct device *dev,
 	pm_runtime_disable(&shost->shost_gendev);
 	pm_runtime_set_suspended(&shost->shost_gendev);
 	pm_runtime_put_noidle(&shost->shost_gendev);
+	blk_cleanup_queue(shost->admin_q);
+	blk_put_queue(shost->admin_q);
+ out_remove_tags:
 	if (shost_use_blk_mq(shost))
 		scsi_mq_destroy_tags(shost);
  fail:
@@ -344,6 +350,9 @@ static void scsi_host_dev_release(struct device *dev)
 		kfree(dev_name(&shost->shost_dev));
 	}
 
+	blk_cleanup_queue(shost->admin_q);
+	blk_put_queue(shost->admin_q);
+
 	if (shost_use_blk_mq(shost)) {
 		if (shost->tag_set.tags)
 			scsi_mq_destroy_tags(shost);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index bfb2356e41fa..89ca6e10e7f6 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -2049,19 +2049,22 @@ static void scsi_mq_done(struct scsi_cmnd *cmd)
 	blk_mq_complete_request(cmd->request);
 }
 
-static void scsi_mq_put_budget(struct blk_mq_hw_ctx *hctx)
+static void __scsi_mq_put_budget(struct blk_mq_hw_ctx *hctx,
+		struct scsi_device *sdev)
 {
-	struct request_queue *q = hctx->queue;
-	struct scsi_device *sdev = q->queuedata;
-
 	atomic_dec(&sdev->device_busy);
 	put_device(&sdev->sdev_gendev);
 }
 
-static bool scsi_mq_get_budget(struct blk_mq_hw_ctx *hctx)
+static void scsi_mq_put_budget(struct blk_mq_hw_ctx *hctx)
+{
+	__scsi_mq_put_budget(hctx, hctx->queue->queuedata);
+}
+
+static bool __scsi_mq_get_budget(struct blk_mq_hw_ctx *hctx,
+		struct scsi_device *sdev)
 {
 	struct request_queue *q = hctx->queue;
-	struct scsi_device *sdev = q->queuedata;
 
 	if (!get_device(&sdev->sdev_gendev))
 		goto out;
@@ -2078,12 +2081,17 @@ static bool scsi_mq_get_budget(struct blk_mq_hw_ctx *hctx)
 	return false;
 }
 
-static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
-			 const struct blk_mq_queue_data *bd)
+static bool scsi_mq_get_budget(struct blk_mq_hw_ctx *hctx)
+{
+	return __scsi_mq_get_budget(hctx, hctx->queue->queuedata);
+}
+
+static blk_status_t __scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
+			 const struct blk_mq_queue_data *bd,
+			 struct scsi_device *sdev)
 {
 	struct request *req = bd->rq;
 	struct request_queue *q = req->q;
-	struct scsi_device *sdev = q->queuedata;
 	struct Scsi_Host *shost = sdev->host;
 	struct scsi_cmnd *cmd = blk_mq_rq_to_pdu(req);
 	blk_status_t ret;
@@ -2131,7 +2139,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	if (scsi_target(sdev)->can_queue > 0)
 		atomic_dec(&scsi_target(sdev)->target_busy);
 out_put_budget:
-	scsi_mq_put_budget(hctx);
+	__scsi_mq_put_budget(hctx, sdev);
 	switch (ret) {
 	case BLK_STS_OK:
 		break;
@@ -2153,6 +2161,29 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 	return ret;
 }
 
+static blk_status_t scsi_admin_queue_rq(struct blk_mq_hw_ctx *hctx,
+			 const struct blk_mq_queue_data *bd)
+{
+	struct scsi_device *sdev = scsi_req(bd->rq)->sdev;
+
+	WARN_ON_ONCE(hctx->queue == sdev->request_queue);
+
+	if (!__scsi_mq_get_budget(hctx, sdev))
+		return BLK_STS_RESOURCE;
+
+	return __scsi_queue_rq(hctx, bd, sdev);
+}
+
+static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
+			 const struct blk_mq_queue_data *bd)
+{
+	struct scsi_device *sdev = hctx->queue->queuedata;
+
+	WARN_ON_ONCE(hctx->queue == sdev->host->admin_q);
+
+	return __scsi_queue_rq(hctx, bd, hctx->queue->queuedata);
+}
+
 static enum blk_eh_timer_return scsi_timeout(struct request *req,
 		bool reserved)
 {
@@ -2285,9 +2316,9 @@ static void scsi_old_exit_rq(struct request_queue *q, struct request *rq)
 			       cmd->sense_buffer);
 }
 
-struct request_queue *scsi_old_alloc_queue(struct scsi_device *sdev)
+static struct request_queue *__scsi_old_alloc_queue(struct Scsi_Host *shost,
+		bool admin)
 {
-	struct Scsi_Host *shost = sdev->host;
 	struct request_queue *q;
 
 	q = blk_alloc_queue_node(GFP_KERNEL, NUMA_NO_NODE, NULL);
@@ -2306,7 +2337,9 @@ struct request_queue *scsi_old_alloc_queue(struct scsi_device *sdev)
 	}
 
 	__scsi_init_queue(shost, q);
-	blk_queue_flag_set(QUEUE_FLAG_SCSI_PASSTHROUGH, q);
+
+	if (!admin)
+		blk_queue_flag_set(QUEUE_FLAG_SCSI_PASSTHROUGH, q);
 	blk_queue_prep_rq(q, scsi_prep_fn);
 	blk_queue_unprep_rq(q, scsi_unprep_fn);
 	blk_queue_softirq_done(q, scsi_softirq_done);
@@ -2315,6 +2348,23 @@ struct request_queue *scsi_old_alloc_queue(struct scsi_device *sdev)
 	return q;
 }
 
+struct request_queue *scsi_old_alloc_queue(struct scsi_device *sdev)
+{
+	return __scsi_old_alloc_queue(sdev->host, false);
+}
+
+static struct request_queue *scsi_old_alloc_admin_queue(struct Scsi_Host *shost)
+{
+	struct request_queue *q = __scsi_old_alloc_queue(shost, true);
+
+	if (!q)
+		return NULL;
+
+	blk_queue_init_tags(q, shost->cmd_per_lun, shost->bqt,
+			    shost->hostt->tag_alloc_policy);
+	return q;
+}
+
 static const struct blk_mq_ops scsi_mq_ops = {
 	.get_budget	= scsi_mq_get_budget,
 	.put_budget	= scsi_mq_put_budget,
@@ -2330,6 +2380,16 @@ static const struct blk_mq_ops scsi_mq_ops = {
 	.map_queues	= scsi_map_queues,
 };
 
+static const struct blk_mq_ops scsi_mq_admin_ops = {
+	.queue_rq	= scsi_admin_queue_rq,
+	.complete	= scsi_softirq_done,
+	.timeout	= scsi_timeout,
+	.init_request	= scsi_mq_init_request,
+	.exit_request	= scsi_mq_exit_request,
+	.initialize_rq_fn = scsi_initialize_rq,
+	.map_queues	= scsi_map_queues,
+};
+
 struct request_queue *scsi_mq_alloc_queue(struct scsi_device *sdev)
 {
 	sdev->request_queue = blk_mq_init_queue(&sdev->host->tag_set);
@@ -2341,6 +2401,37 @@ struct request_queue *scsi_mq_alloc_queue(struct scsi_device *sdev)
 	return sdev->request_queue;
 }
 
+static struct request_queue *scsi_mq_alloc_admin_queue(struct Scsi_Host *shost)
+{
+	struct request_queue *q = __blk_mq_init_queue(&shost->tag_set,
+			QUEUE_FLAG_MQ_ADMIN_DEFAULT);
+	if (IS_ERR(q))
+		return NULL;
+
+	q->mq_ops = &scsi_mq_admin_ops;
+
+	__scsi_init_queue(shost, q);
+
+	return q;
+}
+
+struct request_queue *scsi_init_admin_queue(struct Scsi_Host *shost)
+{
+	struct request_queue *q;
+
+	if (shost_use_blk_mq(shost))
+		q = scsi_mq_alloc_admin_queue(shost);
+	else
+		q = scsi_old_alloc_admin_queue(shost);
+
+	if (!q)
+		return NULL;
+
+	WARN_ON(!blk_get_queue(q));
+	shost->admin_q = q;
+	return q;
+}
+
 int scsi_mq_setup_tags(struct Scsi_Host *shost)
 {
 	unsigned int cmd_size, sgl_size;
diff --git a/drivers/scsi/scsi_priv.h b/drivers/scsi/scsi_priv.h
index 99f1db5e467e..0553acbc3f65 100644
--- a/drivers/scsi/scsi_priv.h
+++ b/drivers/scsi/scsi_priv.h
@@ -94,6 +94,7 @@ extern void scsi_run_host_queues(struct Scsi_Host *shost);
 extern void scsi_requeue_run_queue(struct work_struct *work);
 extern struct request_queue *scsi_old_alloc_queue(struct scsi_device *sdev);
 extern struct request_queue *scsi_mq_alloc_queue(struct scsi_device *sdev);
+extern struct request_queue *scsi_init_admin_queue(struct Scsi_Host *shost);
 extern void scsi_start_queue(struct scsi_device *sdev);
 extern int scsi_mq_setup_tags(struct Scsi_Host *shost);
 extern void scsi_mq_destroy_tags(struct Scsi_Host *shost);
-- 
2.9.5
