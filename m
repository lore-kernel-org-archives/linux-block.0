Return-Path: <SRS0=1cqs=AO=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: tj@kernel.org,
	lizefan@huawei.com,
	tglx@linutronix.de,
	kernel-team@fb.com,
	axboe@kernel.dk,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V2 1/4] kthread: add a mechanism to store cgroup info
Date: Wed, 13 Sep 2017 14:01:26 -0700
Message-Id: <802ba16bd896e56bc974780e97157760fde7c273.1505335620.git.shli@fb.com>
In-Reply-To: <cover.1505335620.git.shli@fb.com>
References: <cover.1505335620.git.shli@fb.com>
In-Reply-To: <cover.1505335620.git.shli@fb.com>
References: <cover.1505335620.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

kthread usually runs jobs on behalf of other threads. The jobs should be
charged to cgroup of original threads. But the jobs run in a kthread,
where we lose the cgroup context of original threads. The patch adds a
machanism to record cgroup info of original threads in kthread context.
Later we can retrieve the cgroup info and attach the cgroup info to jobs.

Since this mechanism is only required by kthread, we store the cgroup
info in kthread data instead of generic task_struct.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 include/linux/kthread.h | 11 +++++++++++
 kernel/kthread.c        | 44 +++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 54 insertions(+), 1 deletion(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 82e197e..bd4369c 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -3,6 +3,7 @@
 /* Simple interface for creating and stopping kernel threads without mess. */
 #include <linux/err.h>
 #include <linux/sched.h>
+#include <linux/cgroup.h>
 
 __printf(4, 5)
 struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
@@ -198,4 +199,14 @@ bool kthread_cancel_delayed_work_sync(struct kthread_delayed_work *work);
 
 void kthread_destroy_worker(struct kthread_worker *worker);
 
+#ifdef CONFIG_CGROUPS
+void kthread_associate_blkcg(struct cgroup_subsys_state *css);
+struct cgroup_subsys_state *kthread_blkcg(void);
+#else
+static inline void kthread_associate_blkcg(struct cgroup_subsys_state *css) { }
+static inline struct cgroup_subsys_state *kthread_blkcg(void)
+{
+	return NULL;
+}
+#endif
 #endif /* _LINUX_KTHREAD_H */
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 26db528..3107eee 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -20,7 +20,6 @@
 #include <linux/freezer.h>
 #include <linux/ptrace.h>
 #include <linux/uaccess.h>
-#include <linux/cgroup.h>
 #include <trace/events/sched.h>
 
 static DEFINE_SPINLOCK(kthread_create_lock);
@@ -47,6 +46,7 @@ struct kthread {
 	void *data;
 	struct completion parked;
 	struct completion exited;
+	struct cgroup_subsys_state *blkcg_css;
 };
 
 enum KTHREAD_BITS {
@@ -1153,3 +1153,45 @@ void kthread_destroy_worker(struct kthread_worker *worker)
 	kfree(worker);
 }
 EXPORT_SYMBOL(kthread_destroy_worker);
+
+#ifdef CONFIG_CGROUPS
+/**
+ * kthread_associate_blkcg - associate blkcg to current kthread
+ * @css: the cgroup info
+ *
+ * Current thread must be a kthread. The thread is running jobs on behalf of
+ * other threads. In some cases, we expect the jobs attach cgroup info of
+ * original threads instead of that of current thread. This function stores
+ * original thread's cgroup info in current kthread context for later
+ * retrieval.
+ */
+void kthread_associate_blkcg(struct cgroup_subsys_state *css)
+{
+	struct kthread *kthread;
+
+	if (!(current->flags & PF_KTHREAD) || !current->set_child_tid)
+		return;
+	kthread = to_kthread(current);
+	if (css) {
+		css_get(css);
+		kthread->blkcg_css = css;
+	} else if (kthread->blkcg_css) {
+		css_put(kthread->blkcg_css);
+		kthread->blkcg_css = NULL;
+	}
+}
+EXPORT_SYMBOL(kthread_associate_blkcg);
+
+/**
+ * kthread_blkcg - get associated blkcg css of current kthread
+ *
+ * Current thread must be a kthread.
+ */
+struct cgroup_subsys_state *kthread_blkcg(void)
+{
+	if ((current->flags & PF_KTHREAD) && current->set_child_tid)
+		return to_kthread(current)->blkcg_css;
+	return NULL;
+}
+EXPORT_SYMBOL(kthread_blkcg);
+#endif
-- 
2.9.5
