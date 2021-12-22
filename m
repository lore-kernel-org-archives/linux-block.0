Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BDB6C433F5
	for <linux-block@archiver.kernel.org>; Wed, 22 Dec 2021 09:31:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239748AbhLVJbj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 22 Dec 2021 04:31:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231653AbhLVJbi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Dec 2021 04:31:38 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8986CC061574
        for <linux-block@vger.kernel.org>; Wed, 22 Dec 2021 01:31:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=8EbmMSRVnC7wp1jtYEwXYel2xRRIf5Gnf3a6IIPaTyY=; b=fZf1l4jvVi5UiO4o9wQdFZOF3V
        kj3zs1GMWzro95WznMMSZCpQc3kfzrZOcdW2mIIEA28b3iJ40BK+ZwgOAHGFjjzw1khVv3pbITJlW
        8FDQUAqtBC3Lvjvvfeu9ntvDwNlrSHNZeD4PNAQSyg/HqIxuKu1dbVxmOx0TXMZS1BrpJ6mspJsJG
        ZAQD0RpKZ/8k+nN/zM62diGRspG+hxdktZUugZStfp71WYBHMTI+feJDA8GHfW3RNOFlgtWxQ5IeS
        q/7baSGiZUSH2DSJHh4Jy3AqlzUrs385RKKpKpeIjXFVC4r97nvO7Y22X7SXinUXh82ukEBHlUUG8
        X0iF16fg==;
Received: from [2001:4bb8:190:3b1b:96b5:489:ff97:f4cf] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mzxyC-003FLK-9a; Wed, 22 Dec 2021 09:31:36 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: ensure the extended dev_t gets free for hidden gendisks
Date:   Wed, 22 Dec 2021 10:31:35 +0100
Message-Id: <20211222093135.938386-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Manually set bd_bdev for hidden gendisk to ensure they are freed when the
whole device bdev inode is freed.  For normal gendisks this is done by
bdev_add, which isn't called for hidden ones.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index 626c8406f21a6..563fb84ff746f 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -498,7 +498,10 @@ int __must_check device_add_disk(struct device *parent, struct gendisk *disk,
 	if (ret)
 		goto out_put_slave_dir;
 
-	if (!(disk->flags & GENHD_FL_HIDDEN)) {
+	if (disk->flags & GENHD_FL_HIDDEN) {
+		/* needed so that the extended dev_t gets freed */
+		disk->part0->bd_dev = MKDEV(disk->major, disk->first_minor);
+	} else {
 		ret = bdi_register(disk->bdi, "%u:%u",
 				   disk->major, disk->first_minor);
 		if (ret)
-- 
2.30.2

