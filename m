Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6F59C4338F
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 15:08:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9481F60FDA
	for <linux-block@archiver.kernel.org>; Fri, 20 Aug 2021 15:08:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240958AbhHTPIs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 20 Aug 2021 11:08:48 -0400
Received: from verein.lst.de ([213.95.11.211]:41320 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238570AbhHTPIo (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 20 Aug 2021 11:08:44 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 20D2D6736F; Fri, 20 Aug 2021 17:08:04 +0200 (CEST)
Date:   Fri, 20 Aug 2021 17:08:03 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>,
        Mike Snitzer <snitzer@redhat.com>, linux-block@vger.kernel.org,
        dm-devel@redhat.com
Subject: Re: [dm-devel] [PATCH 4/8] block: support delayed holder
 registration
Message-ID: <20210820150803.GA490@lst.de>
References: <20210804094147.459763-1-hch@lst.de> <20210804094147.459763-5-hch@lst.de> <20210814211309.GA616511@roeck-us.net> <20210815070724.GA23276@lst.de> <a8d66952-ee44-d3fa-d699-439415b9abfe@roeck-us.net> <20210816072158.GA27147@lst.de> <20210816141702.GA3449320@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210816141702.GA3449320@roeck-us.net>
User-Agent: Mutt/1.5.17 (2007-11-01)
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Please try the patch below:

---
From 7609266da56160d211662cd2fbe26570aad11b15 Mon Sep 17 00:00:00 2001
From: Christoph Hellwig <hch@lst.de>
Date: Fri, 20 Aug 2021 17:00:11 +0200
Subject: mtd_blkdevs: don't hold del_mtd_blktrans_dev in
 blktrans_{open,release}

There is nothing that this protects against except for slightly reducing
the window when new opens can appear just before calling del_gendisk.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/mtd/mtd_blkdevs.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/mtd/mtd_blkdevs.c b/drivers/mtd/mtd_blkdevs.c
index 44bea3f65060..6b81a1c9ccbe 100644
--- a/drivers/mtd/mtd_blkdevs.c
+++ b/drivers/mtd/mtd_blkdevs.c
@@ -207,7 +207,6 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 	if (!dev)
 		return -ERESTARTSYS; /* FIXME: busy loop! -arnd*/
 
-	mutex_lock(&mtd_table_mutex);
 	mutex_lock(&dev->lock);
 
 	if (dev->open)
@@ -233,7 +232,6 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 unlock:
 	dev->open++;
 	mutex_unlock(&dev->lock);
-	mutex_unlock(&mtd_table_mutex);
 	blktrans_dev_put(dev);
 	return ret;
 
@@ -244,7 +242,6 @@ static int blktrans_open(struct block_device *bdev, fmode_t mode)
 	module_put(dev->tr->owner);
 	kref_put(&dev->ref, blktrans_dev_release);
 	mutex_unlock(&dev->lock);
-	mutex_unlock(&mtd_table_mutex);
 	blktrans_dev_put(dev);
 	return ret;
 }
@@ -256,7 +253,6 @@ static void blktrans_release(struct gendisk *disk, fmode_t mode)
 	if (!dev)
 		return;
 
-	mutex_lock(&mtd_table_mutex);
 	mutex_lock(&dev->lock);
 
 	if (--dev->open)
@@ -272,7 +268,6 @@ static void blktrans_release(struct gendisk *disk, fmode_t mode)
 	}
 unlock:
 	mutex_unlock(&dev->lock);
-	mutex_unlock(&mtd_table_mutex);
 	blktrans_dev_put(dev);
 }
 
-- 
2.30.2

