Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:37472 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751012AbdGNXQb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Jul 2017 19:16:31 -0400
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@infradead.org>
Cc: Bart Van Assche <bart.vanassche@sandisk.com>,
        Ming Lei <ming.lei@redhat.com>,
        Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
        =?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Juergen Gross <jgross@suse.com>, xen-devel@lists.xenproject.org
Subject: [PATCH 1/6] xen-blkfront: quiesce/unquiesce queue instead of start/stop queues
Date: Sat, 15 Jul 2017 07:15:56 +0800
Message-Id: <20170714231601.14444-2-ming.lei@redhat.com>
In-Reply-To: <20170714231601.14444-1-ming.lei@redhat.com>
References: <20170714231601.14444-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

stopping queue may cause race and may not stop the queue really
after the API returns, and we have improved quiescing
interface and it really can block dispatching once it returns.

So switch to quiesce/unquiece like what we did on other drivers
(NVMe, NBD, mtip32xx, ...)

The blk_mq_stop_hw_queues() and blk_mq_start_stopped_hw_queues()
used in blkif_queue_rq() and blkif_interrupt() are for congestion
control, we leave it as it is since it is safe for this usage.

Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: "Roger Pau Monné" <roger.pau@citrix.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Cc: xen-devel@lists.xenproject.org
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/block/xen-blkfront.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index c852ed3c01d5..1578befda635 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1187,7 +1187,7 @@ static void xlvbd_release_gendisk(struct blkfront_info *info)
 		return;
 
 	/* No more blkif_request(). */
-	blk_mq_stop_hw_queues(info->rq);
+	blk_mq_quiesce_queue(info->rq);
 
 	for (i = 0; i < info->nr_rings; i++) {
 		struct blkfront_ring_info *rinfo = &info->rinfo[i];
@@ -1216,8 +1216,10 @@ static void xlvbd_release_gendisk(struct blkfront_info *info)
 /* Already hold rinfo->ring_lock. */
 static inline void kick_pending_request_queues_locked(struct blkfront_ring_info *rinfo)
 {
-	if (!RING_FULL(&rinfo->ring))
+	if (!RING_FULL(&rinfo->ring)) {
 		blk_mq_start_stopped_hw_queues(rinfo->dev_info->rq, true);
+		blk_mq_kick_requeue_list(rinfo->dev_info->rq);
+	}
 }
 
 static void kick_pending_request_queues(struct blkfront_ring_info *rinfo)
@@ -1225,7 +1227,8 @@ static void kick_pending_request_queues(struct blkfront_ring_info *rinfo)
 	unsigned long flags;
 
 	spin_lock_irqsave(&rinfo->ring_lock, flags);
-	kick_pending_request_queues_locked(rinfo);
+	if (!RING_FULL(&rinfo->ring))
+		blk_mq_run_hw_queues(rinfo->dev_info->rq, true);
 	spin_unlock_irqrestore(&rinfo->ring_lock, flags);
 }
 
@@ -1346,7 +1349,7 @@ static void blkif_free(struct blkfront_info *info, int suspend)
 		BLKIF_STATE_SUSPENDED : BLKIF_STATE_DISCONNECTED;
 	/* No more blkif_request(). */
 	if (info->rq)
-		blk_mq_stop_hw_queues(info->rq);
+		blk_mq_quiesce_queue(info->rq);
 
 	for (i = 0; i < info->nr_rings; i++)
 		blkif_free_ring(&info->rinfo[i]);
@@ -2018,22 +2021,13 @@ static int blkif_recover(struct blkfront_info *info)
 	/* Now safe for us to use the shared ring */
 	info->connected = BLKIF_STATE_CONNECTED;
 
-	for (r_index = 0; r_index < info->nr_rings; r_index++) {
-		struct blkfront_ring_info *rinfo;
-
-		rinfo = &info->rinfo[r_index];
-		/* Kick any other new requests queued since we resumed */
-		kick_pending_request_queues(rinfo);
-	}
-
 	list_for_each_entry_safe(req, n, &info->requests, queuelist) {
 		/* Requeue pending requests (flush or discard) */
 		list_del_init(&req->queuelist);
 		BUG_ON(req->nr_phys_segments > segs);
 		blk_mq_requeue_request(req, false);
 	}
-	blk_mq_start_stopped_hw_queues(info->rq, true);
-	blk_mq_kick_requeue_list(info->rq);
+	blk_mq_unquiesce_queue(info->rq);
 
 	while ((bio = bio_list_pop(&info->bio_list)) != NULL) {
 		/* Traverse the list of pending bios and re-queue them */
-- 
2.9.4
