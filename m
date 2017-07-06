Return-Path: <maxg@mellanox.com>
From: Max Gurtovoy <maxg@mellanox.com>
To: axboe@kernel.dk, linux-block@vger.kernel.org
Cc: Max Gurtovoy <maxg@mellanox.com>
Subject: [PATCH 1/1] null_blk: fix error flow for shared tags during module_init
Date: Thu,  6 Jul 2017 16:24:49 +0300
Message-Id: <1499347489-10863-1-git-send-email-maxg@mellanox.com>
List-ID: <linux-block@vger.kernel.org>

In case we use shared tags feature, blk_mq_alloc_tag_set might fail
during module initialization. Check the return value and default to run
without shared tag set before continuing. Also move the tagset
initialization process after defining the amount of submition queues.

Signed-off-by: Max Gurtovoy <maxg@mellanox.com>
---
 drivers/block/null_blk.c |   12 +++++++++---
 1 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 71f4422..0b7e7e1 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -844,9 +844,6 @@ static int __init null_init(void)
 		queue_mode = NULL_Q_MQ;
 	}
 
-	if (queue_mode == NULL_Q_MQ && shared_tags)
-		null_init_tag_set(&tag_set);
-
 	if (queue_mode == NULL_Q_MQ && use_per_node_hctx) {
 		if (submit_queues < nr_online_nodes) {
 			pr_warn("null_blk: submit_queues param is set to %u.",
@@ -858,6 +855,15 @@ static int __init null_init(void)
 	else if (!submit_queues)
 		submit_queues = 1;
 
+	if (queue_mode == NULL_Q_MQ && shared_tags) {
+		ret = null_init_tag_set(&tag_set);
+		if (ret) {
+			pr_warn("null_blk: Can't use shared tags %d\n", ret);
+			pr_warn("null_blk: defaults to non shared tags\n");
+			shared_tags = false;
+		}
+	}
+
 	mutex_init(&lock);
 
 	null_major = register_blkdev(0, "nullb");
-- 
1.7.1
