Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Dave Chinner <dchinner@redhat.com>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"Darrick J . Wong" <darrick.wong@oracle.com>,
	xfs@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 5/5] xfs: use block layer helpers to allocate io buffer from slab
Date: Thu, 18 Oct 2018 21:18:17 +0800
Message-Id: <20181018131817.11813-6-ming.lei@redhat.com>
In-Reply-To: <20181018131817.11813-1-ming.lei@redhat.com>
References: <20181018131817.11813-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

XFS may use kmalloc() to allocate io buffer, this way may not respect
request queue's DMA alignment limit, and cause data corruption.

This patch uses the introduced block layer helpers to allocate this
kind of io buffer, and makes sure that DMA alignment is respected.

Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: xfs@vger.kernel.org
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Matthew Wilcox <willy@infradead.org>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 fs/xfs/xfs_buf.c   | 28 +++++++++++++++++++++++++---
 fs/xfs/xfs_super.c | 13 ++++++++++++-
 2 files changed, 37 insertions(+), 4 deletions(-)

diff --git a/fs/xfs/xfs_buf.c b/fs/xfs/xfs_buf.c
index e839907e8492..fabee5e1706b 100644
--- a/fs/xfs/xfs_buf.c
+++ b/fs/xfs/xfs_buf.c
@@ -314,12 +314,34 @@ xfs_buf_free(
 			__free_page(page);
 		}
 	} else if (bp->b_flags & _XBF_KMEM)
-		kmem_free(bp->b_addr);
+		bdev_free_sec_buf(bp->b_target->bt_bdev, bp->b_addr,
+				BBTOB(bp->b_length));
 	_xfs_buf_free_pages(bp);
 	xfs_buf_free_maps(bp);
 	kmem_zone_free(xfs_buf_zone, bp);
 }
 
+void *
+xfs_buf_allocate_memory_from_slab(xfs_buf_t *bp, int size)
+{
+	int	retries = 0;
+	gfp_t	lflags = kmem_flags_convert(KM_NOFS);
+	void	*ptr;
+
+	do {
+		ptr = bdev_alloc_sec_buf(bp->b_target->bt_bdev, size, lflags);
+		if (ptr)
+			return ptr;
+		if (!(++retries % 100))
+			xfs_err(NULL,
+	"%s(%u) possible memory allocation deadlock size %u in %s (mode:0x%x)",
+				current->comm, current->pid,
+				(unsigned int)size, __func__, lflags);
+		congestion_wait(BLK_RW_ASYNC, HZ/50);
+	} while (1);
+
+}
+
 /*
  * Allocates all the pages for buffer in question and builds it's page list.
  */
@@ -342,7 +364,7 @@ xfs_buf_allocate_memory(
 	 */
 	size = BBTOB(bp->b_length);
 	if (size < PAGE_SIZE) {
-		bp->b_addr = kmem_alloc(size, KM_NOFS);
+		bp->b_addr = xfs_buf_allocate_memory_from_slab(bp, size);
 		if (!bp->b_addr) {
 			/* low memory - use alloc_page loop instead */
 			goto use_alloc_page;
@@ -351,7 +373,7 @@ xfs_buf_allocate_memory(
 		if (((unsigned long)(bp->b_addr + size - 1) & PAGE_MASK) !=
 		    ((unsigned long)bp->b_addr & PAGE_MASK)) {
 			/* b_addr spans two pages - use alloc_page instead */
-			kmem_free(bp->b_addr);
+			bdev_free_sec_buf(bp->b_target->bt_bdev, bp->b_addr, size);
 			bp->b_addr = NULL;
 			goto use_alloc_page;
 		}
diff --git a/fs/xfs/xfs_super.c b/fs/xfs/xfs_super.c
index 207ee302b1bb..026cdae3aa4f 100644
--- a/fs/xfs/xfs_super.c
+++ b/fs/xfs/xfs_super.c
@@ -664,6 +664,10 @@ xfs_blkdev_get(
 		xfs_warn(mp, "Invalid device [%s], error=%d", name, error);
 	}
 
+	error = bdev_create_sec_buf_slabs(*bdevp);
+	if (error)
+		blkdev_put(*bdevp, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
+
 	return error;
 }
 
@@ -671,8 +675,10 @@ STATIC void
 xfs_blkdev_put(
 	struct block_device	*bdev)
 {
-	if (bdev)
+	if (bdev) {
+		bdev_destroy_sec_buf_slabs(bdev);
 		blkdev_put(bdev, FMODE_READ|FMODE_WRITE|FMODE_EXCL);
+	}
 }
 
 void
@@ -706,6 +712,8 @@ xfs_close_devices(
 	}
 	xfs_free_buftarg(mp->m_ddev_targp);
 	fs_put_dax(dax_ddev);
+
+	bdev_destroy_sec_buf_slabs(mp->m_super->s_bdev);
 }
 
 /*
@@ -774,6 +782,9 @@ xfs_open_devices(
 		mp->m_logdev_targp = mp->m_ddev_targp;
 	}
 
+	if (bdev_create_sec_buf_slabs(ddev))
+		goto out_free_rtdev_targ;
+
 	return 0;
 
  out_free_rtdev_targ:
-- 
2.9.5
