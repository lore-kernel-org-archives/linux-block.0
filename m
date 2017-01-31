Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f173.google.com ([209.85.192.173]:34367 "EHLO
        mail-pf0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750796AbdAaWyH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2017 17:54:07 -0500
Received: by mail-pf0-f173.google.com with SMTP id e4so112113964pfg.1
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2017 14:54:07 -0800 (PST)
From: Omar Sandoval <osandov@osandov.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: kernel-team@fb.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: [PATCH 1/6] debugfs: add debugfs_lookup()
Date: Tue, 31 Jan 2017 14:53:17 -0800
Message-Id: <0b6ca2b7f686cd19177034ad26f96a86dd34009e.1485902856.git.osandov@fb.com>
In-Reply-To: <cover.1485902856.git.osandov@fb.com>
References: <cover.1485902856.git.osandov@fb.com>
In-Reply-To: <cover.1485902856.git.osandov@fb.com>
References: <cover.1485902856.git.osandov@fb.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Omar Sandoval <osandov@fb.com>

We don't always have easy access to the dentry of a file or directory we
created in debugfs. Add a helper which allows us to get a dentry we
previously created.

The motivation for this change is a problem with blktrace and the blk-mq
debugfs entries introduced in 07e4fead45e6 ("blk-mq: create debugfs
directory tree"). Namely, in some cases, the directory that blktrace
needs to create may already exist, but in other cases, it may not. We
_could_ rely on a bunch of implied knowledge to decide whether to create
the directory or not, but it's much cleaner on our end to just look it
up.

Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Signed-off-by: Omar Sandoval <osandov@fb.com>
---
 fs/debugfs/inode.c      | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/debugfs.h |  8 ++++++++
 2 files changed, 44 insertions(+)

diff --git a/fs/debugfs/inode.c b/fs/debugfs/inode.c
index f17fcf89e18e..7fb1732a3630 100644
--- a/fs/debugfs/inode.c
+++ b/fs/debugfs/inode.c
@@ -248,6 +248,42 @@ static struct file_system_type debug_fs_type = {
 };
 MODULE_ALIAS_FS("debugfs");
 
+/**
+ * debugfs_lookup() - look up an existing debugfs file
+ * @name: a pointer to a string containing the name of the file to look up.
+ * @parent: a pointer to the parent dentry of the file.
+ *
+ * This function will return a pointer to a dentry if it succeeds.  If the file
+ * doesn't exist or an error occurs, %NULL will be returned.  The returned
+ * dentry must be passed to dput() when it is no longer needed.
+ *
+ * If debugfs is not enabled in the kernel, the value -%ENODEV will be
+ * returned.
+ */
+struct dentry *debugfs_lookup(const char *name, struct dentry *parent)
+{
+	struct dentry *dentry;
+
+	if (IS_ERR(parent))
+		return NULL;
+
+	if (!parent)
+		parent = debugfs_mount->mnt_root;
+
+	inode_lock(d_inode(parent));
+	dentry = lookup_one_len(name, parent, strlen(name));
+	inode_unlock(d_inode(parent));
+
+	if (IS_ERR(dentry))
+		return NULL;
+	if (!d_really_is_positive(dentry)) {
+		dput(dentry);
+		return NULL;
+	}
+	return dentry;
+}
+EXPORT_SYMBOL_GPL(debugfs_lookup);
+
 static struct dentry *start_creating(const char *name, struct dentry *parent)
 {
 	struct dentry *dentry;
diff --git a/include/linux/debugfs.h b/include/linux/debugfs.h
index 014cc564d1c4..c0befcf41b58 100644
--- a/include/linux/debugfs.h
+++ b/include/linux/debugfs.h
@@ -80,6 +80,8 @@ static const struct file_operations __fops = {				\
 
 #if defined(CONFIG_DEBUG_FS)
 
+struct dentry *debugfs_lookup(const char *name, struct dentry *parent);
+
 struct dentry *debugfs_create_file(const char *name, umode_t mode,
 				   struct dentry *parent, void *data,
 				   const struct file_operations *fops);
@@ -181,6 +183,12 @@ ssize_t debugfs_write_file_bool(struct file *file, const char __user *user_buf,
  * want to duplicate the design decision mistakes of procfs and devfs again.
  */
 
+static inline struct dentry *debugfs_lookup(const char *name,
+					    struct dentry *parent)
+{
+	return ERR_PTR(-ENODEV);
+}
+
 static inline struct dentry *debugfs_create_file(const char *name, umode_t mode,
 					struct dentry *parent, void *data,
 					const struct file_operations *fops)
-- 
2.11.0

