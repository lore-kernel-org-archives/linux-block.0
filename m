Return-Path: <bvanassche@acm.org>
From: Bart Van Assche <bvanassche@acm.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Tejun Heo <tj@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v10 5/8] percpu-refcount: Introduce percpu_ref_resurrect()
Date: Fri, 21 Sep 2018 13:31:19 -0700
Message-Id: <20180921203122.49743-6-bvanassche@acm.org>
In-Reply-To: <20180921203122.49743-1-bvanassche@acm.org>
References: <20180921203122.49743-1-bvanassche@acm.org>
MIME-Version: 1.0
List-ID: <linux-block@vger.kernel.org>

This function will be used in a later patch to switch the struct
request_queue q_usage_counter from killed back to live. In contrast
to percpu_ref_reinit(), this new function does not require that the
refcount is zero.

Signed-off-by: Bart Van Assche <bvanassche@acm.org>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 include/linux/percpu-refcount.h |  1 +
 lib/percpu-refcount.c           | 28 ++++++++++++++++++++++++++--
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 009cdf3d65b6..b297cd1cd4f1 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -108,6 +108,7 @@ void percpu_ref_switch_to_atomic_sync(struct percpu_ref *ref);
 void percpu_ref_switch_to_percpu(struct percpu_ref *ref);
 void percpu_ref_kill_and_confirm(struct percpu_ref *ref,
 				 percpu_ref_func_t *confirm_kill);
+void percpu_ref_resurrect(struct percpu_ref *ref);
 void percpu_ref_reinit(struct percpu_ref *ref);
 
 /**
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 9f96fa7bc000..17fe3e996ddc 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -356,11 +356,35 @@ EXPORT_SYMBOL_GPL(percpu_ref_kill_and_confirm);
  */
 void percpu_ref_reinit(struct percpu_ref *ref)
 {
+	WARN_ON_ONCE(!percpu_ref_is_zero(ref));
+
+	percpu_ref_resurrect(ref);
+}
+EXPORT_SYMBOL_GPL(percpu_ref_reinit);
+
+/**
+ * percpu_ref_resurrect - modify a percpu refcount from dead to live
+ * @ref: perpcu_ref to resurrect
+ *
+ * Modify @ref so that it's in the same state as before percpu_ref_kill() was
+ * called. @ref must have be dead but not exited.
+ *
+ * If @ref->release() frees @ref then the caller is responsible for
+ * guaranteeing that @ref->release() does not get called while this
+ * function is in progress.
+ *
+ * Note that percpu_ref_tryget[_live]() are safe to perform on @ref while
+ * this function is in progress.
+ */
+void percpu_ref_resurrect(struct percpu_ref *ref)
+{
+	unsigned long __percpu *percpu_count;
 	unsigned long flags;
 
 	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
 
-	WARN_ON_ONCE(!percpu_ref_is_zero(ref));
+	WARN_ON_ONCE(!(ref->percpu_count_ptr & __PERCPU_REF_DEAD));
+	WARN_ON_ONCE(__ref_is_percpu(ref, &percpu_count));
 
 	ref->percpu_count_ptr &= ~__PERCPU_REF_DEAD;
 	percpu_ref_get(ref);
@@ -368,4 +392,4 @@ void percpu_ref_reinit(struct percpu_ref *ref)
 
 	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
 }
-EXPORT_SYMBOL_GPL(percpu_ref_reinit);
+EXPORT_SYMBOL_GPL(percpu_ref_resurrect);
-- 
2.19.0.444.g18242da7ef-goog
