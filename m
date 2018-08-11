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
Subject: [RFC PATCH V2 10/17] SCSI: deal with admin queue busy
Date: Sat, 11 Aug 2018 15:12:13 +0800
Message-Id: <20180811071220.357-11-ming.lei@redhat.com>
In-Reply-To: <20180811071220.357-1-ming.lei@redhat.com>
References: <20180811071220.357-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

When request originated from admin queue isn't queued successfully, we
deal with it just like for normal requests, that said the admin queue
will be rerun after one request in this host is completed.

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
 drivers/scsi/scsi_lib.c  | 61 ++++++++++++++++++++++++++++++++++--------------
 include/scsi/scsi_host.h |  2 ++
 2 files changed, 46 insertions(+), 17 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 5a2e7fff1452..87448526c8c9 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -475,10 +475,14 @@ static void scsi_starved_list_run(struct Scsi_Host *shost)
 	LIST_HEAD(starved_list);
 	struct scsi_device *sdev;
 	unsigned long flags;
+	bool run_admin;
 
 	spin_lock_irqsave(shost->host_lock, flags);
 	list_splice_init(&shost->starved_list, &starved_list);
 
+	run_admin = shost->run_admin_queue;
+	shost->run_admin_queue = false;
+
 	while (!list_empty(&starved_list)) {
 		struct request_queue *slq;
 
@@ -527,6 +531,10 @@ static void scsi_starved_list_run(struct Scsi_Host *shost)
 	/* put any unprocessed entries back */
 	list_splice(&starved_list, &shost->starved_list);
 	spin_unlock_irqrestore(shost->host_lock, flags);
+
+	/* no need to get queue for admin_q */
+	if (run_admin)
+		scsi_kick_queue(shost->admin_q);
 }
 
 /*
@@ -534,26 +542,30 @@ static void scsi_starved_list_run(struct Scsi_Host *shost)
  *
  * Purpose:    Select a proper request queue to serve next
  *
- * Arguments:  q       - last request's queue
+ * Arguments:	sdev	- the last request's scsi_device
+ * 		q       - last request's queue, which may points to
+ * 			host->admin_q
  *
  * Returns:     Nothing
  *
  * Notes:      The previous command was completely finished, start
  *             a new one if possible.
  */
-static void scsi_run_queue(struct request_queue *q)
+static void scsi_run_queue(struct scsi_device *sdev, struct request_queue *q)
 {
-	struct scsi_device *sdev = q->queuedata;
+	struct Scsi_Host *shost = sdev->host;
 
 	if (scsi_target(sdev)->single_lun)
 		scsi_single_lun_run(sdev);
-	if (!list_empty(&sdev->host->starved_list))
-		scsi_starved_list_run(sdev->host);
 
-	if (q->mq_ops)
-		blk_mq_run_hw_queues(q, false);
-	else
-		blk_run_queue(q);
+	if (!list_empty(&shost->starved_list) || shost->run_admin_queue)
+		scsi_starved_list_run(shost);
+
+	scsi_kick_queue(q);
+
+	/* q may points to host->admin_queue */
+	if (sdev->request_queue != q)
+		scsi_kick_queue(sdev->request_queue);
 }
 
 void scsi_requeue_run_queue(struct work_struct *work)
@@ -563,7 +575,7 @@ void scsi_requeue_run_queue(struct work_struct *work)
 
 	sdev = container_of(work, struct scsi_device, requeue_work);
 	q = sdev->request_queue;
-	scsi_run_queue(q);
+	scsi_run_queue(sdev, q);
 }
 
 /*
@@ -597,7 +609,7 @@ static void scsi_requeue_command(struct request_queue *q, struct scsi_cmnd *cmd)
 	blk_requeue_request(q, req);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
-	scsi_run_queue(q);
+	scsi_run_queue(sdev, q);
 
 	put_device(&sdev->sdev_gendev);
 }
@@ -607,7 +619,7 @@ void scsi_run_host_queues(struct Scsi_Host *shost)
 	struct scsi_device *sdev;
 
 	shost_for_each_device(sdev, shost)
-		scsi_run_queue(sdev->request_queue);
+		scsi_run_queue(sdev, sdev->request_queue);
 }
 
 static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
@@ -714,8 +726,13 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
 
 		__blk_mq_end_request(req, error);
 
+		/*
+		 * scsi_device is shared between host->admin_queue and
+		 * sdev->request_queue
+		 */
 		if (scsi_target(sdev)->single_lun ||
-		    !list_empty(&sdev->host->starved_list))
+		    !list_empty(&sdev->host->starved_list) ||
+		    sdev->host->run_admin_queue || scsi_is_admin_queue(q))
 			kblockd_schedule_work(&sdev->requeue_work);
 		else
 			blk_mq_run_hw_queues(q, true);
@@ -731,7 +748,7 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
 		blk_finish_request(req, error);
 		spin_unlock_irqrestore(q->queue_lock, flags);
 
-		scsi_run_queue(q);
+		scsi_run_queue(sdev, q);
 	}
 
 	put_device(&sdev->sdev_gendev);
@@ -1494,6 +1511,12 @@ static inline int scsi_dev_queue_ready(struct request_queue *q,
 	return 1;
 out_dec:
 	atomic_dec(&sdev->device_busy);
+
+	if (unlikely(scsi_is_admin_queue(q))) {
+		spin_lock_irq(sdev->host->host_lock);
+		sdev->host->run_admin_queue = true;
+		spin_unlock_irq(sdev->host->host_lock);
+	}
 	return 0;
 }
 
@@ -1502,7 +1525,7 @@ static inline int scsi_dev_queue_ready(struct request_queue *q,
  * @sdev: scsi device on starget to check.
  */
 static inline int scsi_target_queue_ready(struct Scsi_Host *shost,
-					   struct scsi_device *sdev)
+					   struct scsi_device *sdev, bool admin)
 {
 	struct scsi_target *starget = scsi_target(sdev);
 	unsigned int busy;
@@ -1544,6 +1567,8 @@ static inline int scsi_target_queue_ready(struct Scsi_Host *shost,
 starved:
 	spin_lock_irq(shost->host_lock);
 	list_move_tail(&sdev->starved_entry, &shost->starved_list);
+	if (admin)
+		shost->run_admin_queue = true;
 	spin_unlock_irq(shost->host_lock);
 out_dec:
 	if (starget->can_queue > 0)
@@ -1600,6 +1625,8 @@ static inline int scsi_host_queue_ready(struct request_queue *q,
 	spin_lock_irq(shost->host_lock);
 	if (list_empty(&sdev->starved_entry))
 		list_add_tail(&sdev->starved_entry, &shost->starved_list);
+	if (scsi_is_admin_queue(q))
+		shost->run_admin_queue = true;
 	spin_unlock_irq(shost->host_lock);
 out_dec:
 	scsi_dec_host_busy(shost);
@@ -1899,7 +1926,7 @@ static void scsi_request_fn(struct request_queue *q)
 			goto not_ready;
 		}
 
-		if (!scsi_target_queue_ready(shost, sdev))
+		if (!scsi_target_queue_ready(shost, sdev, scsi_is_admin_queue(q)))
 			goto not_ready;
 
 		if (!scsi_host_queue_ready(q, shost, sdev))
@@ -2062,7 +2089,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
 		goto out_put_budget;
 
 	ret = BLK_STS_RESOURCE;
-	if (!scsi_target_queue_ready(shost, sdev))
+	if (!scsi_target_queue_ready(shost, sdev, scsi_is_admin_queue(q)))
 		goto out_put_budget;
 	if (!scsi_host_queue_ready(q, shost, sdev))
 		goto out_dec_target_busy;
diff --git a/include/scsi/scsi_host.h b/include/scsi/scsi_host.h
index 53b485fe9b67..7479923c4a2a 100644
--- a/include/scsi/scsi_host.h
+++ b/include/scsi/scsi_host.h
@@ -532,6 +532,8 @@ struct Scsi_Host {
 	struct list_head	__devices;
 	struct list_head	__targets;
 	
+	struct request_queue	*admin_q;
+	bool                    run_admin_queue;
 	struct list_head	starved_list;
 
 	spinlock_t		default_lock;
-- 
2.9.5
