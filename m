Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0b-00082601.pphosted.com ([67.231.153.30]:42323 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1754361AbcEZSIf (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Thu, 26 May 2016 14:08:35 -0400
Date: Thu, 26 May 2016 11:08:14 -0700
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
CC: <sitsofe@yahoo.com>, <snitzer@redhat.com>, <axboe@fb.com>,
	<martin.petersen@oracle.com>, <Kernel-team@fb.com>
Subject: [PATCH] block: correctly fallback for zeroout
Message-ID: <20160526180813.GA49039@shli-mbp.local>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

blkdev_issue_zeroout try discard/writesame first, if they fail, zeroout
fallback to regular write. The problem is discard/writesame doesn't
return error for -EOPNOTSUPP, then zeroout can't do fallback and leave
disk data not changed. zeroout should have guaranteed zero-fill
behavior.

BTW, I saw several callers of blkdev_issue_discard can handle
-EOPNOTSUPP, not sure why blkdev_issue_discard not returns -EOPNOTSUPP.
The same story for blkdev_issue_write_same.

https://bugzilla.kernel.org/show_bug.cgi?id=118581

Cc: Sitsofe Wheeler <sitsofe@yahoo.com>
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Jens Axboe <axboe@fb.com>
Cc: Martin K. Petersen <martin.petersen@oracle.com>
Signed-off-by: Shaohua Li <shli@fb.com>
---
 block/blk-lib.c | 35 ++++++++++++++++++++++++++---------
 1 file changed, 26 insertions(+), 9 deletions(-)

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
2.8.0.rc2

