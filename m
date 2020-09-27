Return-Path: <SRS0=7dNq=DE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0272C4346E
	for <linux-block@archiver.kernel.org>; Sun, 27 Sep 2020 07:11:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 595C423899
	for <linux-block@archiver.kernel.org>; Sun, 27 Sep 2020 07:11:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="RvGUzFuP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726382AbgI0HLL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 27 Sep 2020 03:11:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726311AbgI0HLL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 27 Sep 2020 03:11:11 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27BC3C0613CE
        for <linux-block@vger.kernel.org>; Sun, 27 Sep 2020 00:11:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=Yma1zqRWU/jRnoUhv/8wvAHk1H6b826vCYsv5iH97ZU=; b=RvGUzFuPJC2JOhxbLjUgY0/Zyt
        ROGphSXWHenuVOrtd6xY2CZTUYJpvXULBpj3oJaTxZKH+Prg6MPKaiZJCSkjwVWgr4YHoXgAHi4Td
        Ga5oK81TurFSmJMyOd5ymnXlFgUSmxaRVu/XhB8+204otWdQLw0LvBEQBIgxA0jXDz4mio688Q5vs
        N5LMqtGgbOBOMA/CO8rSWDjle/GYBbRbulbTlYz+aUdRpooQX/eA4U6VSrp+v23ZVHJqsojrt7lvw
        VOSU0HmTu0gBJXnGxCjGTFwsDcKZBO+vvikqBA7tjYSK/60U8MrA5LwFwnORjUObWW6n9QtD921XI
        qEix3Xhg==;
Received: from [46.189.67.162] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kMQpw-0000VX-N0; Sun, 27 Sep 2020 07:11:09 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] mtip32xx: remove a call to fsync_bdev on removal
Date:   Sun, 27 Sep 2020 09:11:08 +0200
Message-Id: <20200927071108.372241-1-hch@lst.de>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Syncing data on removal is not the device drivers job, and none of other
common drivers does something like this.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/mtip32xx/mtip32xx.c | 15 ---------------
 drivers/block/mtip32xx/mtip32xx.h |  2 --
 2 files changed, 17 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index 153e2cdecb4d40..53ac59d19ae530 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3687,7 +3687,6 @@ static int mtip_block_initialize(struct driver_data *dd)
 	/* Enable the block device and add it to /dev */
 	device_add_disk(&dd->pdev->dev, dd->disk, NULL);
 
-	dd->bdev = bdget_disk(dd->disk, 0);
 	/*
 	 * Now that the disk is active, initialize any sysfs attributes
 	 * managed by the protocol layer.
@@ -3721,9 +3720,6 @@ static int mtip_block_initialize(struct driver_data *dd)
 	return rv;
 
 kthread_run_error:
-	bdput(dd->bdev);
-	dd->bdev = NULL;
-
 	/* Delete our gendisk. This also removes the device from /dev */
 	del_gendisk(dd->disk);
 
@@ -3804,14 +3800,6 @@ static int mtip_block_remove(struct driver_data *dd)
 	blk_mq_tagset_busy_iter(&dd->tags, mtip_no_dev_cleanup, dd);
 	blk_mq_unquiesce_queue(dd->queue);
 
-	/*
-	 * Delete our gendisk structure. This also removes the device
-	 * from /dev
-	 */
-	if (dd->bdev) {
-		bdput(dd->bdev);
-		dd->bdev = NULL;
-	}
 	if (dd->disk) {
 		if (test_bit(MTIP_DDF_INIT_DONE_BIT, &dd->dd_flag))
 			del_gendisk(dd->disk);
@@ -4206,9 +4194,6 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 	} while (atomic_read(&dd->irq_workers_active) != 0 &&
 		time_before(jiffies, to));
 
-	if (!dd->sr)
-		fsync_bdev(dd->bdev);
-
 	if (atomic_read(&dd->irq_workers_active) != 0) {
 		dev_warn(&dd->pdev->dev,
 			"Completion workers still active!\n");
diff --git a/drivers/block/mtip32xx/mtip32xx.h b/drivers/block/mtip32xx/mtip32xx.h
index e22a7f0523bf30..88f4206310e4c8 100644
--- a/drivers/block/mtip32xx/mtip32xx.h
+++ b/drivers/block/mtip32xx/mtip32xx.h
@@ -463,8 +463,6 @@ struct driver_data {
 
 	int isr_binding;
 
-	struct block_device *bdev;
-
 	struct list_head online_list; /* linkage for online list */
 
 	struct list_head remove_list; /* linkage for removing list */
-- 
2.28.0

