Return-Path: <jianchao.w.wang@oracle.com>
From: Jianchao Wang <jianchao.w.wang@oracle.com>
To: axboe@kernel.dk, tj@kernel.org, kent.overstreet@gmail.com,
        ming.lei@redhat.com, bart.vanassche@wdc.com
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/3] percpu_ref: add a new helper interface __percpu_ref_get_many
Date: Thu, 20 Sep 2018 18:18:21 +0800
Message-Id: <1537438703-25217-2-git-send-email-jianchao.w.wang@oracle.com>
In-Reply-To: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
References: <1537438703-25217-1-git-send-email-jianchao.w.wang@oracle.com>
List-ID: <linux-block@vger.kernel.org>

This __percpu_ref_get_many is almost same with the percpu_ref_get_many,
except for the caller need to provide a sched rcu critical section
for it. We want to do some other condition checking under the sched
rcu lock. With this interface, one extra rcu_read_lock/unlock_sched
could be saved.

Signed-off-by: Jianchao Wang <jianchao.w.wang@oracle.com>
---
 include/linux/percpu-refcount.h | 23 +++++++++++++++++------
 1 file changed, 17 insertions(+), 6 deletions(-)

diff --git a/include/linux/percpu-refcount.h b/include/linux/percpu-refcount.h
index 009cdf3..b86e03b 100644
--- a/include/linux/percpu-refcount.h
+++ b/include/linux/percpu-refcount.h
@@ -169,21 +169,32 @@ static inline bool __ref_is_percpu(struct percpu_ref *ref,
  * @ref: percpu_ref to get
  * @nr: number of references to get
  *
- * Analogous to atomic_long_add().
- *
- * This function is safe to call as long as @ref is between init and exit.
+ * This function is same with percpu_ref_get_many except for the caller need to
+ * provide a sched rcu critical section for it.
  */
-static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
+static inline void __percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
 {
 	unsigned long __percpu *percpu_count;
 
-	rcu_read_lock_sched();
-
 	if (__ref_is_percpu(ref, &percpu_count))
 		this_cpu_add(*percpu_count, nr);
 	else
 		atomic_long_add(nr, &ref->count);
+}
 
+/**
+ * percpu_ref_get_many - increment a percpu refcount
+ * @ref: percpu_ref to get
+ * @nr: number of references to get
+ *
+ * Analogous to atomic_long_add().
+ *
+ * This function is safe to call as long as @ref is between init and exit.
+ */
+static inline void percpu_ref_get_many(struct percpu_ref *ref, unsigned long nr)
+{
+	rcu_read_lock_sched();
+	__percpu_ref_get_many(ref, nr);
 	rcu_read_unlock_sched();
 }
 
-- 
2.7.4
