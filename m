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
Subject: [PATCH 08/14] null_blk: complete requests from ->timeout
Date: Tue, 29 May 2018 15:52:33 +0200
Message-Id: <20180529135239.27005-9-hch@lst.de>
In-Reply-To: <20180529135239.27005-1-hch@lst.de>
References: <20180529135239.27005-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

By completing the request entirely in the driver we can remove the
BLK_EH_HANDLED return value and thus the split responsibility between the
driver and the block layer that has been causing trouble.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 drivers/block/null_blk.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index b4d368e3ddcd..2bdadd7f1454 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -1365,7 +1365,8 @@ static blk_qc_t null_queue_bio(struct request_queue *q, struct bio *bio)
 static enum blk_eh_timer_return null_rq_timed_out_fn(struct request *rq)
 {
 	pr_info("null: rq %p timed out\n", rq);
-	return BLK_EH_HANDLED;
+	blk_mq_complete_request(rq);
+	return BLK_EH_DONE;
 }
 
 static int null_rq_prep_fn(struct request_queue *q, struct request *req)
@@ -1427,7 +1428,8 @@ static void null_request_fn(struct request_queue *q)
 static enum blk_eh_timer_return null_timeout_rq(struct request *rq, bool res)
 {
 	pr_info("null: rq %p timed out\n", rq);
-	return BLK_EH_HANDLED;
+	blk_mq_complete_request(rq);
+	return BLK_EH_DONE;
 }
 
 static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
-- 
2.17.0
