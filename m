Return-Path: <ktkhai@virtuozzo.com>
Subject: [PATCH 4/5] blkcg: Charge aio requests in blkio cgroup hierarchy
From: Kirill Tkhai <ktkhai@virtuozzo.com>
To: axboe@kernel.dk, bcrl@kvack.org, viro@zeniv.linux.org.uk, tj@kernel.org,
 linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, linux-aio@kvack.org,
 oleg@redhat.com, ktkhai@virtuozzo.com
Date: Mon, 04 Dec 2017 19:13:27 +0300
Message-ID: <151240400729.10164.9814778954180833321.stgit@localhost.localdomain>
In-Reply-To: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
References: <151240305010.10164.15584502480037205018.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Return-Path: ktkhai@virtuozzo.com
List-ID: <linux-block@vger.kernel.org>

This patch adds accounting of number of requests of allocated aio
contexts per blkio cgroup, and aggregates child cgroups requests
up the hierarhy. This may be used to limit aio requests available
for containers.

By default, newly allocated blkcg::blkg_aio_max_nr is set
to "unlimited" value (see blkcg_css_alloc() in previous patch).
This guarantees that applications, which do not know about
blkcg::blkg_aio_max_nr, will be able to run like they used to do
before, without configuring child cgroup's blkg_aio_max_nr.

For protection "task attach" vs "io_context create/destroy"
read locked cgroup_threadgroup_rwsem is used. We take it
via cgroup_threadgroup_change_*() interfaces, which are used
around the places we charge kioctx::max_reqs and link a ctx
to mm_struct::ioctx_table.

Single allocation are protected aio_nr_lock like it used before.

Signed-off-by: Kirill Tkhai <ktkhai@virtuozzo.com>
---
 block/blk-cgroup.c  |   44 +++++++++++++++++++++-
 fs/aio.c            |  101 +++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/aio.h |   11 ++++++
 3 files changed, 153 insertions(+), 3 deletions(-)

diff --git a/block/blk-cgroup.c b/block/blk-cgroup.c
index 774560469b01..9cc6e9574946 100644
--- a/block/blk-cgroup.c
+++ b/block/blk-cgroup.c
@@ -1217,8 +1217,8 @@ void blkcg_exit_queue(struct request_queue *q)
  */
 static int blkcg_can_attach(struct cgroup_taskset *tset)
 {
-	struct task_struct *task;
-	struct cgroup_subsys_state *dst_css;
+	struct cgroup_subsys_state *dst_css, *old_css;
+	struct task_struct *task, *p;
 	struct io_context *ioc;
 	int ret = 0;
 
@@ -1230,11 +1230,46 @@ static int blkcg_can_attach(struct cgroup_taskset *tset)
 			ret = -EINVAL;
 		task_unlock(task);
 		if (ret)
-			break;
+			goto err;
+		if (!thread_group_leader(task))
+			continue;
+		ret = charge_task_aio_nr(task, css_to_blkcg(dst_css));
+		if (ret)
+			goto err;
+		old_css = task_css(task, io_cgrp_id);
+		uncharge_task_aio_nr(task, css_to_blkcg(old_css));
+	}
+err:
+	if (ret) {
+		cgroup_taskset_for_each(p, dst_css, tset) {
+			if (p == task)
+				break;
+			if (!thread_group_leader(p))
+				continue;
+			uncharge_task_aio_nr(p, css_to_blkcg(dst_css));
+			old_css = task_css(p, io_cgrp_id);
+			WARN_ON_ONCE(charge_task_aio_nr(p, css_to_blkcg(old_css)));
+		}
 	}
 	return ret;
 }
 
+#ifdef CONFIG_AIO
+static void blkcg_cancel_attach(struct cgroup_taskset *tset)
+{
+	struct cgroup_subsys_state *dst_css, *old_css;
+	struct task_struct *p;
+
+	cgroup_taskset_for_each(p, dst_css, tset) {
+		if (!thread_group_leader(p))
+			continue;
+		uncharge_task_aio_nr(p, css_to_blkcg(dst_css));
+		old_css = task_css(p, io_cgrp_id);
+		WARN_ON_ONCE(charge_task_aio_nr(p, css_to_blkcg(old_css)));
+	}
+}
+#endif
+
 static void blkcg_bind(struct cgroup_subsys_state *root_css)
 {
 	int i;
@@ -1260,6 +1295,9 @@ struct cgroup_subsys io_cgrp_subsys = {
 	.css_offline = blkcg_css_offline,
 	.css_free = blkcg_css_free,
 	.can_attach = blkcg_can_attach,
+#ifdef CONFIG_AIO
+	.cancel_attach = blkcg_cancel_attach,
+#endif
 	.bind = blkcg_bind,
 	.dfl_cftypes = blkcg_files,
 	.legacy_cftypes = blkcg_legacy_files,
diff --git a/fs/aio.c b/fs/aio.c
index 755f97a42ebe..2e63f5c582c0 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -40,6 +40,7 @@
 #include <linux/ramfs.h>
 #include <linux/percpu-refcount.h>
 #include <linux/mount.h>
+#include <linux/cgroup-defs.h>
 
 #include <asm/kmap_types.h>
 #include <linux/uaccess.h>
@@ -696,6 +697,97 @@ static int ioctx_add_table(struct kioctx *ctx, struct mm_struct *mm)
 	}
 }
 
+#ifdef CONFIG_BLK_CGROUP
+static bool try_to_charge_blkcg(unsigned long nr, struct blkcg *blkg)
+{
+	struct blkcg *tmp = blkg;
+
+	while (blkg) {
+		if (nr + blkg->blkg_aio_nr > blkg->blkg_aio_max_nr ||
+		    nr + blkg->blkg_aio_nr < nr)
+			goto fail;
+
+		blkg->blkg_aio_nr += nr;
+		blkg = blkcg_parent(blkg);
+	}
+
+	return true;
+fail:
+	while (tmp != blkg) {
+		tmp->blkg_aio_nr -= nr;
+		tmp = blkcg_parent(tmp);
+	}
+	return false;
+}
+
+
+static void uncharge_blkcg(unsigned long nr, struct blkcg *blkg)
+{
+	while (blkg) {
+		blkg->blkg_aio_nr -= nr;
+		blkg = blkcg_parent(blkg);
+	}
+}
+
+static bool __try_to_charge_aio_nr(unsigned nr)
+{
+	struct blkcg *blkg;
+
+	percpu_rwsem_assert_held(&cgroup_threadgroup_rwsem);
+	blkg = container_of(task_css_check(current, io_cgrp_id, true),
+			     struct blkcg, css);
+	return try_to_charge_blkcg(nr, blkg);
+}
+
+static void __uncharge_aio_nr(unsigned nr)
+{
+	struct blkcg *blkg;
+
+	percpu_rwsem_assert_held(&cgroup_threadgroup_rwsem);
+	blkg = container_of(task_css_check(current, io_cgrp_id, true),
+			     struct blkcg, css);
+	uncharge_blkcg(nr, blkg);
+}
+
+static unsigned long get_task_max_reqs(struct task_struct *p)
+{
+	struct kioctx_table *tbl;
+	unsigned long nr = 0;
+	struct kioctx *ctx;
+	int i;
+
+	if (p->flags & PF_KTHREAD)
+		return 0;
+	/* rwsem must be write locked */
+	tbl = rcu_dereference_protected(p->mm->ioctx_table,
+			percpu_rwsem_is_held(&cgroup_threadgroup_rwsem));
+	if (!tbl)
+		return 0;
+	for (i = 0; i < tbl->nr; i++) {
+		ctx = tbl->table[i];
+		if (!ctx)
+			continue;
+		nr += ctx->max_reqs;
+	}
+	return nr;
+}
+
+int charge_task_aio_nr(struct task_struct *p, struct blkcg *blkg)
+{
+	unsigned long nr = get_task_max_reqs(p);
+
+	if (!nr || try_to_charge_blkcg(nr, blkg))
+		return 0;
+	return -ENOMEM;
+}
+
+void uncharge_task_aio_nr(struct task_struct *p, struct blkcg *blkg)
+{
+	unsigned long nr = get_task_max_reqs(p);
+	if (nr)
+		uncharge_blkcg(nr, blkg);
+}
+#else
 static bool __try_to_charge_aio_nr(unsigned nr)
 {
 	if (aio_nr + nr > aio_max_nr ||
@@ -713,6 +805,7 @@ static void __uncharge_aio_nr(unsigned nr)
 	else
 		aio_nr -= nr;
 }
+#endif /* CONFIG_BLK_CGROUP */
 
 static bool try_to_charge_aio_nr(unsigned nr)
 {
@@ -803,6 +896,8 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 	if (ctx->req_batch < 1)
 		ctx->req_batch = 1;
 
+	cgroup_threadgroup_change_begin(current);
+
 	/* limit the number of system wide aios */
 	err = -EAGAIN;
 	if (!try_to_charge_aio_nr(ctx->max_reqs))
@@ -815,6 +910,8 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 	if (err)
 		goto err_cleanup;
 
+	cgroup_threadgroup_change_end(current);
+
 	/* Release the ring_lock mutex now that all setup is complete. */
 	mutex_unlock(&ctx->ring_lock);
 
@@ -825,6 +922,7 @@ static struct kioctx *ioctx_alloc(unsigned nr_events)
 err_cleanup:
 	uncharge_aio_nr(ctx->max_reqs);
 err_ctx:
+	cgroup_threadgroup_change_end(current);
 	atomic_set(&ctx->dead, 1);
 	if (ctx->mmap_size)
 		vm_munmap(ctx->mmap_base, ctx->mmap_size);
@@ -849,9 +947,11 @@ static int kill_ioctx(struct mm_struct *mm, struct kioctx *ctx,
 {
 	struct kioctx_table *table;
 
+	cgroup_threadgroup_change_begin(current);
 	spin_lock(&mm->ioctx_lock);
 	if (atomic_xchg(&ctx->dead, 1)) {
 		spin_unlock(&mm->ioctx_lock);
+		cgroup_threadgroup_change_end(current);
 		return -EINVAL;
 	}
 
@@ -871,6 +971,7 @@ static int kill_ioctx(struct mm_struct *mm, struct kioctx *ctx,
 	 *  could tell).
 	 */
 	uncharge_aio_nr(ctx->max_reqs);
+	cgroup_threadgroup_change_end(current);
 
 	if (ctx->mmap_size)
 		vm_munmap(ctx->mmap_base, ctx->mmap_size);
diff --git a/include/linux/aio.h b/include/linux/aio.h
index de929a8c9c59..bf442e562a8f 100644
--- a/include/linux/aio.h
+++ b/include/linux/aio.h
@@ -31,9 +31,20 @@ static inline void kiocb_set_cancel_fn(struct kiocb *req,
 /* for sysctl: */
 extern unsigned long aio_nr;
 extern unsigned long aio_max_nr;
+
+static inline int charge_task_aio_nr(struct task_struct *p, struct blkcg *g)
+{
+	return 0;
+}
+static inline void uncharge_task_aio_nr(struct task_struct *p, struct blkcg *g)
+{
+}
 #else
 #define aio_nr		blkcg_root.blkg_aio_nr
 #define aio_max_nr	blkcg_root.blkg_aio_max_nr
+
+extern int charge_task_aio_nr(struct task_struct *, struct blkcg *);
+extern void uncharge_task_aio_nr(struct task_struct *, struct blkcg *);
 #endif /* !CONFIG_BLK_CGROUP || !CONFIG_AIO */
 
 #endif /* __LINUX__AIO_H */
