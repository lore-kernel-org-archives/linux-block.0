Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA883C433E6
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 15:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0ABC64E62
	for <linux-block@archiver.kernel.org>; Tue, 23 Feb 2021 15:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233097AbhBWPT1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 23 Feb 2021 10:19:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232651AbhBWPTX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 23 Feb 2021 10:19:23 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0916CC061786
        for <linux-block@vger.kernel.org>; Tue, 23 Feb 2021 07:18:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=dnt88h5BQZBRIxKRmJECssOV1Fv/BI8Wicek7CyeREg=; b=uv2uRR7OTMr/56oOvFoJmdQCso
        71vkSKkPNR6o/24WaEvnQam+z3BxZIZcl3KAqGZHXmVnxw2M10V5hwAtsVnRdM2zO2px/DagOqNN2
        IPWN1WT9/yK1zIk+qBThrSF/38epy627cjzirnLLT9htpqU5iIC/J5vfXvd+wU8cY4LXw38mqu0H+
        olm9REnk2cpEzvDwqvwcXjlRTLRgUk4zeqgUb2D5/tKH/8/dAYZNYBKFNg+Xk530gFFYGCPIxFdmd
        cU8uZH6Rl/FE1lF1axlsU04z7o6bP1yzIWttp0ihinDzkVHlo9FrvX8oJPXXlChIzT7jrgl7AH6ZD
        eecyBuWg==;
Received: from [2001:4bb8:188:6508:3991:8e69:68b0:a1e6] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lEZSD-0087nY-DC; Tue, 23 Feb 2021 15:18:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Tom Seewald <tseewald@gmail.com>
Subject: [PATCH] block: reopen the device in blkdev_reread_part
Date:   Tue, 23 Feb 2021 16:18:22 +0100
Message-Id: <20210223151822.399791-1-hch@lst.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Historically the BLKRRPART ioctls called into the now defunct ->revalidate
method, which caused the sd driver to check if any media is present.
When the ->revalidate method was removed this revalidation was lost,
leading to lots of I/O errors when using the eject command.  Fix this by
reopening the device to rescan the partitions, and thus calling the
revalidation logic in the sd driver.

Fixes: 471bd0af544b ("sd: use bdev_check_media_change")
Reported--by: Tom Seewald <tseewald@gmail.com>
Signed-off-by: Christoph Hellwig <hch@lst.de>
Tested-by: Tom Seewald <tseewald@gmail.com>
---
 block/ioctl.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/block/ioctl.c b/block/ioctl.c
index d61d652078f41c..ff241e663c018f 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -81,20 +81,27 @@ static int compat_blkpg_ioctl(struct block_device *bdev,
 }
 #endif
 
-static int blkdev_reread_part(struct block_device *bdev)
+static int blkdev_reread_part(struct block_device *bdev, fmode_t mode)
 {
-	int ret;
+	struct block_device *tmp;
 
 	if (!disk_part_scan_enabled(bdev->bd_disk) || bdev_is_partition(bdev))
 		return -EINVAL;
 	if (!capable(CAP_SYS_ADMIN))
 		return -EACCES;
 
-	mutex_lock(&bdev->bd_mutex);
-	ret = bdev_disk_changed(bdev, false);
-	mutex_unlock(&bdev->bd_mutex);
+	/*
+	 * Reopen the device to revalidate the driver state and force a
+	 * partition rescan.
+	 */
+	mode &= ~FMODE_EXCL;
+	set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
 
-	return ret;
+	tmp = blkdev_get_by_dev(bdev->bd_dev, mode, NULL);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	blkdev_put(tmp, mode);
+	return 0;
 }
 
 static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
@@ -498,7 +505,7 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 		bdev->bd_bdi->ra_pages = (arg * 512) / PAGE_SIZE;
 		return 0;
 	case BLKRRPART:
-		return blkdev_reread_part(bdev);
+		return blkdev_reread_part(bdev, mode);
 	case BLKTRACESTART:
 	case BLKTRACESTOP:
 	case BLKTRACETEARDOWN:
-- 
2.29.2

