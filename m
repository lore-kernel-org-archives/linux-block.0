Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9008C433E1
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 06:55:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80EA52085B
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 06:55:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="W9vhYFnz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727954AbgGBGzH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 02:55:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727948AbgGBGzH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 02:55:07 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3D0EC08C5DC
        for <linux-block@vger.kernel.org>; Wed,  1 Jul 2020 23:55:06 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id w6so27950152ejq.6
        for <linux-block@vger.kernel.org>; Wed, 01 Jul 2020 23:55:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ZbGfoLD1hyDSJuDUf+5wLzWjwZYjdlwlztihqUAYr0o=;
        b=W9vhYFnzU/7cJIIbbRFkTAHBr8D9MoArsDYN/pgfeBU/TeHkGOyhMnLRyJR3ffz44r
         21oGwfofsrh16+IMrlTsBeZ+NwrNcTwPrDNW7puNBzjDgr7azt3gBcjwtGy7BsbST9qb
         aaxeRCBlrhKJQAHrXTrikNRO3x0HR1sJHpS1VUtMWvGOfWmG0HRvp8SPTd4s0YWOrAd+
         c4OTko+2eoCHJmWtUN7DBX0A+o+LTLU9M0sXehPuDlkO86WKd/iWBmYhNfNBnGi2vV10
         Xgc+QM4XHLXBXuhtHU1xXy1EOW7I2CI+cc4TI9nugEhMl+jQ85iIvlenmao2RmyQffsA
         HdBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ZbGfoLD1hyDSJuDUf+5wLzWjwZYjdlwlztihqUAYr0o=;
        b=PvnXybaYvd2Ha+srKXhigG3USPdBtYqBLFtWJJH/L0S7JWDwmIX5h1zgA0UqnsXiTy
         a7g0sZiKoaRmgh1MLeNMZP/hXY5PBS8PXM21e6/V89E3Ue1oFkC8yZFCrGfc1jgXdW8m
         rv9THZ4dchaCgrXRklRvhQr/Hg6MyithCo+5yTHE8/Pgw+bEEgInDSQMoQdIxx2Kpfgu
         uCRNhgYQ9LAT9630LMeBuvlQTd22JNLp9a/K38VNtpFrso9uYk2SLBbZWSPNQmHm1393
         qll61P/tSxfs9eatVSDAoFkZFmxKG0qllHxGq1SWlBInrXiXDwbRoGJKElP9DPwnB50a
         S/LA==
X-Gm-Message-State: AOAM532hBwywW6KfKloXEoeg9lVOZRSNWmZUAeIyRYshU8aPFYQekMs/
        1wFb+4iS7Aj0qbT2V/YToD1CJQ==
X-Google-Smtp-Source: ABdhPJx32JrMy5eydsY52ILcBd63eiMqYEYl8hr9LGadI8mRzZdjLGJTtpC4LAsrp6Gt65msb5MZQQ==
X-Received: by 2002:a17:906:1682:: with SMTP id s2mr27993699ejd.532.1593672905359;
        Wed, 01 Jul 2020 23:55:05 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id cz2sm7912769edb.82.2020.07.01.23.55.04
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 01 Jul 2020 23:55:04 -0700 (PDT)
From:   =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk, Damien.LeMoal@wdc.com,
        mb@lightnvm.io,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH 2/4] block: add support for zone offline transition
Date:   Thu,  2 Jul 2020 08:54:36 +0200
Message-Id: <20200702065438.46350-3-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702065438.46350-1-javier@javigon.com>
References: <20200702065438.46350-1-javier@javigon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

Add support for offline transition on the zoned block device. Use the
existing feature flags for the underlying driver to report support for
the feature, as currently this transition is only supported in ZNS and
not in ZAC/ZBC

Signed-off-by: Javier González <javier.gonz@samsung.com>
Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-core.c              | 2 ++
 block/blk-zoned.c             | 8 +++++++-
 drivers/nvme/host/core.c      | 3 +++
 drivers/nvme/host/zns.c       | 2 +-
 include/linux/blk_types.h     | 3 +++
 include/linux/blkdev.h        | 1 -
 include/uapi/linux/blkzoned.h | 3 +++
 7 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index 03252af8c82c..589cbdacc5ec 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -140,6 +140,7 @@ static const char *const blk_op_name[] = {
 	REQ_OP_NAME(ZONE_CLOSE),
 	REQ_OP_NAME(ZONE_FINISH),
 	REQ_OP_NAME(ZONE_APPEND),
+	REQ_OP_NAME(ZONE_OFFLINE),
 	REQ_OP_NAME(WRITE_SAME),
 	REQ_OP_NAME(WRITE_ZEROES),
 	REQ_OP_NAME(SCSI_IN),
@@ -1030,6 +1031,7 @@ generic_make_request_checks(struct bio *bio)
 	case REQ_OP_ZONE_OPEN:
 	case REQ_OP_ZONE_CLOSE:
 	case REQ_OP_ZONE_FINISH:
+	case REQ_OP_ZONE_OFFLINE:
 		if (!blk_queue_is_zoned(q))
 			goto not_supported;
 		break;
diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 0f156e96e48f..b97f67f462b4 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -320,7 +320,8 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 }
 
 /*
- * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl processing.
+ * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE, BLKFINISHZONE and BLKOFFLINEZONE
+ * ioctl processing.
  * Called from blkdev_ioctl.
  */
 int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
@@ -363,6 +364,11 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 	case BLKFINISHZONE:
 		op = REQ_OP_ZONE_FINISH;
 		break;
+	case BLKOFFLINEZONE:
+		if (!(q->zone_flags & BLK_ZONE_REP_OFFLINE))
+			return -EINVAL;
+		op = REQ_OP_ZONE_OFFLINE;
+		break;
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index e5f754889234..1f5c7fc3d2c9 100644
--- a/drivers/nvme/host/core.c
+++ b/drivers/nvme/host/core.c
@@ -776,6 +776,9 @@ blk_status_t nvme_setup_cmd(struct nvme_ns *ns, struct request *req,
 	case REQ_OP_ZONE_FINISH:
 		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_FINISH);
 		break;
+	case REQ_OP_ZONE_OFFLINE:
+		ret = nvme_setup_zone_mgmt_send(ns, req, cmd, NVME_ZONE_OFFLINE);
+		break;
 	case REQ_OP_WRITE_ZEROES:
 		ret = nvme_setup_write_zeroes(ns, req, cmd);
 		break;
diff --git a/drivers/nvme/host/zns.c b/drivers/nvme/host/zns.c
index 888264261ba3..b34d2ed13825 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -81,7 +81,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
 	}
 
 	q->limits.zoned = BLK_ZONED_HM;
-	q->zone_flags = BLK_ZONE_REP_CAPACITY;
+	q->zone_flags = BLK_ZONE_REP_CAPACITY | BLK_ZONE_REP_OFFLINE;
 	blk_queue_flag_set(QUEUE_FLAG_ZONE_RESETALL, q);
 free_data:
 	kfree(id);
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ccb895f911b1..c0123c643e2f 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -316,6 +316,8 @@ enum req_opf {
 	REQ_OP_ZONE_FINISH	= 12,
 	/* write data at the current zone write pointer */
 	REQ_OP_ZONE_APPEND	= 13,
+	/* Transition a zone to offline */
+	REQ_OP_ZONE_OFFLINE	= 14,
 
 	/* SCSI passthrough using struct scsi_request */
 	REQ_OP_SCSI_IN		= 32,
@@ -455,6 +457,7 @@ static inline bool op_is_zone_mgmt(enum req_opf op)
 	case REQ_OP_ZONE_OPEN:
 	case REQ_OP_ZONE_CLOSE:
 	case REQ_OP_ZONE_FINISH:
+	case REQ_OP_ZONE_OFFLINE:
 		return true;
 	default:
 		return false;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 3f2e3425fa53..e489b646486d 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -370,7 +370,6 @@ extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 				     unsigned int cmd, unsigned long arg);
 extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 				  unsigned int cmd, unsigned long arg);
-
 #else /* CONFIG_BLK_DEV_ZONED */
 
 static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index 42c3366cc25f..e5adf4a9f4b0 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -77,9 +77,11 @@ enum blk_zone_cond {
  * enum blk_zone_report_flags - Feature flags of reported zone descriptors.
  *
  * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.
+ * @BLK_ZONE_REP_OFFLINE : Zone device supports offline transition.
  */
 enum blk_zone_report_flags {
 	BLK_ZONE_REP_CAPACITY	= (1 << 0),
+	BLK_ZONE_REP_OFFLINE	= (1 << 1),
 };
 
 /**
@@ -166,5 +168,6 @@ struct blk_zone_range {
 #define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)
 #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
 #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
+#define BLKOFFLINEZONE	_IOW(0x12, 137, struct blk_zone_range)
 
 #endif /* _UAPI_BLKZONED_H */
-- 
2.17.1

