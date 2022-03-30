Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12B51C433F5
	for <linux-block@archiver.kernel.org>; Wed, 30 Mar 2022 05:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242986AbiC3Fb3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Mar 2022 01:31:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242991AbiC3Fb2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Mar 2022 01:31:28 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FC161C2DA2
        for <linux-block@vger.kernel.org>; Tue, 29 Mar 2022 22:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=Lz7Imp5+g0S82Xgvrrb73I7LJeBwqhTUW10bjI0Otj0=; b=h6+XDHjNl4/6J9fyXwVP2MID9S
        +oX+ymV31gRTs1xUWLTdujACXF6xHNojtG/MEVHnITvIyl1Bpz3qBqiMUAU65DoPOaCZOMm0Gf+sA
        gN8Ncp/q7bSHQXSNHLqXAxoePHSsafCsRZYHe+xpGSLTKYIT8lbWWR99N6oeFb/N1oO46ejnDb5rz
        HPM9AgAq0hpTL3yMXhXElc0jYts7UpckZ+RsOPOp5CjW1Hw+lgspdgTiM62nIh43xYUURx/wsjffd
        vsDTsjJEnolM+3aJ0/3aSP7zk3X2uXK/oTJSiPuTKbjw4PniJtDwCDebnFHVQCzcmkevx7yfTf8W7
        MLY0GlEw==;
Received: from 213-225-15-62.nat.highway.a1.net ([213.225.15.62] helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nZQtf-00ELDB-Re; Wed, 30 Mar 2022 05:29:32 +0000
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
Subject: [PATCH 03/15] zram: cleanup zram_remove
Date:   Wed, 30 Mar 2022 07:29:05 +0200
Message-Id: <20220330052917.2566582-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220330052917.2566582-1-hch@lst.de>
References: <20220330052917.2566582-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the bdev variable and just use the gendisk pointed to by the
zram_device directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Jan Kara <jack@suse.cz>
---
 drivers/block/zram/zram_drv.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index fd83fad59beb1..863606f1722b1 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1987,19 +1987,18 @@ static int zram_add(void)
 
 static int zram_remove(struct zram *zram)
 {
-	struct block_device *bdev = zram->disk->part0;
 	bool claimed;
 
-	mutex_lock(&bdev->bd_disk->open_mutex);
-	if (bdev->bd_openers) {
-		mutex_unlock(&bdev->bd_disk->open_mutex);
+	mutex_lock(&zram->disk->open_mutex);
+	if (zram->disk->part0->bd_openers) {
+		mutex_unlock(&zram->disk->open_mutex);
 		return -EBUSY;
 	}
 
 	claimed = zram->claim;
 	if (!claimed)
 		zram->claim = true;
-	mutex_unlock(&bdev->bd_disk->open_mutex);
+	mutex_unlock(&zram->disk->open_mutex);
 
 	zram_debugfs_unregister(zram);
 
@@ -2011,7 +2010,7 @@ static int zram_remove(struct zram *zram)
 		;
 	} else {
 		/* Make sure all the pending I/O are finished */
-		sync_blockdev(bdev);
+		sync_blockdev(zram->disk->part0);
 		zram_reset_device(zram);
 	}
 
-- 
2.30.2

