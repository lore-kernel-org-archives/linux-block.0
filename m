Return-Path: <prvs=11458901a0=axboe@fb.com>
From: Jens Axboe <axboe@fb.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <paolo.valente@linaro.org>, Jens Axboe <axboe@fb.com>
Subject: [PATCH 7/7] null_blk: add parameters to ask for mq-sched and write cache
Date: Fri, 2 Dec 2016 20:15:21 -0700
Message-ID: <1480734921-23701-8-git-send-email-axboe@fb.com>
In-Reply-To: <1480734921-23701-1-git-send-email-axboe@fb.com>
References: <1480734921-23701-1-git-send-email-axboe@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Jens Axboe <axboe@fb.com>
---
 drivers/block/null_blk.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 4943ee22716e..f2726936cd1a 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -117,6 +117,14 @@ static bool use_lightnvm;
 module_param(use_lightnvm, bool, S_IRUGO);
 MODULE_PARM_DESC(use_lightnvm, "Register as a LightNVM device");
 
+static bool use_sched;
+module_param(use_sched, bool, S_IRUGO);
+MODULE_PARM_DESC(use_sched, "Ask for blk-mq scheduling");
+
+static bool wc;
+module_param(wc, bool, S_IRUGO);
+MODULE_PARM_DESC(use_sched, "Claim volatile write cache");
+
 static int irqmode = NULL_IRQ_SOFTIRQ;
 
 static int null_set_irqmode(const char *str, const struct kernel_param *kp)
@@ -724,6 +732,9 @@ static int null_add_dev(void)
 		nullb->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
 		nullb->tag_set.driver_data = nullb;
 
+		if (use_sched)
+			nullb->tag_set.flags |= BLK_MQ_F_SQ_SCHED;
+
 		rv = blk_mq_alloc_tag_set(&nullb->tag_set);
 		if (rv)
 			goto out_cleanup_queues;
@@ -760,6 +771,9 @@ static int null_add_dev(void)
 	queue_flag_set_unlocked(QUEUE_FLAG_NONROT, nullb->q);
 	queue_flag_clear_unlocked(QUEUE_FLAG_ADD_RANDOM, nullb->q);
 
+	if (wc)
+		blk_queue_write_cache(nullb->q, true, false);
+
 	mutex_lock(&lock);
 	nullb->index = nullb_indexes++;
 	mutex_unlock(&lock);
-- 
2.7.4
