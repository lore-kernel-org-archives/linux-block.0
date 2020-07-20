Return-Path: <SRS0=KbiG=A7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12818C433F2
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 06:13:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E3E4721775
	for <linux-block@archiver.kernel.org>; Mon, 20 Jul 2020 06:12:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="D7k9LYQD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726893AbgGTGM7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726892AbgGTGM7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 20 Jul 2020 02:12:59 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECD3BC0619D2
        for <linux-block@vger.kernel.org>; Sun, 19 Jul 2020 23:12:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=6wS8AG/dT4atadMMMMGDnuFn9Z9C/x/k+18Du5ci1CE=; b=D7k9LYQDumBiBrMRL1NiBUGTi4
        yAJWZlPnyaAeNEzZQKLWMEVLLVjkenW+/agpMZtUPXH4yZy3NZ6XZO5FLm8biTIirM/b7z/fw19tg
        w2tZ/sOZjL5cAQazdVSyovX3ZLIMP1TV2cbBhrR3JG7iXLrxffhplAgSCGTwY9oggfV1cntSCdc1D
        cROT9mbd8/axNQYQ0AQsebI8ZCpQclc7mvin4yJk2VPtBINLFn9gXp98k9kxKYNIR/lgusQp/+PBd
        fA6AM2AkEKYdNQoIDNAECZRV8mUh7r1wCeGXOd8KW8GcRFhRvE7c4n+GsaLlcG9iNgQyr7wxXgHTk
        FspYrfkg==;
Received: from [2001:4bb8:105:4a81:b96b:120c:c0c5:74fd] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jxP2m-0006gd-GA; Mon, 20 Jul 2020 06:12:57 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     Damien.LeMoal@wdc.com, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: [PATCH 3/3] block: remove blk_queue_stack_limits
Date:   Mon, 20 Jul 2020 08:12:51 +0200
Message-Id: <20200720061251.652457-4-hch@lst.de>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200720061251.652457-1-hch@lst.de>
References: <20200720061251.652457-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This function is just a tiny wrapper around blk_stack_limits.  Open code
it int the two callers.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-settings.c         | 11 -----------
 drivers/block/drbd/drbd_nl.c |  4 ++--
 drivers/nvme/host/core.c     |  3 ++-
 include/linux/blkdev.h       |  1 -
 4 files changed, 4 insertions(+), 15 deletions(-)

diff --git a/block/blk-settings.c b/block/blk-settings.c
index 8c63af7726850c..76a7e03bcd6cac 100644
--- a/block/blk-settings.c
+++ b/block/blk-settings.c
@@ -455,17 +455,6 @@ void blk_queue_io_opt(struct request_queue *q, unsigned int opt)
 }
 EXPORT_SYMBOL(blk_queue_io_opt);
 
-/**
- * blk_queue_stack_limits - inherit underlying queue limits for stacked drivers
- * @t:	the stacking driver (top)
- * @b:  the underlying device (bottom)
- **/
-void blk_queue_stack_limits(struct request_queue *t, struct request_queue *b)
-{
-	blk_stack_limits(&t->limits, &b->limits, 0);
-}
-EXPORT_SYMBOL(blk_queue_stack_limits);
-
 /**
  * blk_stack_limits - adjust queue_limits for stacked devices
  * @t:	the stacking driver limits (top device)
diff --git a/drivers/block/drbd/drbd_nl.c b/drivers/block/drbd/drbd_nl.c
index da4a3ebe04efa5..d0d9a549b58388 100644
--- a/drivers/block/drbd/drbd_nl.c
+++ b/drivers/block/drbd/drbd_nl.c
@@ -1250,7 +1250,7 @@ static void fixup_discard_if_not_supported(struct request_queue *q)
 
 static void fixup_write_zeroes(struct drbd_device *device, struct request_queue *q)
 {
-	/* Fixup max_write_zeroes_sectors after blk_queue_stack_limits():
+	/* Fixup max_write_zeroes_sectors after blk_stack_limits():
 	 * if we can handle "zeroes" efficiently on the protocol,
 	 * we want to do that, even if our backend does not announce
 	 * max_write_zeroes_sectors itself. */
@@ -1361,7 +1361,7 @@ static void drbd_setup_queue_param(struct drbd_device *device, struct drbd_backi
 	decide_on_write_same_support(device, q, b, o, disable_write_same);
 
 	if (b) {
-		blk_queue_stack_limits(q, b);
+		blk_stack_limits(&q->limits, &b->limits, 0);
 
 		if (q->backing_dev_info->ra_pages !=
 		    b->backing_dev_info->ra_pages) {
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index 5192a024dc1b9c..45c4c408649080 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -1973,7 +1973,8 @@ static int __nvme_revalidate_disk(struct gendisk *disk, struct nvme_id_ns *id)
 #ifdef CONFIG_NVME_MULTIPATH
 	if (ns->head->disk) {
 		nvme_update_disk_info(ns->head->disk, ns, id);
-		blk_queue_stack_limits(ns->head->disk->queue, ns->queue);
+		blk_stack_limits(&ns->head->disk->queue->limits,
+				 &ns->queue->limits, 0);
 		revalidate_disk(ns->head->disk);
 	}
 #endif
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 247b0e0a2901f0..484cd3c8447452 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1108,7 +1108,6 @@ extern int blk_stack_limits(struct queue_limits *t, struct queue_limits *b,
 			    sector_t offset);
 extern void disk_stack_limits(struct gendisk *disk, struct block_device *bdev,
 			      sector_t offset);
-extern void blk_queue_stack_limits(struct request_queue *t, struct request_queue *b);
 extern void blk_queue_update_dma_pad(struct request_queue *, unsigned int);
 extern void blk_queue_segment_boundary(struct request_queue *, unsigned long);
 extern void blk_queue_virt_boundary(struct request_queue *, unsigned long);
-- 
2.27.0

