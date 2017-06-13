Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 04/11] fs: add support for an inode to carry stream related data
Date: Tue, 13 Jun 2017 11:15:16 -0600
Message-Id: <1497374123-15286-5-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
References: <1497374123-15286-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

No functional changes in this patch, just in preparation for
allowing applications to pass in hints about data life times
for writes.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/inode.c         |  1 +
 include/linux/fs.h | 10 ++++++++++
 2 files changed, 11 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index db5914783a71..c911a2b9b5a4 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -149,6 +149,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_blocks = 0;
 	inode->i_bytes = 0;
 	inode->i_generation = 0;
+	inode->i_stream = WRITE_LIFE_UNKNOWN;
 	inode->i_pipe = NULL;
 	inode->i_bdev = NULL;
 	inode->i_cdev = NULL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 803e5a9b2654..bb8c246eeda8 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -30,6 +30,7 @@
 #include <linux/percpu-rwsem.h>
 #include <linux/workqueue.h>
 #include <linux/delayed_call.h>
+#include <linux/blk_types.h>
 
 #include <asm/byteorder.h>
 #include <uapi/linux/fs.h>
@@ -629,6 +630,7 @@ struct inode {
 #ifdef CONFIG_IMA
 	atomic_t		i_readcount; /* struct files open RO */
 #endif
+	unsigned int		i_stream;
 	const struct file_operations	*i_fop;	/* former ->i_op->default_file_ops */
 	struct file_lock_context	*i_flctx;
 	struct address_space	i_data;
@@ -655,6 +657,14 @@ struct inode {
 	void			*i_private; /* fs or device private pointer */
 };
 
+static inline unsigned int inode_streamid(struct inode *inode)
+{
+	if (inode)
+		return inode->i_stream;
+
+	return 0;
+}
+
 static inline unsigned int i_blocksize(const struct inode *node)
 {
 	return (1 << node->i_blkbits);
-- 
2.7.4
