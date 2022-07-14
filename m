Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89B1CCCA47B
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:07:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239969AbiGNSHn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:07:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239145AbiGNSHm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:07:42 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 065D0474DB
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:41 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id bf13so2258251pgb.11
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8+Bh9N5Yp5KDYV7iPP9RY6GJoeEKF5We9shml1qw4dM=;
        b=1B1yhY0TrEXeiQLZezPe/4dGVdVVuWzaIzSo0OBEEx9ZRnCSzmSFOQLIRuqbwrZyTc
         68c1uYk6+J0Tpk8KRy5mEqf6frk6VhR084PoBsdc7zfGxZSjfuWB0EcIulkWK8Huvwmj
         dE9VzrQ120y7hStDIQ36m/o+PNX73hMx/2iMOeV+x6d9+lW5V2WDIty6I3qaldKABGft
         TBp05k+G6nlvz+OpDgtjTom4v6QpjDmM5+8wE+tbdFG5FhRFri3z25qvsd+eGb12Q94q
         LnVVl50MHCsTz5Sl/4CaGV6ncZNI9iJNEg0FQ8ewNCK7V/r05S51U+emDp1TlDCPAEHG
         W11A==
X-Gm-Message-State: AJIora8O+1MZv1L9OObvqEjEVDxc2WopLtcCXiYKKqbzuhny/ytXOv0k
        YSNNi/y46asx8YdoNB9bgj0=
X-Google-Smtp-Source: AGRyM1sGBKWJp8QqCM4IN2XDlvihI2WBfYgcFhHn/jshwzZLqNJXLePWFZ+ZJ3Vc1ClfPgmxULoG2g==
X-Received: by 2002:a63:f910:0:b0:419:d6c0:c969 with SMTP id h16-20020a63f910000000b00419d6c0c969mr537016pgi.624.1657822060412;
        Thu, 14 Jul 2022 11:07:40 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.07.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:07:39 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Tejun Heo <tj@kernel.org>, Minchan Kim <minchan@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Hannes Reinecke <hare@suse.de>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Johannes Thumshirn <johannes.thumshirn@wdc.com>
Subject: [PATCH v3 03/63] block: Change the type of the last .rw_page() argument
Date:   Thu, 14 Jul 2022 11:06:29 -0700
Message-Id: <20220714180729.1065367-4-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
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
Cc: Hannes Reinecke <hare@suse.de>
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Johannes Thumshirn <johannes.thumshirn@wdc.com>
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
index 2f13f0062192..ca2ff113ea00 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -1381,7 +1381,7 @@ struct block_device_operations {
 			unsigned int flags);
 	int (*open) (struct block_device *, fmode_t);
 	void (*release) (struct gendisk *, fmode_t);
-	int (*rw_page)(struct block_device *, sector_t, struct page *, unsigned int);
+	int (*rw_page)(struct block_device *, sector_t, struct page *, enum req_op);
 	int (*ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
 	int (*compat_ioctl) (struct block_device *, fmode_t, unsigned, unsigned long);
 	unsigned int (*check_events) (struct gendisk *disk,
