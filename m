Return-Path: <SRS0=j3P0=CX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1D96C43461
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 07:12:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5980421D24
	for <linux-block@archiver.kernel.org>; Mon, 14 Sep 2020 07:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="v5g7YFP0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726082AbgINHM0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Sep 2020 03:12:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726067AbgINHM0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Sep 2020 03:12:26 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B107CC06174A
        for <linux-block@vger.kernel.org>; Mon, 14 Sep 2020 00:12:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=K79C0CiheKGwIMpu0QJgj+n0u2GZXYgAhnx3d4vFpJA=; b=v5g7YFP0eDRSJOIo1je0KN4m7M
        Fcv/Eo83/+mZ+kZBoqgZxVpFavODO8Gq5x5RdK6hqMV1gNDmOeuQyTWovRNRmf1SQKOs1fqpRst/2
        PBw4YzgF67T6gmZpNY/oiVUXnX9gGgS8rqqAUpuEXTzKjIIlqrMHRiz+PstaXlGsq3UprQIDIjTFo
        uiSjA6eTq+PNcnPngqlUKt29NaJ0XwPpw0Bm8O29Aal3jVYOYyb+i7rU88A4fBCuKysKRw50sfgHJ
        HswycW1/NKgpHOf6kxxK/I3ozi9Kff9zMSA6MvZPXSAu1nCgFUjic2ImhV7wboeWhQUmUmbjdii+s
        rf+XYTig==;
Received: from 089144214092.atnat0023.highway.a1.net ([89.144.214.92] helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kHif1-0006vE-Aj; Mon, 14 Sep 2020 07:12:23 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Tim Waugh <tim@cyberelk.net>
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: remove the revalidate_disk method
Date:   Mon, 14 Sep 2020 09:03:37 +0200
Message-Id: <20200914070337.1578317-4-hch@lst.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200914070337.1578317-1-hch@lst.de>
References: <20200914070337.1578317-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

No implementations left.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/filesystems/locking.rst |  2 --
 fs/block_dev.c                        | 12 ++++--------
 include/linux/blkdev.h                |  1 -
 3 files changed, 4 insertions(+), 11 deletions(-)

diff --git a/Documentation/filesystems/locking.rst b/Documentation/filesystems/locking.rst
index c0f2c7586531b0..28f611cad54f61 100644
--- a/Documentation/filesystems/locking.rst
+++ b/Documentation/filesystems/locking.rst
@@ -468,7 +468,6 @@ prototypes::
 	int (*direct_access) (struct block_device *, sector_t, void **,
 				unsigned long *);
 	void (*unlock_native_capacity) (struct gendisk *);
-	int (*revalidate_disk) (struct gendisk *);
 	int (*getgeo)(struct block_device *, struct hd_geometry *);
 	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
 
@@ -483,7 +482,6 @@ ioctl:			no
 compat_ioctl:		no
 direct_access:		no
 unlock_native_capacity:	no
-revalidate_disk:	no
 getgeo:			no
 swap_slot_free_notify:	no	(see below)
 ======================= ===================
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 0b34955b9e360f..2e70585be7171b 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -1400,14 +1400,10 @@ int bdev_disk_changed(struct block_device *bdev, bool invalidate)
 	 * below to get the sane behavior for most device while not breaking
 	 * userspace for this particular setup.
 	 */
-	if (invalidate) {
-		if (disk_part_scan_enabled(disk) ||
-		    !(disk->flags & GENHD_FL_REMOVABLE))
-			set_capacity(disk, 0);
-	} else {
-		if (disk->fops->revalidate_disk)
-			disk->fops->revalidate_disk(disk);
-	}
+	if (invalidate &&
+	    (disk_part_scan_enabled(disk) ||
+	     !(disk->flags & GENHD_FL_REMOVABLE)))
+		set_capacity(disk, 0);
 
 	check_disk_size_change(disk, bdev, !invalidate);
 
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 5bd96fbab9b4c8..3d18bfbdb69b07 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1837,7 +1837,6 @@ struct block_device_operations {
 	unsigned int (*check_events) (struct gendisk *disk,
 				      unsigned int clearing);
 	void (*unlock_native_capacity) (struct gendisk *);
-	int (*revalidate_disk) (struct gendisk *);
 	int (*getgeo)(struct block_device *, struct hd_geometry *);
 	/* this callback is with swap_lock and sometimes page table lock held */
 	void (*swap_slot_free_notify) (struct block_device *, unsigned long);
-- 
2.28.0

