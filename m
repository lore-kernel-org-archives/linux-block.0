Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00FEAC43334
	for <linux-block@archiver.kernel.org>; Mon, 18 Jul 2022 06:29:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229711AbiGRG3k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 18 Jul 2022 02:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231976AbiGRG3i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 18 Jul 2022 02:29:38 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EAABBF
        for <linux-block@vger.kernel.org>; Sun, 17 Jul 2022 23:29:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=8uLbd4oIFOB/kbJTjtRtcUT7WyCCYN9f2zhyU6Eo74k=; b=akTr6UL4FZExYGk7eUZ7vHTUx6
        y3HeWlqO06WJ96fQKasOJ8BIrHrNdOaTWfqOJZ98Xkm5adRJAV22yl9XV09egkGtzySa1vAWNvaoR
        rb8shTuICNu0rN7aTK57PGe73IVnrgRLdTB0351C4QmYVpcBouE+x0Xs0YqDNgArwt56ZU6Nz2Adm
        2M40Nzp91ktqn8VG6FgdGhGTt9TdOLuAEwMB8UeUUtWb4z+s6j2MXWwgjLKw8tq2dbOWHWKp6VnU+
        Wh/+pfM11egRkhhYYdzUVlLyplQUFtB5kC//BXXOF+ikg4126WuhijjrXx5xPOoGppQi5ePpGDd9M
        am1KAaOg==;
Received: from 089144198117.atnat0007.highway.a1.net ([89.144.198.117] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oDKG5-00BD6J-UT; Mon, 18 Jul 2022 06:29:34 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     ming.lei@redhat.com, linux-block@vger.kernel.org
Subject: [PATCH 2/2] Revert "ublk_drv: fix request queue leak"
Date:   Mon, 18 Jul 2022 08:29:28 +0200
Message-Id: <20220718062928.335399-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220718062928.335399-1-hch@lst.de>
References: <20220718062928.335399-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This was just a rather broken way to paper over a core block layer bug
that is now fixed.

This reverts commit cebbe577cb17ed9b04b50d9e6802a8bacffbadca.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/block/ublk_drv.c | 21 ++++++---------------
 1 file changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/block/ublk_drv.c b/drivers/block/ublk_drv.c
index b633d268b90ae..4e0248ef6bec5 100644
--- a/drivers/block/ublk_drv.c
+++ b/drivers/block/ublk_drv.c
@@ -155,8 +155,6 @@ static DEFINE_MUTEX(ublk_ctl_mutex);
 
 static struct miscdevice ublk_misc;
 
-static struct lock_class_key ublk_bio_compl_lkclass;
-
 static inline bool ublk_can_use_task_work(const struct ublk_queue *ubq)
 {
 	if (IS_BUILTIN(CONFIG_BLK_DEV_UBLK) &&
@@ -633,7 +631,7 @@ static void ublk_commit_rqs(struct blk_mq_hw_ctx *hctx)
 static int ublk_init_hctx(struct blk_mq_hw_ctx *hctx, void *driver_data,
 		unsigned int hctx_idx)
 {
-	struct ublk_device *ub = driver_data;
+	struct ublk_device *ub = hctx->queue->queuedata;
 	struct ublk_queue *ubq = ublk_get_queue(ub, hctx->queue_num);
 
 	hctx->driver_data = ubq;
@@ -1074,8 +1072,6 @@ static void ublk_cdev_rel(struct device *dev)
 {
 	struct ublk_device *ub = container_of(dev, struct ublk_device, cdev_dev);
 
-	blk_mq_destroy_queue(ub->ub_queue);
-
 	put_disk(ub->ub_disk);
 
 	blk_mq_free_tag_set(&ub->tag_set);
@@ -1165,17 +1161,14 @@ static int ublk_add_dev(struct ublk_device *ub)
 	if (err)
 		goto out_deinit_queues;
 
-	ub->ub_queue = blk_mq_init_queue(&ub->tag_set);
-	if (IS_ERR(ub->ub_queue))
-		goto out_cleanup_tags;
-	ub->ub_queue->queuedata = ub;
-
-	disk = ub->ub_disk = blk_mq_alloc_disk_for_queue(ub->ub_queue,
-						 &ublk_bio_compl_lkclass);
+	disk = ub->ub_disk = blk_mq_alloc_disk(&ub->tag_set, ub);
 	if (IS_ERR(disk)) {
 		err = PTR_ERR(disk);
-		goto out_free_request_queue;
+		goto out_cleanup_tags;
 	}
+	ub->ub_queue = ub->ub_disk->queue;
+
+	ub->ub_queue->queuedata = ub;
 
 	blk_queue_logical_block_size(ub->ub_queue, bsize);
 	blk_queue_physical_block_size(ub->ub_queue, bsize);
@@ -1207,8 +1200,6 @@ static int ublk_add_dev(struct ublk_device *ub)
 
 	return 0;
 
-out_free_request_queue:
-	blk_mq_destroy_queue(ub->ub_queue);
 out_cleanup_tags:
 	blk_mq_free_tag_set(&ub->tag_set);
 out_deinit_queues:
-- 
2.30.2

