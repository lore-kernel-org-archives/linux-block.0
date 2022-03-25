Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B9AC433F5
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 06:39:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358469AbiCYGla (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 02:41:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233618AbiCYGl3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 02:41:29 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C506859A40
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 23:39:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=pDGhq6oYWM+hFQ1+Vu/seG4dCcDKNWyq7W0wufvJx9A=; b=OxiV4MCYGInZoy69XXEQfNE0+W
        /F33kM4N2Xt69TlJ+Trrie3AStvXkMJ1R0ngXd0F46GJ6g5JcV4ZIoapu0RY1Awv47XhEHlERxCHT
        H5xLWhJf1/jl5twbJBlq5JXm5k9NGk4GSSBxntpwhSurymVcoxDbIhZamwAWETfCacmsbgomnOYBi
        4NEv+BZsVsuVvl5w5swJXcEYplNbAYz+OLlrSimsRu/hRZfHOUtBOGp1MZasITLPmXYX8oD6dHqKz
        Pey82z+RRssTr4womPYzzMTxH3mIeVmn/8LfsSulhM8ecxGsbtyG3bivBkLoI8Tt//b582qWGIIAr
        2qelOHGQ==;
Received: from 089144194144.atnat0003.highway.a1.net ([89.144.194.144] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXdbw-001HIp-S8; Fri, 25 Mar 2022 06:39:49 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>,
        Matteo Croce <mcroce@microsoft.com>,
        linux-block@vger.kernel.org, nbd@other.debian.org
Subject: [PATCH 04/14] block: add a disk_openers helper
Date:   Fri, 25 Mar 2022 07:39:19 +0100
Message-Id: <20220325063929.1773899-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220325063929.1773899-1-hch@lst.de>
References: <20220325063929.1773899-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add a helper that returns the openers for a given gendisk to avoid having
drivers poke into disk->part0 to get at this information in a somewhat
cumbersome way.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 drivers/block/nbd.c           |  4 ++--
 drivers/block/zram/zram_drv.c |  4 ++--
 include/linux/blkdev.h        | 15 +++++++++++++++
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/block/nbd.c b/drivers/block/nbd.c
index 2f29da41fbc80..7473f3d4e1270 100644
--- a/drivers/block/nbd.c
+++ b/drivers/block/nbd.c
@@ -1219,7 +1219,7 @@ static int nbd_reconnect_socket(struct nbd_device *nbd, unsigned long arg)
 
 static void nbd_bdev_reset(struct nbd_device *nbd)
 {
-	if (nbd->disk->part0->bd_openers > 1)
+	if (disk_openers(nbd->disk) > 1)
 		return;
 	set_capacity(nbd->disk, 0);
 }
@@ -1579,7 +1579,7 @@ static void nbd_release(struct gendisk *disk, fmode_t mode)
 	struct nbd_device *nbd = disk->private_data;
 
 	if (test_bit(NBD_RT_DISCONNECT_ON_CLOSE, &nbd->config->runtime_flags) &&
-			disk->part0->bd_openers == 0)
+			disk_openers(disk) == 0)
 		nbd_disconnect_and_put(nbd);
 
 	nbd_config_put(nbd);
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index 863606f1722b1..2362385f782a9 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1800,7 +1800,7 @@ static ssize_t reset_store(struct device *dev,
 
 	mutex_lock(&disk->open_mutex);
 	/* Do not reset an active device or claimed device */
-	if (disk->part0->bd_openers || zram->claim) {
+	if (disk_openers(disk) || zram->claim) {
 		mutex_unlock(&disk->open_mutex);
 		return -EBUSY;
 	}
@@ -1990,7 +1990,7 @@ static int zram_remove(struct zram *zram)
 	bool claimed;
 
 	mutex_lock(&zram->disk->open_mutex);
-	if (zram->disk->part0->bd_openers) {
+	if (disk_openers(zram->disk)) {
 		mutex_unlock(&zram->disk->open_mutex);
 		return -EBUSY;
 	}
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index eb27312a1b8f3..9824ebc9b4d31 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -176,6 +176,21 @@ static inline bool disk_live(struct gendisk *disk)
 	return !inode_unhashed(disk->part0->bd_inode);
 }
 
+/**
+ * disk_openers - returns how many openers are there for a disk
+ * @disk: disk to check
+ *
+ * This returns the number of openers for a disk.  Note that this value is only
+ * stable if disk->open_mutex is held.
+ *
+ * Note: Due to a quirk in the block layer open code, each open partition is
+ * only counted once even if there are multiple openers.
+ */
+static inline unsigned int disk_openers(struct gendisk *disk)
+{
+	return disk->part0->bd_openers;
+}
+
 /*
  * The gendisk is refcounted by the part0 block_device, and the bd_device
  * therein is also used for device model presentation in sysfs.
-- 
2.30.2

