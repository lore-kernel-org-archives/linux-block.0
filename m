Return-Path: <SRS0=eh4K=IG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2EE9C433DB
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 07:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80A246512F
	for <linux-block@archiver.kernel.org>; Mon,  8 Mar 2021 07:47:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232096AbhCHHq3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Mar 2021 02:46:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232114AbhCHHqM (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Mar 2021 02:46:12 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8398CC06174A
        for <linux-block@vger.kernel.org>; Sun,  7 Mar 2021 23:46:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=c7sb+A4wHTchgvyY+VHcVt1ZX/G2Fcwphae/YqoQRwQ=; b=H5nj9+OZ5MgwmIWWBiY92Nb9Ou
        b8E7w8rPZtKwWcyOzfiVyJIVw9qpYZcNF79oGErqQ+9WuBF0mT9lFsxQ58LrTTUAbwR+NmaktheSh
        cy2nayWmN6Cu/sjBr/rRoMsv+ctQFCDVjnPTEKopLya5TP5jNgIynv3o2Cy2dZR2OrZtHw7UAcxu3
        ZaZr50tgyI62ezZUHWcjwa+kV/5TLnQ1L2wnrwKapRiN5rBOHtEDC0dvUBNRBQuUiHalQVHonfB0L
        LhBmFd6+9LfYBs4FWrdro4e9aKAmgy+4GctXfyCcZpd/7KStc9HiB6mNSH6o7vq9O5w8ohpy7iUtm
        8hCl/tTA==;
Received: from [2001:4bb8:180:9884:c70:4a89:bc61:3] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94 #2 (Red Hat Linux))
        id 1lJAad-00FBqK-NY; Mon, 08 Mar 2021 07:46:08 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: remove the revalidate_disk method
Date:   Mon,  8 Mar 2021 08:45:50 +0100
Message-Id: <20210308074550.422714-4-hch@lst.de>
X-Mailer: git-send-email 2.30.1
In-Reply-To: <20210308074550.422714-1-hch@lst.de>
References: <20210308074550.422714-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No implementations left.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/locking.rst | 2 --
 fs/block_dev.c                        | 3 ---
 include/linux/blkdev.h                | 1 -
 3 files changed, 6 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index b7dcc86c92a45f..9774e92e449fbd 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -469,7 +469,6 @@ prototypes::
 	int (*direct_access) (struct block_device *, sector_t, void **,
 				unsigned long *);
 	void (*unlock_native_capacity) (struct gendisk *);
-	int (*revalidate_disk) (struct gendisk *);
 	int (*getgeo)(struct block_device *, struct hd_geometry *);
 	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 
@@ -484,7 +483,6 @@ ioctl:			no
 compat_ioctl:		no
 direct_access:		no
 unlock_native_capacity:	no
-revalidate_disk:	no
 getgeo:			no
 swap_slot_free_notify:	no	(see below)
 ======================= ===================
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 4aa1f88d5bf8b3..422d088ac7dbaa 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1250,9 +1250,6 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 		if (disk_part_scan_enabled(disk) ||
 		    !(disk->flags & GENHD_FL_REMOVABLE))
 			set_capacity(disk, 0);
-	} else {
-		if (disk->fops->revalidate_disk)
-			disk->fops->revalidate_disk(disk);
 	}
 
 	if (get_capacity(disk)) {
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bc6bc8383b434e..b4241f73f7a89c 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1870,7 +1870,6 @@ struct block_device_operations {
 	unsigned int (*check_events) (struct gendisk *disk,
 				      unsigned int clearing);
 	void (*unlock_native_capacity) (struct gendisk *);
-	int (*revalidate_disk) (struct gendisk *);
 	int (*getgeo)(struct block_device *, struct hd_geometry *);
 	int (*set_read_only)(struct block_device *bdev, bool ro);
 	/* this callback is with swap_lock and sometimes page table lock held */
-- 
2.30.1

