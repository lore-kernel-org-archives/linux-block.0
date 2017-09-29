Return-Path: <zhangweiping@didichuxing.com>
Date: Sat, 30 Sep 2017 01:09:57 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH] null_blk: add "no_sched" module parameter
Message-ID: <20170929170951.GA18535@localhost.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

add an option that disable io scheduler for null block device.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 drivers/block/null_blk.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index bd92286..3c63863 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -154,6 +154,10 @@ enum {
 	NULL_Q_MQ		= 2,
 };
 
+static int g_no_sched;
+module_param_named(no_sched, g_no_sched, int, S_IRUGO);
+MODULE_PARM_DESC(no_sched, "No io scheduler");
+
 static int g_submit_queues = 1;
 module_param_named(submit_queues, g_submit_queues, int, S_IRUGO);
 MODULE_PARM_DESC(submit_queues, "Number of submission queues");
@@ -1753,7 +1757,7 @@ static int null_init_tag_set(struct nullb *nullb, struct blk_mq_tag_set *set)
 						g_hw_queue_depth;
 	set->numa_node = nullb ? nullb->dev->home_node : g_home_node;
 	set->cmd_size	= sizeof(struct nullb_cmd);
-	set->flags = BLK_MQ_F_SHOULD_MERGE;
+	set->flags = g_no_sched ? BLK_MQ_F_NO_SCHED : BLK_MQ_F_SHOULD_MERGE;
 	set->driver_data = NULL;
 
 	if ((nullb && nullb->dev->blocking) || g_blocking)
-- 
2.9.4
