Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 236AFC433F5
	for <linux-block@archiver.kernel.org>; Tue,  4 Jan 2022 07:16:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231719AbiADHQu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Jan 2022 02:16:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230349AbiADHQu (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Jan 2022 02:16:50 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06F27C061761
        for <linux-block@vger.kernel.org>; Mon,  3 Jan 2022 23:16:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=e2cbBNYTX/qw7guQ5dQ5eIO7S2aEXen5spLRsg3hBSQ=; b=0WukTOWCksJL/srqqsqEZbp7/C
        eWHBSp4T2adR7aHhjG9JoXAOzqPbb1q3GB1WMc1aB3e0GxogrSbRMgCJs8dn4oeVMZk8y88Uk+pwY
        2uj4SB3uf31+OQYLYqaYO2N85c3wxeLCZoRu+4Kf7iB0bNwseJcM9sPBh8iqSAfZceXM4L91J55C1
        YvsbZAs5bizlqJcJYN6fRsmpU7cKLTp4fzTID/YjXxxxuGxu10/VwyYNbYs/yFS1BOfGBqKAPlwjs
        2DEzHNUdXVMSPJFxvcnJQHS/FM9zM9YyYPe9onzyZYvHtVWmzM/2ZtIPqFOBSj25yS9hOmSY9XR5A
        3pmk0jkQ==;
Received: from [2001:4bb8:184:3f95:15c:3e66:a12b:4469] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4e3t-00AVCD-9K; Tue, 04 Jan 2022 07:16:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, penguin-kernel@I-love.SAKURA.ne.jp
Subject: [PATCH v2] block: deprecate autoloading based on dev_t
Date:   Tue,  4 Jan 2022 08:16:47 +0100
Message-Id: <20220104071647.164918-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Make the legacy dev_t based autoloading optional and add a deprecation
warning.  This kind of autoloading has ceased to be useful about 20 years
ago.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---

Changes since v1:
 - improve the Kconfig help text and deprecation printk

 block/Kconfig | 12 ++++++++++++
 block/bdev.c  |  9 ++++++---
 block/genhd.c |  6 ++++++
 3 files changed, 24 insertions(+), 3 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index d5d4197b7ed2d..205f8d01c6952 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -26,6 +26,18 @@ menuconfig BLOCK
 
 if BLOCK
 
+config BLOCK_LEGACY_AUTOLOAD
+	bool "Legacy autoloading support"
+	help
+	  Enable loading modules and creating block device instances based on
+	  accesses through their device special file.  This is a historic Linux
+	  feature and makes no sense in a udev world where device files are
+	  created on demand.
+
+	  Say N here unless booting or other functionality broke without it, in
+	  which case you should also send a report to your distribution and
+	  linux-block@vger.kernel.org.
+
 config BLK_RQ_ALLOC_TIME
 	bool
 
diff --git a/block/bdev.c b/block/bdev.c
index 8bf93a19041b7..51e41b2da2d9f 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -738,12 +738,15 @@ struct block_device *blkdev_get_no_open(dev_t dev)
 	struct inode *inode;
 
 	inode = ilookup(blockdev_superblock, dev);
-	if (!inode) {
+	if (!inode && IS_ENABLED(CONFIG_BLOCK_LEGACY_AUTOLOAD)) {
 		blk_request_module(dev);
 		inode = ilookup(blockdev_superblock, dev);
-		if (!inode)
-			return NULL;
+		if (inode)
+			pr_warn_ratelimited(
+"block device autoloading is deprecated. It will be removed in Linux 5.19\n");
 	}
+	if (!inode)
+		return NULL;
 
 	/* switch from the inode reference to a device mode one: */
 	bdev = &BDEV_I(inode)->bdev;
diff --git a/block/genhd.c b/block/genhd.c
index 626c8406f21a6..6ae990ff02660 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -185,7 +185,9 @@ static struct blk_major_name {
 	struct blk_major_name *next;
 	int major;
 	char name[16];
+#ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
 	void (*probe)(dev_t devt);
+#endif
 } *major_names[BLKDEV_MAJOR_HASH_SIZE];
 static DEFINE_MUTEX(major_names_lock);
 static DEFINE_SPINLOCK(major_names_spinlock);
@@ -275,7 +277,9 @@ int __register_blkdev(unsigned int major, const char *name,
 	}
 
 	p->major = major;
+#ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
 	p->probe = probe;
+#endif
 	strlcpy(p->name, name, sizeof(p->name));
 	p->next = NULL;
 	index = major_to_index(major);
@@ -679,6 +683,7 @@ static ssize_t disk_badblocks_store(struct device *dev,
 	return badblocks_store(disk->bb, page, len, 0);
 }
 
+#ifdef CONFIG_BLOCK_LEGACY_AUTOLOAD
 void blk_request_module(dev_t devt)
 {
 	unsigned int major = MAJOR(devt);
@@ -698,6 +703,7 @@ void blk_request_module(dev_t devt)
 		/* Make old-style 2.4 aliases work */
 		request_module("block-major-%d", MAJOR(devt));
 }
+#endif /* CONFIG_BLOCK_LEGACY_AUTOLOAD */
 
 /*
  * print a full list of all partitions - intended for places where the root
-- 
2.30.2

