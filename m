Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24F7CC433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:49:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0487520899
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 08:49:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GKRGdjgj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726810AbgGBIt1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 04:49:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726734AbgGBIt1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 04:49:27 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00C0FC08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 01:49:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=4Iz3kyrsqepii29Qm0LnEjOG9fd7tYe4JKIIweGOp1w=; b=GKRGdjgjAryYqzZ4LhVzinVSlc
        Zx+3cWIxAbnBWiici0qGuS3cRs1r39r6ECP4c/GJv9YbHdTtZU/GWCiEQ/xdUeawungwcn2sfnGKZ
        WDKLu8yOKQZ39y+I/WKtkDn91A/dq8cDzi8JvkRtE7aNHJeZLPM7dPERjLZFZD6iwKuYKRGQDAJr7
        1wSDxKgeHbubYC0VyjEMZeAy2mg5+RhIQxSVmdAHCRe3ML29U8A/FLZh8XJBV7mLVFN8lVcUHM81V
        1YAO1y8u9lwdDq5OGBvFzB0/ooVx7eMMWR0rIzfR24G3DXzryWGhxi2krJ2HbAN8R7OF/8Q0jn9bK
        bxUiOLIg==;
Received: from [213.208.157.36] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jquuK-0001Vg-PU; Thu, 02 Jul 2020 08:49:25 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH 3/4] block: use bd_prepare_to_claim directly in the loop driver
Date:   Thu,  2 Jul 2020 10:49:18 +0200
Message-Id: <20200702084919.3720275-4-hch@lst.de>
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

The arcane magic in bd_start_claiming is only needed to be able to claim
a block_device that hasn't been fully set up.  Switch the loop driver
that claims from the ioctl path with a fully set up struct block_device
to just use the much simpler bd_prepare_to_claim directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/loop.c   | 7 +++----
 fs/block_dev.c         | 9 +++++----
 include/linux/blkdev.h | 3 ++-
 3 files changed, 10 insertions(+), 9 deletions(-)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index a943207705ddf1..d181601462260b 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1090,11 +1090,10 @@ static int loop_configure(struct loop_device *lo, fmode_t mode,
 	 * here to avoid changing device under exclusive owner.
 	 */
 	if (!(mode & FMODE_EXCL)) {
-		claimed_bdev = bd_start_claiming(bdev, loop_configure);
-		if (IS_ERR(claimed_bdev)) {
-			error = PTR_ERR(claimed_bdev);
+		claimed_bdev = bdev->bd_contains;
+		error = bd_prepare_to_claim(bdev, claimed_bdev, loop_configure);
+		if (error)
 			goto out_putf;
-		}
 	}
 
 	error = mutex_lock_killable(&loop_ctl_mutex);
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 1c9da1f08011b0..7075004d36997b 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1027,8 +1027,8 @@ static bool bd_may_claim(struct block_device *bdev, struct block_device *whole,
  * RETURNS:
  * 0 if @bdev can be claimed, -EBUSY otherwise.
  */
-static int bd_prepare_to_claim(struct block_device *bdev,
-			       struct block_device *whole, void *holder)
+int bd_prepare_to_claim(struct block_device *bdev, struct block_device *whole,
+		void *holder)
 {
 retry:
 	spin_lock(&bdev_lock);
@@ -1055,6 +1055,7 @@ static int bd_prepare_to_claim(struct block_device *bdev,
 	spin_unlock(&bdev_lock);
 	return 0;
 }
+EXPORT_SYMBOL_GPL(bd_prepare_to_claim); /* only for the loop driver */
 
 static struct gendisk *bdev_get_gendisk(struct block_device *bdev, int *partno)
 {
@@ -1100,7 +1101,8 @@ static struct gendisk *bdev_get_gendisk(struct block_device *bdev, int *partno)
  * Pointer to the block device containing @bdev on success, ERR_PTR()
  * value on failure.
  */
-struct block_device *bd_start_claiming(struct block_device *bdev, void *holder)
+static struct block_device *bd_start_claiming(struct block_device *bdev,
+		void *holder)
 {
 	struct gendisk *disk;
 	struct block_device *whole;
@@ -1141,7 +1143,6 @@ struct block_device *bd_start_claiming(struct block_device *bdev, void *holder)
 
 	return whole;
 }
-EXPORT_SYMBOL(bd_start_claiming);
 
 static void bd_clear_claiming(struct block_device *whole, void *holder)
 {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 408eb66a82fdc7..6489a0c478165b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1921,7 +1921,8 @@ int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder);
 struct block_device *blkdev_get_by_path(const char *path, fmode_t mode,
 		void *holder);
 struct block_device *blkdev_get_by_dev(dev_t dev, fmode_t mode, void *holder);
-struct block_device *bd_start_claiming(struct block_device *bdev, void *holder);
+int bd_prepare_to_claim(struct block_device *bdev, struct block_device *whole,
+		void *holder);
 void bd_abort_claiming(struct block_device *bdev, struct block_device *whole,
 		void *holder);
 void blkdev_put(struct block_device *bdev, fmode_t mode);
-- 
2.26.2

