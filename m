Return-Path: <rgoldwyn@suse.de>
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: axboe@kernel.dk
Cc: viro@ZenIV.linux.org.uk,
	hch@lst.de,
	jack@suse.cz,
	akpm@linux-foundation.org,
	linux-block@vger.kernel.org,
	Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH 08/10] ext4: nowait aio support
Date: Tue, 20 Jun 2017 07:05:47 -0500
Message-Id: <20170620120549.23147-9-rgoldwyn@suse.de>
In-Reply-To: <20170620120549.23147-1-rgoldwyn@suse.de>
References: <20170620120549.23147-1-rgoldwyn@suse.de>
List-ID: <linux-block@vger.kernel.org>

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

Return EAGAIN if any of the following checks fail for direct I/O:
  + i_rwsem is lockable
  + Writing beyond end of file (will trigger allocation)
  + Blocks are not allocated at the write location

Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/ext4/file.c | 35 +++++++++++++++++++++++++++++------
 1 file changed, 29 insertions(+), 6 deletions(-)

diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 02ce7e7bbdf5..58e2eeaa0bc4 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -37,7 +37,11 @@ static ssize_t ext4_dax_read_iter(struct kiocb *iocb, struct iov_iter *to)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t ret;
 
-	inode_lock_shared(inode);
+	if (!inode_trylock_shared(inode)) {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EAGAIN;
+		inode_lock_shared(inode);
+	}
 	/*
 	 * Recheck under inode lock - at this point we are sure it cannot
 	 * change anymore
@@ -179,7 +183,11 @@ ext4_dax_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	struct inode *inode = file_inode(iocb->ki_filp);
 	ssize_t ret;
 
-	inode_lock(inode);
+	if (!inode_trylock(inode)) {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EAGAIN;
+		inode_lock(inode);
+	}
 	ret = ext4_write_checks(iocb, from);
 	if (ret <= 0)
 		goto out;
@@ -216,7 +224,12 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 		return ext4_dax_write_iter(iocb, from);
 #endif
 
-	inode_lock(inode);
+	if (!inode_trylock(inode)) {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EAGAIN;
+		inode_lock(inode);
+	}
+
 	ret = ext4_write_checks(iocb, from);
 	if (ret <= 0)
 		goto out;
@@ -235,9 +248,15 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 
 	iocb->private = &overwrite;
 	/* Check whether we do a DIO overwrite or not */
-	if (o_direct && ext4_should_dioread_nolock(inode) && !unaligned_aio &&
-	    ext4_overwrite_io(inode, iocb->ki_pos, iov_iter_count(from)))
-		overwrite = 1;
+	if (o_direct && !unaligned_aio) {
+		if (ext4_overwrite_io(inode, iocb->ki_pos, iov_iter_count(from))) {
+			if (ext4_should_dioread_nolock(inode))
+				overwrite = 1;
+		} else if (iocb->ki_flags & IOCB_NOWAIT) {
+			ret = -EAGAIN;
+			goto out;
+		}
+	}
 
 	ret = __generic_file_write_iter(iocb, from);
 	inode_unlock(inode);
@@ -435,6 +454,10 @@ static int ext4_file_open(struct inode * inode, struct file * filp)
 		if (ret < 0)
 			return ret;
 	}
+
+	/* Set the flags to support nowait AIO */
+	filp->f_mode |= FMODE_AIO_NOWAIT;
+
 	return dquot_file_open(inode, filp);
 }
 
-- 
2.12.0
