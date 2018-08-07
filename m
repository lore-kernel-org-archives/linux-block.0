Return-Path: <prvs=750bc9d11=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Tejun Heo <tj@kernel.org>,
	Ming Lei <ming.lei@redhat.com>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Hannes Reinecke <hare@suse.com>,
	Johannes Thumshirn <jthumshirn@suse.de>,
	Alan Stern <stern@rowland.harvard.edu>
Subject: [PATCH v5 4/9] percpu-refcount: Introduce percpu_ref_is_in_use()
Date: Tue,  7 Aug 2018 15:51:28 -0700
Message-Id: <20180807225133.27221-5-bart.vanassche@wdc.com>
In-Reply-To: <20180807225133.27221-1-bart.vanassche@wdc.com>
References: <20180807225133.27221-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Introduce a function that allows to determine whether a per-cpu refcount
is in use. This function will be used in a later patch to determine
whether or not any block layer requests are being executed.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Hannes Reinecke <hare@suse.com>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Alan Stern <stern@rowland.harvard.edu>
---
 include/linux/percpu-refcount.h |  2 ++
 lib/percpu-refcount.c           | 40 +++++++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 009cdf3d65b6..dd247756d634 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -331,4 +331,6 @@ static inline bool percpu_ref_is_zero(struct percpu_ref *ref)
 	return !atomic_long_read(&ref->count);
 }
 
+bool percpu_ref_is_in_use(struct percpu_ref *ref);
+
 #endif
diff --git a/lib/percpu-refcount.c b/lib/percpu-refcount.c
index 9f96fa7bc000..1dcb47e2c561 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -369,3 +369,43 @@ void percpu_ref_reinit(struct percpu_ref *ref)
 	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_reinit);
+
+/**
+ * percpu_ref_is_in_use - verify whether or not a percpu refcount is in use
+ * @ref: percpu_ref to test
+ *
+ * For a percpu refcount that is in percpu-mode, verify whether the reference
+ * count is above one. For a percpu refcount that is in atomic mode, verify
+ * whether the reference count is above zero. This function allows to verify
+ * whether any references are held on a percpu refcount that is switched
+ * between atomic and percpu mode with percpu_ref_reinit() /
+ * percpu_ref_kill().
+ *
+ * This function is safe to call as long as @ref is between init and exit. It
+ * is the responsibility of the caller to handle percpu_ref_get() and
+ * percpu_ref_put() calls that occur concurrently with this function.
+ */
+bool percpu_ref_is_in_use(struct percpu_ref *ref)
+{
+	unsigned long __percpu *percpu_count;
+	unsigned long sum = 0;
+	int cpu;
+	unsigned long flags;
+
+	/* Obtain percpu_ref_switch_lock to serialize against mode switches. */
+	spin_lock_irqsave(&percpu_ref_switch_lock, flags);
+	rcu_read_lock_sched();
+	if (__ref_is_percpu(ref, &percpu_count)) {
+		for_each_possible_cpu(cpu)
+			sum += *per_cpu_ptr(percpu_count, cpu);
+	}
+	rcu_read_unlock_sched();
+	sum += atomic_long_read(&ref->count);
+	sum &= ~PERCPU_COUNT_BIAS;
+	sum += (ref->percpu_count_ptr & __PERCPU_REF_DEAD);
+	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
+
+	WARN_ON_ONCE(sum == 0);
+	return sum > 1;
+}
+EXPORT_SYMBOL_GPL(percpu_ref_is_in_use);
-- 
2.18.0
