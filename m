Return-Path: <SRS0=r6We=DC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30E22C4363D
	for <linux-block@archiver.kernel.org>; Fri, 25 Sep 2020 16:06:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9A1C2311D
	for <linux-block@archiver.kernel.org>; Fri, 25 Sep 2020 16:06:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="cj/4AY1i"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgIYQGm (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Sep 2020 12:06:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728858AbgIYQGm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Sep 2020 12:06:42 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3CD1C0613CE;
        Fri, 25 Sep 2020 09:06:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=uQJgydSUoDayMaZ249oqW7zlbGRJdSVTgqWhb7/rJ3k=; b=cj/4AY1inDNhDrclJrrVdCdYE+
        PJvR/111DO97fIjVnQ14y2n3dlupQHcIJ/DkkbbQS3rpDbWSt50bn+xQWsabkwUb7YyV8SKlH1cO7
        Hoe90eDO+/f1nOSbc1ugnU90h8Cz052p4U1tI1KWFWw+M+1zqleVC0aheX0+YbvjySe753X/V4N/+
        Ewd6DbHsExdbRARUIHO1ZJmryZu6V3TdVKllEEEXXI+EGNk40D8tMlScIUB7ZgyLSOhYTpPnf2JYF
        AAof47/pFcDFKKKLi2aP44Xf+u7N2grImrufgZ/1wr528ymlA2LbAY/oZg+2FtW4YsVvKPvtGtDvI
        M0d/+vSA==;
Received: from [213.208.157.35] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kLqF5-0003Ow-HI; Fri, 25 Sep 2020 16:06:39 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Philipp Reisner <philipp.reisner@linbit.com>,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        drbd-dev@lists.linbit.com
Subject: [PATCH 2/2] block: add a bdget_part helper
Date:   Fri, 25 Sep 2020 18:06:18 +0200
Message-Id: <20200925160618.1481450-3-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200925160618.1481450-1-hch@lst.de>
References: <20200925160618.1481450-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All remaining callers of bdget() outside of fs/block_dev.c want to get a
reference to the struct block_device for a given struct hd_struct.  Add
a helper just for that and then mark bdget static.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c           | 2 +-
 block/partitions/core.c | 2 +-
 fs/block_dev.c          | 9 ++++++---
 include/linux/blkdev.h  | 2 +-
 kernel/trace/blktrace.c | 9 ++-------
 5 files changed, 11 insertions(+), 13 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index e5f17f022ec700..0a273211fec283 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -1048,7 +1048,7 @@ struct block_device *bdget_disk(struct gendisk *disk, int partno)
 
 	part = disk_get_part(disk, partno);
 	if (part)
-		bdev = bdget(part_devt(part));
+		bdev = bdget_part(part);
 	disk_put_part(part);
 
 	return bdev;
diff --git a/block/partitions/core.c b/block/partitions/core.c
index dd6811422a87af..5309e0f44ba352 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -580,7 +580,7 @@ int bdev_resize_partition(struct block_device *bdev, int partno,
 		return -ENXIO;
 
 	ret = -ENOMEM;
-	bdevp = bdget(part_devt(part));
+	bdevp = bdget_part(part);
 	if (!bdevp)
 		goto out_put_part;
 
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 6b9d19ffa5af7b..9e84b1928b9401 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -891,7 +891,7 @@ static int bdev_set(struct inode *inode, void *data)
 	return 0;
 }
 
-struct block_device *bdget(dev_t dev)
+static struct block_device *bdget(dev_t dev)
 {
 	struct block_device *bdev;
 	struct inode *inode;
@@ -920,8 +920,6 @@ struct block_device *bdget(dev_t dev)
 	return bdev;
 }
 
-EXPORT_SYMBOL(bdget);
-
 /**
  * bdgrab -- Grab a reference to an already referenced block device
  * @bdev:	Block device to grab a reference to.
@@ -933,6 +931,11 @@ struct block_device *bdgrab(struct block_device *bdev)
 }
 EXPORT_SYMBOL(bdgrab);
 
+struct block_device *bdget_part(struct hd_struct *part)
+{
+	return bdget(part_devt(part));
+}
+
 long nr_blockdev_pages(void)
 {
 	struct inode *inode;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index d5a3e1a4c2f79b..cf80e61b4c5e1a 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -2003,7 +2003,7 @@ void bd_abort_claiming(struct block_device *bdev, struct block_device *whole,
 void blkdev_put(struct block_device *bdev, fmode_t mode);
 
 struct block_device *I_BDEV(struct inode *inode);
-struct block_device *bdget(dev_t);
+struct block_device *bdget_part(struct hd_struct *part);
 struct block_device *bdgrab(struct block_device *bdev);
 void bdput(struct block_device *);
 
diff --git a/kernel/trace/blktrace.c b/kernel/trace/blktrace.c
index ec874ea040922a..f1022945e3460b 100644
--- a/kernel/trace/blktrace.c
+++ b/kernel/trace/blktrace.c
@@ -1827,13 +1827,11 @@ static ssize_t sysfs_blk_trace_attr_show(struct device *dev,
 					 struct device_attribute *attr,
 					 char *buf)
 {
-	struct hd_struct *p = dev_to_part(dev);
+	struct block_device *bdev = bdget_part(dev_to_part(dev));
 	struct request_queue *q;
-	struct block_device *bdev;
 	struct blk_trace *bt;
 	ssize_t ret = -ENXIO;
 
-	bdev = bdget(part_devt(p));
 	if (bdev == NULL)
 		goto out;
 
@@ -1875,7 +1873,6 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 {
 	struct block_device *bdev;
 	struct request_queue *q;
-	struct hd_struct *p;
 	struct blk_trace *bt;
 	u64 value;
 	ssize_t ret = -EINVAL;
@@ -1895,9 +1892,7 @@ static ssize_t sysfs_blk_trace_attr_store(struct device *dev,
 		goto out;
 
 	ret = -ENXIO;
-
-	p = dev_to_part(dev);
-	bdev = bdget(part_devt(p));
+	bdev = bdget_part(dev_to_part(dev));
 	if (bdev == NULL)
 		goto out;
 
-- 
2.28.0

