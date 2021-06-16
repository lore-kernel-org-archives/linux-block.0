Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45F97C48BE5
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 05:40:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B00C6128C
	for <linux-block@archiver.kernel.org>; Wed, 16 Jun 2021 05:40:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbhFPFmL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 16 Jun 2021 01:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbhFPFmK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 16 Jun 2021 01:42:10 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BC3CC061574;
        Tue, 15 Jun 2021 22:40:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=RN6xMNjyKugnDqAJMixQLRXDoQ5TkT3s3W9aIuQhd3Q=; b=JKGUUtL7wQ+SW4fYYWxw36ZhON
        6HmYvgocPf4X2B3DOStuqpsrFVAggzi0gVSbDtdQkrgwbAJkD6xcUqxtuzXEo4tsOAJluxZ4wEH3E
        L+ah3ZK6RHgb3367HEmvr0rA/HYvF3bYJJsUbRLTeGl05Y+kgjGMVn3JiB3sYPBW8c7gD5DtDHKE1
        IKaCoXUP7CXFxXgJ/htTvr1sdYf8Tc1haV+r8ocAJ68r4zQvYKeF1tmkjPZTHzV84EmJBuTD1QbIA
        jBpjwpP+c8rKZjDwK/+B6Ne+yexMb6QSaluQfL89JDuZMGSAyz7V9SiyvfyPiBwN8HBLwJrPkk7Qz
        28yVVAyA==;
Received: from [2001:4bb8:19b:fdce:84d:447:81f0:ca60] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ltOHF-007e8z-Bx; Wed, 16 Jun 2021 05:39:51 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     linux-mmc@vger.kernel.org, linux-block@vger.kernel.org
Subject: [PATCH 1/2] mmc: remove an extra blk_{get,put}_queue pair
Date:   Wed, 16 Jun 2021 07:39:33 +0200
Message-Id: <20210616053934.880951-2-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210616053934.880951-1-hch@lst.de>
References: <20210616053934.880951-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The gendisk already acquires a reference to the queue when add_disk
is called, which dropped on put_disk.  So remove the superflous
extra refcounting.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mmc/core/block.c | 14 +-------------
 1 file changed, 1 insertion(+), 13 deletions(-)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 689eb9afeeed..947624e76c33 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -201,7 +201,7 @@ static void mmc_blk_put(struct mmc_blk_data *md)
 	md->usage--;
 	if (md->usage == 0) {
 		int devidx = mmc_get_devidx(md->disk);
-		blk_put_queue(md->queue.queue);
+
 		ida_simple_remove(&mmc_blk_ida, devidx);
 		put_disk(md->disk);
 		kfree(md);
@@ -2326,18 +2326,6 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 
 	md->queue.blkdata = md;
 
-	/*
-	 * Keep an extra reference to the queue so that we can shutdown the
-	 * queue (i.e. call blk_cleanup_queue()) while there are still
-	 * references to the 'md'. The corresponding blk_put_queue() is in
-	 * mmc_blk_put().
-	 */
-	if (!blk_get_queue(md->queue.queue)) {
-		mmc_cleanup_queue(&md->queue);
-		ret = -ENODEV;
-		goto err_putdisk;
-	}
-
 	md->disk->major	= MMC_BLOCK_MAJOR;
 	md->disk->first_minor = devidx * perdev_minors;
 	md->disk->fops = &mmc_bdops;
-- 
2.30.2

