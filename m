Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp1040.oracle.com ([141.146.126.69]:17436 "EHLO
	aserp1040.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751238AbcFCD0f (ORCPT
	<rfc822;linux-block@vger.kernel.org>); Thu, 2 Jun 2016 23:26:35 -0400
To: Shaohua Li <shli@fb.com>
Cc: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<sitsofe@yahoo.com>, <snitzer@redhat.com>, <axboe@fb.com>,
	<martin.petersen@oracle.com>, <Kernel-team@fb.com>
Subject: Re: [PATCH] block: correctly fallback for zeroout
From: "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20160526180813.GA49039@shli-mbp.local>
Date: Thu, 02 Jun 2016 23:26:22 -0400
In-Reply-To: <20160526180813.GA49039@shli-mbp.local> (Shaohua Li's message of
	"Thu, 26 May 2016 11:08:14 -0700")
Message-ID: <yq1d1nzrm01.fsf@sermon.lab.mkp.net>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>>>>> "Shaohua" == Shaohua Li <shli@fb.com> writes:

Shaohua> blkdev_issue_zeroout try discard/writesame first, if they fail,
Shaohua> zeroout fallback to regular write. The problem is
Shaohua> discard/writesame doesn't return error for -EOPNOTSUPP, then
Shaohua> zeroout can't do fallback and leave disk data not
Shaohua> changed. zeroout should have guaranteed zero-fill behavior.

As discussed at LSF/MM, let's explicitly separate the exported/ioctl()
functions from the __/do_foo_bar iterators. That's essentially what you
have done. And then put all error handling and policy in the ioctl()
wrappers instead of the worker functions.

diff --git a/block/blk-lib.c b/block/blk-lib.c
index 23d7f30..232f9ea 100644
--- a/block/blk-lib.c
+++ b/block/blk-lib.c
@@ -95,8 +95,9 @@ EXPORT_SYMBOL(__blkdev_issue_discard);
  * Description:
  *    Issue a discard request for the sectors in question.
  */
-int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
-		sector_t nr_sects, gfp_t gfp_mask, unsigned long flags)
+static int do_blkdev_issue_discard(struct block_device *bdev, sector_t sector,
+	sector_t nr_sects, gfp_t gfp_mask, unsigned long flags,
+	bool ignore_nosupport)
 {
 	int type = REQ_WRITE | REQ_DISCARD;
 	struct bio *bio = NULL;
@@ -111,13 +112,20 @@ int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
 			&bio);
 	if (!ret && bio) {
 		ret = submit_bio_wait(type, bio);
-		if (ret == -EOPNOTSUPP)
+		if (ignore_nosupport && ret == -EOPNOTSUPP)
 			ret = 0;
 	}
 	blk_finish_plug(&plug);
 
 	return ret;
 }
+
+int blkdev_issue_discard(struct block_device *bdev, sector_t sector,
+		sector_t nr_sects, gfp_t gfp_mask, unsigned long flags)
+{
+	return do_blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask,
+			flags, true);
+}

I'd prefer to do the EOPNOTSUPP mapping for the ioctl here instead of in
the do_blkdev_issue_discard() function. Then you don't need the
ignore_nosupport flag.

 EXPORT_SYMBOL(blkdev_issue_discard);
 
 /**
@@ -131,9 +139,9 @@ EXPORT_SYMBOL(blkdev_issue_discard);
  * Description:
  *    Issue a write same request for the sectors in question.
  */
-int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
+static int do_blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 			    sector_t nr_sects, gfp_t gfp_mask,
-			    struct page *page)
+			    struct page *page, bool ignore_nosupport)
 {
 	struct request_queue *q = bdev_get_queue(bdev);
 	unsigned int max_write_same_sectors;
@@ -167,7 +175,15 @@ int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
 
 	if (bio)
 		ret = submit_bio_wait(REQ_WRITE | REQ_WRITE_SAME, bio);
-	return ret != -EOPNOTSUPP ? ret : 0;
+	return (ret != -EOPNOTSUPP || !ignore_nosupport) ? ret : 0;
+}
+
+int blkdev_issue_write_same(struct block_device *bdev, sector_t sector,
+			    sector_t nr_sects, gfp_t gfp_mask,
+			    struct page *page)
+{
+	return do_blkdev_issue_write_same(bdev, sector, nr_sects, gfp_mask,
+		page, true);
 }
 EXPORT_SYMBOL(blkdev_issue_write_same);

There should not be a "soft" fail for WRITE SAME, it's not a hint.

@@ -238,12 +254,13 @@ int blkdev_issue_zeroout(struct block_device *bdev, sector_t sector,
 	struct request_queue *q = bdev_get_queue(bdev);
 
 	if (discard && blk_queue_discard(q) && q->limits.discard_zeroes_data &&
-	    blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, 0) == 0)
+	    do_blkdev_issue_discard(bdev, sector, nr_sects, gfp_mask, 0,
+					false) == 0)
 		return 0;
 
 	if (bdev_write_same(bdev) &&
-	    blkdev_issue_write_same(bdev, sector, nr_sects, gfp_mask,
-				    ZERO_PAGE(0)) == 0)
+	    do_blkdev_issue_write_same(bdev, sector, nr_sects, gfp_mask,
+				    ZERO_PAGE(0), false) == 0)
 		return 0;
 
 	return __blkdev_issue_zeroout(bdev, sector, nr_sects, gfp_mask);

-- 
Martin K. Petersen	Oracle Linux Engineering
