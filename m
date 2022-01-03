Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4688EC433F5
	for <linux-block@archiver.kernel.org>; Mon,  3 Jan 2022 19:03:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbiACTDp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Jan 2022 14:03:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235959AbiACTDp (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Jan 2022 14:03:45 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64E52C061761
        for <linux-block@vger.kernel.org>; Mon,  3 Jan 2022 11:03:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=jCBd2rRse62qOHOk0TkeoIG16cION914ybbLMOBsJo0=; b=NYqz+k1Gls5Nv6cxajgP8V5qLZ
        ZGvU61jIJlWlBs0ynCeRiaHNJLKKMQPBZo1igeF3fohP4fpNU6wMVjYamVrigiKpcFDAHGxy9wPLU
        0SMPSgwdw5k4rFG3C85PUDxLoEkCNV7HeF5RapZKnNAydCh9TegP49A+WCAscWlyWrP6qkYmy1X55
        btUc9clfCWqrKzpF8K2anD9sCwxCz3gDqoWcHO+0iXuEjvy5GAHarjyjM6I93ddTFJy7RI51uU2No
        IpAjtlDpQ/GxHRkKhccyMRo2s/gQySvtRBA9vUEajFs/n+t+Bmptonl5h9EIigr99CyqnKlTcipxP
        MGmOIwYA==;
Received: from [2001:4bb8:184:3f95:b8f7:97d6:6b53:b9be] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n4ScS-009t13-HM; Mon, 03 Jan 2022 19:03:44 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH] block: deprecate autoloading based on dev_t
Date:   Mon,  3 Jan 2022 20:03:42 +0100
Message-Id: <20220103190342.146980-1-hch@lst.de>
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
 block/Kconfig | 11 +++++++++++
 block/bdev.c  |  9 ++++++---
 block/genhd.c |  6 ++++++
 3 files changed, 23 insertions(+), 3 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index d5d4197b7ed2d..9cd8706faa7be 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -26,6 +26,17 @@ menuconfig BLOCK
 
 if BLOCK
 
+config BLOCK_LEGACY_AUTOLOAD
+	bool "Legacy autoloading support"
+	help
+	  Enable loading modules and creating block device instances based on
+	  accesses through their device special file.  This is a historic Linux
+	  feature and makes no sense in a udev world where device files are
+	  created on demand.
+
+	  Say N here unless your boot broke without it, in which case you should
+	  send a report to linux-block@vger.kernel.org and your distribution.
+
 config BLK_RQ_ALLOC_TIME
 	bool
 
diff --git a/block/bdev.c b/block/bdev.c
index 8bf93a19041b7..dd6fd5b807b30 100644
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
+"block device autoloading is deprecated in will be removed in Linux 5.19\n");
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

