Return-Path: <BATV+2972572aac770b70d036+5119+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: viro@zeniv.linux.org.uk,
	axboe@kernel.dk
Cc: Milosz Tanski <milosz@adfin.com>,
	Goldwyn Rodrigues <rgoldwyn@suse.com>,
	mgorman@suse.de,
	Volker.Lendecke@sernet.de,
	linux-fsdevel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH 3/4] fs: support RWF_NOWAIT for buffered reads
Date: Tue, 29 Aug 2017 16:13:20 +0200
Message-Id: <20170829141321.4482-4-hch@lst.de>
In-Reply-To: <20170829141321.4482-1-hch@lst.de>
References: <20170829141321.4482-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This is based on the old idea and code from Milosz Tanski.  With the aio
nowait code it becomes mostly trivial now.  Buffered writes continue to
return -EOPNOTSUPP if RWF_NOWAIT is passed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 fs/aio.c           |  6 ------
 fs/btrfs/file.c    |  6 +++++-
 fs/ext4/file.c     |  6 +++---
 fs/xfs/xfs_file.c  | 11 +++++++++--
 include/linux/fs.h |  6 +++---
 5 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index dcad3a66748c..d93daa076726 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1593,12 +1593,6 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		goto out_put_req;
 	}
 
-	if ((req->common.ki_flags & IOCB_NOWAIT) &&
-			!(req->common.ki_flags & IOCB_DIRECT)) {
-		ret = -EOPNOTSUPP;
-		goto out_put_req;
-	}
-
 	ret = put_user(KIOCB_KEY, &user_iocb->aio_key);
 	if (unlikely(ret)) {
 		pr_debug("EFAULT: aio_key\n");
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 9e75d8a39aac..e62dd55b4079 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1886,6 +1886,10 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	loff_t oldsize;
 	int clean_page = 0;
 
+	if (!(iocb->ki_flags & IOCB_DIRECT) &&
+	    (iocb->ki_flags & IOCB_NOWAIT))
+		return -EOPNOTSUPP;
+
 	if (!inode_trylock(inode)) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
 			return -EAGAIN;
@@ -3105,7 +3109,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 
 static int btrfs_file_open(struct inode *inode, struct file *filp)
 {
-	filp->f_mode |= FMODE_AIO_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT;
 	return generic_file_open(inode, filp);
 }
 
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 0d7cf0cc9b87..f83521337b8f 100644
--- a/fs/ext4/file.c
+++ b/fs/ext4/file.c
@@ -223,6 +223,8 @@ ext4_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	if (IS_DAX(inode))
 		return ext4_dax_write_iter(iocb, from);
 #endif
+	if (!o_direct && (iocb->ki_flags & IOCB_NOWAIT))
+		return -EOPNOTSUPP;
 
 	if (!inode_trylock(inode)) {
 		if (iocb->ki_flags & IOCB_NOWAIT)
@@ -448,9 +450,7 @@ static int ext4_file_open(struct inode * inode, struct file * filp)
 			return ret;
 	}
 
-	/* Set the flags to support nowait AIO */
-	filp->f_mode |= FMODE_AIO_NOWAIT;
-
+	filp->f_mode |= FMODE_NOWAIT;
 	return dquot_file_open(inode, filp);
 }
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index c4893e226fd8..1a09104b3eb0 100644
--- a/fs/xfs/xfs_file.c
+++ b/fs/xfs/xfs_file.c
@@ -259,7 +259,11 @@ xfs_file_buffered_aio_read(
 
 	trace_xfs_file_buffered_read(ip, iov_iter_count(to), iocb->ki_pos);
 
-	xfs_ilock(ip, XFS_IOLOCK_SHARED);
+	if (!xfs_ilock_nowait(ip, XFS_IOLOCK_SHARED)) {
+		if (iocb->ki_flags & IOCB_NOWAIT)
+			return -EAGAIN;
+		xfs_ilock(ip, XFS_IOLOCK_SHARED);
+	}
 	ret = generic_file_read_iter(iocb, to);
 	xfs_iunlock(ip, XFS_IOLOCK_SHARED);
 
@@ -636,6 +640,9 @@ xfs_file_buffered_aio_write(
 	int			enospc = 0;
 	int			iolock;
 
+	if (iocb->ki_flags & IOCB_NOWAIT)
+		return -EOPNOTSUPP;
+
 write_retry:
 	iolock = XFS_IOLOCK_EXCL;
 	xfs_ilock(ip, iolock);
@@ -912,7 +919,7 @@ xfs_file_open(
 		return -EFBIG;
 	if (XFS_FORCED_SHUTDOWN(XFS_M(inode->i_sb)))
 		return -EIO;
-	file->f_mode |= FMODE_AIO_NOWAIT;
+	file->f_mode |= FMODE_NOWAIT;
 	return 0;
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 6e1fd5d21248..ded258edc425 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -146,8 +146,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File was opened by fanotify and shouldn't generate fanotify events */
 #define FMODE_NONOTIFY		((__force fmode_t)0x4000000)
 
-/* File is capable of returning -EAGAIN if AIO will block */
-#define FMODE_AIO_NOWAIT	((__force fmode_t)0x8000000)
+/* File is capable of returning -EAGAIN if I/O will block */
+#define FMODE_NOWAIT	((__force fmode_t)0x8000000)
 
 /*
  * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
@@ -3149,7 +3149,7 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, int flags)
 		return -EOPNOTSUPP;
 
 	if (flags & RWF_NOWAIT) {
-		if (!(ki->ki_filp->f_mode & FMODE_AIO_NOWAIT))
+		if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
 			return -EOPNOTSUPP;
 		ki->ki_flags |= IOCB_NOWAIT;
 	}
-- 
2.11.0
