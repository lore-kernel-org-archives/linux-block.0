Return-Path: <prvs=672e5e3bd=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH] block: Verify whether blk_queue_enter() is used when necessary
Date: Mon, 21 May 2018 11:11:27 -0700
Message-Id: <20180521181127.11919-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

It is required to protect blkg_lookup() calls with a blk_queue_enter() /
blk_queue_exit() pair. Since it is nontrivial to verify whether this is
the case, verify this at runtime. Only perform this verification if
CONFIG_LOCKDEP=y to avoid that unnecessary runtime overhead is added.

Note: using lockdep to verify whether blkg_lookup() is protected
correctly is not possible since lock_acquire() and lock_release()
must be called from the same task and since blk_queue_enter() and
blk_queue_exit() can be called from different tasks.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c              |  2 ++
 block/blk-core.c                | 24 ++++++++++++++++++++++++
 include/linux/blk-cgroup.h      |  2 ++
 include/linux/blkdev.h          | 11 +++++++++++
 include/linux/percpu-refcount.h |  2 ++
 lib/percpu-refcount.c           | 25 +++++++++++++++++++++++++
 6 files changed, 66 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index eb85cb87c40f..78822dcfa0da 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -145,6 +145,8 @@ struct blkcg_gq *blkg_lookup_slowpath(struct blkcg *blkcg,
 {
 	struct blkcg_gq *blkg;
 
+	WARN_ON_ONCE(!blk_entered_queue(q));
+
 	/*
 	 * Hint didn't match.  Look up from the radix tree.  Note that the
 	 * hint can only be updated under queue_lock as otherwise @blkg
diff --git a/block/blk-core.c b/block/blk-core.c
index 8b9e5dc882f4..b6fa6a9f7daa 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -687,6 +687,9 @@ EXPORT_SYMBOL_GPL(blk_queue_bypass_end);
 
 void blk_set_queue_dying(struct request_queue *q)
 {
+#ifdef CONFIG_PROVE_LOCKING
+	q->cleanup_queue_task = current;
+#endif
 	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
 
 	/*
@@ -907,6 +910,25 @@ struct request_queue *blk_alloc_queue(gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(blk_alloc_queue);
 
+#ifdef CONFIG_PROVE_LOCKING
+/**
+ * blk_entered_queue() - whether or not it is safe to access cgroup information
+ * @q: request queue pointer
+ *
+ * In order to avoid races between accessing cgroup information and the cgroup
+ * information removal from inside blk_cleanup_queue(), any code that accesses
+ * cgroup information must either be protected by blk_queue_enter() and/or
+ * blk_queue_enter_live() or must be called after the queue has been marked
+ * dying from the same task that called blk_cleanup_queue().
+ */
+bool blk_entered_queue(struct request_queue *q)
+{
+	return (blk_queue_dying(q) && current == q->cleanup_queue_task) ||
+		percpu_ref_read(&q->q_usage_counter) > 0;
+}
+EXPORT_SYMBOL(blk_entered_queue);
+#endif
+
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
@@ -2254,6 +2276,8 @@ generic_make_request_checks(struct bio *bio)
 		goto end_io;
 	}
 
+	WARN_ON_ONCE(!blk_entered_queue(q));
+
 	/*
 	 * For a REQ_NOWAIT based request, return -EOPNOTSUPP
 	 * if queue is not a request based queue.
diff --git a/include/linux/blk-cgroup.h b/include/linux/blk-cgroup.h
index 6c666fd7de3c..3b8512c259aa 100644
--- a/include/linux/blk-cgroup.h
+++ b/include/linux/blk-cgroup.h
@@ -266,6 +266,8 @@ static inline struct blkcg_gq *__blkg_lookup(struct blkcg *blkcg,
 {
 	struct blkcg_gq *blkg;
 
+	WARN_ON_ONCE(!blk_entered_queue(q));
+
 	if (blkcg == &blkcg_root)
 		return q->root_blkg;
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 780e4ea80d4d..0ed23677c36f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -649,6 +649,9 @@ struct request_queue {
 
 	int			bypass_depth;
 	atomic_t		mq_freeze_depth;
+#ifdef CONFIG_PROVE_LOCKING
+	struct task_struct	*cleanup_queue_task;
+#endif
 
 #if defined(CONFIG_BLK_DEV_BSG)
 	bsg_job_fn		*bsg_job_fn;
@@ -1000,6 +1003,14 @@ extern int sg_scsi_ioctl(struct request_queue *, struct gendisk *, fmode_t,
 
 extern int blk_queue_enter(struct request_queue *q, blk_mq_req_flags_t flags);
 extern void blk_queue_exit(struct request_queue *q);
+#ifdef CONFIG_PROVE_LOCKING
+extern bool blk_entered_queue(struct request_queue *q);
+#else
+static inline bool blk_entered_queue(struct request_queue *q)
+{
+	return true;
+}
+#endif
 extern void blk_start_queue(struct request_queue *q);
 extern void blk_start_queue_async(struct request_queue *q);
 extern void blk_stop_queue(struct request_queue *q);
diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 009cdf3d65b6..5707289ba828 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -331,4 +331,6 @@ static inline bool percpu_ref_is_zero(struct percpu_ref *ref)
 	return !atomic_long_read(&ref->count);
 }
 
+unsigned long percpu_ref_read(struct percpu_ref *ref);
+
 #endif
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 9f96fa7bc000..094c6c0b446e 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -369,3 +369,28 @@ void percpu_ref_reinit(struct percpu_ref *ref)
 	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_reinit);
+
+/**
+ * percpu_ref_read - read a percpu refcount
+ * @ref: percpu_ref to test
+ *
+ * This function is safe to call as long as @ref is between init and exit.
+ */
+unsigned long percpu_ref_read(struct percpu_ref *ref)
+{
+	unsigned long __percpu *percpu_count;
+	unsigned long sum = 0;
+	int cpu;
+
+	rcu_read_lock_sched();
+	if (__ref_is_percpu(ref, &percpu_count)) {
+		for_each_possible_cpu(cpu)
+			sum += *per_cpu_ptr(percpu_count, cpu);
+	}
+	rcu_read_unlock_sched();
+	sum += atomic_long_read(&ref->count);
+	sum &= ~PERCPU_COUNT_BIAS;
+
+	return sum;
+}
+EXPORT_SYMBOL_GPL(percpu_ref_read);
-- 
2.16.3
