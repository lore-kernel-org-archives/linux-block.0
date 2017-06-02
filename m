Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38680 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751497AbdFBVyq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Jun 2017 17:54:46 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH 10/11] blktrace: add an option to allow displying cgroup path
Date: Fri,  2 Jun 2017 14:54:03 -0700
Message-Id: <5a18256edc93507d0c59966ccaafa4ee2f9db888.1496432591.git.shli@fb.com>
In-Reply-To: <cover.1496432591.git.shli@fb.com>
References: <cover.1496432591.git.shli@fb.com>
In-Reply-To: <cover.1496432591.git.shli@fb.com>
References: <cover.1496432591.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

By default we output cgroup id in blktrace. This adds an option to
display cgroup path. Since get cgroup path is a relativly heavy
operation, we don't enable it by default.

with the option enabled, blktrace will output something like this:
dd-1353  [007] d..2   293.015252:   8,0   /test/level  D   R 24 + 8 [dd]

Signed-off-by: Shaohua Li <shli@fb.com>
---
 fs/kernfs/mount.c       | 19 +++++++++++++++++++
 include/linux/cgroup.h  |  6 ++++++
 include/linux/kernfs.h  |  2 ++
 kernel/cgroup/cgroup.c  | 12 ++++++++++++
 kernel/trace/blktrace.c | 14 +++++++++++++-
 5 files changed, 52 insertions(+), 1 deletion(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index d24d816..4c1636e 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -76,6 +76,25 @@ void kernfs_encode_node_id(struct kernfs_node *kn, struct kernfs_node_id *id)
 	id->gen = kn->generation;
 }
 
+/*
+ * Similar like kernfs_fh_get_inode, this one gets kernfs node from inode
+ * number and generation
+ */
+struct kernfs_node *kernfs_get_node_by_id(struct kernfs_root *root,
+	const struct kernfs_node_id *id)
+{
+	struct kernfs_node *kn;
+
+	kn = kernfs_get_node_by_ino(root, id->ino);
+	if (!kn)
+		return NULL;
+	if (kn->generation != id->gen) {
+		kernfs_put(kn);
+		return NULL;
+	}
+	return kn;
+}
+
 static struct inode *kernfs_fh_get_inode(struct super_block *sb,
 		u64 ino, u32 generation)
 {
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index c30dda8..56390c8 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -593,6 +593,9 @@ static inline struct kernfs_node_id *cgroup_get_node_id(struct cgroup *cgrp)
 {
 	return &cgrp->node_id;
 }
+
+void cgroup_path_from_node_id(const struct kernfs_node_id *id,
+					char *buf, size_t buflen);
 #else /* !CONFIG_CGROUPS */
 
 struct cgroup_subsys_state;
@@ -625,6 +628,9 @@ static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
 {
 	return true;
 }
+
+static inline void cgroup_path_from_node_id(const struct kernfs_node_id *id,
+	char *buf, size_t buflen) {}
 #endif /* !CONFIG_CGROUPS */
 
 /*
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 932d89f..1c9397d 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -346,6 +346,8 @@ struct super_block *kernfs_pin_sb(struct kernfs_root *root, const void *ns);
 void kernfs_init(void);
 
 void kernfs_encode_node_id(struct kernfs_node *kn, struct kernfs_node_id *id);
+struct kernfs_node *kernfs_get_node_by_id(struct kernfs_root *root,
+	const struct kernfs_node_id *id);
 
 #else	/* CONFIG_KERNFS */
 
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 489672d..7f91ad1 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -4604,6 +4604,18 @@ static int __init cgroup_wq_init(void)
 }
 core_initcall(cgroup_wq_init);
 
+void cgroup_path_from_node_id(const struct kernfs_node_id *id,
+					char *buf, size_t buflen)
+{
+	struct kernfs_node *kn;
+
+	kn = kernfs_get_node_by_id(cgrp_dfl_root.kf_root, id);
+	if (!kn)
+		return;
+	kernfs_path(kn, buf, buflen);
+	kernfs_put(kn);
+}
+
 /*
  * proc_cgroup_show()
  *  - Print task's cgroup paths into seq_file, one line for each hierarchy
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index e351837..18cbc02 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -48,12 +48,14 @@ static __cacheline_aligned_in_smp DEFINE_SPINLOCK(running_trace_lock);
 /* Select an alternative, minimalistic output than the original one */
 #define TRACE_BLK_OPT_CLASSIC	0x1
 #define TRACE_BLK_OPT_CGROUP	0x2
+#define TRACE_BLK_OPT_CGNAME	0x4
 
 static struct tracer_opt blk_tracer_opts[] = {
 	/* Default disable the minimalistic output */
 	{ TRACER_OPT(blk_classic, TRACE_BLK_OPT_CLASSIC) },
 #ifdef CONFIG_BLK_CGROUP
 	{ TRACER_OPT(blk_cgroup, TRACE_BLK_OPT_CGROUP) },
+	{ TRACER_OPT(blk_cgname, TRACE_BLK_OPT_CGNAME) },
 #endif
 	{ }
 };
@@ -1212,7 +1214,17 @@ static void blk_log_action(struct trace_iterator *iter, const char *act,
 	if (has_cg) {
 		const struct kernfs_node_id *id = cgid_start(iter->ent);
 
-		trace_seq_printf(&iter->seq, "%3d,%-3d %8x,%-8x %2s %3s ",
+		if (blk_tracer_flags.val & TRACE_BLK_OPT_CGNAME) {
+			char blkcg_name_buf[NAME_MAX + 1] = "<...>";
+
+			cgroup_path_from_node_id(id, blkcg_name_buf,
+				sizeof(blkcg_name_buf));
+			trace_seq_printf(&iter->seq, "%3d,%-3d %s %2s %3s ",
+				 MAJOR(t->device), MINOR(t->device),
+				 blkcg_name_buf, act, rwbs);
+		} else
+			trace_seq_printf(&iter->seq,
+				 "%3d,%-3d %8x,%-8x %2s %3s ",
 				 MAJOR(t->device), MINOR(t->device),
 				 id->ino, id->gen, act, rwbs);
 	} else
-- 
2.9.3
