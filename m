Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: keith.busch@linux.intel.com, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] blk-mq: fallback to previous nr_hw_queues when updating fails
Date: Thu, 27 Sep 2018 18:43:04 +0800
Message-Id: <1538044984-2147-3-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1538044984-2147-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1538044984-2147-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

When we try to increate the nr_hw_queues, we may fail due to
shortage of memory or other reason, then blk_mq_realloc_hw_ctxs stops
and some entries in q->queue_hw_ctx are left with NULL. However,
because queue map has been updated with new nr_hw_queues, some cpus
have been mapped to hw queue which just encounters allocation failure,
thus blk_mq_map_queue could return NULL. This will cause panic in
following blk_mq_map_swqueue.

To fix it, let blk_mq_realloc_hw_ctxs return false to
skip blk_mq_map_swqueue and fallback to previous nr_hw_queues in
case of increasing nr_hw_queues failure.

Reported-by: syzbot+83e8cbe702263932d9d4@syzkaller.appspotmail.com
Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c | 40 +++++++++++++++++++++++++++++++++++-----
 1 file changed, 35 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 6356455..c867ede 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2503,10 +2503,10 @@ static int blk_mq_hw_ctx_size(struct blk_mq_tag_set *tag_set)
 	return hw_ctx_size;
 }
 
-static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
+static bool blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 						struct request_queue *q)
 {
-	int i, j;
+	int i, j, end;
 	struct blk_mq_hw_ctx **hctxs = q->queue_hw_ctx;
 
 	/* protect against switching io scheduler  */
@@ -2542,7 +2542,24 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 		}
 		blk_mq_hctx_kobj_init(hctxs[i]);
 	}
-	for (j = i; j < q->nr_hw_queues; j++) {
+
+	if (i != set->nr_hw_queues) {
+		/*
+		 * Increasing nr_hw_queues fails. Free the newly allocated
+		 * hctxs and keep the previous q->nr_hw_queues.
+		 */
+		j = q->nr_hw_queues;
+		end = i;
+	} else {
+		/*
+		 * If nr_hw_queues is decreased, free the redundant hctxs.
+		 */
+		j = i;
+		end = q->nr_hw_queues;
+		q->nr_hw_queues = set->nr_hw_queues;
+	}
+
+	for (; j < end; j++) {
 		struct blk_mq_hw_ctx *hctx = hctxs[j];
 
 		if (hctx) {
@@ -2554,8 +2571,9 @@ static void blk_mq_realloc_hw_ctxs(struct blk_mq_tag_set *set,
 
 		}
 	}
-	q->nr_hw_queues = i;
 	mutex_unlock(&q->sysfs_lock);
+
+	return (q->nr_hw_queues == set->nr_hw_queues);
 }
 
 struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
@@ -2939,6 +2957,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 {
 	struct request_queue *q;
 	LIST_HEAD(head);
+	int prev_nr_hw_queues;
 
 	lockdep_assert_held(&set->tag_list_lock);
 
@@ -2967,10 +2986,21 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_sysfs_unregister(q);
 	}
 
+	prev_nr_hw_queues = set->nr_hw_queues;
 	set->nr_hw_queues = nr_hw_queues;
+again:
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-		blk_mq_realloc_hw_ctxs(set, q);
+		/*
+		 * If increasing nr_hw_queues fail, fallback to previous
+		 * nr_hw_queues.
+		 */
+		if (!blk_mq_realloc_hw_ctxs(set, q)) {
+			pr_warn("updating nr_hw_queues to %d fails, fallback to %d.\n",
+					nr_hw_queues, prev_nr_hw_queues);
+			set->nr_hw_queues = prev_nr_hw_queues;
+			goto again;
+		}
 		blk_mq_map_swqueue(q);
 	}
 
-- 
2.7.4
