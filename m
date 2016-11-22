Return-Path: <Damien.LeMoal@wdc.com>
From: Damien Le Moal <damien.lemoal@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
CC: <linux-block@vger.kernel.org>, Christoph Hellwig <hch@lst.de>, Damien Le
 Moal <damien.lemoal@wdc.com>
Subject: [PATCH 1/1] block_dev: Fixed direct I/O bio sector calculation
Date: Tue, 22 Nov 2016 15:38:49 +0900
Message-ID: <1479796729-25517-1-git-send-email-damien.lemoal@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: damien.lemoal@wdc.com
List-ID: <linux-block@vger.kernel.org>

A direct I/O alignment must be always checked against the device blocks size,
but the I/O offset (bio->bi_iter.bi_sector must always use 512B sector unit, and
not the actual logical block size.

Signed-off-by: Damien Le Moal <damien.lemoal@wdc.com>
---
 fs/block_dev.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 35cc494..e49fb79 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -226,7 +226,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	bio.bi_max_vecs = nr_pages;
 	bio.bi_io_vec = vecs;
 	bio.bi_bdev = bdev;
-	bio.bi_iter.bi_sector = pos >> blkbits;
+	bio.bi_iter.bi_sector = pos >> 9;
 	bio.bi_private = current;
 	bio.bi_end_io = blkdev_bio_end_io_simple;
 
@@ -358,7 +358,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 
 	for (;;) {
 		bio->bi_bdev = bdev;
-		bio->bi_iter.bi_sector = pos >> blkbits;
+		bio->bi_iter.bi_sector = pos >> 9;
 		bio->bi_private = dio;
 		bio->bi_end_io = blkdev_bio_end_io;
 
-- 
2.7.4

Western Digital Corporation (and its subsidiaries) E-mail Confidentiality Notice & Disclaimer:

This e-mail and any files transmitted with it may contain confidential or legally privileged information of WDC and/or its affiliates, and are intended solely for the use of the individual or entity to which they are addressed. If you are not the intended recipient, any disclosure, copying, distribution or any action taken or omitted to be taken in reliance on it, is prohibited. If you have received this e-mail in error, please notify the sender immediately and delete the e-mail in its entirety from your system.
