Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B3194C636CC
	for <linux-block@archiver.kernel.org>; Tue, 31 Jan 2023 14:15:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232045AbjAaOP6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 31 Jan 2023 09:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231764AbjAaOP6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Jan 2023 09:15:58 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6188A49962
        for <linux-block@vger.kernel.org>; Tue, 31 Jan 2023 06:15:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=cok/YpbhllPcfsmfnWd3rl9gYNCyf9x4CcNXiMm1jQ0=; b=Cd+Sr0tnvzLRVLH5QP8wt6hLHY
        3cMmUjft3fkzjMW70LvIEg1yvslABfdiFxxc9hLQG3WxHESU4GHdQTP7JAeH8sB/CeKlitZb+4KR5
        PWY1VKgVuxFm7Mayh1MLr7wHffo8aWafayBiARipuzzGe997lgE4bfThATZxDh626w6hiUxFehWTc
        tKdRgoHT59g1PJlD4hDrAZ/nBuvtQ1F20MDVGVHcDYFIJ9z4ZBIIausrxwIyI9G9PneTweRwwulu3
        zPLOj+VtYvzb2cXcIxiG4E5HzsB2eCsBrCkIkGbYw9q7sLROQvAOPAsLe/dG+5L9fpojQJlKTs8eM
        yORydwew==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pMrQM-008GUx-50; Tue, 31 Jan 2023 14:15:50 +0000
Date:   Tue, 31 Jan 2023 06:15:50 -0800
From:   Christoph Hellwig <hch@infradead.org>
To:     Yu Kuai <yukuai1@huaweicloud.com>
Cc:     Jan Kara <jack@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        linux-block@vger.kernel.org, "yukuai (C)" <yukuai3@huawei.com>
Subject: Re: [PATCH] block: Do not reread partition table on exclusively open
 device
Message-ID: <Y9kiltmuPSbRRLsO@infradead.org>
References: <20221130175653.24299-1-jack@suse.cz>
 <ada13b1b-dd2a-8be0-3b12-3470a086bbf6@huaweicloud.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ada13b1b-dd2a-8be0-3b12-3470a086bbf6@huaweicloud.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It might be easier to just move the check into blkdev_get_whole,
which also ensures that non-excluisve openers don't cause a partition
scan while someone else has the device exclusively open.

diff --git a/block/bdev.c b/block/bdev.c
index edc110d90df404..a831b6c9c627d7 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -666,25 +666,28 @@ static void blkdev_flush_mapping(struct block_device *bdev)
 static int blkdev_get_whole(struct block_device *bdev, fmode_t mode)
 {
 	struct gendisk *disk = bdev->bd_disk;
-	int ret;
+	int ret = 0;
 
-	if (disk->fops->open) {
+	if (disk->fops->open)
 		ret = disk->fops->open(bdev, mode);
-		if (ret) {
-			/* avoid ghost partitions on a removed medium */
-			if (ret == -ENOMEDIUM &&
-			     test_bit(GD_NEED_PART_SCAN, &disk->state))
-				bdev_disk_changed(disk, true);
+
+	if (ret) {
+		/* avoid ghost partitions on a removed medium */
+		if (ret != -ENOMEDIUM)
 			return ret;
-		}
+	} else {
+		if (!atomic_read(&bdev->bd_openers))
+			set_init_blocksize(bdev);
+		atomic_inc(&bdev->bd_openers);
 	}
 
-	if (!atomic_read(&bdev->bd_openers))
-		set_init_blocksize(bdev);
-	if (test_bit(GD_NEED_PART_SCAN, &disk->state))
+	/*
+	 * Skip the partition scan if someone else has the device exclusively
+	 * open.
+	 */
+	if (test_bit(GD_NEED_PART_SCAN, &disk->state) && !bdev->bd_holder)
 		bdev_disk_changed(disk, false);
-	atomic_inc(&bdev->bd_openers);
-	return 0;
+	return ret;
 }
 
 static void blkdev_put_whole(struct block_device *bdev, fmode_t mode)
diff --git a/block/genhd.c b/block/genhd.c
index 23cf83b3331cde..4a7b1b8b9efdb5 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -366,9 +366,6 @@ int disk_scan_partitions(struct gendisk *disk, fmode_t mode, void *owner)
 		return -EINVAL;
 	if (disk->open_partitions)
 		return -EBUSY;
-	/* Someone else has bdev exclusively open? */
-	if (disk->part0->bd_holder && disk->part0->bd_holder != owner)
-		return -EBUSY;
 
 	set_bit(GD_NEED_PART_SCAN, &disk->state);
 	bdev = blkdev_get_by_dev(disk_devt(disk), mode, NULL);
