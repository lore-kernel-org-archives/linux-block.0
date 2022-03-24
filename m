Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C0BAC433FE
	for <linux-block@archiver.kernel.org>; Thu, 24 Mar 2022 07:51:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239839AbiCXHxF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 24 Mar 2022 03:53:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229616AbiCXHxE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 24 Mar 2022 03:53:04 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EB5899686
        for <linux-block@vger.kernel.org>; Thu, 24 Mar 2022 00:51:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender
        :Reply-To:Content-Type:Content-ID:Content-Description;
        bh=68Vr9ZZvn7QlZeObLr2LIfxyN5gniOKZYA3d9ipjL3Q=; b=pVOkQxsAa/GqbX+WMYuWpXUN60
        Nql2UDvVBt1ON2mTFf5YrKzammMYyJ1LTA0pCu3rztFT5S/9zbcSYO3/H+pls1s95HRLxaowSQdKX
        aVvDP/gxlIzLYAqLbHw8jdjNmDj3nwEMRXD7CRIQjk+frmLPKsbkpFUPBcdPZQB1Bhvut0VwmmfiB
        wCRuRnMw1Zlp3qm4W7/qEt15tuqrESOfENDdLtKzkQrw77iwLE6O5mG6xU6WLyf+0BDyulq2DlKYl
        pMcR0dYk4LwCk0Il76E97ijVRTGVX6BWkl3VIjpMXCdp1y4Tod+CJ02wL1bUfXxmXZcv+fTcRVv4l
        ZwvpMMYw==;
Received: from [2001:4bb8:19a:b822:f71:16c0:5841:924e] (helo=localhost)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nXIFk-00FzUG-LB; Thu, 24 Mar 2022 07:51:29 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>, Josef Bacik <josef@toxicpanda.com>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>
Cc:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        Jan Kara <jack@suse.cz>,
        "Darrick J . Wong" <djwong@kernel.org>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        nbd@other.debian.org
Subject: [PATCH 03/13] zram: cleanup zram_remove
Date:   Thu, 24 Mar 2022 08:51:09 +0100
Message-Id: <20220324075119.1556334-4-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220324075119.1556334-1-hch@lst.de>
References: <20220324075119.1556334-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Remove the bdev variable and just use the gendisk pointed to by the
zram_device directly.

Signed-off-by: Christoph Hellwig <hch@lst.de>
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

