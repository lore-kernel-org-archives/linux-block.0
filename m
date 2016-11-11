Return-Path: <Bart.VanAssche@sandisk.com>
Subject: Re: Regression: nvme timeouts and oopses
To: Jens Axboe <axboe@kernel.dk>
References: <af308491-a381-f13d-2d87-89bbca68d99e@kernel.dk>
CC: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>, "Christoph
 Hellwig" <hch@lst.de>, Keith Busch <keith.busch@intel.com>
From: Bart Van Assche <bart.vanassche@sandisk.com>
Message-ID: <50342d6b-e185-d125-c04c-e72d6fc45ccd@sandisk.com>
Date: Fri, 11 Nov 2016 11:23:53 -0800
MIME-Version: 1.0
In-Reply-To: <af308491-a381-f13d-2d87-89bbca68d99e@kernel.dk>
Content-Type: text/plain; charset="utf-8"
Return-Path: Bart.VanAssche@sandisk.com
List-ID: <linux-block@vger.kernel.org>

On 11/11/2016 10:47 AM, Jens Axboe wrote:
> I've been running into problems when stability testing my 4.10 branch,

Hello Jens,

Can you try the patch below instead of the revert?

Thanks,

Bart.

---
 block/blk-mq.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b7753ae..f047180 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1279,11 +1279,11 @@ static struct request *blk_mq_map_request(struct request_queue *q,
 	return rq;
 }
 
-static void blk_mq_try_issue_directly(struct blk_mq_hw_ctx *hctx,
-				      struct request *rq, blk_qc_t *cookie)
+static void blk_mq_try_issue_directly(struct request *rq, blk_qc_t *cookie)
 {
 	int ret;
 	struct request_queue *q = rq->q;
+	struct blk_mq_hw_ctx *hctx = blk_mq_map_queue(q, rq->mq_ctx->cpu);
 	struct blk_mq_queue_data bd = {
 		.rq = rq,
 		.list = NULL,
@@ -1395,11 +1395,11 @@ static blk_qc_t blk_mq_make_request(struct request_queue *q, struct bio *bio)
 
 		if (!(data.hctx->flags & BLK_MQ_F_BLOCKING)) {
 			rcu_read_lock();
-			blk_mq_try_issue_directly(data.hctx, old_rq, &cookie);
+			blk_mq_try_issue_directly(old_rq, &cookie);
 			rcu_read_unlock();
 		} else {
 			srcu_idx = srcu_read_lock(&data.hctx->queue_rq_srcu);
-			blk_mq_try_issue_directly(data.hctx, old_rq, &cookie);
+			blk_mq_try_issue_directly(old_rq, &cookie);
 			srcu_read_unlock(&data.hctx->queue_rq_srcu, srcu_idx);
 		}
 		goto done;
-- 
2.10.1
