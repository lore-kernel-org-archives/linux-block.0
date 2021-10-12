Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D048DC433F5
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 10:48:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AC75060F23
	for <linux-block@archiver.kernel.org>; Tue, 12 Oct 2021 10:48:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235972AbhJLKur (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 12 Oct 2021 06:50:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235932AbhJLKuq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 12 Oct 2021 06:50:46 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83A37C061570
        for <linux-block@vger.kernel.org>; Tue, 12 Oct 2021 03:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=kA+nkXDjDDLRM3jRm6BOmcXzqKWrmN5hncLLaaNmUdg=; b=SyZc4dx65K+T+Zo7bNp4HZSo8h
        S2FLKLH5T3QrLpcVa3Cm3nuvlMweNA1cQ3tCfFF9nywjKhEUrff+6LqLP1i20xRJFEt7RMYA3yITg
        ypTnmqMqyaYBGdMfsApliGGxGb0WMCl76UMXLeEUBfq00Jr/3D3nUcKXEPOdT9HVi2zCR75X93p3/
        +u3rA6UXkhbfcz0fQQo5hsSJbDIqECuIdcxELHwivObEL/kMeaAKuCE7ix22/AW0k+9DuAnHMFsjR
        sDF8S3SaBlU7PggaMEXg5nYLeIaQosoQhIu5cKpIq49fLGPu6gjTbXxotlZabFxPjsSYnkP7j5V2j
        P99IfkUg==;
Received: from [2001:4bb8:199:73c5:f5ed:58c2:719f:d965] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1maFKC-006QbY-It; Tue, 12 Oct 2021 10:48:10 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org
Subject: [PATCH 3/3] block: merge block_ioctl into blkdev_ioctl
Date:   Tue, 12 Oct 2021 12:44:50 +0200
Message-Id: <20211012104450.659013-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20211012104450.659013-1-hch@lst.de>
References: <20211012104450.659013-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Simplify the ioctl path and match the code structure on the compat side.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/blk.h   |  3 +--
 block/fops.c  | 19 +------------------
 block/ioctl.c | 18 ++++++++++++++----
 3 files changed, 16 insertions(+), 24 deletions(-)

diff --git a/block/blk.h b/block/blk.h
index bca4ba1a1f8dd..35ca73355f90c 100644
--- a/block/blk.h
+++ b/block/blk.h
@@ -403,8 +403,7 @@ static inline void bio_clear_hipri(struct bio *bio)
 	bio->bi_opf &= ~REQ_HIPRI;
 }
 
-int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
-		unsigned long arg);
+long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 long compat_blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg);
 
 extern const struct address_space_operations def_blk_aops;
diff --git a/block/fops.c b/block/fops.c
index 1e970c247e0eb..7bb9581a146cf 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -461,23 +461,6 @@ static int blkdev_close(struct inode *inode, struct file *filp)
 	return 0;
 }
 
-static long block_ioctl(struct file *file, unsigned cmd, unsigned long arg)
-{
-	struct block_device *bdev = I_BDEV(bdev_file_inode(file));
-	fmode_t mode = file->f_mode;
-
-	/*
-	 * O_NDELAY can be altered using fcntl(.., F_SETFL, ..), so we have
-	 * to updated it before every ioctl.
-	 */
-	if (file->f_flags & O_NDELAY)
-		mode |= FMODE_NDELAY;
-	else
-		mode &= ~FMODE_NDELAY;
-
-	return blkdev_ioctl(bdev, mode, cmd, arg);
-}
-
 /*
  * Write data to the block device.  Only intended for the block device itself
  * and the raw driver which basically is a fake block device.
@@ -621,7 +604,7 @@ const struct file_operations def_blk_fops = {
 	.iopoll		= blkdev_iopoll,
 	.mmap		= generic_file_mmap,
 	.fsync		= blkdev_fsync,
-	.unlocked_ioctl	= block_ioctl,
+	.unlocked_ioctl	= blkdev_ioctl,
 #ifdef CONFIG_COMPAT
 	.compat_ioctl	= compat_blkdev_ioctl,
 #endif
diff --git a/block/ioctl.c b/block/ioctl.c
index 0f823444cc557..77b1b2453f395 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -538,12 +538,22 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
  *
  * New commands must be compatible and go into blkdev_common_ioctl
  */
-int blkdev_ioctl(struct block_device *bdev, fmode_t mode, unsigned cmd,
-			unsigned long arg)
+long blkdev_ioctl(struct file *file, unsigned cmd, unsigned long arg)
 {
-	int ret;
-	loff_t size;
+	struct block_device *bdev = I_BDEV(file->f_mapping->host);
 	void __user *argp = (void __user *)arg;
+	fmode_t mode = file->f_mode;
+	loff_t size;
+	int ret;
+
+	/*
+	 * O_NDELAY can be altered using fcntl(.., F_SETFL, ..), so we have
+	 * to updated it before every ioctl.
+	 */
+	if (file->f_flags & O_NDELAY)
+		mode |= FMODE_NDELAY;
+	else
+		mode &= ~FMODE_NDELAY;
 
 	switch (cmd) {
 	/* These need separate implementations for the data structure */
-- 
2.30.2

