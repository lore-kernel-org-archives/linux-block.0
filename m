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
Subject: [RFC PATCH 08/14] SCSI: deal with admin queue busy
Date: Wed,  8 Aug 2018 01:44:27 +0800
Message-Id: <20180807174433.8374-9-ming.lei@redhat.com>
In-Reply-To: <20180807174433.8374-1-ming.lei@redhat.com>
References: <20180807174433.8374-1-ming.lei@redhat.com>
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
 drivers/scsi/scsi_lib.c  | 46 +++++++++++++++++++++++++++++++++-------------
 include/scsi/scsi_host.h |  2 ++
 2 files changed, 35 insertions(+), 13 deletions(-)

diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 0c9c38a82cc8..d0467c8cb996 100644
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
@@ -541,14 +549,16 @@ static void scsi_starved_list_run(struct Scsi_Host *shost)
  * Notes:      The previous command was completely finished, start
  *             a new one if possible.
  */
-static void scsi_run_queue(struct request_queue *q)
+static void scsi_run_queue(struct Scsi_Host *shost, struct request_queue *q)
 {
-	struct scsi_device *sdev = q->queuedata;
+	if (!scsi_is_admin_queue(q)) {
+		struct scsi_device *sdev = q->queuedata;
+		if (scsi_target(sdev)->single_lun)
+			scsi_single_lun_run(sdev);
+	}
 
-	if (scsi_target(sdev)->single_lun)
-		scsi_single_lun_run(sdev);
-	if (!list_empty(&sdev->host->starved_list))
-		scsi_starved_list_run(sdev->host);
+	if (!list_empty(&shost->starved_list) || shost->run_admin_queue)
+		scsi_starved_list_run(shost);
 
 	if (q->mq_ops)
 		blk_mq_run_hw_queues(q, false);
@@ -563,7 +573,7 @@ void scsi_requeue_run_queue(struct work_struct *work)
 
 	sdev = container_of(work, struct scsi_device, requeue_work);
 	q = sdev->request_queue;
-	scsi_run_queue(q);
+	scsi_run_queue(sdev->host, q);
 }
 
 /*
@@ -597,7 +607,7 @@ static void scsi_requeue_command(struct request_queue *q, struct scsi_cmnd *cmd)
 	blk_requeue_request(q, req);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
-	scsi_run_queue(q);
+	scsi_run_queue(sdev->host, q);
 
 	put_device(&sdev->sdev_gendev);
 }
@@ -607,7 +617,7 @@ void scsi_run_host_queues(struct Scsi_Host *shost)
 	struct scsi_device *sdev;
 
 	shost_for_each_device(sdev, shost)
-		scsi_run_queue(sdev->request_queue);
+		scsi_run_queue(shost, sdev->request_queue);
 }
 
 static void scsi_uninit_cmd(struct scsi_cmnd *cmd)
@@ -731,7 +741,7 @@ static bool scsi_end_request(struct request *req, blk_status_t error,
 		blk_finish_request(req, error);
 		spin_unlock_irqrestore(q->queue_lock, flags);
 
-		scsi_run_queue(q);
+		scsi_run_queue(sdev->host, q);
 	}
 
 	put_device(&sdev->sdev_gendev);
@@ -1495,6 +1505,12 @@ static inline int scsi_dev_queue_ready(struct request_queue *q,
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
 
@@ -1503,7 +1519,7 @@ static inline int scsi_dev_queue_ready(struct request_queue *q,
  * @sdev: scsi device on starget to check.
  */
 static inline int scsi_target_queue_ready(struct Scsi_Host *shost,
-					   struct scsi_device *sdev)
+					   struct scsi_device *sdev, bool admin)
 {
 	struct scsi_target *starget = scsi_target(sdev);
 	unsigned int busy;
@@ -1545,6 +1561,8 @@ static inline int scsi_target_queue_ready(struct Scsi_Host *shost,
 starved:
 	spin_lock_irq(shost->host_lock);
 	list_move_tail(&sdev->starved_entry, &shost->starved_list);
+	if (admin)
+		shost->run_admin_queue = true;
 	spin_unlock_irq(shost->host_lock);
 out_dec:
 	if (starget->can_queue > 0)
@@ -1601,6 +1619,8 @@ static inline int scsi_host_queue_ready(struct request_queue *q,
 	spin_lock_irq(shost->host_lock);
 	if (list_empty(&sdev->starved_entry))
 		list_add_tail(&sdev->starved_entry, &shost->starved_list);
+	if (scsi_is_admin_queue(q))
+		shost->run_admin_queue = true;
 	spin_unlock_irq(shost->host_lock);
 out_dec:
 	scsi_dec_host_busy(shost);
@@ -1900,7 +1920,7 @@ static void scsi_request_fn(struct request_queue *q)
 			goto not_ready;
 		}
 
-		if (!scsi_target_queue_ready(shost, sdev))
+		if (!scsi_target_queue_ready(shost, sdev, scsi_is_admin_queue(q)))
 			goto not_ready;
 
 		if (!scsi_host_queue_ready(q, shost, sdev))
@@ -2063,7 +2083,7 @@ static blk_status_t scsi_queue_rq(struct blk_mq_hw_ctx *hctx,
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
