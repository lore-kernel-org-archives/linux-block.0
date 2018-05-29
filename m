Return-Path: <BATV+a01a3e67072ae75c0352+5392+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/2] block: unexport check_disk_size_change
Date: Tue, 29 May 2018 16:42:58 +0200
Message-Id: <20180529144259.29819-2-hch@lst.de>
In-Reply-To: <20180529144259.29819-1-hch@lst.de>
References: <20180529144259.29819-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Only used in block_dev.c and the partitions code, and it should remain
that way..

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Johannes Thumshirn <jthumshirn@suse.de>
---
 fs/block_dev.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7ec920e27065..771ddfa29dc9 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1342,7 +1342,6 @@ void check_disk_size_change(struct gendisk *disk, struct block_device *bdev)
 			flush_disk(bdev, false);
 	}
 }
-EXPORT_SYMBOL(check_disk_size_change);
 
 /**
  * revalidate_disk - wrapper for lower-level driver's revalidate_disk call-back
-- 
2.17.0
