Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AD946C4338F
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:51:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 841AA610A6
	for <linux-block@archiver.kernel.org>; Wed, 18 Aug 2021 14:51:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239393AbhHROv7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 18 Aug 2021 10:51:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239019AbhHROv6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 18 Aug 2021 10:51:58 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65A58C061764
        for <linux-block@vger.kernel.org>; Wed, 18 Aug 2021 07:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:
        Content-Type:Content-ID:Content-Description;
        bh=KlTGPGXtD5pcKg1e/+kLFkuthMkxZfGhOC5GRsPi52E=; b=OTQRzpNK0Ut/NnC3H3FHEIJ2Fn
        g7/h4lhheh3iRQpXXo12CiJAEhX9pR3fqLVz69k/gLCsh7Z9K8tllXpCWNv2JJoQSheNZnDvKjtCf
        TDgcNAN0bz4qbAk+Bn2TsHq4o2C/oB1WkqvKN+iw/qjqdZ2+CLu0i6iW+cn9KaKwpjj9hzPRuo2tt
        ZTAJQazW+YTdLGBF/mEht2Ml8yQqItTCARXaiC5Ane0KT9i/6rFQvSfqW1+6JrxqObT/TYX/ab2FV
        T21qCa+04tr2RS5857VOauQbSfZK80iR2K6ujVFh3Ct+b/9uRMGItHGqOdhUP2X5nwUcmTVjwIeJi
        R0nza+sw==;
Received: from [2001:4bb8:188:1b1:5a9e:9f39:5a86:b20c] (helo=localhost)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1mGMt6-003wlK-HD; Wed, 18 Aug 2021 14:50:05 +0000
From:   Christoph Hellwig <hch@lst.de>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Luis Chamberlain <mcgrof@kernel.org>,
        linux-block@vger.kernel.org
Subject: [PATCH 04/11] block: create the bdi link earlier in device_add_disk
Date:   Wed, 18 Aug 2021 16:45:35 +0200
Message-Id: <20210818144542.19305-5-hch@lst.de>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20210818144542.19305-1-hch@lst.de>
References: <20210818144542.19305-1-hch@lst.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This will simplify error handling going forward.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/genhd.c | 13 ++++++-------
 1 file changed, 6 insertions(+), 7 deletions(-)

diff --git a/block/genhd.c b/block/genhd.c
index ab455f110be2..f05e58f214d2 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -518,8 +518,13 @@ void device_add_disk(struct device *parent, struct gendisk *disk,
 				   disk->major, disk->first_minor);
 		WARN_ON(ret);
 		bdi_set_owner(disk->bdi, ddev);
-		bdev_add(disk->part0, ddev->devt);
+		if (disk->bdi->dev) {
+			ret = sysfs_create_link(&ddev->kobj,
+						&disk->bdi->dev->kobj, "bdi");
+			WARN_ON(ret);
+		}
 
+		bdev_add(disk->part0, ddev->devt);
 		disk_scan_partitions(disk);
 
 		/*
@@ -528,12 +533,6 @@ void device_add_disk(struct device *parent, struct gendisk *disk,
 		 */
 		dev_set_uevent_suppress(ddev, 0);
 		disk_uevent(disk, KOBJ_ADD);
-
-		if (disk->bdi->dev) {
-			ret = sysfs_create_link(&ddev->kobj,
-						&disk->bdi->dev->kobj, "bdi");
-			WARN_ON(ret);
-		}
 	}
 
 	blk_register_queue(disk);
-- 
2.30.2

