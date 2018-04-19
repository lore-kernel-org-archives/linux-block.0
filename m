Return-Path: <prvs=6401ab460=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Tejun Heo <tj@kernel.org>
Subject: [PATCH] block: Verify whether blk_queue_enter() is used when necessary
Date: Wed, 18 Apr 2018 17:53:15 -0700
Message-Id: <20180419005315.15908-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

It is required to protect blkg_lookup() calls with a blk_queue_enter() /
blk_queue_exit() pair. Since it is nontrivial to verify whether this is
the case, verify this at runtime. Only perform this verification if
CONFIG_LOCKDEP=y to avoid that unnecessary runtime overhead is added.
Introduce percpu_ref_is_positive() to avoid having to introduce a new
counter to make this verification possible.

Note: using lockdep to verify whether blkg_lookup() is protected
correctly is not possible since lock_acquire() and lock_release()
must be called from the same task and since blk_queue_enter() and
blk_queue_exit() can be called from different tasks.

Suggested-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
---
 block/blk-cgroup.c              |  2 ++
 block/blk-core.c                | 23 +++++++++++++++++++++++
 include/linux/blk-cgroup.h      |  2 ++
 include/linux/blkdev.h          | 11 +++++++++++
 include/linux/percpu-refcount.h | 26 ++++++++++++++++++++++++++
 5 files changed, 64 insertions(+)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 21bc449d01c0..82025728337c 100644
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
index 11882b509611..de90ecab61cd 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -695,6 +695,9 @@ EXPORT_SYMBOL_GPL(blk_queue_bypass_end);
 
 void blk_set_queue_dying(struct request_queue *q)
 {
+#ifdef CONFIG_PROVE_LOCKING
+	q->cleanup_queue_task = current;
+#endif
 	blk_queue_flag_set(QUEUE_FLAG_DYING, q);
 
 	/*
@@ -909,6 +912,24 @@ struct request_queue *blk_alloc_queue(gfp_t gfp_mask)
 }
 EXPORT_SYMBOL(blk_alloc_queue);
 
+#ifdef CONFIG_PROVE_LOCKING
+/**
+ * blk_entered_queue() - whether or not it is safe to access cgroup information
+ * @q: request queue pointer
+ *
+ * In order to avoid races between accessing cgroup information and the cgroup
+ * information removal from inside blk_cleanup_queue(), any code that accesses
+ * cgroup information must be protected by blk_queue_enter() and/or
+ * blk_queue_enter_live().
+ */
+bool blk_entered_queue(struct request_queue *q)
+{
+	return (blk_queue_dying(q) && current == q->cleanup_queue_task) ||
+		percpu_ref_is_positive(&q->q_usage_counter);
+}
+EXPORT_SYMBOL(blk_entered_queue);
+#endif
+
 /**
  * blk_queue_enter() - try to increase q->q_usage_counter
  * @q: request queue pointer
@@ -2267,6 +2288,8 @@ generic_make_request_checks(struct bio *bio)
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
index f486a984426d..b7681f3ee793 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -633,6 +633,9 @@ struct request_queue {
 
 	int			bypass_depth;
 	atomic_t		mq_freeze_depth;
+#ifdef CONFIG_PROVE_LOCKING
+	struct task_struct	*cleanup_queue_task;
+#endif
 
 #if defined(CONFIG_BLK_DEV_BSG)
 	bsg_job_fn		*bsg_job_fn;
@@ -988,6 +991,14 @@ extern int sg_scsi_ioctl(struct request_queue *, struct gendisk *, fmode_t,
 
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
index 009cdf3d65b6..acbc68cb0c54 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -331,4 +331,30 @@ static inline bool percpu_ref_is_zero(struct percpu_ref *ref)
 	return !atomic_long_read(&ref->count);
 }
 
+/**
+ * percpu_ref_is_positive - test whether a percpu refcount is strictly positive
+ * @ref: percpu_ref to test
+ *
+ * Returns %true if @ref > 0.
+ *
+ * This function is safe to call as long as @ref is between init and exit.
+ */
+static inline bool percpu_ref_is_positive(struct percpu_ref *ref)
+{
+	unsigned long __percpu *percpu_count;
+	unsigned long sum = 0;
+	int cpu;
+
+	rcu_read_lock_sched();
+	if (__ref_is_percpu(ref, &percpu_count)) {
+		for_each_possible_cpu(cpu)
+			sum += *per_cpu_ptr(percpu_count, cpu);
+	} else {
+		sum = atomic_long_read(&ref->count);
+	}
+	rcu_read_unlock_sched();
+
+	return sum > 0;
+}
+
 #endif
-- 
2.16.3
