Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 83C58C4332F
	for <linux-block@archiver.kernel.org>; Mon, 30 Oct 2023 14:01:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232542AbjJ3OBX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 30 Oct 2023 10:01:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232532AbjJ3OBX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 30 Oct 2023 10:01:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 138B2B7
        for <linux-block@vger.kernel.org>; Mon, 30 Oct 2023 07:01:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=7Yjc15PJUnJY0o47CDNKLqnyXJ93R9B0HXbm6Hil9Kg=; b=AwMeO+hfZL9/XRZYwws0NCYtbb
        YGtasjQP1bEFrQ16dbpnotuRB8vaChDpSvbyBkfHP8SFOY7fVXvA/mmIq2+95q93ukz0pluxQAUD+
        SmWIKPfY9Bx9yLvTCez+a2Wpoum4YTCiNe4b5K0bM5VXhQkFcgC9srdcE/17kWFfbgF7SD65RtfDV
        Wk+HRH33F0jUaZrlq1boODdPqi3JhIfTzq8/5axCEObT08GnAPl3DdoEpkAplFOzU5zH7H+wZPdtr
        xZEeXgT+KL5lnZnxGnF6wpQiETVM7lGhv/acCMsg4ZjVr0Sh9NqgfxFDijvExPiOQLd84oiCTGFlJ
        sxFftiYw==;
Received: from 2a02-8389-2341-5b80-39d3-4735-9a3c-88d8.cable.dynamic.v6.surfer.at ([2a02:8389:2341:5b80:39d3:4735:9a3c:88d8] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qxSpQ-003RsW-2R;
        Mon, 30 Oct 2023 14:01:17 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk, richard@nod.at, miquel.raynal@bootlin.com,
        vigneshr@ti.com
Cc:     linux-block@vger.kernel.org, linux-mtd@lists.infradead.org,
        zhongjinghua@huawei.com, yukuai1@huaweicloud.com
Subject: [PATCH 2/2] block: dev_t components are unsigned
Date:   Mon, 30 Oct 2023 15:01:06 +0100
Message-Id: <20231030140106.1393384-2-hch@lst.de>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20231030140106.1393384-1-hch@lst.de>
References: <20231030140106.1393384-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

... thus mark the major, first_minor and minors fields in struct gendisk
as such.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c          | 4 ++--
 include/linux/blkdev.h | 6 +++---
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index cc32a0c704eb84..ceeb30518db696 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -180,7 +180,7 @@ void blkdev_show(struct seq_file *seqf, off_t offset)
 	spin_lock(&major_names_spinlock);
 	for (dp = major_names[major_to_index(offset)]; dp; dp = dp->next)
 		if (dp->major == offset)
-			seq_printf(seqf, "%3d %s\n", dp->major, dp->name);
+			seq_printf(seqf, "%3u %s\n", dp->major, dp->name);
 	spin_unlock(&major_names_spinlock);
 }
 #endif /* CONFIG_PROC_FS */
@@ -896,7 +896,7 @@ static ssize_t disk_range_show(struct device *dev,
 {
 	struct gendisk *disk = dev_to_disk(dev);
 
-	return sprintf(buf, "%d\n", disk->minors);
+	return sprintf(buf, "%u\n", disk->minors);
 }
 
 static ssize_t disk_ext_range_show(struct device *dev,
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index eef450f259828d..3ecf928d6325b6 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -130,9 +130,9 @@ struct gendisk {
 	 * major/first_minor/minors should not be set by any new driver, the
 	 * block core will take care of allocating them automatically.
 	 */
-	int major;
-	int first_minor;
-	int minors;
+	unsigned int major;
+	unsigned int first_minor;
+	unsigned int minors;
 
 	char disk_name[DISK_NAME_LEN];	/* name of major driver */
 
-- 
2.39.2

