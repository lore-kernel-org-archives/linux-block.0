Return-Path: <BATV+7138d8dfc060164c836f+5389+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: linux-nvme@lists.infradead.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	Sagi Grimberg <sagi@grimberg.me>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org
Subject: [PATCH 01/14] block: unexport check_disk_size_change
Date: Sat, 26 May 2018 12:27:22 +0200
Message-Id: <20180526102735.31404-2-hch@lst.de>
In-Reply-To: <20180526102735.31404-1-hch@lst.de>
References: <20180526102735.31404-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Only used in block_dev.c and the partitions code, and it should remain
that way..

Signed-off-by: Christoph Hellwig <hch@lst.de>
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
