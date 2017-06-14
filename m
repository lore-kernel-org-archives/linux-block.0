Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:47632 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752860AbdFNQMU (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Jun 2017 12:12:20 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH V2 07/12] cgroup: export fhandle info for a cgroup
Date: Wed, 14 Jun 2017 09:12:05 -0700
Message-Id: <8d928141f1e628c31b4502068b35c97987645138.1497455937.git.shli@fb.com>
In-Reply-To: <cover.1497455937.git.shli@fb.com>
References: <cover.1497455937.git.shli@fb.com>
In-Reply-To: <cover.1497455937.git.shli@fb.com>
References: <cover.1497455937.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

Add an API to export cgroup fhandle info. We don't export a full 'struct
file_handle', there are unrequired info. Sepcifically, cgroup is always
a directory, so we don't need a 'FILEID_KERNFS_WITH_PARENT' type
fhandle, we only need export the inode number and generation number.
Since the first part of 'kernfs_fid' and 'kernfs_node_id' have the same
layout, we can just export a 'kernfs_node_id'.

Signed-off-by: Shaohua Li <shli@fb.com>
---
 include/linux/cgroup.h | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
index 30c6877..5ebe89f 100644
--- a/include/linux/cgroup.h
+++ b/include/linux/cgroup.h
@@ -609,6 +609,10 @@ static inline void cgroup_kthread_ready(void)
 	current->no_cgroup_migration = 0;
 }
 
+static inline struct kernfs_node_id *cgroup_get_node_id(struct cgroup *cgrp)
+{
+	return &cgrp->kn->id;
+}
 #else /* !CONFIG_CGROUPS */
 
 struct cgroup_subsys_state;
@@ -631,6 +635,10 @@ static inline int cgroup_init_early(void) { return 0; }
 static inline int cgroup_init(void) { return 0; }
 static inline void cgroup_init_kthreadd(void) {}
 static inline void cgroup_kthread_ready(void) {}
+static inline struct kernfs_node_id *cgroup_get_node_id(struct cgroup *cgrp)
+{
+	return NULL;
+}
 
 static inline bool task_under_cgroup_hierarchy(struct task_struct *task,
 					       struct cgroup *ancestor)
-- 
2.9.3
