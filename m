Return-Path: <axboe@kernel.dk>
To: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
From: Jens Axboe <axboe@kernel.dk>
Subject: null_blk: add blocking mode
Message-ID: <9a2b8d7e-1b04-4c94-2c79-c16fa8134f9d@kernel.dk>
Date: Thu, 30 Mar 2017 12:53:05 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

This adds a new module parameter to null_blk, blocking. If set, null_blk
will set the BLK_MQ_F_BLOCKING flag, indicating that it sometimes/always
needs to block in its ->queue_rq() function.  The intent is to help find
regressions in blocking drivers, since not many of them exist.

If null_blk is loaded with submit_queues > 1 and blocking=1, this
shows the regression recently fixed by bf4907c05e61.

Signed-off-by: Jens Axboe <axboe@fb.com>

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 6f2e565..d95635f 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -117,6 +117,10 @@ static bool use_lightnvm;
 module_param(use_lightnvm, bool, S_IRUGO);
 MODULE_PARM_DESC(use_lightnvm, "Register as a LightNVM device");
 
+static bool blocking;
+module_param(blocking, bool, S_IRUGO);
+MODULE_PARM_DESC(blocking, "Register as a blocking blk-mq driver device");
+
 static int irqmode = NULL_IRQ_SOFTIRQ;
 
 static int null_set_irqmode(const char *str, const struct kernel_param *kp)
@@ -357,6 +361,8 @@ static int null_queue_rq(struct blk_mq_hw_ctx *hctx,
 {
 	struct nullb_cmd *cmd = blk_mq_rq_to_pdu(bd->rq);
 
+	might_sleep_if(hctx->flags & BLK_MQ_F_BLOCKING);
+
 	if (irqmode == NULL_IRQ_TIMER) {
 		hrtimer_init(&cmd->timer, CLOCK_MONOTONIC, HRTIMER_MODE_REL);
 		cmd->timer.function = null_cmd_timer_expired;
@@ -724,6 +730,9 @@ static int null_add_dev(void)
 		nullb->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 		nullb->tag_set.driver_data = nullb;
 
+		if (blocking)
+			nullb->tag_set.flags |= BLK_MQ_F_BLOCKING;
+
 		rv = blk_mq_alloc_tag_set(&nullb->tag_set);
 		if (rv)
 			goto out_cleanup_queues;
