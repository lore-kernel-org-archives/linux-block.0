Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: adilger@dilger.ca,
	Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/10] fs: add support for an inode to carry stream related data
Date: Tue, 13 Jun 2017 22:01:52 -0600
Message-Id: <1497412919-19400-4-git-send-email-axboe@kernel.dk>
In-Reply-To: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
References: <1497412919-19400-1-git-send-email-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

No functional changes in this patch, just in preparation for
allowing applications to pass in hints about data life times
for writes.

Pack the i_stream field into a 2-byte hole, so we don't grow
the size of the inode.

Reviewed-by: Andreas Dilger <adilger@dilger.ca>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/inode.c         | 1 +
 include/linux/fs.h | 9 +++++++++
 2 files changed, 10 insertions(+)

diff --git a/fs/inode.c b/fs/inode.c
index db5914783a71..5717cb378fda 100644
--- a/fs/inode.c
+++ b/fs/inode.c
@@ -149,6 +149,7 @@ int inode_init_always(struct super_block *sb, struct inode *inode)
 	inode->i_blocks = 0;
 	inode->i_bytes = 0;
 	inode->i_generation = 0;
+	inode->i_stream = 0;
 	inode->i_pipe = NULL;
 	inode->i_bdev = NULL;
 	inode->i_cdev = NULL;
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 803e5a9b2654..771e172d23d7 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -591,6 +591,7 @@ struct inode {
 	struct timespec		i_ctime;
 	spinlock_t		i_lock;	/* i_blocks, i_bytes, maybe i_size */
 	unsigned short          i_bytes;
+	unsigned short		i_stream;
 	unsigned int		i_blkbits;
 	blkcnt_t		i_blocks;
 
@@ -655,6 +656,14 @@ struct inode {
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
