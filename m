Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Shaun Tancheff <shaun@tancheff.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Damien Le Moal <damien.lemoal@hgst.com>,
	Hannes Reinecke <hare@suse.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block: zoned: fix harmless maybe-uninitialized warning
Date: Fri, 21 Oct 2016 17:42:33 +0200
Message-Id: <20161021154242.3707589-1-arnd@arndb.de>
List-ID: <linux-block@vger.kernel.org>

The blkdev_report_zones produces a harmless warning when
-Wmaybe-uninitialized is set, after gcc gets a little confused
about the multiple 'goto' here:

block/blk-zoned.c: In function 'blkdev_report_zones':
block/blk-zoned.c:188:13: error: 'nz' may be used uninitialized in this function [-Werror=maybe-uninitialized]

Moving the assignment to nr_zones makes this a little simpler
while also avoiding the warning reliably. I'm removing the
extraneous initialization of 'int ret' in the same patch, as
that is semi-related and could cause an uninitialized use of
that variable to not produce a warning.

Fixes: 6a0cb1bc106f ("block: Implement support for zoned block devices")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/blk-zoned.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 667f95d86695..472211fa183a 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -80,7 +80,7 @@ int blkdev_report_zones(struct block_device *bdev,
 	unsigned int i, n, nz;
 	unsigned int ofst;
 	void *addr;
-	int ret = 0;
+	int ret;
 
 	if (!q)
 		return -ENXIO;
@@ -179,14 +179,12 @@ int blkdev_report_zones(struct block_device *bdev,
 
 	}
 
+	*nr_zones = nz;
 out:
 	bio_for_each_segment_all(bv, bio, i)
 		__free_page(bv->bv_page);
 	bio_put(bio);
 
-	if (ret == 0)
-		*nr_zones = nz;
-
 	return ret;
 }
 EXPORT_SYMBOL_GPL(blkdev_report_zones);
-- 
2.9.0
