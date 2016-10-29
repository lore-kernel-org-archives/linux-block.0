Return-Path: <linux-scsi-owner@vger.kernel.org>
Subject: [PATCH v5 08/14] blk-mq: Add a kick_requeue_list argument to
 blk_mq_requeue_request()
To: Jens Axboe <axboe@fb.com>
References: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
CC: Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Ming Lei <tom.leiming@gmail.com>,
        "Konrad Rzeszutek Wilk" <konrad.wilk@oracle.com>,
        =?UTF-8?Q?Roger_Pau_Monn=c3=a9?= <roger.pau@citrix.com>,
        Laurence Oberman <loberman@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <01d525ec-5b5b-b22d-4b17-36d7406920ed@sandisk.com>
Date: Fri, 28 Oct 2016 17:21:41 -0700
MIME-Version: 1.0
In-Reply-To: <7460e8b2-2cfd-c0d5-7ae7-7f662d89dad3@sandisk.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-scsi-owner@vger.kernel.org
List-ID: <linux-block@vger.kernel.org>

Most blk_mq_requeue_request() and blk_mq_add_to_requeue_list() calls
are followed by kicking the requeue list. Hence add an argument to
these two functions that allows to kick the requeue list. This was
proposed by Christoph Hellwig.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
---
 block/blk-flush.c            |  5 +----
 block/blk-mq.c               | 10 +++++++---
 drivers/block/xen-blkfront.c |  2 +-
 drivers/md/dm-rq.c           |  2 +-
 drivers/nvme/host/core.c     |  2 +-
 drivers/scsi/scsi_lib.c      |  4 +---
 include/linux/blk-mq.h       |  5 +++--
 7 files changed, 15 insertions(+), 15 deletions(-)

diff --git a/block/blk-flush.c b/block/blk-flush.c
index 3c882cb..7e9950b 100644
--- a/block/blk-flush.c
+++ b/block/blk-flush.c
@@ -134,10 +134,7 @@ static void blk_flush_restore_request(struct request *rq)
 static bool blk_flush_queue_rq(struct request *rq, bool add_front)
 {
 	if (rq->q->mq_ops) {
-		struct request_queue *q = rq->q;
-
-		blk_mq_add_to_requeue_list(rq, add_front);
-		blk_mq_kick_requeue_list(q);
+		blk_mq_add_to_requeue_list(rq, add_front, true);
 		return false;
 	} else {
 		if (add_front)
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 96015a9..b7753ae 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -494,12 +494,12 @@ static void __blk_mq_requeue_request(struct request *rq)
 	}
 }
 
-void blk_mq_requeue_request(struct request *rq)
+void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list)
 {
 	__blk_mq_requeue_request(rq);
 
 	BUG_ON(blk_queued_rq(rq));
-	blk_mq_add_to_requeue_list(rq, true);
+	blk_mq_add_to_requeue_list(rq, true, kick_requeue_list);
 }
 EXPORT_SYMBOL(blk_mq_requeue_request);
 
@@ -533,7 +533,8 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	blk_mq_run_hw_queues(q, false);
 }
 
-void blk_mq_add_to_requeue_list(struct request *rq, bool at_head)
+void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
+				bool kick_requeue_list)
 {
 	struct request_queue *q = rq->q;
 	unsigned long flags;
@@ -552,6 +553,9 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head)
 		list_add_tail(&rq->queuelist, &q->requeue_list);
 	}
 	spin_unlock_irqrestore(&q->requeue_lock, flags);
+
+	if (kick_requeue_list)
+		blk_mq_kick_requeue_list(q);
 }
 EXPORT_SYMBOL(blk_mq_add_to_requeue_list);
 
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 60fff99..a3e1727 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2043,7 +2043,7 @@ static int blkif_recover(struct blkfront_info *info)
 		/* Requeue pending requests (flush or discard) */
 		list_del_init(&req->queuelist);
 		BUG_ON(req->nr_phys_segments > segs);
-		blk_mq_requeue_request(req);
+		blk_mq_requeue_request(req, false);
 	}
 	blk_mq_start_stopped_hwqueues(info->rq);
 	blk_mq_kick_requeue_list(info->rq);
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 2b82496..4b62e74 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -347,7 +347,7 @@ EXPORT_SYMBOL(dm_mq_kick_requeue_list);
 
 static void dm_mq_delay_requeue_request(struct request *rq, unsigned long msecs)
 {
-	blk_mq_requeue_request(rq);
+	blk_mq_requeue_request(rq, false);
 	__dm_mq_kick_requeue_list(rq->q, msecs);
 }
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index ab5f59e..8403996 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -203,7 +203,7 @@ void nvme_requeue_req(struct request *req)
 {
 	unsigned long flags;
 
-	blk_mq_requeue_request(req);
+	blk_mq_requeue_request(req, false);
 	spin_lock_irqsave(req->q->queue_lock, flags);
 	if (!blk_queue_stopped(req->q))
 		blk_mq_kick_requeue_list(req->q);
diff --git a/drivers/scsi/scsi_lib.c b/drivers/scsi/scsi_lib.c
index 126a784..b4f682c 100644
--- a/drivers/scsi/scsi_lib.c
+++ b/drivers/scsi/scsi_lib.c
@@ -86,10 +86,8 @@ scsi_set_blocked(struct scsi_cmnd *cmd, int reason)
 static void scsi_mq_requeue_cmd(struct scsi_cmnd *cmd)
 {
 	struct scsi_device *sdev = cmd->device;
-	struct request_queue *q = cmd->request->q;
 
-	blk_mq_requeue_request(cmd->request);
-	blk_mq_kick_requeue_list(q);
+	blk_mq_requeue_request(cmd->request, true);
 	put_device(&sdev->sdev_gendev);
 }
 
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index ed20ac7..35a0af5 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -218,8 +218,9 @@ void blk_mq_start_request(struct request *rq);
 void blk_mq_end_request(struct request *rq, int error);
 void __blk_mq_end_request(struct request *rq, int error);
 
-void blk_mq_requeue_request(struct request *rq);
-void blk_mq_add_to_requeue_list(struct request *rq, bool at_head);
+void blk_mq_requeue_request(struct request *rq, bool kick_requeue_list);
+void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
+				bool kick_requeue_list);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
 void blk_mq_abort_requeue_list(struct request_queue *q);
-- 
2.10.1

