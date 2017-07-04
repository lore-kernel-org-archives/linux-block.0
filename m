Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-nvme@lists.infradead.org
Cc: Christoph Hellwig <hch@lst.de>,
	Keith Busch <keith.busch@intel.com>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	=?UTF-8?q?Roger=20Pau=20Monn=C3=A9?= <roger.pau@citrix.com>,
	Boris Ostrovsky <boris.ostrovsky@oracle.com>,
	Juergen Gross <jgross@suse.com>
Subject: [PATCH 8/8] xen-blockfront: quiesce IO before device removal
Date: Tue,  4 Jul 2017 10:55:12 +0300
Message-Id: <1499154912-10420-9-git-send-email-sagi@grimberg.me>
In-Reply-To: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
References: <1499154912-10420-1-git-send-email-sagi@grimberg.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

Before calling blk_cleanup_queue one must make sure
that no request is being queued. In order to guarantee that
we need to use blk_mq_quiesce as it respects the submission
path rcu grace.

Cc: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Cc: Roger Pau Monné <roger.pau@citrix.com>
Cc: Boris Ostrovsky <boris.ostrovsky@oracle.com>
Cc: Juergen Gross <jgross@suse.com>
Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 drivers/block/xen-blkfront.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/xen-blkfront.c b/drivers/block/xen-blkfront.c
index c852ed3c01d5..5272ca8fb0dc 100644
--- a/drivers/block/xen-blkfront.c
+++ b/drivers/block/xen-blkfront.c
@@ -1187,7 +1187,7 @@ static void xlvbd_release_gendisk(struct blkfront_info *info)
 		return;
 
 	/* No more blkif_request(). */
-	blk_mq_stop_hw_queues(info->rq);
+	blk_mq_quiesce_queue(info->rq);
 
 	for (i = 0; i < info->nr_rings; i++) {
 		struct blkfront_ring_info *rinfo = &info->rinfo[i];
@@ -1217,7 +1217,7 @@ static void xlvbd_release_gendisk(struct blkfront_info *info)
 static inline void kick_pending_request_queues_locked(struct blkfront_ring_info *rinfo)
 {
 	if (!RING_FULL(&rinfo->ring))
-		blk_mq_start_stopped_hw_queues(rinfo->dev_info->rq, true);
+		blk_mq_unquiesce_queue(rinfo->dev_info->rq);
 }
 
 static void kick_pending_request_queues(struct blkfront_ring_info *rinfo)
@@ -1346,7 +1346,7 @@ static void blkif_free(struct blkfront_info *info, int suspend)
 		BLKIF_STATE_SUSPENDED : BLKIF_STATE_DISCONNECTED;
 	/* No more blkif_request(). */
 	if (info->rq)
-		blk_mq_stop_hw_queues(info->rq);
+		blk_mq_quiesce_queue(info->rq);
 
 	for (i = 0; i < info->nr_rings; i++)
 		blkif_free_ring(&info->rinfo[i]);
@@ -2032,7 +2032,7 @@ static int blkif_recover(struct blkfront_info *info)
 		BUG_ON(req->nr_phys_segments > segs);
 		blk_mq_requeue_request(req, false);
 	}
-	blk_mq_start_stopped_hw_queues(info->rq, true);
+	blk_mq_unquiesce_queue(info->rq);
 	blk_mq_kick_requeue_list(info->rq);
 
 	while ((bio = bio_list_pop(&info->bio_list)) != NULL) {
-- 
2.7.4
