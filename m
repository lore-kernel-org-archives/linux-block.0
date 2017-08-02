Return-Path: <zhangweiping@didichuxing.com>
Date: Thu, 3 Aug 2017 00:26:39 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>
Subject: [PATCH 1/2] null_blk: simplify logic for use_per_node_hctx
Message-ID: <20170802162634.GA30506@bogon.didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Return-Path: zhangweiping@didichuxing.com
List-ID: <linux-block@vger.kernel.org>

make sure submit_queues equal nr_online_nodes.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 drivers/block/null_blk.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 85c24ca..72e2bc5 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -733,9 +733,6 @@ static int null_add_dev(void)
 
 	spin_lock_init(&nullb->lock);
 
-	if (queue_mode == NULL_Q_MQ && use_per_node_hctx)
-		submit_queues = nr_online_nodes;
-
 	rv = setup_queues(nullb);
 	if (rv)
 		goto out_free_nullb;
@@ -845,8 +842,8 @@ static int __init null_init(void)
 	}
 
 	if (queue_mode == NULL_Q_MQ && use_per_node_hctx) {
-		if (submit_queues < nr_online_nodes) {
-			pr_warn("null_blk: submit_queues param is set to %u.",
+		if (submit_queues != nr_online_nodes) {
+			pr_warn("null_blk: submit_queues param is set to %u.\n",
 							nr_online_nodes);
 			submit_queues = nr_online_nodes;
 		}
-- 
2.9.4
