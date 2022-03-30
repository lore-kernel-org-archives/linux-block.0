Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85E84C433EF
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 05:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242989AbiC3Fb3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242992AbiC3Fb2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 01:31:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA2FE1C3488
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 22:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=nPTRgdK0NfHYZhnKEMojoH1w5k7xxfCR+ONb3XrZyPY=; b=MOlTaxQqn/1lgE/kXJnOkF955f
        cuH03D1hhFjZtpMo8IQcaK/z7iSkj7xXFUaVc+XM4nBFM8u6TI2v6OcDfp90DRMH9pOvu8GyXiP9e
        ynPj2Dj5LM9xXgYcQwpBRMqd7VEMwceNVmmCDCxiDIr2q7zbnQanVnYOOBHBk8iY1Z/e8jYBaSY7h
        2+T80/7N4xvG6WZP5L+8zDGZJD0TwxVS6Nx6Vzti/nYi8KrFaOfddUyHQyJS66JiKkFHk+jA+chJg
        M21CmojcxrpFNxonOkz5eGYp2gIbgpM7o/4h6yLE/ATD/ivv8lMtn7NOWL2wTdDZ9o+MDIbPA3d7W
        L+QExgBw==;
Received: from 213-225-15-62.nat.highway.a1.net ([213.225.15.62] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZQtj-00ELEi-Mf; Wed, 30 Mar 2022 05:29:36 +0000
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
Subject: [PATCH 04/15] block: add a disk_openers helper
Date:   Wed, 30 Mar 2022 07:29:06 +0200
Message-Id: <20220330052917.2566582-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330052917.2566582-1-hch@lst.de>
References: <20220330052917.2566582-1-hch@lst.de>
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
index 60d0161389971..1abd5a56a5c99 100644
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

