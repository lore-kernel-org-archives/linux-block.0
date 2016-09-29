Return-Path: <darrick.wong@oracle.com>
Subject: [PATCH 1/3] block: invalidate the page cache when issuing
 BLKZEROOUT.
From: "Darrick J. Wong" <darrick.wong@oracle.com>
To: axboe@kernel.dk, akpm@linux-foundation.org, darrick.wong@oracle.com
Cc: linux-block@vger.kernel.org, tytso@mit.edu, martin.petersen@oracle.com,
        snitzer@redhat.com, linux-api@vger.kernel.org, bfoster@redhat.com,
        xfs@oss.sgi.com, hch@infradead.org, dm-devel@redhat.com,
        linux-fsdevel@vger.kernel.org, bart.vanassche@sandisk.com,
        Christoph Hellwig <hch@lst.de>
Date: Wed, 28 Sep 2016 17:39:37 -0700
Message-ID: <147510957761.8940.14476876584539116975.stgit@birch.djwong.org>
In-Reply-To: <147510957066.8940.13803086684642725401.stgit@birch.djwong.org>
References: <147510957066.8940.13803086684642725401.stgit@birch.djwong.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

Invalidate the page cache (as a regular O_DIRECT write would do) to avoid
returning stale cache contents at a later time.

Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/ioctl.c |   18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)


diff --git a/block/ioctl.c b/block/ioctl.c
index ed2397f..755119c 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -225,7 +225,8 @@ static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 		unsigned long arg)
 {
 	uint64_t range[2];
-	uint64_t start, len;
+	struct address_space *mapping;
+	uint64_t start, end, len;
 
 	if (!(mode & FMODE_WRITE))
 		return -EBADF;
@@ -235,18 +236,23 @@ static int blk_ioctl_zeroout(struct block_device *bdev, fmode_t mode,
 
 	start = range[0];
 	len = range[1];
+	end = start + len - 1;
 
 	if (start & 511)
 		return -EINVAL;
 	if (len & 511)
 		return -EINVAL;
-	start >>= 9;
-	len >>= 9;
-
-	if (start + len > (i_size_read(bdev->bd_inode) >> 9))
+	if (end >= (uint64_t)i_size_read(bdev->bd_inode))
+		return -EINVAL;
+	if (end < start)
 		return -EINVAL;
 
-	return blkdev_issue_zeroout(bdev, start, len, GFP_KERNEL, false);
+	/* Invalidate the page cache, including dirty pages */
+	mapping = bdev->bd_inode->i_mapping;
+	truncate_inode_pages_range(mapping, start, end);
+
+	return blkdev_issue_zeroout(bdev, start >> 9, len >> 9, GFP_KERNEL,
+				    false);
 }
 
 static int put_ushort(unsigned long arg, unsigned short val)
