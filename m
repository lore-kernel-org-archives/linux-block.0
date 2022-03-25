Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B08FC433FE
	for <linux-block@archiver.kernel.org>; Fri, 25 Mar 2022 06:39:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358467AbiCYGlX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Mar 2022 02:41:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358469AbiCYGlX (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Mar 2022 02:41:23 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 184FA57B24
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 23:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=DDP0HPj6K7Sy805ftOyLrgXZ6H2ZFEDnovzc8W3ZFbI=; b=CPxIXQ8Dvf/UA8/LUnlIwY7xCw
        TmgOj7X9sf1uIR0OS+J6u32yWrlGzD6MqcUoSr0vaaes47FVKmSrY2yb5QMmOvjsv5gRp8SS3PtYG
        sqyxwZRN4IAsP/OIwT9lCNPoT1dXFVy/wtOJUg/aRGQRbPzJ0fMQCZ+bf1ceDRjWGIhxPlofFqQYQ
        +Z58uXmcdkDaBqAb0ijD24BbGo3ofOi090etZrJzCYOc1799y0xxMdN6OiNdlkJ1ptFHd5CHuiZdC
        AbtzqN0PNc1G39I4Jk5Bn1QNJbps01SUbPL2g6cPnw10N39EBc44NOS2gxg90Yba57MHui3QV4bSO
        zVGxwgag==;
Received: from 089144194144.atnat0003.highway.a1.net ([89.144.194.144] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXdbo-001HHQ-My; Fri, 25 Mar 2022 06:39:41 +0000
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
Subject: [PATCH 02/14] zram: cleanup reset_store
Date:   Fri, 25 Mar 2022 07:39:17 +0100
Message-Id: <20220325063929.1773899-3-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220325063929.1773899-1-hch@lst.de>
References: <20220325063929.1773899-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use a local variable for the gendisk instead of the part0 block_device,
as the gendisk is what this function actually operates on.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 drivers/block/zram/zram_drv.c | 18 +++++++++---------
 1 file changed, 9 insertions(+), 9 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index e9474b02012de..fd83fad59beb1 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1786,7 +1786,7 @@ static ssize_t reset_store(struct device *dev,
 	int ret;
 	unsigned short do_reset;
 	struct zram *zram;
-	struct block_device *bdev;
+	struct gendisk *disk;
 
 	ret = kstrtou16(buf, 10, &do_reset);
 	if (ret)
@@ -1796,26 +1796,26 @@ static ssize_t reset_store(struct device *dev,
 		return -EINVAL;
 
 	zram = dev_to_zram(dev);
-	bdev = zram->disk->part0;
+	disk = zram->disk;
 
-	mutex_lock(&bdev->bd_disk->open_mutex);
+	mutex_lock(&disk->open_mutex);
 	/* Do not reset an active device or claimed device */
-	if (bdev->bd_openers || zram->claim) {
-		mutex_unlock(&bdev->bd_disk->open_mutex);
+	if (disk->part0->bd_openers || zram->claim) {
+		mutex_unlock(&disk->open_mutex);
 		return -EBUSY;
 	}
 
 	/* From now on, anyone can't open /dev/zram[0-9] */
 	zram->claim = true;
-	mutex_unlock(&bdev->bd_disk->open_mutex);
+	mutex_unlock(&disk->open_mutex);
 
 	/* Make sure all the pending I/O are finished */
-	sync_blockdev(bdev);
+	sync_blockdev(disk->part0);
 	zram_reset_device(zram);
 
-	mutex_lock(&bdev->bd_disk->open_mutex);
+	mutex_lock(&disk->open_mutex);
 	zram->claim = false;
-	mutex_unlock(&bdev->bd_disk->open_mutex);
+	mutex_unlock(&disk->open_mutex);
 
 	return len;
 }
-- 
2.30.2

