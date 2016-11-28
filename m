Return-Path: <krisman@linux.vnet.ibm.com>
From: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org5,
        Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>,
        Ming Lei <ming.lei@canonical.com>
Subject: [PATCH] blk-mq: Drop explicit timeout sync in hotplug
Date: Mon, 28 Nov 2016 14:48:05 -0200
Message-Id: <1480351685-3369-1-git-send-email-krisman@linux.vnet.ibm.com>
List-ID: <linux-block@vger.kernel.org>

After commit 287922eb0b18 ("block: defer timeouts to a workqueue"),
deleting the timeout work after freezing the queue shouldn't be
necessary, since the synchronization is already enforced by the
acquisition of a q_usage_counter reference in blk_mq_timeout_work.

Signed-off-by: Gabriel Krisman Bertazi <krisman@linux.vnet.ibm.com>
Cc: Ming Lei <ming.lei@canonical.com>
---
 block/blk-mq.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 9d4a1d630d0b..bac12caece06 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2220,16 +2220,9 @@ static void blk_mq_queue_reinit_work(void)
 	 */
 	list_for_each_entry(q, &all_q_list, all_q_node)
 		blk_mq_freeze_queue_start(q);
-	list_for_each_entry(q, &all_q_list, all_q_node) {
+	list_for_each_entry(q, &all_q_list, all_q_node)
 		blk_mq_freeze_queue_wait(q);
 
-		/*
-		 * timeout handler can't touch hw queue during the
-		 * reinitialization
-		 */
-		del_timer_sync(&q->timeout);
-	}
-
 	list_for_each_entry(q, &all_q_list, all_q_node)
 		blk_mq_queue_reinit(q, &cpuhp_online_new);
 
-- 
2.7.4
