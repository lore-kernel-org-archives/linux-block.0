Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7137AC6FA82
	for <linux-block@archiver.kernel.org>; Wed, 21 Sep 2022 18:05:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229762AbiIUSFf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 21 Sep 2022 14:05:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229988AbiIUSFc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 21 Sep 2022 14:05:32 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE18675FE9
        for <linux-block@vger.kernel.org>; Wed, 21 Sep 2022 11:05:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=vIMyATbddCeHK5BUOCJrfxsf1/ksAXbNSBQ1XmhEEsY=; b=WkUR2oCz6/73ly/068gI2ZAWpA
        f175hc4Tjf28QKTosvAFujAC+S/0ugbAAVit6edNz2ZOIkfrtrNaYfSIZt7fxXJZqc47hh0h05mWh
        UHO9MAxpHqDk6o6DRP+78jqZ3Cvw+t6rQ9x9/SdmzL2F3y+YLlgbzcULM9q+kciT4Q7Ah8mXVDM2H
        GnjAqB3mwtsCLzWC9Hm5be24gqDQH7a0w81tSSi4tFeyemMhR3nhBjJU26kXQcu0MI2PUIA88hHTg
        oj+b6BS0GtgzvMjIZ6poVfwdLbayl0L/kFfWeL7iuqpJs2Ny7LDjyBKOpI1NfQfW1Q+/2vIynM/BK
        SkvP+7rQ==;
Received: from ip4d15bec4.dynamic.kabel-deutschland.de ([77.21.190.196] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ob46D-00CGaq-BM; Wed, 21 Sep 2022 18:05:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Tejun Heo <tj@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 11/17] blk-iocost: cleanup ioc_qos_write
Date:   Wed, 21 Sep 2022 20:04:55 +0200
Message-Id: <20220921180501.1539876-12-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220921180501.1539876-1-hch@lst.de>
References: <20220921180501.1539876-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use a local disk variable instead of retrieving the disk and
request_queue over and over by various means.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk-iocost.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/block/blk-iocost.c b/block/blk-iocost.c
index 1e7bf0d353227..b8e5f550aa5be 100644
--- a/block/blk-iocost.c
+++ b/block/blk-iocost.c
@@ -3167,6 +3167,7 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 			     size_t nbytes, loff_t off)
 {
 	struct block_device *bdev;
+	struct gendisk *disk;
 	struct ioc *ioc;
 	u32 qos[NR_QOS_PARAMS];
 	bool enable, user;
@@ -3177,12 +3178,13 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	if (IS_ERR(bdev))
 		return PTR_ERR(bdev);
 
-	ioc = q_to_ioc(bdev_get_queue(bdev));
+	disk = bdev->bd_disk;
+	ioc = q_to_ioc(disk->queue);
 	if (!ioc) {
-		ret = blk_iocost_init(bdev->bd_disk);
+		ret = blk_iocost_init(disk);
 		if (ret)
 			goto err;
-		ioc = q_to_ioc(bdev_get_queue(bdev));
+		ioc = q_to_ioc(disk->queue);
 	}
 
 	spin_lock_irq(&ioc->lock);
@@ -3259,11 +3261,11 @@ static ssize_t ioc_qos_write(struct kernfs_open_file *of, char *input,
 	spin_lock_irq(&ioc->lock);
 
 	if (enable) {
-		blk_stat_enable_accounting(ioc->rqos.q);
-		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, ioc->rqos.q);
+		blk_stat_enable_accounting(disk->queue);
+		blk_queue_flag_set(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
 		ioc->enabled = true;
 	} else {
-		blk_queue_flag_clear(QUEUE_FLAG_RQ_ALLOC_TIME, ioc->rqos.q);
+		blk_queue_flag_clear(QUEUE_FLAG_RQ_ALLOC_TIME, disk->queue);
 		ioc->enabled = false;
 	}
 
-- 
2.30.2

