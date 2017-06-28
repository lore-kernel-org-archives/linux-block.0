Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:39122 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751642AbdF1QaG (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 28 Jun 2017 12:30:06 -0400
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Cc: tj@kernel.org, gregkh@linuxfoundation.org, hch@lst.de,
        axboe@fb.com, rostedt@goodmis.org, lizefan@huawei.com,
        Kernel-team@fb.com, Shaohua Li <shli@fb.com>
Subject: [PATCH V4 01/12] kernfs: use idr instead of ida to manage inode number
Date: Wed, 28 Jun 2017 09:29:51 -0700
Message-Id: <5852a3cf1bfcf1900e3453775ccd5d976e300b66.1498666964.git.shli@fb.com>
In-Reply-To: <cover.1498666964.git.shli@fb.com>
References: <cover.1498666964.git.shli@fb.com>
In-Reply-To: <cover.1498666964.git.shli@fb.com>
References: <cover.1498666964.git.shli@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Shaohua Li <shli@fb.com>

kernfs uses ida to manage inode number. The problem is we can't get
kernfs_node from inode number with ida. Switching to use idr, next patch
will add an API to get kernfs_node from inode number.

Acked-by: Tejun Heo <tj@kernel.org>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 fs/kernfs/dir.c        | 17 ++++++++++++-----
 include/linux/kernfs.h |  2 +-
 2 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/fs/kernfs/dir.c b/fs/kernfs/dir.c
index db5900aaa..8ad7a17 100644
--- a/fs/kernfs/dir.c
+++ b/fs/kernfs/dir.c
@@ -21,6 +21,7 @@
 DEFINE_MUTEX(kernfs_mutex);
 static DEFINE_SPINLOCK(kernfs_rename_lock);	/* kn->parent and ->name */
 static char kernfs_pr_cont_buf[PATH_MAX];	/* protected by rename_lock */
+static DEFINE_SPINLOCK(kernfs_idr_lock);	/* root->ino_idr */
 
 #define rb_to_kn(X) rb_entry((X), struct kernfs_node, rb)
 
@@ -533,7 +534,9 @@ void kernfs_put(struct kernfs_node *kn)
 		simple_xattrs_free(&kn->iattr->xattrs);
 	}
 	kfree(kn->iattr);
-	ida_simple_remove(&root->ino_ida, kn->ino);
+	spin_lock(&kernfs_idr_lock);
+	idr_remove(&root->ino_idr, kn->ino);
+	spin_unlock(&kernfs_idr_lock);
 	kmem_cache_free(kernfs_node_cache, kn);
 
 	kn = parent;
@@ -542,7 +545,7 @@ void kernfs_put(struct kernfs_node *kn)
 			goto repeat;
 	} else {
 		/* just released the root kn, free @root too */
-		ida_destroy(&root->ino_ida);
+		idr_destroy(&root->ino_idr);
 		kfree(root);
 	}
 }
@@ -630,7 +633,11 @@ static struct kernfs_node *__kernfs_new_node(struct kernfs_root *root,
 	if (!kn)
 		goto err_out1;
 
-	ret = ida_simple_get(&root->ino_ida, 1, 0, GFP_KERNEL);
+	idr_preload(GFP_KERNEL);
+	spin_lock(&kernfs_idr_lock);
+	ret = idr_alloc(&root->ino_idr, kn, 1, 0, GFP_ATOMIC);
+	spin_unlock(&kernfs_idr_lock);
+	idr_preload_end();
 	if (ret < 0)
 		goto err_out2;
 	kn->ino = ret;
@@ -875,13 +882,13 @@ struct kernfs_root *kernfs_create_root(struct kernfs_syscall_ops *scops,
 	if (!root)
 		return ERR_PTR(-ENOMEM);
 
-	ida_init(&root->ino_ida);
+	idr_init(&root->ino_idr);
 	INIT_LIST_HEAD(&root->supers);
 
 	kn = __kernfs_new_node(root, "", S_IFDIR | S_IRUGO | S_IXUGO,
 			       KERNFS_DIR);
 	if (!kn) {
-		ida_destroy(&root->ino_ida);
+		idr_destroy(&root->ino_idr);
 		kfree(root);
 		return ERR_PTR(-ENOMEM);
 	}
diff --git a/include/linux/kernfs.h b/include/linux/kernfs.h
index a9b11b8..5f5d602 100644
--- a/include/linux/kernfs.h
+++ b/include/linux/kernfs.h
@@ -163,7 +163,7 @@ struct kernfs_root {
 	unsigned int		flags;	/* KERNFS_ROOT_* flags */
 
 	/* private fields, do not use outside kernfs proper */
-	struct ida		ino_ida;
+	struct idr		ino_idr;
 	struct kernfs_syscall_ops *syscall_ops;
 
 	/* list of kernfs_super_info of this root, protected by kernfs_mutex */
-- 
2.9.3
