Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
Subject: [PATCH 06/12] blk-mq: Add a kick_requeue_list argument to
 blk_mq_requeue_request()
To: Jens Axboe <axboe@fb.com>
References: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <3944826d-bfde-f1e6-40ec-2c9a3c259e3a@sandisk.com>
Date: Wed, 26 Oct 2016 15:53:39 -0700
MIME-Version: 1.0
In-Reply-To: <b22edafc-725f-0419-d074-34d35d57d126@sandisk.com>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 James Bottomley <jejb@linux.vnet.ibm.com>,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 Mike Snitzer <snitzer@redhat.com>,
 "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
 Ming Lei <tom.leiming@gmail.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <keith.busch@intel.com>, Doug Ledford <dledford@redhat.com>,
 "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
 Laurence Oberman <loberman@redhat.com>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Most blk_mq_requeue_request() and blk_mq_add_to_requeue_list() calls
are followed by kicking the requeue list. Hence add an argument to
these two functions that allows to kick the requeue list. This was
proposed by Christoph Hellwig.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Sagi Grimberg <sagi@grimberg.me>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
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
index 6a14b68..a834aed 100644
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
index 4945437..688bcc3 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -492,12 +492,12 @@ static void __blk_mq_requeue_request(struct request *rq)
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
 
@@ -535,7 +535,8 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	blk_mq_start_hw_queues(q);
 }
 
-void blk_mq_add_to_requeue_list(struct request *rq, bool at_head)
+void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
+				bool kick_requeue_list)
 {
 	struct request_queue *q = rq->q;
 	unsigned long flags;
@@ -554,6 +555,9 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head)
 		list_add_tail(&rq->queuelist, &q->requeue_list);
 	}
 	spin_unlock_irqrestore(&q->requeue_lock, flags);
+
+	if (kick_requeue_list)
+		blk_mq_kick_requeue_list(q);
 }
 EXPORT_SYMBOL(blk_mq_add_to_requeue_list);
 
diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index 9908597..1ca702d 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -2043,7 +2043,7 @@ static int blkif_recover(struct blkfront_info *info)
 		/* Requeue pending requests (flush or discard) */
 		list_del_init(&req->queuelist);
 		BUG_ON(req->nr_phys_segments > segs);
-		blk_mq_requeue_request(req);
+		blk_mq_requeue_request(req, false);
 	}
 	blk_mq_kick_requeue_list(info->rq);
 
diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index dc75bea..fbd37b4 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -354,7 +354,7 @@ EXPORT_SYMBOL(dm_mq_kick_requeue_list);
 
 static void dm_mq_delay_requeue_request(struct request *rq, unsigned long msecs)
 {
-	blk_mq_requeue_request(rq);
+	blk_mq_requeue_request(rq, false);
 	__dm_mq_kick_requeue_list(rq->q, msecs);
 }
 
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 79e679d..7bb73ba 100644
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
index 2cca9cf..ab5b06f 100644
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
index 61be48b..76f6319 100644
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
 void blk_mq_cancel_requeue_work(struct request_queue *q);
 void blk_mq_kick_requeue_list(struct request_queue *q);
 void blk_mq_delay_kick_requeue_list(struct request_queue *q, unsigned long msecs);
-- 
2.10.1


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
