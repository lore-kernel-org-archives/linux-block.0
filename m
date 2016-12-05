Return-Path: <krinkin.m.u@gmail.com>
Return-Path: <krinkin.m.u@gmail.com>
From: Mike Krinkin <krinkin.m.u@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org,
	hch@lst.de,
	martin.petersen@oracle.com,
	hare@suse.de,
	shaun@tancheff.com,
	damien.lemoal@hgst.com,
	shaun.tancheff@seagate.com,
	chaitanya.kulkarni@hgst.com,
	Mike Krinkin <krinkin.m.u@gmail.com>
Subject: [PATCH] block: Add missed break in generic_make_request_checks
Date: Tue,  6 Dec 2016 00:18:20 +0300
Message-Id: <1480972700-3873-1-git-send-email-krinkin.m.u@gmail.com>
List-ID: <linux-block@vger.kernel.org>

With recent linux-next i started to get this error:

[   19.746764] EXT4-fs (sda6): Delayed block allocation failed for inode 4999023 at logical offset 0 with max blocks 6 with error 95
[   19.746767] EXT4-fs (sda6): This should not happen!! Data will be lost

Bisect points at the commit e73c23ff736e ("block: add async variant of
blkdev_issue_zeroout") but i think that the real problem is a missed
break in the commit 2d253440b5af ("block: Define zoned block device
operations").

Fixes: 2d253440b5af ("block: Define zoned block device operations")
Signed-off-by: Mike Krinkin <krinkin.m.u@gmail.com>
---
 block/blk-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/block/blk-core.c b/block/blk-core.c
index 24de87d..1998aa4 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -1947,6 +1947,7 @@ generic_make_request_checks(struct bio *bio)
 	case REQ_OP_WRITE_SAME:
 		if (!bdev_write_same(bio->bi_bdev))
 			goto not_supported;
+		break;
 	case REQ_OP_ZONE_REPORT:
 	case REQ_OP_ZONE_RESET:
 		if (!bdev_is_zoned(bio->bi_bdev))
-- 
2.7.4
