Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39174 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751927AbdF1QaJ (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 12:30:09 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH V4 07/12] cgroup: export fhandle info for a cgroup
Date: Wed, 28 Jun 2017 09:29:57 -0700
Message-Id: <a81d74a4e19be95207d7455ec9abb4fb0b4d1736.1498666964.git.shli@fb.com>
In-Reply-To: <cover.1498666964.git.shli@fb.com>
References: <cover.1498666964.git.shli@fb.com>
In-Reply-To: <cover.1498666964.git.shli@fb.com>
References: <cover.1498666964.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

Add an API to export cgroup fhandle info. We don't export a full 'struct
file_handle', there are unrequired info. Sepcifically, cgroup is always
a directory, so we don't need a 'FILEID_INO32_GEN_PARENT' type fhandle,
we only need export the inode number and generation number just like
what generic_fh_to_dentry does. And we can avoid the overhead of getting
an inode too, since kernfs_node_id (ino and generation) has all the info
required.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 include/linux/cgroup.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 30c6877..52ef9a6 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -609,6 +609,10 @@ static inline void cgroup_kthread_ready(void)
 	current->no_cgroup_migration = 0;
 }
 
+static inline union kernfs_node_id *cgroup_get_kernfs_id(struct cgroup *cgrp)
+{
+	return &cgrp->kn->id;
+}
 #else /* !CONFIG_CGROUPS */
 
 struct cgroup_subsys_state;
@@ -631,6 +635,10 @@ static inline int cgroup_init_early(void) { return 0; }
 static inline int cgroup_init(void) { return 0; }
 static inline void cgroup_init_kthreadd(void) {}
 static inline void cgroup_kthread_ready(void) {}
+static inline union kernfs_node_id *cgroup_get_kernfs_id(struct cgroup *cgrp)
+{
+	return NULL;
+}
 
 static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
 					       struct cgroup *ancestor)
-- 
2.9.3
