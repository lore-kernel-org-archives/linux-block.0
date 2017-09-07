Return-Path: <SRS0=Wszy=AI=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: tj@kernel.org,
	lizefan@huawei.com,
	tglx@linutronix.de,
	kernel-team@fb.com,
	axboe@kernel.dk,
	Shaohua Li <shli@fb.com>
Subject: [PATCH 1/3] kthread: add a mechanism to store cgroup info
Date: Wed,  6 Sep 2017 19:00:51 -0700
Message-Id: <9d25e5bed5ef2fad5f8a817e293f0d93e3b329c2.1504748195.git.shli@fb.com>
In-Reply-To: <cover.1504748195.git.shli@fb.com>
References: <cover.1504748195.git.shli@fb.com>
In-Reply-To: <cover.1504748195.git.shli@fb.com>
References: <cover.1504748195.git.shli@fb.com>
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
 include/linux/kthread.h | 13 +++++++++++
 include/linux/sched.h   |  1 +
 kernel/kthread.c        | 57 ++++++++++++++++++++++++++++++++++++++++++++++++-
 3 files changed, 70 insertions(+), 1 deletion(-)

diff --git a/include/linux/kthread.h b/include/linux/kthread.h
index 82e197e..3eb24d1 100644
--- a/include/linux/kthread.h
+++ b/include/linux/kthread.h
@@ -3,6 +3,7 @@
 /* Simple interface for creating and stopping kernel threads without mess. */
 #include <linux/err.h>
 #include <linux/sched.h>
+#include <linux/cgroup.h>
 
 __printf(4, 5)
 struct task_struct *kthread_create_on_node(int (*threadfn)(void *data),
@@ -198,4 +199,16 @@ bool kthread_cancel_delayed_work_sync(struct kthread_delayed_work *work);
 
 void kthread_destroy_worker(struct kthread_worker *worker);
 
+#ifdef CONFIG_CGROUPS
+void kthread_set_orig_css(struct cgroup_subsys_state *css);
+struct cgroup_subsys_state *kthread_get_orig_css(void);
+void kthread_reset_orig_css(void);
+#else
+static inline void kthread_set_orig_css(struct cgroup_subsys_state *css) { }
+static inline struct cgroup_subsys_state *kthread_get_orig_css(void)
+{
+	return NULL;
+}
+static inline void kthread_reset_orig_css(void) { }
+#endif
 #endif /* _LINUX_KTHREAD_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c05ac5f..ab2295d 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1276,6 +1276,7 @@ extern struct pid *cad_pid;
 #define PF_SWAPWRITE		0x00800000	/* Allowed to write to swap */
 #define PF_NO_SETAFFINITY	0x04000000	/* Userland is not allowed to meddle with cpus_allowed */
 #define PF_MCE_EARLY		0x08000000      /* Early kill for mce process policy */
+#define PF_KTHREAD_HAS_CSS	0x10000000	/* kthread has css info attached */
 #define PF_MUTEX_TESTER		0x20000000	/* Thread belongs to the rt mutex tester */
 #define PF_FREEZER_SKIP		0x40000000	/* Freezer should not count it as freezable */
 #define PF_SUSPEND_TASK		0x80000000      /* This thread called freeze_processes() and should not be frozen */
diff --git a/kernel/kthread.c b/kernel/kthread.c
index 26db528..d084ef3 100644
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
+	struct cgroup_subsys_state *orig_css;
 };
 
 enum KTHREAD_BITS {
@@ -1153,3 +1153,58 @@ void kthread_destroy_worker(struct kthread_worker *worker)
 	kfree(worker);
 }
 EXPORT_SYMBOL(kthread_destroy_worker);
+
+#ifdef CONFIG_CGROUPS
+/**
+ * kthread_set_orig_css - set the original css for current thread
+ * @css: the cgroup info
+ *
+ * Current thread must be a kthread. The thread is running jobs on behalf of
+ * other threads. In some cases, we expect the jobs attach cgroup info of
+ * original threads instead of that of current thread. This function stores
+ * original thread's cgroup info in current kthread context for later
+ * retrieval.
+ */
+void kthread_set_orig_css(struct cgroup_subsys_state *css)
+{
+	struct kthread *kthread = to_kthread(current);
+
+	if (css) {
+		css_get(css);
+		kthread->orig_css = css;
+		current->flags |= PF_KTHREAD_HAS_CSS;
+	}
+}
+EXPORT_SYMBOL(kthread_set_orig_css);
+
+/**
+ * kthread_get_orig_css - get the stored original cgroup info
+ *
+ * Current thread must be a kthread.
+ */
+struct cgroup_subsys_state *kthread_get_orig_css(void)
+{
+	if (current->flags & PF_KTHREAD_HAS_CSS)
+		return to_kthread(current)->orig_css;
+	return NULL;
+}
+EXPORT_SYMBOL(kthread_get_orig_css);
+
+/**
+ * kthread_reset_orig_css - clear stored cgroup info
+ *
+ * Current thread must be a kthread.
+ */
+void kthread_reset_orig_css(void)
+{
+	struct kthread *kthread = to_kthread(current);
+	struct cgroup_subsys_state *css;
+
+	css = kthread->orig_css;
+	if (css)
+		css_put(css);
+	kthread->orig_css = NULL;
+	current->flags &= ~PF_KTHREAD_HAS_CSS;
+}
+EXPORT_SYMBOL(kthread_reset_orig_css);
+#endif
-- 
2.9.5
