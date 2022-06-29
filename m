Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA26ECCA47E
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231423AbiF2XcB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiF2XcA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:00 -0400
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED30A25C
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:31:59 -0700 (PDT)
Received: by mail-pj1-f46.google.com with SMTP id g16-20020a17090a7d1000b001ea9f820449so987595pjl.5
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=r8DzTgvJ23x4yZP0IWCaebcTTEEaBSxZS+QqCv07FtI=;
        b=BoPKm/DJopsSnu9643ZjvXkm4grYp/x9clHiFv8sKsbDkaucrYrcajU2P/Xo1Cl297
         UxZrQVAHx4cUgeUsoqjcrH4fHQMwZDtSwuGyusppFcozthgcv/v12AmyuzxmQVZXMdKG
         dfvx3s24UawQ2I0y4LhPei0ZP8zW7ij4865gNYbRosAFxbte3ApU091cxxxLv3fYr7r1
         suo9f1zpgVdLSwSJLGim4ISkpz4/sDCfKQw7ESIRDYy9PyqF6kXaKCkWU4WhO6D/roKh
         oop1tH8S2BoXT6fBJAA+DJUVvgIEgmFkCC3/iZuQD6NdFmyWhhxvnldWsgKFCGBR9jVc
         D8+Q==
X-Gm-Message-State: AJIora+2kchJd1NPbf9gC5BIFnopQDk1xsXyQVkWUjsxziQ4w9P6jIET
        ClEMzMFj9pKcVT7Qh1DrXEsNmta70CQ=
X-Google-Smtp-Source: AGRyM1t5VhGmCC7x+kWG9dKxEzBosKDPsB8EU+oDL5YPnLFTeSH8STH0nxOWClvKTs3Amq4b1W+iKQ==
X-Received: by 2002:a17:903:41c7:b0:16a:2dcf:c4a0 with SMTP id u7-20020a17090341c700b0016a2dcfc4a0mr11323453ple.83.1656545519436;
        Wed, 29 Jun 2022 16:31:59 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.31.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:31:58 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, Minchan Kim <minchan@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH v2 03/63] block: Change the type of the last .rw_page() argument
Date:   Wed, 29 Jun 2022 16:30:45 -0700
Message-Id: <20220629233145.2779494-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
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
index 9e26d5e769f3..7b82876af36e 100644
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
index e5233c911e43..a35b86c58aa2 100644
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
index 5e622c0d4b66..dfbf73145d16 100644
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
index a72b81fa3242..f36efcc11f67 100644
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
index bd395daa057c..0c4a53104705 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1413,7 +1413,7 @@ struct block_device_operations {
 			unsigned int flags);
 	int (*open) (struct block_device *, fmode_t);
 	void (*release) (struct gendisk *, fmode_t);
-	int (*rw_page)(struct block_device *, sector_t, struct page *, unsigned int);
+	int (*rw_page)(struct block_device *, sector_t, struct page *, enum req_op);
 	int (*ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
 	int (*compat_ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
 	unsigned int (*check_events) (struct gendisk *disk,
