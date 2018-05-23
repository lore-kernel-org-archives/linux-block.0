Return-Path: <BATV+df5a2477ff0fa86e9985+5386+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>
Cc: Bart Van Assche <bart.vanassche@wdc.com>,
	Ming Lei <ming.lei@redhat.com>,
	Josef Bacik <josef@toxicpanda.com>,
	Tejun Heo <tj@kernel.org>,
	Lee Duncan <lduncan@suse.com>,
	Chris Leech <cleech@redhat.com>,
	Rafael David Tinoco <rafael.tinoco@canonical.com>,
	linux-block@vger.kernel.org,
	linux-scsi@vger.kernel.org
Subject: [PATCH 14/14] blk-mq: simplify blk_mq_rq_timed_out
Date: Wed, 23 May 2018 14:19:41 +0200
Message-Id: <20180523121941.8632-15-hch@lst.de>
In-Reply-To: <20180523121941.8632-1-hch@lst.de>
References: <20180523121941.8632-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-mq.c | 22 ++++++++--------------
 1 file changed, 8 insertions(+), 14 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 8c7b1803b7e9..592bab689f8e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -747,22 +747,16 @@ EXPORT_SYMBOL(blk_mq_tag_to_rq);
 
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
