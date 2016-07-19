Return-Path: <BATV+a6fbff1bfc78a84bb09b+4713+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: shli@fb.com,
	martin.petersen@oracle.com,
	snitzer@redhat.com,
	sitsofe@yahoo.com,
	linux-block@vger.kernel.org
Subject: [PATCH 2/2] block: don't ignore -EOPNOTSUPP blkdev_issue_write_same
Date: Tue, 19 Jul 2016 11:23:34 +0200
Message-Id: <1468920214-32400-3-git-send-email-hch@lst.de>
In-Reply-To: <1468920214-32400-1-git-send-email-hch@lst.de>
References: <1468920214-32400-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

WRITE SAME is a data integrity operation and we can't simply ignore
errors.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
---
 block/blk-lib.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 45b35b1..e371f83 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -178,7 +178,7 @@ int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 
 	if (bio)
 		ret = submit_bio_wait(bio);
-	return ret != -EOPNOTSUPP ? ret : 0;
+	return ret;
 }
 EXPORT_SYMBOL(blkdev_issue_write_same);
 
-- 
2.1.4
