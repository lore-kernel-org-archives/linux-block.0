Return-Path: <nicstange@gmail.com>
Return-Path: <nicstange@gmail.com>
From: Nicolai Stange <nicstange@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: Chaitanya Kulkarni <chaitanya.kulkarni@hgst.com>,
	Shaun Tancheff <shaun.tancheff@seagate.com>,
	Damien Le Moal <damien.lemoal@hgst.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Nicolai Stange <nicstange@gmail.com>
Subject: [PATCH] block: fix unintended fallthrough in generic_make_request_checks()
Date: Sun,  4 Dec 2016 14:56:39 +0100
Message-Id: <20161204135639.7016-1-nicstange@gmail.com>
List-ID: <linux-block@vger.kernel.org>

Since commit e73c23ff736e ("block: add async variant of
blkdev_issue_zeroout") messages like the following show up:

  EXT4-fs (dm-1): Delayed block allocation failed for inode 2368848 at
                  logical offset 0 with max blocks 1 with error 95
  EXT4-fs (dm-1): This should not happen!! Data will be lost

Due to the following fallthrough introduced with
commit 2d253440b5af ("block: Define zoned block device operations"),
generic_make_request_checks() would accept a REQ_OP_WRITE_SAME bio only
if the block device supports "write same" *and* is a zoned one:

  switch (bio_op(bio)) {
  [...]
  case REQ_OP_WRITE_SAME:
        if (!bdev_write_same(bio->bi_bdev))
                goto not_supported;
  case REQ_OP_ZONE_REPORT:
  case REQ_OP_ZONE_RESET:
                if (!bdev_is_zoned(bio->bi_bdev))
                        goto not_supported;
                break;
  [...]
  }

Thus, although the bio setup as done by __blkdev_issue_write_same() from
commit e73c23ff736e ("block: add async variant of blkdev_issue_zeroout")
would succeed, its actual submission would not, resulting in the
EOPNOTSUPP == 95.

Fix this by removing the fallthrough which, due to the lack of an explicit
comment, seems to be unintended anyway.

Fixes: e73c23ff736e ("block: add async variant of blkdev_issue_zeroout")
Fixes: 2d253440b5af ("block: Define zoned block device operations")
Signed-off-by: Nicolai Stange <nicstange@gmail.com>
---
Applicable to next-20161202.

Note that after this patch, I'm seeing a single
 EXT4-fs (dm-1): Delayed block allocation failed for inode 2625094 at
                 logical offset 2032 with max blocks 2 with error 121
with 121 == EREMOTEIO

This is because my SATA sda reports 0x20 (invalid command) back
in response to 0x41 (WRITE_SAME).

After this has happened, sd_done() disables "write same" once and for
all, hence only this single message.

I expect this to get fixed by
  https://patchwork.kernel.org/patch/9321963/

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
2.10.2
