Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E512AC433E0
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 11:45:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 954CC600CF
	for <linux-block@archiver.kernel.org>; Mon, 22 Feb 2021 11:45:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbhBVLpq (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Feb 2021 06:45:46 -0500
Received: from verein.lst.de ([213.95.11.211]:58110 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229902AbhBVLpm (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Feb 2021 06:45:42 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id ECACE68D0D; Mon, 22 Feb 2021 12:44:55 +0100 (CET)
Date:   Mon, 22 Feb 2021 12:44:55 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Tom Seewald <tseewald@gmail.com>
Cc:     Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        axboe@kernel.dk
Subject: Re: [Regression] [Bisected] Errors when ejecting USB storage
 drives since v5.10
Message-ID: <20210222114455.GA1749@lst.de>
References: <CAARYdbiUBxFTY25VusuxgxqVzNRnoB61fFQeXcmsKyDP_d_ipQ@mail.gmail.com> <20210216123755.GA4608@lst.de> <CAARYdbiDzi_WcNGe4GkWjtTXeNOV7pZCLiJFk4r+Np_Je+2aZw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAARYdbiDzi_WcNGe4GkWjtTXeNOV7pZCLiJFk4r+Np_Je+2aZw@mail.gmail.com>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Ok, let's try something else entirely, which restores the full revalidation
that BLKRRPART previously caused by accident:

diff --git a/block/ioctl.c b/block/ioctl.c
index d61d652078f41c..06b2ecdce593c6 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -81,20 +81,25 @@ static int compat_blkpg_ioctl(struct block_device *bdev,
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
-
-	return ret;
+	/*
+	 * Reopen the device to revalidate the driver state and force a
+	 * partition rescan.
+	 */
+	set_bit(GD_NEED_PART_SCAN, &bdev->bd_disk->state);
+	tmp = blkdev_get_by_dev(bdev->bd_dev, mode, NULL);
+	if (IS_ERR(tmp))
+		return PTR_ERR(tmp);
+	blkdev_put(tmp, mode);
+	return 0;
 }
 
 static int blk_ioctl_discard(struct block_device *bdev, fmode_t mode,
@@ -498,7 +503,7 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 		bdev->bd_bdi->ra_pages = (arg * 512) / PAGE_SIZE;
 		return 0;
 	case BLKRRPART:
-		return blkdev_reread_part(bdev);
+		return blkdev_reread_part(bdev, mode & ~FMODE_EXCL);
 	case BLKTRACESTART:
 	case BLKTRACESTOP:
 	case BLKTRACETEARDOWN:
