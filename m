Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 132D8C48BE8
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 06:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6EAB6128B
	for <linux-block@archiver.kernel.org>; Mon, 14 Jun 2021 06:03:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbhFNGF7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jun 2021 02:05:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232380AbhFNGF7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jun 2021 02:05:59 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40076C061574
        for <linux-block@vger.kernel.org>; Sun, 13 Jun 2021 23:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=6mO1zw8nNVZUZidy3etWT9nvNEPrsJZuD3woVvh7zRw=; b=AC9/63abZ2DjtDSkIfQ4Rof5HX
        ZCwGa6ZcPmI1snUVDb0Wf5YvKJC0mWYeYc6ONk4DAfvpM11xZmKbFpWlkz3LVbg0Yh9BGqEli1nk4
        bxk9JHAeLAAbA8tj79Lv3CIta1Bw4c+ityrkBk+wOLKEx1xz2ubm0yh8s4zzcAMryg/UYOcBWv6/3
        MqtyWWaHgpYK0t+atcIHC8DSyuSqjbHt97erGbWB3bYfgqn1oG0yHkQ2DisPMzYiuitt8yhYrqAqA
        JD6q000Dfv/JAUmLzqyxKf0Qjhp7bz3fS0kn4sN3tgTxrwGoB1buB6ry3k84H8NAbmJYcD/j7qmVm
        JOODMEgQ==;
Received: from [2001:4bb8:19b:fdce:c70:4a89:bc61:2] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1lsfhT-00Cfss-CM; Mon, 14 Jun 2021 06:03:55 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 2/2] mtip32xx: use blk_mq_alloc_disk and blk_cleanup_disk
Date:   Mon, 14 Jun 2021 08:03:43 +0200
Message-Id: <20210614060343.3965416-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210614060343.3965416-1-hch@lst.de>
References: <20210614060343.3965416-1-hch@lst.de>
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
 drivers/block/mtip32xx/mtip32xx.c | 71 ++++++++++++-------------------
 1 file changed, 27 insertions(+), 44 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index e2749698fb81..461cb8846c83 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -3561,35 +3561,6 @@ static int mtip_block_initialize(struct driver_data *dd)
 		goto protocol_init_error;
 	}
 
-	dd->disk = alloc_disk_node(MTIP_MAX_MINORS, dd->numa_node);
-	if (dd->disk  == NULL) {
-		dev_err(&dd->pdev->dev,
-			"Unable to allocate gendisk structure\n");
-		rv = -EINVAL;
-		goto alloc_disk_error;
-	}
-
-	rv = ida_alloc(&rssd_index_ida, GFP_KERNEL);
-	if (rv < 0)
-		goto ida_get_error;
-	index = rv;
-
-	rv = rssd_disk_name_format("rssd",
-				index,
-				dd->disk->disk_name,
-				DISK_NAME_LEN);
-	if (rv)
-		goto disk_index_error;
-
-	dd->disk->major		= dd->major;
-	dd->disk->first_minor	= index * MTIP_MAX_MINORS;
-	dd->disk->minors 	= MTIP_MAX_MINORS;
-	dd->disk->fops		= &mtip_block_ops;
-	dd->disk->private_data	= dd;
-	dd->index		= index;
-
-	mtip_hw_debugfs_init(dd);
-
 	memset(&dd->tags, 0, sizeof(dd->tags));
 	dd->tags.ops = &mtip_mq_ops;
 	dd->tags.nr_hw_queues = 1;
@@ -3608,17 +3579,35 @@ static int mtip_block_initialize(struct driver_data *dd)
 		goto block_queue_alloc_tag_error;
 	}
 
-	/* Allocate the request queue. */
-	dd->queue = blk_mq_init_queue(&dd->tags);
-	if (IS_ERR(dd->queue)) {
+	dd->disk = blk_mq_alloc_disk(&dd->tags, dd);
+	if (IS_ERR(dd->disk)) {
 		dev_err(&dd->pdev->dev,
 			"Unable to allocate request queue\n");
 		rv = -ENOMEM;
 		goto block_queue_alloc_init_error;
 	}
+	dd->queue		= dd->disk->queue;
 
-	dd->disk->queue		= dd->queue;
-	dd->queue->queuedata	= dd;
+	rv = ida_alloc(&rssd_index_ida, GFP_KERNEL);
+	if (rv < 0)
+		goto ida_get_error;
+	index = rv;
+
+	rv = rssd_disk_name_format("rssd",
+				index,
+				dd->disk->disk_name,
+				DISK_NAME_LEN);
+	if (rv)
+		goto disk_index_error;
+
+	dd->disk->major		= dd->major;
+	dd->disk->first_minor	= index * MTIP_MAX_MINORS;
+	dd->disk->minors 	= MTIP_MAX_MINORS;
+	dd->disk->fops		= &mtip_block_ops;
+	dd->disk->private_data	= dd;
+	dd->index		= index;
+
+	mtip_hw_debugfs_init(dd);
 
 skip_create_disk:
 	/* Initialize the protocol layer. */
@@ -3684,23 +3673,17 @@ static int mtip_block_initialize(struct driver_data *dd)
 kthread_run_error:
 	/* Delete our gendisk. This also removes the device from /dev */
 	del_gendisk(dd->disk);
-
 read_capacity_error:
 init_hw_cmds_error:
-	blk_cleanup_queue(dd->queue);
-block_queue_alloc_init_error:
-	blk_mq_free_tag_set(&dd->tags);
-block_queue_alloc_tag_error:
 	mtip_hw_debugfs_exit(dd);
 disk_index_error:
 	ida_free(&rssd_index_ida, index);
-
 ida_get_error:
-	put_disk(dd->disk);
-
-alloc_disk_error:
+	blk_cleanup_disk(dd->disk);
+block_queue_alloc_init_error:
+	blk_mq_free_tag_set(&dd->tags);
+block_queue_alloc_tag_error:
 	mtip_hw_exit(dd); /* De-initialize the protocol layer. */
-
 protocol_init_error:
 	return rv;
 }
-- 
2.30.2

