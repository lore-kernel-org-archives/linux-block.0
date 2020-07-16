Return-Path: <SRS0=Ci6H=A3=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA59C433E4
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 14:33:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2E974207CB
	for <linux-block@archiver.kernel.org>; Thu, 16 Jul 2020 14:33:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="q/wv6t7T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728547AbgGPOdS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Jul 2020 10:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727844AbgGPOdS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Jul 2020 10:33:18 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14507C061755
        for <linux-block@vger.kernel.org>; Thu, 16 Jul 2020 07:33:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=AahNguEfNZOn+G74MhalxTS9iAxX1yEKCQMWNpUyIn8=; b=q/wv6t7Ta3GUuRzn83B6K4vAod
        i8HKsopEF2tNyi+AChQV1UHo1O4LsZRSm+xUN+AhZZ0Lff22NvMWUb+NQ/QybwAHYxtjco9fhvMkl
        VWqYpty19BEdzlPMa4bPaXJ3K9PgSIWCS10yx6RxkNlZ8Ujsm7uW0zPzqbEVlvRoggw1GrNjkeki5
        ObWesr6SK1ub1PgrmJM0sbMlJxmudeHEhqpZU0cpT3vJnqorWU5rkaIqqLsXZscEgxrWS7fjKyV6v
        VGO89OYIeBuYnLTz1wEz/J16lOTh1xA6AOJJyFci5J6fQioiS3T/BXgO4l83w3UEZMQ+yupkzjjDJ
        01eQ653w==;
Received: from [2001:4bb8:105:4a81:1bd9:4dba:216e:37b8] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jw4wl-0000CI-Sh; Thu, 16 Jul 2020 14:33:16 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org
Subject: [PATCH 3/4] block: use bd_prepare_to_claim directly in the loop driver
Date:   Thu, 16 Jul 2020 16:33:09 +0200
Message-Id: <20200716143310.473136-4-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200716143310.473136-1-hch@lst.de>
References: <20200716143310.473136-1-hch@lst.de>
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
index b7b2ee4b288ae9..ee80bd81af748d 100644
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
index 71173a1ffa8b87..06995b96e94679 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1919,7 +1919,8 @@ int blkdev_get(struct block_device *bdev, fmode_t mode, void *holder);
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
2.27.0

