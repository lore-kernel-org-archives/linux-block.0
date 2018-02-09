Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: pass inclusive 'lend' parameter to truncate_inode_pages_range
Date: Fri,  9 Feb 2018 22:15:51 +0800
Message-Id: <20180209141551.8927-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

The 'lend' parameter of truncate_inode_pages_range is required to be
inclusive, so follow the rule.

This patch fixes one memory corruption triggered by discard.

Fixes: 351499a172c0 ("block: Invalidate cache on discard v2")
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/ioctl.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index 1668506d8ed8..3884d810efd2 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -225,7 +225,7 @@ static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
 
 	if (start + len > i_size_read(bdev->bd_inode))
 		return -EINVAL;
-	truncate_inode_pages_range(mapping, start, start + len);
+	truncate_inode_pages_range(mapping, start, start + len - 1);
 	return blkdev_issue_discard(bdev, start >> 9, len >> 9,
 				    GFP_KERNEL, flags);
 }
-- 
2.9.5
