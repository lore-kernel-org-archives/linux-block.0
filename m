Return-Path: <BATV+49f9428214963ec94ced+5065+infradead.org+hch@bombadil.srs.infradead.org>
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
Date: Thu,  6 Jul 2017 08:30:18 -0700
Message-Id: <20170706153019.11645-4-hch@lst.de>
In-Reply-To: <20170706153019.11645-1-hch@lst.de>
References: <20170706153019.11645-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This is based on the old idea and code from Milosz Tanski.  With the aio
nowait code it becomes mostly trivial now.  Buffered writes continue to
return -EOPNOTSUPP if RWF_NOWAIT is passed.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/aio.c           |  6 ------
 fs/btrfs/file.c    |  9 ++++++---
 fs/ext4/file.c     |  6 +++---
 fs/xfs/xfs_file.c  | 11 +++++++++--
 include/linux/fs.h |  6 +++---
 5 files changed, 21 insertions(+), 17 deletions(-)

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
index 24338702ea5b..0ecf90db049d 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -1886,11 +1886,14 @@ static ssize_t btrfs_file_write_iter(struct kiocb *iocb,
 	loff_t oldsize;
 	int clean_page = 0;
 
-	if ((iocb->ki_flags & IOCB_NOWAIT) &&
-			(iocb->ki_flags & IOCB_DIRECT)) {
+	if (iocb->ki_flags & IOCB_NOWAIT) {
+		if (!(iocb->ki_flags & IOCB_DIRECT))
+			return -EOPNOTSUPP;
+
 		/* Don't sleep on inode rwsem */
 		if (!inode_trylock(inode))
 			return -EAGAIN;
+
 		/*
 		 * We will allocate space in case nodatacow is not set,
 		 * so bail
@@ -3100,7 +3103,7 @@ static loff_t btrfs_file_llseek(struct file *file, loff_t offset, int whence)
 
 static int btrfs_file_open(struct inode *inode, struct file *filp)
 {
-	filp->f_mode |= FMODE_AIO_NOWAIT;
+	filp->f_mode |= FMODE_NOWAIT;
 	return generic_file_open(inode, filp);
 }
 
diff --git a/fs/ext4/file.c b/fs/ext4/file.c
index 58e2eeaa0bc4..da7c66e05408 100644
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
@@ -455,9 +457,7 @@ static int ext4_file_open(struct inode * inode, struct file * filp)
 			return ret;
 	}
 
-	/* Set the flags to support nowait AIO */
-	filp->f_mode |= FMODE_AIO_NOWAIT;
-
+	filp->f_mode |= FMODE_NOWAIT;
 	return dquot_file_open(inode, filp);
 }
 
diff --git a/fs/xfs/xfs_file.c b/fs/xfs/xfs_file.c
index 17f27a2fb5e2..f6b9f9ae4d3c 100644
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
@@ -911,7 +918,7 @@ xfs_file_open(
 		return -EFBIG;
 	if (XFS_FORCED_SHUTDOWN(XFS_M(inode->i_sb)))
 		return -EIO;
-	file->f_mode |= FMODE_AIO_NOWAIT;
+	file->f_mode |= FMODE_NOWAIT;
 	return 0;
 }
 
diff --git a/include/linux/fs.h b/include/linux/fs.h
index 818568c8e5ed..9380c40b498b 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -144,8 +144,8 @@ typedef int (dio_iodone_t)(struct kiocb *iocb, loff_t offset,
 /* File was opened by fanotify and shouldn't generate fanotify events */
 #define FMODE_NONOTIFY		((__force fmode_t)0x4000000)
 
-/* File is capable of returning -EAGAIN if AIO will block */
-#define FMODE_AIO_NOWAIT	((__force fmode_t)0x8000000)
+/* File is capable of returning -EAGAIN if I/O will block */
+#define FMODE_NOWAIT	((__force fmode_t)0x8000000)
 
 /*
  * Flag for rw_copy_check_uvector and compat_rw_copy_check_uvector
@@ -3094,7 +3094,7 @@ static inline int kiocb_set_rw_flags(struct kiocb *ki, int flags)
 		return -EOPNOTSUPP;
 
 	if (flags & RWF_NOWAIT) {
-		if (!(ki->ki_filp->f_mode & FMODE_AIO_NOWAIT))
+		if (!(ki->ki_filp->f_mode & FMODE_NOWAIT))
 			return -EOPNOTSUPP;
 		ki->ki_flags |= IOCB_NOWAIT;
 	}
-- 
2.11.0
