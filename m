Return-Path: <SRS0=TWoo=AP=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: tj@kernel.org,
	lizefan@huawei.com,
	tglx@linutronix.de,
	kernel-team@fb.com,
	axboe@kernel.dk,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V3 1/4] kthread: add a mechanism to store cgroup info
Date: Thu, 14 Sep 2017 14:02:04 -0700
Message-Id: <9649525546c2a69f22c7ec5a87858affece87160.1505422351.git.shli@fb.com>
In-Reply-To: <cover.1505422351.git.shli@fb.com>
References: <cover.1505422351.git.shli@fb.com>
In-Reply-To: <cover.1505422351.git.shli@fb.com>
References: <cover.1505422351.git.shli@fb.com>
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
 include/linux/kthread.h | 11 +++++++++
 kernel/kthread.c        | 66 +++++++++++++++++++++++++++++++++++++++++++++++--
 2 files changed, 75 insertions(+), 2 deletions(-)

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
index 26db528..a8b4e83 100644
--- a/kernel/kthread.c
+++ b/kernel/kthread.c
@@ -20,7 +20,6 @@
 #include <linux/freezer.h>
 #include <linux/ptrace.h>
 #include <linux/uaccess.h>
-#include <linux/cgroup.h>
 #include <trace/events/sched.h>
 
 static DEFINE_SPINLOCK(kthread_create_lock);
@@ -47,6 +46,9 @@ struct kthread {
 	void *data;
 	struct completion parked;
 	struct completion exited;
+#ifdef CONFIG_CGROUPS
+	struct cgroup_subsys_state *blkcg_css;
+#endif
 };
 
 enum KTHREAD_BITS {
@@ -74,11 +76,17 @@ static inline struct kthread *to_kthread(struct task_struct *k)
 
 void free_kthread_struct(struct task_struct *k)
 {
+	struct kthread *kthread;
+
 	/*
 	 * Can be NULL if this kthread was created by kernel_thread()
 	 * or if kmalloc() in kthread() failed.
 	 */
-	kfree(to_kthread(k));
+	kthread = to_kthread(k);
+#ifdef CONFIG_CGROUPS
+	WARN_ON_ONCE(kthread && kthread->blkcg_css);
+#endif
+	kfree(kthread);
 }
 
 /**
@@ -216,6 +224,9 @@ static int kthread(void *_create)
 	self->data = data;
 	init_completion(&self->exited);
 	init_completion(&self->parked);
+#ifdef CONFIG_CGROUPS
+	self->blkcg_css = NULL;
+#endif
 	current->vfork_done = &self->exited;
 
 	/* OK, tell user we're spawned, wait for stop or wakeup */
@@ -1153,3 +1164,54 @@ void kthread_destroy_worker(struct kthread_worker *worker)
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
+	if (!(current->flags & PF_KTHREAD))
+		return;
+	kthread = to_kthread(current);
+	if (!kthread)
+		return;
+
+	if (kthread->blkcg_css) {
+		css_put(kthread->blkcg_css);
+		kthread->blkcg_css = NULL;
+	}
+	if (css) {
+		css_get(css);
+		kthread->blkcg_css = css;
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
+	struct kthread *kthread;
+
+	if (current->flags & PF_KTHREAD) {
+		kthread = to_kthread(current);
+		if (kthread)
+			return kthread->blkcg_css;
+	}
+	return NULL;
+}
+EXPORT_SYMBOL(kthread_blkcg);
+#endif
-- 
2.9.5
