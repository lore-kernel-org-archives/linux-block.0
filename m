Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk
Cc: tom.leiming@gmail.com, bart.vanassche@wdc.com, keith.busch@linux.intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] blk-mq: init hctx sched after update cpu & nr_hw_queues mapping
Date: Wed, 15 Aug 2018 15:25:14 +0800
Message-Id: <1534317915-5041-2-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1534317915-5041-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1534317915-5041-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

Kyber depends on the mapping between cpu and nr_hw_queues. When
update nr_hw_queues, elevator_type->ops.mq.init_hctx will be
invoked before the mapping is adapted correctly, this would cause
terrible result. A simply way to fix this is switch the io scheduler
to none before update the nr_hw_queues, and then get it back after
update nr_hw_queues. To achieve this, we add a new member elv_type
in request_queue to save the original elevator and adapt and export
elevator_switch_mq.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 block/blk-mq.c         | 37 +++++++++++++++++++++++++++++--------
 block/blk.h            |  2 ++
 block/elevator.c       | 20 ++++++++++++--------
 include/linux/blkdev.h |  3 +++
 4 files changed, 46 insertions(+), 16 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 5efd789..89904cc 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -112,6 +112,7 @@ void blk_mq_in_flight(struct request_queue *q, struct hd_struct *part,
 	struct mq_inflight mi = { .part = part, .inflight = inflight, };
 
 	inflight[0] = inflight[1] = 0;
+
 	blk_mq_queue_tag_busy_iter(q, blk_mq_check_inflight, &mi);
 }
 
@@ -2147,8 +2148,6 @@ static void blk_mq_exit_hctx(struct request_queue *q,
 	if (set->ops->exit_request)
 		set->ops->exit_request(set, hctx->fq->flush_rq, hctx_idx);
 
-	blk_mq_sched_exit_hctx(q, hctx, hctx_idx);
-
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
 
@@ -2216,12 +2215,9 @@ static int blk_mq_init_hctx(struct request_queue *q,
 	    set->ops->init_hctx(hctx, set->driver_data, hctx_idx))
 		goto free_bitmap;
 
-	if (blk_mq_sched_init_hctx(q, hctx, hctx_idx))
-		goto exit_hctx;
-
 	hctx->fq = blk_alloc_flush_queue(q, hctx->numa_node, set->cmd_size);
 	if (!hctx->fq)
-		goto sched_exit_hctx;
+		goto exit_hctx;
 
 	if (blk_mq_init_request(set, hctx->fq->flush_rq, hctx_idx, node))
 		goto free_fq;
@@ -2235,8 +2231,6 @@ static int blk_mq_init_hctx(struct request_queue *q,
 
  free_fq:
 	kfree(hctx->fq);
- sched_exit_hctx:
-	blk_mq_sched_exit_hctx(q, hctx, hctx_idx);
  exit_hctx:
 	if (set->ops->exit_hctx)
 		set->ops->exit_hctx(hctx, hctx_idx);
@@ -2913,6 +2907,25 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_freeze_queue(q);
 
+	/*
+	 * switch io scheduler to NULL to clean up the data in it.
+	 * will get it back after update mapping between cpu and hw queues.
+	 */
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		if (!q->elevator) {
+			q->elv_type = NULL;
+			continue;
+		}
+		q->elv_type = q->elevator->type;
+		mutex_lock(&q->sysfs_lock);
+		/*
+		 * elevator_release will put it.
+		 */
+		__module_get(q->elv_type->elevator_owner);
+		elevator_switch_mq(q, NULL);
+		mutex_unlock(&q->sysfs_lock);
+	}
+
 	set->nr_hw_queues = nr_hw_queues;
 	blk_mq_update_queue_map(set);
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
@@ -2920,6 +2933,14 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_queue_reinit(q);
 	}
 
+	list_for_each_entry(q, &set->tag_list, tag_set_list) {
+		if (!q->elv_type)
+			continue;
+
+		mutex_lock(&q->sysfs_lock);
+		elevator_switch_mq(q, q->elv_type);
+		mutex_unlock(&q->sysfs_lock);
+	}
 	list_for_each_entry(q, &set->tag_list, tag_set_list)
 		blk_mq_unfreeze_queue(q);
 }
diff --git a/block/blk.h b/block/blk.h
index d4d67e9..0c9bc8d 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -234,6 +234,8 @@ static inline void elv_deactivate_rq(struct request_queue *q, struct request *rq
 
 int elevator_init(struct request_queue *);
 int elevator_init_mq(struct request_queue *q);
+int elevator_switch_mq(struct request_queue *q,
+			      struct elevator_type *new_e);
 void elevator_exit(struct request_queue *, struct elevator_queue *);
 int elv_register_queue(struct request_queue *q);
 void elv_unregister_queue(struct request_queue *q);
diff --git a/block/elevator.c b/block/elevator.c
index fa828b5..5ea6e7d 100644
--- a/block/elevator.c
+++ b/block/elevator.c
@@ -933,16 +933,13 @@ void elv_unregister(struct elevator_type *e)
 }
 EXPORT_SYMBOL_GPL(elv_unregister);
 
-static int elevator_switch_mq(struct request_queue *q,
+int elevator_switch_mq(struct request_queue *q,
 			      struct elevator_type *new_e)
 {
 	int ret;
 
 	lockdep_assert_held(&q->sysfs_lock);
 
-	blk_mq_freeze_queue(q);
-	blk_mq_quiesce_queue(q);
-
 	if (q->elevator) {
 		if (q->elevator->registered)
 			elv_unregister_queue(q);
@@ -968,8 +965,6 @@ static int elevator_switch_mq(struct request_queue *q,
 		blk_add_trace_msg(q, "elv switch: none");
 
 out:
-	blk_mq_unquiesce_queue(q);
-	blk_mq_unfreeze_queue(q);
 	return ret;
 }
 
@@ -1021,8 +1016,17 @@ static int elevator_switch(struct request_queue *q, struct elevator_type *new_e)
 
 	lockdep_assert_held(&q->sysfs_lock);
 
-	if (q->mq_ops)
-		return elevator_switch_mq(q, new_e);
+	if (q->mq_ops) {
+		blk_mq_freeze_queue(q);
+		blk_mq_quiesce_queue(q);
+
+		err = elevator_switch_mq(q, new_e);
+
+		blk_mq_unquiesce_queue(q);
+		blk_mq_unfreeze_queue(q);
+
+		return err;
+	}
 
 	/*
 	 * Turn on BYPASS and drain all requests w/ elevator private data.
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d6869e0..ee930c4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -437,6 +437,9 @@ struct request_queue {
 	struct list_head	queue_head;
 	struct request		*last_merge;
 	struct elevator_queue	*elevator;
+
+	/* used when update nr_hw_queues */
+	struct elevator_type	*elv_type;
 	int			nr_rqs[2];	/* # allocated [a]sync rqs */
 	int			nr_rqs_elvpriv;	/* # allocated rqs w/ elvpriv */
 
-- 
2.7.4
