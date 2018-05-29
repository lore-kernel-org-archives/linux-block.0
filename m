Return-Path: <BATV+a01a3e67072ae75c0352+5392+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 14/14] blk-mq: simplify blk_mq_rq_timed_out
Date: Tue, 29 May 2018 15:52:39 +0200
Message-Id: <20180529135239.27005-15-hch@lst.de>
In-Reply-To: <20180529135239.27005-1-hch@lst.de>
References: <20180529135239.27005-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d898de8841a0..ba6f30a67027 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -770,22 +770,16 @@ EXPORT_SYMBOL(blk_mq_tag_to_rq);
 
 static void blk_mq_rq_timed_out(struct request *req, bool reserved)
 {
-	const struct blk_mq_ops *ops = req->q->mq_ops;
-	enum blk_eh_timer_return ret = BLK_EH_RESET_TIMER;
+	if (req->q->mq_ops->timeout) {
+		enum blk_eh_timer_return ret;
 
-	if (ops->timeout)
-		ret = ops->timeout(req, reserved);
-
-	switch (ret) {
-	case BLK_EH_RESET_TIMER:
-		blk_add_timer(req);
-		break;
-	case BLK_EH_DONE:
-		break;
-	default:
-		printk(KERN_ERR "block: bad eh return: %d\n", ret);
-		break;
+		ret = req->q->mq_ops->timeout(req, reserved);
+		if (ret == BLK_EH_DONE)
+			return;
+		WARN_ON_ONCE(ret != BLK_EH_RESET_TIMER);
 	}
+
+	blk_add_timer(req);
 }
 
 static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
-- 
2.17.0
