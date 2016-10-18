Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-co1nam03on0085.outbound.protection.outlook.com ([104.47.40.85]:5618
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1754138AbcJRVvF (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 18 Oct 2016 17:51:05 -0400
Subject: [PATCH v3 05/11] blk-mq: Add a kick_requeue_list argument to
 blk_mq_requeue_request()
To: Jens Axboe <axboe@fb.com>
References: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
CC: Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        Ming Lin <ming.l@ssi.samsung.com>,
        Laurence Oberman <loberman@redhat.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <7b52319b-03f7-e432-909a-2f46232770c6@sandisk.com>
Date: Tue, 18 Oct 2016 14:51:02 -0700
MIME-Version: 1.0
In-Reply-To: <b39eb0e7-1007-eb63-8e7f-9a7f08508379@sandisk.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

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
index d41ed92..b0c8b44 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -491,12 +491,12 @@ static void __blk_mq_requeue_request(struct request *rq)
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
 
@@ -534,7 +534,8 @@ static void blk_mq_requeue_work(struct work_struct *work)
 	blk_mq_start_hw_queues(q);
 }
 
-void blk_mq_add_to_requeue_list(struct request *rq, bool at_head)
+void blk_mq_add_to_requeue_list(struct request *rq, bool at_head,
+				bool kick_requeue_list)
 {
 	struct request_queue *q = rq->q;
 	unsigned long flags;
@@ -553,6 +554,9 @@ void blk_mq_add_to_requeue_list(struct request *rq, bool at_head)
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
index 76d1666..d5cec26 100644
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
index 329381a..e4a6f2d 100644
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
index 02c3918..1fcdc04 100644
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

