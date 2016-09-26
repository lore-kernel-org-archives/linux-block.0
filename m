Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-co1nam03on0086.outbound.protection.outlook.com ([104.47.40.86]:62054
        "EHLO NAM03-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S941512AbcIZS1A (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Sep 2016 14:27:00 -0400
Subject: [PATCH 2/9] dm: Fix a race condition related to stopping and starting
 queues
To: Jens Axboe <axboe@fb.com>
References: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
CC: Christoph Hellwig <hch@lst.de>,
        James Bottomley <jejb@linux.vnet.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Doug Ledford <dledford@redhat.com>,
        Keith Busch <keith.busch@intel.com>,
        "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
        "linux-scsi@vger.kernel.org" <linux-scsi@vger.kernel.org>,
        "linux-rdma@vger.kernel.org" <linux-rdma@vger.kernel.org>,
        "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <ba8ddc16-b709-e7fb-1120-b6e1bd393540@sandisk.com>
Date: Mon, 26 Sep 2016 11:26:50 -0700
MIME-Version: 1.0
In-Reply-To: <7948dbb8-6333-dc62-2673-4da35b4dfdbc@sandisk.com>
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Ensure that all ongoing dm_mq_queue_rq() and dm_mq_requeue_request()
calls have stopped before setting the "queue stopped" flag. This
allows to remove the "queue stopped" test from dm_mq_queue_rq() and
dm_mq_requeue_request(). This patch fixes a race condition because
dm_mq_queue_rq() is called without holding the queue lock and hence
BLK_MQ_S_STOPPED can be set at any time while dm_mq_queue_rq() is
in progress.

Signed-off-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Mike Snitzer <snitzer@redhat.com>
---
 drivers/md/dm-rq.c | 14 +++-----------
 1 file changed, 3 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm-rq.c b/drivers/md/dm-rq.c
index 182b679..1b7a65e 100644
--- a/drivers/md/dm-rq.c
+++ b/drivers/md/dm-rq.c
@@ -116,9 +116,12 @@ static void dm_mq_stop_queue(struct request_queue *q)
 	queue_flag_set(QUEUE_FLAG_STOPPED, q);
 	spin_unlock_irqrestore(q->queue_lock, flags);
 
+	/* Wait until dm_mq_queue_rq() has finished. */
+	blk_quiesce_queue(q);
 	/* Avoid that requeuing could restart the queue. */
 	blk_mq_cancel_requeue_work(q);
 	blk_mq_stop_hw_queues(q);
+	blk_resume_queue(q);
 }
 
 void dm_stop_queue(struct request_queue *q)
@@ -901,17 +904,6 @@ static int dm_mq_queue_rq(struct blk_mq_hw_ctx *hctx,
 		dm_put_live_table(md, srcu_idx);
 	}
 
-	/*
-	 * On suspend dm_stop_queue() handles stopping the blk-mq
-	 * request_queue BUT: even though the hw_queues are marked
-	 * BLK_MQ_S_STOPPED at that point there is still a race that
-	 * is allowing block/blk-mq.c to call ->queue_rq against a
-	 * hctx that it really shouldn't.  The following check guards
-	 * against this rarity (albeit _not_ race-free).
-	 */
-	if (unlikely(test_bit(BLK_MQ_S_STOPPED, &hctx->state)))
-		return BLK_MQ_RQ_QUEUE_BUSY;
-
 	if (ti->type->busy && ti->type->busy(ti))
 		return BLK_MQ_RQ_QUEUE_BUSY;
 
-- 
2.10.0

