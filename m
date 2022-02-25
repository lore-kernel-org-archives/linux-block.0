Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 233E0C433F5
	for <linux-block@archiver.kernel.org>; Fri, 25 Feb 2022 18:14:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229705AbiBYSPQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Feb 2022 13:15:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbiBYSPQ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Feb 2022 13:15:16 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8235F1F6353
        for <linux-block@vger.kernel.org>; Fri, 25 Feb 2022 10:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=Q7VHpVx21mUja6gLo8+e7srJn+uYkNFU0P21aMHgCMk=; b=qYVIo1gSo7SVNxFixFAnSGP4Zd
        7VFVQRle08MOyeu5Gypjv0hnXUEh2Cp+b4a/4KISqfaRN52lkTvI7/rtOj+1ncBYQNBQHsl11DAW5
        bDjaYFhznzBWLNRGkkU+1kbNZTxUIFpVQPvIvC0ndY0XYBmWMzzxxv2HFPmQpJBPD/o9dkIR+C/wd
        3nN60zLE56FdORD4Or2oL+bjqMD5VzXvHTk5Zy3JV2waqaW6015ac8+Zc8etQllMq+nLs9sU8XSvU
        AJQ0OfGCqrOwgGvabJ7aILAjknmFYCO8LEa4ZLrsn/jxCe60yLswigmBe3bzi3UtBMh98Cje7aRfv
        nS0F7Epg==;
Received: from 089144202139.atnat0011.highway.a1.net ([89.144.202.139] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nNf75-006W01-18; Fri, 25 Feb 2022 18:14:43 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Luis Chamberlain <mcgrof@kernel.org>
Subject: [PATCH] block: default BLOCK_LEGACY_AUTOLOAD to y
Date:   Fri, 25 Feb 2022 19:14:40 +0100
Message-Id: <20220225181440.1351591-1-hch@lst.de>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

As Luis reported, losetup currently doesn't properly create the loop
device without this if the device node already exists because old
scripts created it manually.  So default to y for now and remove the
aggressive removal schedule.

Reported-by: Luis Chamberlain <mcgrof@kernel.org>
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Kconfig | 8 +++-----
 block/bdev.c  | 2 +-
 2 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/block/Kconfig b/block/Kconfig
index 168b873eb666d..7eb5d6d53b3fc 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -28,15 +28,13 @@ if BLOCK
 
 config BLOCK_LEGACY_AUTOLOAD
 	bool "Legacy autoloading support"
+	default y
 	help
 	  Enable loading modules and creating block device instances based on
 	  accesses through their device special file.  This is a historic Linux
 	  feature and makes no sense in a udev world where device files are
-	  created on demand.
-
-	  Say N here unless booting or other functionality broke without it, in
-	  which case you should also send a report to your distribution and
-	  linux-block@vger.kernel.org.
+	  created on demand, but scripts that manually create device nodes and
+	  then call losetup might rely on this behavior.
 
 config BLK_RQ_ALLOC_TIME
 	bool
diff --git a/block/bdev.c b/block/bdev.c
index c687726445660..a3632317c8aae 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -738,7 +738,7 @@ struct block_device *blkdev_get_no_open(dev_t dev)
 		inode = ilookup(blockdev_superblock, dev);
 		if (inode)
 			pr_warn_ratelimited(
-"block device autoloading is deprecated. It will be removed in Linux 5.19\n");
+"block device autoloading is deprecated and will be removed.\n");
 	}
 	if (!inode)
 		return NULL;
-- 
2.30.2

