Return-Path: <prvs=590d2a92c=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Hannes Reinecke <hare@suse.de>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 02/11] block: Use the queue_flag_*() functions instead of open-coding these
Date: Wed, 28 Feb 2018 11:28:14 -0800
Message-Id: <20180228192823.5191-3-bart.vanassche@wdc.com>
In-Reply-To: <20180228192823.5191-1-bart.vanassche@wdc.com>
References: <20180228192823.5191-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Except for changing the atomic queue flag manipulations that are
protected by the queue lock into non-atomic manipulations, this
patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Hannes Reinecke <hare@suse.de>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Ming Lei <ming.lei@redhat.com>
---
 block/blk-core.c     | 2 +-
 block/blk-mq.c       | 2 +-
 block/blk-settings.c | 4 ++--
 block/blk-stat.c     | 6 +++---
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 9d95b2e7c289..1d6b4b0545aa 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -995,7 +995,7 @@ struct request_queue *blk_alloc_queue_node(gfp_t gfp_mask, int node_id,
 	 * registered by blk_register_queue().
 	 */
 	q->bypass_depth = 1;
-	__set_bit(QUEUE_FLAG_BYPASS, &q->queue_flags);
+	queue_flag_set_unlocked(QUEUE_FLAG_BYPASS, q);
 
 	init_waitqueue_head(&q->mq_freeze_wq);
 
diff --git a/block/blk-mq.c b/block/blk-mq.c
index c60408138be6..96baa6511c1e 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2696,7 +2696,7 @@ struct request_queue *blk_mq_init_allocated_queue(struct blk_mq_tag_set *set,
 	q->queue_flags |= QUEUE_FLAG_MQ_DEFAULT;
 
 	if (!(set->flags & BLK_MQ_F_SG_MERGE))
-		q->queue_flags |= 1 << QUEUE_FLAG_NO_SG_MERGE;
+		queue_flag_set_unlocked(QUEUE_FLAG_NO_SG_MERGE, q);
 
 	q->sg_reserved_size = INT_MAX;
 
diff --git a/block/blk-settings.c b/block/blk-settings.c
index 48ebe6be07b7..7f719da0eadd 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -861,9 +861,9 @@ void blk_queue_flush_queueable(struct request_queue *q, bool queueable)
 {
 	spin_lock_irq(q->queue_lock);
 	if (queueable)
-		clear_bit(QUEUE_FLAG_FLUSH_NQ, &q->queue_flags);
+		queue_flag_clear(QUEUE_FLAG_FLUSH_NQ, q);
 	else
-		set_bit(QUEUE_FLAG_FLUSH_NQ, &q->queue_flags);
+		queue_flag_set(QUEUE_FLAG_FLUSH_NQ, q);
 	spin_unlock_irq(q->queue_lock);
 }
 EXPORT_SYMBOL_GPL(blk_queue_flush_queueable);
diff --git a/block/blk-stat.c b/block/blk-stat.c
index 28003bf9941c..b664aa6df725 100644
--- a/block/blk-stat.c
+++ b/block/blk-stat.c
@@ -152,7 +152,7 @@ void blk_stat_add_callback(struct request_queue *q,
 
 	spin_lock(&q->stats->lock);
 	list_add_tail_rcu(&cb->list, &q->stats->callbacks);
-	set_bit(QUEUE_FLAG_STATS, &q->queue_flags);
+	queue_flag_set(QUEUE_FLAG_STATS, q);
 	spin_unlock(&q->stats->lock);
 }
 EXPORT_SYMBOL_GPL(blk_stat_add_callback);
@@ -163,7 +163,7 @@ void blk_stat_remove_callback(struct request_queue *q,
 	spin_lock(&q->stats->lock);
 	list_del_rcu(&cb->list);
 	if (list_empty(&q->stats->callbacks) && !q->stats->enable_accounting)
-		clear_bit(QUEUE_FLAG_STATS, &q->queue_flags);
+		queue_flag_clear(QUEUE_FLAG_STATS, q);
 	spin_unlock(&q->stats->lock);
 
 	del_timer_sync(&cb->timer);
@@ -191,7 +191,7 @@ void blk_stat_enable_accounting(struct request_queue *q)
 {
 	spin_lock(&q->stats->lock);
 	q->stats->enable_accounting = true;
-	set_bit(QUEUE_FLAG_STATS, &q->queue_flags);
+	queue_flag_set(QUEUE_FLAG_STATS, q);
 	spin_unlock(&q->stats->lock);
 }
 
-- 
2.16.2
