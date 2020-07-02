Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1DA7C433DF
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 989B020884
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:49:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="gtb/PEgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726734AbgGBIt3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:49:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725263AbgGBIt2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 04:49:28 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C05AC08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 01:49:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=f3DHxMMy6/nMa2BH8zbmQwyeGcm+NETqoF9rsJb21rg=; b=gtb/PEgmwE+yTuG+TGZ2ZdH3x/
        VdF6Vjr3FWHhFEgVRQ1jdToS3BMxtlpRIvpJclFx2mYOl2lOco7c5uxxShTjiGRUUf7L9wQY9zRcp
        UEXER1Cg0bR6W+GV4PyU6vQDV6NUPg514pf++BER4mMt/m1pC9C19ngHslXWMOwgVjSj3VQGT56Ri
        N4HY+nNCToeENYlmm5f4CzxL+g5WyqeUBcuJ3V0yyX4RswNNiyEfEpjRPBxCNfYggPvr+65byPFh9
        pHIieIdI7qS74nGWO0jIAOMvVkt35FlX/0oWxf5he+a8ssP0Uqyu5dXmM+36IKd3fEvs5p4tMD/q7
        peR8Twsg==;
Received: from [213.208.157.36] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jquuL-0001Vs-VQ; Thu, 02 Jul 2020 08:49:26 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH 4/4] block: integrate bd_start_claiming into __blkdev_get
Date:   Thu,  2 Jul 2020 10:49:19 +0200
Message-Id: <20200702084919.3720275-5-hch@lst.de>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702084919.3720275-1-hch@lst.de>
References: <20200702084919.3720275-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

bd_start_claiming duplicates a lot of the work done in __blkdev_get.
Integrate the two functions to avoid the duplicate work, and to do the
right thing for the md -ERESTARTSYS corner case.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 fs/block_dev.c | 177 +++++++++++++++----------------------------------
 1 file changed, 55 insertions(+), 122 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index 7075004d36997b..6fa987c77e0a1b 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1078,72 +1078,6 @@ static struct gendisk *bdev_get_gendisk(struct block_device *bdev, int *partno)
 	return disk;
 }
 
-/**
- * bd_start_claiming - start claiming a block device
- * @bdev: block device of interest
- * @holder: holder trying to claim @bdev
- *
- * @bdev is about to be opened exclusively.  Check @bdev can be opened
- * exclusively and mark that an exclusive open is in progress.  Each
- * successful call to this function must be matched with a call to
- * either bd_finish_claiming() or bd_abort_claiming() (which do not
- * fail).
- *
- * This function is used to gain exclusive access to the block device
- * without actually causing other exclusive open attempts to fail. It
- * should be used when the open sequence itself requires exclusive
- * access but may subsequently fail.
- *
- * CONTEXT:
- * Might sleep.
- *
- * RETURNS:
- * Pointer to the block device containing @bdev on success, ERR_PTR()
- * value on failure.
- */
-static struct block_device *bd_start_claiming(struct block_device *bdev,
-		void *holder)
-{
-	struct gendisk *disk;
-	struct block_device *whole;
-	int partno, err;
-
-	might_sleep();
-
-	/*
-	 * @bdev might not have been initialized properly yet, look up
-	 * and grab the outer block device the hard way.
-	 */
-	disk = bdev_get_gendisk(bdev, &partno);
-	if (!disk)
-		return ERR_PTR(-ENXIO);
-
-	/*
-	 * Normally, @bdev should equal what's returned from bdget_disk()
-	 * if partno is 0; however, some drivers (floppy) use multiple
-	 * bdev's for the same physical device and @bdev may be one of the
-	 * aliases.  Keep @bdev if partno is 0.  This means claimer
-	 * tracking is broken for those devices but it has always been that
-	 * way.
-	 */
-	if (partno)
-		whole = bdget_disk(disk, 0);
-	else
-		whole = bdgrab(bdev);
-
-	put_disk_and_module(disk);
-	if (!whole)
-		return ERR_PTR(-ENOMEM);
-
-	err = bd_prepare_to_claim(bdev, whole, holder);
-	if (err) {
-		bdput(whole);
-		return ERR_PTR(err);
-	}
-
-	return whole;
-}
-
 static void bd_clear_claiming(struct block_device *whole, void *holder)
 {
 	lockdep_assert_held(&bdev_lock);
@@ -1156,7 +1090,7 @@ static void bd_clear_claiming(struct block_device *whole, void *holder)
 /**
  * bd_finish_claiming - finish claiming of a block device
  * @bdev: block device of interest
- * @whole: whole block device (returned from bd_start_claiming())
+ * @whole: whole block device
  * @holder: holder that has claimed @bdev
  *
  * Finish exclusive open of a block device. Mark the device as exlusively
@@ -1182,7 +1116,7 @@ static void bd_finish_claiming(struct block_device *bdev,
 /**
  * bd_abort_claiming - abort claiming of a block device
  * @bdev: block device of interest
- * @whole: whole block device (returned from bd_start_claiming())
+ * @whole: whole block device
  * @holder: holder that has claimed @bdev
  *
  * Abort claiming of a block device when the exclusive open failed. This can be
@@ -1521,13 +1455,15 @@ EXPORT_SYMBOL_GPL(bdev_disk_changed);
  *    mutex_lock_nested(whole->bd_mutex, 1)
  */
 
-static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
+static int __blkdev_get(struct block_device *bdev, fmode_t mode, void *holder,
+		int for_part)
 {
+	struct block_device *whole = NULL, *claiming = NULL;
 	struct gendisk *disk;
 	int ret;
 	int partno;
 	int perm = 0;
-	bool first_open = false, need_restart;
+	bool first_open = false, unblock_events = true, need_restart;
 
 	if (mode & FMODE_READ)
 		perm |= MAY_READ;
@@ -1549,6 +1485,25 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	if (!disk)
 		goto out;
 
+	if (partno) {
+		whole = bdget_disk(disk, 0);
+		if (!whole) {
+			ret = -ENOMEM;
+			goto out_put_disk;
+		}
+	}
+
+	if (!for_part && (mode & FMODE_EXCL)) {
+		WARN_ON_ONCE(!holder);
+		if (whole)
+			claiming = whole;
+		else
+			claiming = bdev;
+		ret = bd_prepare_to_claim(bdev, claiming, holder);
+		if (ret)
+			goto out_put_whole;
+	}
+
 	disk_block_events(disk);
 	mutex_lock_nested(&bdev->bd_mutex, for_part);
 	if (!bdev->bd_openers) {
@@ -1592,18 +1547,11 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 			if (ret)
 				goto out_clear;
 		} else {
-			struct block_device *whole;
-			whole = bdget_disk(disk, 0);
-			ret = -ENOMEM;
-			if (!whole)
-				goto out_clear;
 			BUG_ON(for_part);
-			ret = __blkdev_get(whole, mode, 1);
-			if (ret) {
-				bdput(whole);
+			ret = __blkdev_get(whole, mode, NULL, 1);
+			if (ret)
 				goto out_clear;
-			}
-			bdev->bd_contains = whole;
+			bdev->bd_contains = bdgrab(whole);
 			bdev->bd_part = disk_get_part(disk, partno);
 			if (!(disk->flags & GENHD_FL_UP) ||
 			    !bdev->bd_part || !bdev->bd_part->nr_sects) {
@@ -1632,11 +1580,30 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 	bdev->bd_openers++;
 	if (for_part)
 		bdev->bd_part_count++;
+	if (claiming)
+		bd_finish_claiming(bdev, claiming, holder);
+
+	/*
+	 * Block event polling for write claims if requested.  Any write holder
+	 * makes the write_holder state stick until all are released.  This is
+	 * good enough and tracking individual writeable reference is too
+	 * fragile given the way @mode is used in blkdev_get/put().
+	 */
+	if (claiming && (mode & FMODE_WRITE) && !bdev->bd_write_holder &&
+	    (disk->flags & GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE)) {
+		bdev->bd_write_holder = true;
+		unblock_events = false;
+	}
 	mutex_unlock(&bdev->bd_mutex);
-	disk_unblock_events(disk);
+
+	if (unblock_events)
+		disk_unblock_events(disk);
+
 	/* only one opener holds refs to the module and disk */
 	if (!first_open)
 		put_disk_and_module(disk);
+	if (whole)
+		bdput(whole);
 	return 0;
 
  out_clear:
@@ -1647,13 +1614,18 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
 		__blkdev_put(bdev->bd_contains, mode, 1);
 	bdev->bd_contains = NULL;
  out_unlock_bdev:
+	if (claiming)
+		bd_abort_claiming(bdev, claiming, holder);
 	mutex_unlock(&bdev->bd_mutex);
 	disk_unblock_events(disk);
+ out_put_whole:
+ 	if (whole)
+		bdput(whole);
+ out_put_disk:
 	put_disk_and_module(disk);
 	if (need_restart)
 		goto restart;
  out:
-
 	return ret;
 }
 
@@ -1678,50 +1650,11 @@ static int __blkdev_get(struct block_device *bdev, fmode_t mode, int for_part)
  */
 int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder)
 {
-	struct block_device *whole = NULL;
 	int res;
 
-	WARN_ON_ONCE((mode & FMODE_EXCL) && !holder);
-
-	if ((mode & FMODE_EXCL) && holder) {
-		whole = bd_start_claiming(bdev, holder);
-		if (IS_ERR(whole)) {
-			bdput(bdev);
-			return PTR_ERR(whole);
-		}
-	}
-
-	res = __blkdev_get(bdev, mode, 0);
-
-	if (whole) {
-		struct gendisk *disk = whole->bd_disk;
-
-		/* finish claiming */
-		mutex_lock(&bdev->bd_mutex);
-		if (!res)
-			bd_finish_claiming(bdev, whole, holder);
-		else
-			bd_abort_claiming(bdev, whole, holder);
-		/*
-		 * Block event polling for write claims if requested.  Any
-		 * write holder makes the write_holder state stick until
-		 * all are released.  This is good enough and tracking
-		 * individual writeable reference is too fragile given the
-		 * way @mode is used in blkdev_get/put().
-		 */
-		if (!res && (mode & FMODE_WRITE) && !bdev->bd_write_holder &&
-		    (disk->flags & GENHD_FL_BLOCK_EVENTS_ON_EXCL_WRITE)) {
-			bdev->bd_write_holder = true;
-			disk_block_events(disk);
-		}
-
-		mutex_unlock(&bdev->bd_mutex);
-		bdput(whole);
-	}
-
+	res =__blkdev_get(bdev, mode, holder, 0);
 	if (res)
 		bdput(bdev);
-
 	return res;
 }
 EXPORT_SYMBOL(blkdev_get);
-- 
2.26.2

