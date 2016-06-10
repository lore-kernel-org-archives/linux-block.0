Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:39805 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750756AbcFJCEn (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 9 Jun 2016 22:04:43 -0400
To: Shaohua Li <shli@fb.com>
Cc: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<axboe@fb.com>, <sitsofe@yahoo.com>, <snitzer@redhat.com>,
	<martin.petersen@oracle.com>, <hch@infradead.org>,
	<Kernel-team@fb.com>
Subject: Re: [PATCH V2] block: correctly fallback for zeroout
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20160606223357.GA52883@shli-mbp.local>
Date: Thu, 09 Jun 2016 22:04:08 -0400
In-Reply-To: <20160606223357.GA52883@shli-mbp.local> (Shaohua Li's message of
	"Mon, 6 Jun 2016 15:33:58 -0700")
Message-ID: <yq18tydiyuf.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Shaohua" == Shaohua Li <shli@fb.com> writes:

Shaohua,

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 23d7f30..a3a26c8 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -84,6 +84,28 @@ int __blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 }
 EXPORT_SYMBOL(__blkdev_issue_discard);
 
+static int do_blkdev_issue_discard(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask, unsigned long flags,
+		int *io_err)
+{
+	int type = REQ_WRITE | REQ_DISCARD;
+	struct bio *bio = NULL;
+	struct blk_plug plug;
+	int ret;
+
+	if (flags & BLKDEV_DISCARD_SECURE)
+		type |= REQ_SECURE;
+
+	blk_start_plug(&plug);
+	ret = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, type,
+			&bio);
+	if (!ret && bio)
+		*io_err = submit_bio_wait(type, bio);
+	blk_finish_plug(&plug);
+
+	return ret;
+}
+

What does the extra io_err buy us? Just have this function return an
error. And then in blkdev_issue_discard if you get -EOPNOTSUPP you
special case it there.

 /**
  * blkdev_issue_discard - queue a discard
  * @bdev:	blockdev to issue discard for
@@ -98,23 +120,12 @@ EXPORT_SYMBOL(__blkdev_issue_discard);
 int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 		sector_t nr_sects, gfp_t gfp_mask, unsigned long flags)
 {
-	int type = REQ_WRITE | REQ_DISCARD;
-	struct bio *bio = NULL;
-	struct blk_plug plug;
-	int ret;
+	int ret, io_err;
 
-	if (flags & BLKDEV_DISCARD_SECURE)
-		type |= REQ_SECURE;
-
-	blk_start_plug(&plug);
-	ret = __blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, type,
-			&bio);
-	if (!ret && bio) {
-		ret = submit_bio_wait(type, bio);
-		if (ret == -EOPNOTSUPP)
-			ret = 0;
-	}
-	blk_finish_plug(&plug);
+	ret = do_blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask,
+		flags, &io_err);
+	if (!ret && io_err != -EOPNOTSUPP)
+		ret = io_err;
 
 	return ret;
 }
@@ -167,7 +178,7 @@ int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 
 	if (bio)
 		ret = submit_bio_wait(REQ_WRITE | REQ_WRITE_SAME, bio);
-	return ret != -EOPNOTSUPP ? ret : 0;
+	return ret;
 }
 EXPORT_SYMBOL(blkdev_issue_write_same);
 
@@ -236,9 +247,11 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 			 sector_t nr_sects, gfp_t gfp_mask, bool discard)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
+	int io_err = 0;
 
 	if (discard && blk_queue_discard(q) && q->limits.discard_zeroes_data &&
-	    blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, 0) == 0)
+	    (do_blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, 0,
+				     &io_err) == 0 && io_err == 0))
 		return 0;
 
 	if (bdev_write_same(bdev) &&

-- 
Martin K. Petersen	Oracle Linux Engineering
