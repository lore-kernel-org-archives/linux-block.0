Return-Path: <prvs=7477a5644=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>,
	Tejun Heo <tj@kernel.org>,
	Jianchao Wang <jianchao.w.wang@oracle.com>,
	Ming Lei <ming.lei@redhat.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	Johannes Thumshirn <jthumshirn@suse.de>
Subject: [PATCH v4 06/10] percpu-refcount: Introduce percpu_ref_read()
Date: Fri,  3 Aug 2018 17:03:21 -0700
Message-Id: <20180804000325.3610-7-bart.vanassche@wdc.com>
In-Reply-To: <20180804000325.3610-1-bart.vanassche@wdc.com>
References: <20180804000325.3610-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Introduce a function that allows to read the value of a per-cpu counter.
This function will be used in the next patch to check whether a per-cpu
counter has the value one.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Cc: Tejun Heo <tj@kernel.org>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jianchao Wang <jianchao.w.wang@oracle.com>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Alan Stern <stern@rowland.harvard.edu>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
---
 include/linux/percpu-refcount.h |  2 ++
 lib/percpu-refcount.c           | 29 +++++++++++++++++++++++++++++
 2 files changed, 31 insertions(+)

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
index 9f96fa7bc000..c0b9fc8efa6b 100644
--- a/lib/percpu-refcount.c
+++ b/lib/percpu-refcount.c
@@ -369,3 +369,32 @@ void percpu_ref_reinit(struct percpu_ref *ref)
 	spin_unlock_irqrestore(&percpu_ref_switch_lock, flags);
 }
 EXPORT_SYMBOL_GPL(percpu_ref_reinit);
+
+/**
+ * percpu_ref_read - read a percpu refcount
+ * @ref: percpu_ref to test
+ *
+ * This function is safe to call as long as @ref is between init and exit. It
+ * is the responsibility of the caller to handle changes of @ref concurrently
+ * with this function. If this function is called while @ref is in per-cpu
+ * mode the returned value may be incorrect if e.g. percpu_ref_get() is called
+ * from one CPU and percpu_ref_put() is called from another CPU.
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
2.18.0
