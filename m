Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53402C4167B
	for <linux-block@archiver.kernel.org>; Mon, 30 Oct 2023 14:01:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232532AbjJ3OBY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Oct 2023 10:01:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232118AbjJ3OBX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Oct 2023 10:01:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DD5BC1
        for <linux-block@vger.kernel.org>; Mon, 30 Oct 2023 07:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=QWgjEf/fjD16JUEjiIUvMczcLDcjuKwRtJFW/bKIjpc=; b=yji1K7Gg8d69e/2EJqSUY1ymcx
        pRM0jjJzJnqwX6LwDJThkDH4hBDQqCu2LgeDlc1qf9tSBtuwWJY03NqgGY6VqksX0TjQ4h7JKfgEo
        l1PpCkkj/adIhQvegGqd4BV1wVCh7f9xVUKLUQmFBSP/9AkoRzjA6aGHZsZvrP/VlS6tKSHWGL8kS
        1mxsN/26QCcr9Lf3oY9C9kWJ57Qf9+pzjmlk+rngsId4Vk/A2bzHoKe7Ee6n7QE+TlaRPYs7FVoHw
        +JSFGJMIOLcDwtBsBxAlQbvI3C073f6JccG3pyr4j9N8DHAt52db4tiaG0OZGkvSzsGvDTaNNRKiC
        q9kUYcUA==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qxSpN-003RsO-2w;
        Mon, 30 Oct 2023 14:01:14 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, richard@nod.at, miquel.raynal@bootlin.com,
        vigneshr@ti.com
Cc:     linux-block@vger.kernel.org, linux-mtd@lists.infradead.org,
        zhongjinghua@huawei.com, yukuai1@huaweicloud.com
Subject: [PATCH 1/2] ubi: block: don't use gendisk->first_minor for the idr_alloc return value
Date:   Mon, 30 Oct 2023 15:01:05 +0100
Message-Id: <20231030140106.1393384-1-hch@lst.de>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

idr_alloc returns an int that is either a negative errno, or the
identifier actually allocated.  Use signed integer ret variable to
catch the return value and only assign it to gd->first_minor to prepare
for marking the first_minor field in the gendisk structure as unsigned.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mtd/ubi/block.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/ubi/block.c b/drivers/mtd/ubi/block.c
index 437c5b83ffe513..51d00b518d3197 100644
--- a/drivers/mtd/ubi/block.c
+++ b/drivers/mtd/ubi/block.c
@@ -402,13 +402,14 @@ int ubiblock_create(struct ubi_volume_info *vi)
 	gd->fops = &ubiblock_ops;
 	gd->major = ubiblock_major;
 	gd->minors = 1;
-	gd->first_minor = idr_alloc(&ubiblock_minor_idr, dev, 0, 0, GFP_KERNEL);
-	if (gd->first_minor < 0) {
+	ret = idr_alloc(&ubiblock_minor_idr, dev, 0, 0, GFP_KERNEL);
+	if (ret < 0) {
 		dev_err(disk_to_dev(gd),
 			"block: dynamic minor allocation failed");
 		ret = -ENODEV;
 		goto out_cleanup_disk;
 	}
+	gd->first_minor  = ret;
 	gd->flags |= GENHD_FL_NO_PART;
 	gd->private_data = dev;
 	sprintf(gd->disk_name, "ubiblock%d_%d", dev->ubi_num, dev->vol_id);
-- 
2.39.2

