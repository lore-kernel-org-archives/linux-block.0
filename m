Return-Path: <keith.busch@intel.com>
Date: Mon, 24 Sep 2018 13:13:48 -0600
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: "jianchao.wang" <jianchao.w.wang@oracle.com>,
	"linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
	Ming Lei <ming.lei@redhat.com>
Subject: Re: Regression caused by f5bbbbe4d635
Message-ID: <20180924191348.GB9223@localhost.localdomain>
References: <bae37c56-3f12-448d-cdb5-6ed2c2d069a4@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <bae37c56-3f12-448d-cdb5-6ed2c2d069a4@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

On Mon, Sep 24, 2018 at 12:44:13PM -0600, Jens Axboe wrote:
> Hi,
> 
> This commit introduced a rcu_read_lock() inside
> blk_mq_queue_tag_busy_iter() - this is problematic for the timout code,
> since we now end up holding the RCU read lock over the timeout code. As
> just one example, nvme ends up doing:
> 
> nvme_timeout()
> 	nvme_dev_disable()
> 		mutex_lock(&dev->shutdown_lock);
> 
> and things are then obviously unhappy...

Yah, there's never been a requirement that tag iterator callbacks be
non-blocking as far as I remember.

The queue's reference in blk_mq_timeout_work looks applicable to any
blk_mq_queue_tag_busy_iter user, so just moving it there looks like it
should do what f5bbbbe4d635 was trying to fix. 

---
diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index 94e1ed667b6e..850577a3de6d 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -320,18 +320,21 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
	struct blk_mq_hw_ctx *hctx;
	int i;
 
-	/*
-	 * __blk_mq_update_nr_hw_queues will update the nr_hw_queues and
-	 * queue_hw_ctx after freeze the queue. So we could use q_usage_counter
-	 * to avoid race with it. __blk_mq_update_nr_hw_queues will users
-	 * synchronize_rcu to ensure all of the users go out of the critical
-	 * section below and see zeroed q_usage_counter.
+	/* A deadlock might occur if a request is stuck requiring a
+	 * timeout at the same time a queue freeze is waiting
+	 * completion, since the timeout code would not be able to
+	 * acquire the queue reference here.
+	 *
+	 * That's why we don't use blk_queue_enter here; instead, we use
+	 * percpu_ref_tryget directly, because we need to be able to
+	 * obtain a reference even in the short window between the queue
+	 * starting to freeze, by dropping the first reference in
+	 * blk_freeze_queue_start, and the moment the last request is
+	 * consumed, marked by the instant q_usage_counter reaches
+	 * zero.
	 */
-	rcu_read_lock();
-	if (percpu_ref_is_zero(&q->q_usage_counter)) {
-		rcu_read_unlock();
+	if (!percpu_ref_tryget(&q->q_usage_counter))
		return;
-	}
 
	queue_for_each_hw_ctx(q, hctx, i) {
		struct blk_mq_tags *tags = hctx->tags;
@@ -347,7 +350,7 @@ void blk_mq_queue_tag_busy_iter(struct request_queue *q, busy_iter_fn *fn,
			bt_for_each(hctx, &tags->breserved_tags, fn, priv, true);
		bt_for_each(hctx, &tags->bitmap_tags, fn, priv, false);
	}
-	rcu_read_unlock();
+	blk_queue_exit(q);
 }
 
 static int bt_alloc(struct sbitmap_queue *bt, unsigned int depth,
diff --git a/block/blk-mq.c b/block/blk-mq.c
index 85a1c1a59c72..28d128450621 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -848,22 +848,6 @@ static void blk_mq_timeout_work(struct work_struct *work)
	struct blk_mq_hw_ctx *hctx;
	int i;
 
-	/* A deadlock might occur if a request is stuck requiring a
-	 * timeout at the same time a queue freeze is waiting
-	 * completion, since the timeout code would not be able to
-	 * acquire the queue reference here.
-	 *
-	 * That's why we don't use blk_queue_enter here; instead, we use
-	 * percpu_ref_tryget directly, because we need to be able to
-	 * obtain a reference even in the short window between the queue
-	 * starting to freeze, by dropping the first reference in
-	 * blk_freeze_queue_start, and the moment the last request is
-	 * consumed, marked by the instant q_usage_counter reaches
-	 * zero.
-	 */
-	if (!percpu_ref_tryget(&q->q_usage_counter))
-		return;
-
	blk_mq_queue_tag_busy_iter(q, blk_mq_check_expired, &next);
 
	if (next != 0) {
@@ -881,7 +865,6 @@ static void blk_mq_timeout_work(struct work_struct *work)
				blk_mq_tag_idle(hctx);
		}
	}
-	blk_queue_exit(q);
 }
 
 struct flush_busy_ctx_data {
@@ -2974,10 +2957,7 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 
	list_for_each_entry(q, &set->tag_list, tag_set_list)
		blk_mq_freeze_queue(q);
-	/*
-	 * Sync with blk_mq_queue_tag_busy_iter.
-	 */
-	synchronize_rcu();
+
	/*
	 * Switch IO scheduler to 'none', cleaning up the data associated
	 * with the previous scheduler. We will switch back once we are done
--
