Return-Path: <SRS0=sMug=AN=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69066C433E0
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 09:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4826D2088E
	for <linux-block@archiver.kernel.org>; Thu,  2 Jul 2020 09:25:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="lp5YikEv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727921AbgGBJZU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 2 Jul 2020 05:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726092AbgGBJZU (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 2 Jul 2020 05:25:20 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAE17C08C5C1
        for <linux-block@vger.kernel.org>; Thu,  2 Jul 2020 02:25:19 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id a8so21681838edy.1
        for <linux-block@vger.kernel.org>; Thu, 02 Jul 2020 02:25:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HP9ZU4c5mMewSGM3BDAdlue75oae6XIhcuq6h8w4GLc=;
        b=lp5YikEvUaavhxnWbW5PiUXDFLBn6Qu1tMctE+KIIWcfO5vHR2t7ynLozmxpVsWLIn
         3PcaI3QJeWplIq+iax3nB1WP1FFt9DjzzdQzSOtIfaZyj9MpXKONS1VfrD0Olul0s4lQ
         krSn8HzIYBAastnbQPr9eY2mGb34lMXzAv6G6fl5xbcQM65+A8szM7HdGCf0qrKeBRNc
         9scOrNL8+EFwddt60ae3Dg6D56Y1xhKvkbjQB14d9U2/DlQHsgvti/VbdQkA9n7nn+pd
         cetvDZab5exI7ghXIpO8W5Etb/9bVBoDo7b1jtLyqEE+FfVgHCoaDzXiA/dmvUiS+sZ/
         Hj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HP9ZU4c5mMewSGM3BDAdlue75oae6XIhcuq6h8w4GLc=;
        b=aRum9oE7e3d+RlUr6o0E21jJqYDMA8nGH9o+1wmpq+FfN6c7HVeFcqN0853OPGRK8g
         dvuRDdet4naAfIdt0+ptnOY/jTFkJvm8sJGZKEVslD9dgP3M34LbQTJny0BRDY6p6Ft+
         EjeIlvgOF4mWcvqY5hoZLKD8HJJS8iQTLSWFq4G7rxk97kdvtz6oTJJQNLDavEZH5gC8
         adhG5+8Y0JDAanUaC77pKTndcftaVmG3BxTK/Tg0ZrJupqlZdDae6WFukOAnp+vpzzgS
         E5eG2uL3qv0wN5XlFdK+Y0zyIGm0TxA9tT/GyK9xHyyd3GRcb1MDpmHUlc82zYoDPA8E
         C9bQ==
X-Gm-Message-State: AOAM533i59IfBtmvoLXWycELjg4bh1mSrnoct7kR+qpYzJAhzVsPxl5C
        7eXR5K0dWV5QHWr3CgGgz1CfDA==
X-Google-Smtp-Source: ABdhPJy+cVgNo/BmuGac5AmZFP6rVVM2ink2VAsrJ7uDsRcPkXIh6wb5nBmJeyxh4ImSp2zkILbriw==
X-Received: by 2002:a50:c8c9:: with SMTP id k9mr32651126edh.157.1593681918452;
        Thu, 02 Jul 2020 02:25:18 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id b18sm6569464ejl.52.2020.07.02.02.25.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 02 Jul 2020 02:25:17 -0700 (PDT)
From:   =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk, Damien.LeMoal@wdc.com,
        mb@lightnvm.io, Johannes.Thumshirn@wdc.com,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH v3 2/4] block: add support for zone offline transition
Date:   Thu,  2 Jul 2020 11:24:36 +0200
Message-Id: <20200702092438.63717-3-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200702092438.63717-1-javier@javigon.com>
References: <20200702092438.63717-1-javier@javigon.com>
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
 include/uapi/linux/blkzoned.h | 6 ++++++
 7 files changed, 22 insertions(+), 3 deletions(-)

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
index 0f156e96e48f..def43ef2b021 100644
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
+		if (!(q->zone_flags & BLK_ZONE_SUP_OFFLINE))
+			return -ENOTTY;
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
index afe62dc27ff7..bb6a33f52d53 100644
--- a/drivers/nvme/host/zns.c
+++ b/drivers/nvme/host/zns.c
@@ -81,7 +81,7 @@ int nvme_update_zone_info(struct gendisk *disk, struct nvme_ns *ns,
 	}
 
 	q->limits.zoned = BLK_ZONED_HM;
-	q->zone_flags = BLK_ZONE_REP_CAPACITY;
+	q->zone_flags = BLK_ZONE_REP_CAPACITY | BLK_ZONE_SUP_OFFLINE;
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
index 42c3366cc25f..8b7c4705cef7 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -77,9 +77,14 @@ enum blk_zone_cond {
  * enum blk_zone_report_flags - Feature flags of reported zone descriptors.
  *
  * @BLK_ZONE_REP_CAPACITY: Zone descriptor has capacity field.
+ * @BLK_ZONE_SUP_OFFLINE : Zone device supports explicit offline transition.
  */
 enum blk_zone_report_flags {
+	/* Report feature flags */
 	BLK_ZONE_REP_CAPACITY	= (1 << 0),
+
+	/* Supported capabilities */
+	BLK_ZONE_SUP_OFFLINE	= (1 << 1),
 };
 
 /**
@@ -166,5 +171,6 @@ struct blk_zone_range {
 #define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)
 #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
 #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
+#define BLKOFFLINEZONE	_IOW(0x12, 137, struct blk_zone_range)
 
 #endif /* _UAPI_BLKZONED_H */
-- 
2.17.1

