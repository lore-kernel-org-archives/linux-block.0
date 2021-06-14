Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9D0C49360
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 06:08:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 272BB60C3D
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 06:08:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbhFNGKX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jun 2021 02:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232388AbhFNGKS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jun 2021 02:10:18 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA230C061756;
        Sun, 13 Jun 2021 23:08:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8IMN221GUcg7i4twRh7IXrs7f7o8wsEFg/6awlYGTsk=; b=zvqbJ1+Gz/nzrl+wVFnHLdDDGj
        E4FsTcWNgMEDuUt5pke9HJ5azNL5JBkKu8g5FAr0ch18cwWnFBO8rUp6SbIsywmiu0GWvJfw/Ejt5
        trDnWswC21YIGYQktaW8shxnAkEy7sMts/T7YoNGQDplQPM9p35cn/etNM/8QYmqJYMcM1JCrsajw
        HoQsH96fn5krjAsiKQkWmbcR9PrSY24NAx1X4qYTXNRhdY0RdNAWNmwe2LkuNkyFH56+c4BXyj8IM
        hbN/Ef4E4XeqMqr/oCv5uPCsAUBmyy+8n1WiwfaiXOazm6LlnlsGeBNWCArx8a3/ho6bHR5hyLWXH
        HsQoq7CQ==;
Received: from [2001:4bb8:19b:fdce:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsflW-00CgLS-5F; Mon, 14 Jun 2021 06:08:06 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Jens Axboe <axboe@kernel.dk>
Cc:     linux-um@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-block@vger.kernel.org
Subject: [PATCH 2/2] ubd: use blk_mq_alloc_disk and blk_cleanup_disk
Date:   Mon, 14 Jun 2021 08:07:59 +0200
Message-Id: <20210614060759.3965724-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210614060759.3965724-1-hch@lst.de>
References: <20210614060759.3965724-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use blk_mq_alloc_disk and blk_cleanup_disk to simplify the gendisk and
request_queue allocation.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/um/drivers/ubd_kern.c | 44 ++++++++++++--------------------------
 1 file changed, 14 insertions(+), 30 deletions(-)

diff --git a/arch/um/drivers/ubd_kern.c b/arch/um/drivers/ubd_kern.c
index f508d45f7a69..0b86aa1b12f1 100644
--- a/arch/um/drivers/ubd_kern.c
+++ b/arch/um/drivers/ubd_kern.c
@@ -825,7 +825,6 @@ static void ubd_device_release(struct device *dev)
 {
 	struct ubd *ubd_dev = dev_get_drvdata(dev);
 
-	blk_cleanup_queue(ubd_dev->queue);
 	blk_mq_free_tag_set(&ubd_dev->tag_set);
 	*ubd_dev = ((struct ubd) DEFAULT_UBD);
 }
@@ -865,17 +864,12 @@ static const struct attribute_group *ubd_attr_groups[] = {
 	NULL,
 };
 
-static int ubd_disk_register(int major, u64 size, int unit,
-			     struct gendisk **disk_out)
+static void ubd_disk_register(int major, u64 size, int unit,
+			      struct gendisk *disk)
 {
-	struct gendisk *disk;
-
-	disk = alloc_disk(1 << UBD_SHIFT);
-	if(disk == NULL)
-		return -ENOMEM;
-
 	disk->major = major;
 	disk->first_minor = unit << UBD_SHIFT;
+	disk->minors = 1 << UBD_SHIFT;
 	disk->fops = &ubd_blops;
 	set_capacity(disk, size / 512);
 	sprintf(disk->disk_name, "ubd%c", 'a' + unit);
@@ -889,9 +883,6 @@ static int ubd_disk_register(int major, u64 size, int unit,
 	disk->private_data = &ubd_devs[unit];
 	disk->queue = ubd_devs[unit].queue;
 	device_add_disk(&ubd_devs[unit].pdev.dev, disk, ubd_attr_groups);
-
-	*disk_out = disk;
-	return 0;
 }
 
 #define ROUND_BLOCK(n) ((n + (SECTOR_SIZE - 1)) & (-SECTOR_SIZE))
@@ -903,6 +894,7 @@ static const struct blk_mq_ops ubd_mq_ops = {
 static int ubd_add(int n, char **error_out)
 {
 	struct ubd *ubd_dev = &ubd_devs[n];
+	struct gendisk *disk;
 	int err = 0;
 
 	if(ubd_dev->file == NULL)
@@ -927,32 +919,24 @@ static int ubd_add(int n, char **error_out)
 	if (err)
 		goto out;
 
-	ubd_dev->queue = blk_mq_init_queue(&ubd_dev->tag_set);
-	if (IS_ERR(ubd_dev->queue)) {
-		err = PTR_ERR(ubd_dev->queue);
+	disk = blk_mq_alloc_disk(&ubd_dev->tag_set, ubd_dev);
+	if (IS_ERR(disk)) {
+		err = PTR_ERR(disk);
 		goto out_cleanup_tags;
 	}
+	ubd_dev->queue = disk->queue;
 
-	ubd_dev->queue->queuedata = ubd_dev;
 	blk_queue_write_cache(ubd_dev->queue, true, false);
-
 	blk_queue_max_segments(ubd_dev->queue, MAX_SG);
 	blk_queue_segment_boundary(ubd_dev->queue, PAGE_SIZE - 1);
-	err = ubd_disk_register(UBD_MAJOR, ubd_dev->size, n, &ubd_gendisk[n]);
-	if(err){
-		*error_out = "Failed to register device";
-		goto out_cleanup_tags;
-	}
-
-	err = 0;
-out:
-	return err;
+	ubd_disk_register(UBD_MAJOR, ubd_dev->size, n, disk);
+	ubd_gendisk[n] = disk;
+	return 0;
 
 out_cleanup_tags:
 	blk_mq_free_tag_set(&ubd_dev->tag_set);
-	if (!(IS_ERR(ubd_dev->queue)))
-		blk_cleanup_queue(ubd_dev->queue);
-	goto out;
+out:
+	return err;
 }
 
 static int ubd_config(char *str, char **error_out)
@@ -1055,7 +1039,7 @@ static int ubd_remove(int n, char **error_out)
 	ubd_gendisk[n] = NULL;
 	if(disk != NULL){
 		del_gendisk(disk);
-		put_disk(disk);
+		blk_cleanup_disk(disk);
 	}
 
 	err = 0;
-- 
2.30.2

