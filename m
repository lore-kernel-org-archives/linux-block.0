Return-Path: <BATV+3de936c6eedb3fd3a39f+5557+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org
Subject: [PATCH 2/6] nullb: remove leftover legacy request code
Date: Sat, 10 Nov 2018 09:30:45 +0100
Message-Id: <20181110083049.17475-3-hch@lst.de>
In-Reply-To: <20181110083049.17475-1-hch@lst.de>
References: <20181110083049.17475-1-hch@lst.de>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

null_softirq_done_fn is only used for the blk-mq path, so remove the
other branch.  Also rename the function to better match the method name.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/null_blk_main.c | 9 +++------
 1 file changed, 3 insertions(+), 6 deletions(-)

diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 9c045bee0985..16ba3db2a015 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -642,14 +642,11 @@ static void null_cmd_end_timer(struct nullb_cmd *cmd)
 	hrtimer_start(&cmd->timer, kt, HRTIMER_MODE_REL);
 }
 
-static void null_softirq_done_fn(struct request *rq)
+static void null_complete_rq(struct request *rq)
 {
 	struct nullb *nullb = rq->q->queuedata;
 
-	if (nullb->dev->queue_mode == NULL_Q_MQ)
-		end_cmd(blk_mq_rq_to_pdu(rq));
-	else
-		end_cmd(rq->special);
+	end_cmd(blk_mq_rq_to_pdu(rq));
 }
 
 static struct nullb_page *null_alloc_page(gfp_t gfp_flags)
@@ -1357,7 +1354,7 @@ static blk_status_t null_queue_rq(struct blk_mq_hw_ctx *hctx,
 
 static const struct blk_mq_ops null_mq_ops = {
 	.queue_rq       = null_queue_rq,
-	.complete	= null_softirq_done_fn,
+	.complete	= null_complete_rq,
 	.timeout	= null_timeout_rq,
 };
 
-- 
2.19.1
