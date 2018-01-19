Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:43293 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1750784AbeASA5w (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 18 Jan 2018 19:57:52 -0500
From: Goldwyn Rodrigues <rgoldwyn@suse.de>
To: linux-block@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, darrick.wong@oracle.com,
        Goldwyn Rodrigues <rgoldwyn@suse.com>
Subject: [PATCH v5 1/2] Return bytes transferred for partial direct I/O
Date: Thu, 18 Jan 2018 18:57:40 -0600
Message-Id: <20180119005741.32058-1-rgoldwyn@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Goldwyn Rodrigues <rgoldwyn@suse.com>

In case direct I/O encounters an error midway, it returns the error.
Instead it should be returning the number of bytes transferred so far.

Test case for filesystems (with ENOSPC):
1. Create an almost full filesystem
2. Create a file, say /mnt/lastfile, until the filesystem is full.
3. Direct write() with count > sizeof /mnt/lastfile.

Result: write() returns -ENOSPC. However, file content has data written
in step 3.

This fixes fstest generic/472.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Goldwyn Rodrigues <rgoldwyn@suse.com>
---
 fs/block_dev.c |  2 +-
 fs/direct-io.c |  4 +---
 fs/iomap.c     | 20 ++++++++++----------
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 4a181fcb5175..49d94360bb51 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -409,7 +409,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 
 	if (!ret)
 		ret = blk_status_to_errno(dio->bio.bi_status);
-	if (likely(!ret))
+	if (likely(dio->size))
 		ret = dio->size;
 
 	bio_put(&dio->bio);
diff --git a/fs/direct-io.c b/fs/direct-io.c
index 3aafb3343a65..0c98b6e65d7c 100644
--- a/fs/direct-io.c
+++ b/fs/direct-io.c
@@ -262,8 +262,6 @@ static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
 		ret = dio->page_errors;
 	if (ret == 0)
 		ret = dio->io_error;
-	if (ret == 0)
-		ret = transferred;
 
 	if (dio->end_io) {
 		// XXX: ki_pos??
@@ -310,7 +308,7 @@ static ssize_t dio_complete(struct dio *dio, ssize_t ret, unsigned int flags)
 	}
 
 	kmem_cache_free(dio_cache, dio);
-	return ret;
+	return transferred ? transferred : ret;
 }
 
 static void dio_aio_complete_work(struct work_struct *work)
diff --git a/fs/iomap.c b/fs/iomap.c
index 47d29ccffaef..cab57d85404e 100644
--- a/fs/iomap.c
+++ b/fs/iomap.c
@@ -716,23 +716,23 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	struct kiocb *iocb = dio->iocb;
 	struct inode *inode = file_inode(iocb->ki_filp);
 	loff_t offset = iocb->ki_pos;
-	ssize_t ret;
+	ssize_t err;
+	ssize_t transferred = dio->size;
 
 	if (dio->end_io) {
-		ret = dio->end_io(iocb,
-				dio->error ? dio->error : dio->size,
+		err = dio->end_io(iocb,
+				transferred ? transferred : dio->error,
 				dio->flags);
 	} else {
-		ret = dio->error;
+		err = dio->error;
 	}
 
-	if (likely(!ret)) {
-		ret = dio->size;
+	if (likely(transferred)) {
 		/* check for short read */
-		if (offset + ret > dio->i_size &&
+		if (offset + transferred > dio->i_size &&
 		    !(dio->flags & IOMAP_DIO_WRITE))
-			ret = dio->i_size - offset;
-		iocb->ki_pos += ret;
+			transferred = dio->i_size - offset;
+		iocb->ki_pos += transferred;
 	}
 
 	/*
@@ -759,7 +759,7 @@ static ssize_t iomap_dio_complete(struct iomap_dio *dio)
 	inode_dio_end(file_inode(iocb->ki_filp));
 	kfree(dio);
 
-	return ret;
+	return transferred ? transferred : err;
 }
 
 static void iomap_dio_complete_work(struct work_struct *work)
-- 
2.15.1
