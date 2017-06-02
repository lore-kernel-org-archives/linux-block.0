Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:38582 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751492AbdFBVyq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 2 Jun 2017 17:54:46 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH 06/11] cgroup: export fhandle info for a cgroup
Date: Fri,  2 Jun 2017 14:53:59 -0700
Message-Id: <38a747029c2a04d7e49dd7518f3caf2ac8ec24b5.1496432591.git.shli@fb.com>
In-Reply-To: <cover.1496432591.git.shli@fb.com>
References: <cover.1496432591.git.shli@fb.com>
In-Reply-To: <cover.1496432591.git.shli@fb.com>
References: <cover.1496432591.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

Add an API to export cgroup fhandle info. We don't export a full 'struct
file_handle', there are unrequired info. Sepcifically, cgroup is always
a directory, so we don't need a 'FILEID_INO32_GEN_PARENT' type fhandle,
we only need export the inode number and generation number just like
what generic_fh_to_parent does. And we can avoid the overhead of getting
an inode too, since kernfs_node has all the info required.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 fs/kernfs/mount.c           | 11 +++++++++++
 include/linux/cgroup-defs.h |  2 ++
 include/linux/cgroup.h      |  8 ++++++++
 include/linux/kernfs.h      |  8 ++++++++
 kernel/cgroup/cgroup.c      |  3 +++
 5 files changed, 32 insertions(+)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index 11c5aba..d24d816 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -65,6 +65,17 @@ const struct super_operations kernfs_sops = {
 	.show_path	= kernfs_sop_show_path,
 };
 
+/*
+ * A special version of export_encode_fh(). This will avoid to get inode and
+ * then do the fhandle encoding. This function must match with export_encode_fh
+ * and the kernfs node should be a directory.
+ */
+void kernfs_encode_node_id(struct kernfs_node *kn, struct kernfs_node_id *id)
+{
+	id->ino = kn->ino;
+	id->gen = kn->generation;
+}
+
 static struct inode *kernfs_fh_get_inode(struct super_block *sb,
 		u64 ino, u32 generation)
 {
diff --git a/include/linux/cgroup-defs.h b/include/linux/cgroup-defs.h
index 2174594..8b6d9e2 100644
--- a/include/linux/cgroup-defs.h
+++ b/include/linux/cgroup-defs.h
@@ -308,6 +308,8 @@ struct cgroup {
 	/* used to store eBPF programs */
 	struct cgroup_bpf bpf;
 
+	struct kernfs_node_id node_id;
+
 	/* ids of the ancestors at each level including self */
 	int ancestor_ids[];
 };
diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index ed2573e..c30dda8 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -589,6 +589,10 @@ static inline void cgroup_kthread_ready(void)
 	current->no_cgroup_migration = 0;
 }
 
+static inline struct kernfs_node_id *cgroup_get_node_id(struct cgroup *cgrp)
+{
+	return &cgrp->node_id;
+}
 #else /* !CONFIG_CGROUPS */
 
 struct cgroup_subsys_state;
@@ -611,6 +615,10 @@ static inline int cgroup_init_early(void) { return 0; }
 static inline int cgroup_init(void) { return 0; }
 static inline void cgroup_init_kthreadd(void) {}
 static inline void cgroup_kthread_ready(void) {}
+static inline struct kernfs_node_id *cgroup_get_node_id(struct cgroup *cgrp)
+{
+	return NULL;
+}
 
 static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
 					       struct cgroup *ancestor)
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index 15c805f..932d89f 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -247,6 +247,12 @@ struct kernfs_ops {
 #endif
 };
 
+/* match with 'struct fid' */
+struct kernfs_node_id {
+	u32 ino;
+	u32 gen;
+};
+
 #ifdef CONFIG_KERNFS
 
 static inline enum kernfs_node_type kernfs_type(struct kernfs_node *kn)
@@ -339,6 +345,8 @@ struct super_block *kernfs_pin_sb(struct kernfs_root *root, const void *ns);
 
 void kernfs_init(void);
 
+void kernfs_encode_node_id(struct kernfs_node *kn, struct kernfs_node_id *id);
+
 #else	/* CONFIG_KERNFS */
 
 static inline enum kernfs_node_type kernfs_type(struct kernfs_node *kn)
diff --git a/kernel/cgroup/cgroup.c b/kernel/cgroup/cgroup.c
index 206d8df..489672d 100644
--- a/kernel/cgroup/cgroup.c
+++ b/kernel/cgroup/cgroup.c
@@ -1692,6 +1692,7 @@ int cgroup_setup_root(struct cgroup_root *root, u16 ss_mask, int ref_flags)
 		goto exit_root_id;
 	}
 	root_cgrp->kn = root->kf_root->kn;
+	kernfs_encode_node_id(root_cgrp->kn, &root_cgrp->node_id);
 
 	ret = css_populate_dir(&root_cgrp->self);
 	if (ret)
@@ -4209,6 +4210,8 @@ int cgroup_mkdir(struct kernfs_node *parent_kn, const char *name, umode_t mode)
 	/* let's create and online css's */
 	kernfs_activate(kn);
 
+	kernfs_encode_node_id(kn, &cgrp->node_id);
+
 	ret = 0;
 	goto out_unlock;
 
-- 
2.9.3
