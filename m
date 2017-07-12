Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:55714 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753786AbdGLSuv (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 Jul 2017 14:50:51 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH V5 07/11] cgroup: export fhandle info for a cgroup
Date: Wed, 12 Jul 2017 11:49:52 -0700
Message-Id: <4c59c56556b3c4051cb63b8ca2be920be177c0b3.1499884836.git.shli@fb.com>
In-Reply-To: <cover.1499884836.git.shli@fb.com>
References: <cover.1499884836.git.shli@fb.com>
In-Reply-To: <cover.1499884836.git.shli@fb.com>
References: <cover.1499884836.git.shli@fb.com>
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

Acked-by: Tejun Heo <tj@kernel.org>
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
