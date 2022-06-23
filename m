Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50579CCA480
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:00:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230157AbiFWTAj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbiFWTAF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:05 -0400
Received: from mail-pf1-f170.google.com (mail-pf1-f170.google.com [209.85.210.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B70D6B85AE
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:39 -0700 (PDT)
Received: by mail-pf1-f170.google.com with SMTP id p14so305261pfh.6
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ej0cRhNsqJVFJXnmr+lazOG+2qvmjZlrhkoNKwPcCRY=;
        b=g2NpiKX8vxFyPry9wU+7vYamnzQrAHQNMbhgRxzaTQpXKS1qnCVLVEQ0s1IBF4gwKV
         ag2qK2xKtuGHEmGIE1MlDvMRy7mHRxgHdtLjGGfM0lhb1T+eRvNIM8T0efYrtHpl98ne
         BzAd3GAA5fdGV99kYr5AYGzibDhg3TXEAU3bPaenxADhzgtQNdJsFDoOl6S28Ce3tI75
         phkkXg3lZ+gSmrdp1kdydsowmuw4pHOTPlB3w9bQUJgWAnxugBfdpdxjM5fqz9DJTCUJ
         mGuE44ui0aOI+FLQjG7kmTa2Oo9Zmz1OUs9Q+UQNPtt50k0bbUzh46caXlBmR3ECM9cB
         +DWQ==
X-Gm-Message-State: AJIora8mUvuq41CoayjmWqGCAMGVwT+QNqjC4kaJEA+JJuI8aSZDSjoP
        dm8EK3XQ6gS59qzTK3+aUy0=
X-Google-Smtp-Source: AGRyM1uUsOy/UYan1g8pOTD2uuPgkC/e6R/yWLmECNTg/DKwfhI11Mu+x3dSgn62bb8HbrP9kQ13Vg==
X-Received: by 2002:a63:4b20:0:b0:401:ae11:2593 with SMTP id y32-20020a634b20000000b00401ae112593mr8363995pga.375.1656007538825;
        Thu, 23 Jun 2022 11:05:38 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.05.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:05:38 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, Minchan Kim <minchan@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 03/51] block: Change the type of the last .rw_page() argument
Date:   Thu, 23 Jun 2022 11:04:40 -0700
Message-Id: <20220623180528.3595304-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220623180528.3595304-1-bvanassche@acm.org>
References: <20220623180528.3595304-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All .rw_page() callers pass an enum req_op value as last argument. Make
this explicit by changing the type of the last argument into enum req_op.
See also commit 3f289dcb4b26 ("block: make bdev_ops->rw_page() take a
REQ_OP instead of bool").

Cc: Tejun Heo <tj@kernel.org>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Dan Williams <dan.j.williams@intel.com>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/block/brd.c           | 2 +-
 drivers/block/zram/zram_drv.c | 2 +-
 drivers/nvdimm/btt.c          | 2 +-
 drivers/nvdimm/pmem.c         | 2 +-
 include/linux/blkdev.h        | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 6e3f2f0d2352..c3d772bdd89f 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -310,7 +310,7 @@ static void brd_submit_bio(struct bio *bio)
 }
 
 static int brd_rw_page(struct block_device *bdev, sector_t sector,
-		       struct page *page, unsigned int op)
+		       struct page *page, enum req_op op)
 {
 	struct brd_device *brd = bdev->bd_disk->private_data;
 	int err;
diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index b8549c61ff2c..481b06a50ab1 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -1631,7 +1631,7 @@ static void zram_slot_free_notify(struct block_device *bdev,
 }
 
 static int zram_rw_page(struct block_device *bdev, sector_t sector,
-		       struct page *page, unsigned int op)
+		       struct page *page, enum req_op op)
 {
 	int offset, ret;
 	u32 index;
diff --git a/drivers/nvdimm/btt.c b/drivers/nvdimm/btt.c
index 9613e54c7a67..143b98e39c38 100644
--- a/drivers/nvdimm/btt.c
+++ b/drivers/nvdimm/btt.c
@@ -1483,7 +1483,7 @@ static void btt_submit_bio(struct bio *bio)
 }
 
 static int btt_rw_page(struct block_device *bdev, sector_t sector,
-		struct page *page, unsigned int op)
+		struct page *page, enum req_op op)
 {
 	struct btt *btt = bdev->bd_disk->private_data;
 	int rc;
diff --git a/drivers/nvdimm/pmem.c b/drivers/nvdimm/pmem.c
index 629d10fcf53b..ed58cbe9550f 100644
--- a/drivers/nvdimm/pmem.c
+++ b/drivers/nvdimm/pmem.c
@@ -239,7 +239,7 @@ static void pmem_submit_bio(struct bio *bio)
 }
 
 static int pmem_rw_page(struct block_device *bdev, sector_t sector,
-		       struct page *page, unsigned int op)
+		       struct page *page, enum req_op op)
 {
 	struct pmem_device *pmem = bdev->bd_disk->private_data;
 	blk_status_t rc;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3f8ee0608d60..de47b0e0e18f 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1419,7 +1419,7 @@ struct block_device_operations {
 			unsigned int flags);
 	int (*open) (struct block_device *, fmode_t);
 	void (*release) (struct gendisk *, fmode_t);
-	int (*rw_page)(struct block_device *, sector_t, struct page *, unsigned int);
+	int (*rw_page)(struct block_device *, sector_t, struct page *, enum req_op);
 	int (*ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
 	int (*compat_ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
 	unsigned int (*check_events) (struct gendisk *disk,
