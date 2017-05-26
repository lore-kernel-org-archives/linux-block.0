Return-Path: <johngong0791@gmail.com>
Return-Path: <johngong0791@gmail.com>
From: "john.gong" <johngong0791@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Tejun Heo <tj@kernel.org>,
	linux-block@vger.kernel.org,
	"john.gong" <johngong0791@gmail.com>
Subject: [PATCH 1/1] block: use the effective nr_hw_queues
Date: Fri, 26 May 2017 16:11:39 +0800
Message-Id: <1495786299-9020-1-git-send-email-johngong0791@gmail.com>
List-ID: <linux-block@vger.kernel.org>

in blk_mq_realloc_hw_ctxs(set, q) set the effective nr_hw_queues,
so use this to set the local node in blk_mq_init_cpu_queues.

Signed-off-by: john.gong <johngong0791@gmail.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a69ad12..7a97a7d 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2339,7 +2339,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	if (set->ops->complete)
 		blk_queue_softirq_done(q, set->ops->complete);
 
-	blk_mq_init_cpu_queues(q, set->nr_hw_queues);
+	blk_mq_init_cpu_queues(q, q->nr_hw_queues);
 
 	get_online_cpus();
 	mutex_lock(&all_q_mutex);
-- 
1.9.1
