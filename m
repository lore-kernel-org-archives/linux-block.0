Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A91A3C433E1
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A9BC206EB
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ul+okasJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404599AbgFYMWR (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:22:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404343AbgFYMWR (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 08:22:17 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AE34C061573
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 05:22:17 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id g75so5332566wme.5
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 05:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HUZa4ScwjxYX1rN8zZ6Z6dgZqN0kjBnH5qLQixL2WJo=;
        b=ul+okasJvE6KMy1WY5AmOXTy2OsCN2ysq/dGKyIV5tlWwQiDyDCzyDaskIq1dl1BqM
         /qPxDbl7edw/QYV4cFOx7Tp8CTjJ4O0LyON9vulEFav1f3tXAYFN+qc6D533Lx1xLE4C
         HTpb7v7YxzX9xjRPI87gOzU4su4qDnBRZh87wCtnG6Crwvx4hPQyJIFmgzQtJxKarW5R
         +P3sve4QoG3wYH01FinDNU/hYNKAvusKtuxFySrNYqkxl6ZYIBZ2JMQ2ioq26exQjsiV
         BK9Dq+bK9yZMeB8rSNhrx/KuGciq3Qu5u2RDZDqFShxDxdW8cO4JWk1URs5Y0DvHsU/K
         Oofw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HUZa4ScwjxYX1rN8zZ6Z6dgZqN0kjBnH5qLQixL2WJo=;
        b=AB0u9ws0O+JXZNoihGbY613GRpE2LNSIO96gjY6xwowGCjIXA6fhS5AldN6gBtzLNx
         4kk85+d+fcqYimXZcR0GBFmv1pfXI3/n3YfmoLxbVgYQoWox7P+GrQXgdHqOrWhbUT+R
         7hN7Eu7nvLkjrsn97DbhVJPCQgE3JxaXOpNgNq0uIMh8U9CbT3xMBAmPuF/jfOqKQuf+
         MkWPqBBWuT1nqmLmhaYPvKTbzwlWKpuho8U0tjZl7PSoiGWap3vewoGOpR2JYXZmTZG7
         spi9dfqdh0OKEK0ZQWCLBKIGynnxOagdf67sz2tqy8sDh5BKKP9ltvX02tpCpGt54r81
         E+4A==
X-Gm-Message-State: AOAM530DT8ZCPxFtdMfjuC+X+nrfIZttkabGIA5LLn/bvRlen3dNe7SJ
        mrrhwdcmIU3dMfBo59vIKw6TpQ==
X-Google-Smtp-Source: ABdhPJzHLz641P5clBQpIy9+k/4I437sBYg1AePtyUs11AaPJ/9WpqJ1Dw+iBmU6GO7ZVL3UDbLnsw==
X-Received: by 2002:a1c:2d4b:: with SMTP id t72mr3038062wmt.105.1593087735750;
        Thu, 25 Jun 2020 05:22:15 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id f186sm11934307wmf.29.2020.06.25.05.22.14
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 05:22:15 -0700 (PDT)
From:   =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH 1/6] block: introduce IOCTL for zone mgmt
Date:   Thu, 25 Jun 2020 14:21:47 +0200
Message-Id: <20200625122152.17359-2-javier@javigon.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200625122152.17359-1-javier@javigon.com>
References: <20200625122152.17359-1-javier@javigon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Javier González <javier.gonz@samsung.com>

The current IOCTL interface for zone management is limited by struct
blk_zone_range, which is unfortunately not extensible. Specially, the
lack of flags is problematic for ZNS zoned devices.

This new IOCTL is designed to be a superset of the current one, with
support for flags and bits for extensibility.

Signed-off-by: Javier González <javier.gonz@samsung.com>
Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-zoned.c             | 56 ++++++++++++++++++++++++++++++++++-
 block/ioctl.c                 |  2 ++
 include/linux/blkdev.h        |  9 ++++++
 include/uapi/linux/blkzoned.h | 33 +++++++++++++++++++++
 4 files changed, 99 insertions(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index 81152a260354..e87c60004dc5 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -322,7 +322,7 @@ int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
  * BLKRESETZONE, BLKOPENZONE, BLKCLOSEZONE and BLKFINISHZONE ioctl processing.
  * Called from blkdev_ioctl.
  */
-int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
+int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
 			   unsigned int cmd, unsigned long arg)
 {
 	void __user *argp = (void __user *)arg;
@@ -370,6 +370,60 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 				GFP_KERNEL);
 }
 
+/*
+ * Zone management ioctl processing. Extension of blkdev_zone_ops_ioctl(), with
+ * blk_zone_mgmt structure.
+ *
+ * Called from blkdev_ioctl.
+ */
+int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
+			   unsigned int cmd, unsigned long arg)
+{
+	void __user *argp = (void __user *)arg;
+	struct request_queue *q;
+	struct blk_zone_mgmt zmgmt;
+	enum req_opf op;
+
+	if (!argp)
+		return -EINVAL;
+
+	q = bdev_get_queue(bdev);
+	if (!q)
+		return -ENXIO;
+
+	if (!blk_queue_is_zoned(q))
+		return -ENOTTY;
+
+	if (!capable(CAP_SYS_ADMIN))
+		return -EACCES;
+
+	if (!(mode & FMODE_WRITE))
+		return -EBADF;
+
+	if (copy_from_user(&zmgmt, argp, sizeof(struct blk_zone_mgmt)))
+		return -EFAULT;
+
+	switch (zmgmt.action) {
+	case BLK_ZONE_MGMT_CLOSE:
+		op = REQ_OP_ZONE_CLOSE;
+		break;
+	case BLK_ZONE_MGMT_FINISH:
+		op = REQ_OP_ZONE_FINISH;
+		break;
+	case BLK_ZONE_MGMT_OPEN:
+		op = REQ_OP_ZONE_OPEN;
+		break;
+	case BLK_ZONE_MGMT_RESET:
+		op = REQ_OP_ZONE_RESET;
+		break;
+	default:
+		return -ENOTTY;
+	}
+
+	return blkdev_zone_mgmt(bdev, op, zmgmt.sector, zmgmt.nr_sectors,
+				GFP_KERNEL);
+}
+
 static inline unsigned long *blk_alloc_zone_bitmap(int node,
 						   unsigned int nr_zones)
 {
diff --git a/block/ioctl.c b/block/ioctl.c
index bdb3bbb253d9..0ea29754e7dd 100644
--- a/block/ioctl.c
+++ b/block/ioctl.c
@@ -514,6 +514,8 @@ static int blkdev_common_ioctl(struct block_device *bdev, fmode_t mode,
 	case BLKOPENZONE:
 	case BLKCLOSEZONE:
 	case BLKFINISHZONE:
+		return blkdev_zone_ops_ioctl(bdev, mode, cmd, arg);
+	case BLKMGMTZONE:
 		return blkdev_zone_mgmt_ioctl(bdev, mode, cmd, arg);
 	case BLKGETZONESZ:
 		return put_uint(argp, bdev_zone_sectors(bdev));
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 8fd900998b4e..bd8521f94dc4 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -368,6 +368,8 @@ int blk_revalidate_disk_zones(struct gendisk *disk,
 
 extern int blkdev_report_zones_ioctl(struct block_device *bdev, fmode_t mode,
 				     unsigned int cmd, unsigned long arg);
+extern int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
+				  unsigned int cmd, unsigned long arg);
 extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 				  unsigned int cmd, unsigned long arg);
 
@@ -385,6 +387,13 @@ static inline int blkdev_report_zones_ioctl(struct block_device *bdev,
 	return -ENOTTY;
 }
 
+
+static inline int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
+					unsigned int cmd, unsigned long arg)
+{
+	return -ENOTTY;
+}
+
 static inline int blkdev_zone_mgmt_ioctl(struct block_device *bdev,
 					 fmode_t mode, unsigned int cmd,
 					 unsigned long arg)
diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index 42c3366cc25f..07b5fde21d9f 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -142,6 +142,38 @@ struct blk_zone_range {
 	__u64		nr_sectors;
 };
 
+/**
+ * enum blk_zone_action - Zone state transitions managed from user-space
+ *
+ * @BLK_ZONE_MGMT_CLOSE: Transition to Closed state
+ * @BLK_ZONE_MGMT_FINISH: Transition to Finish state
+ * @BLK_ZONE_MGMT_OPEN: Transition to Open state
+ * @BLK_ZONE_MGMT_RESET: Transition to Reset state
+ */
+enum blk_zone_action {
+	BLK_ZONE_MGMT_CLOSE	= 0x1,
+	BLK_ZONE_MGMT_FINISH	= 0x2,
+	BLK_ZONE_MGMT_OPEN	= 0x3,
+	BLK_ZONE_MGMT_RESET	= 0x4,
+};
+
+/**
+ * struct blk_zone_mgmt - Extended zoned management
+ *
+ * @action: Zone action as in described in enum blk_zone_action
+ * @flags: Flags for the action
+ * @sector: Starting sector of the first zone to operate on
+ * @nr_sectors: Total number of sectors of all zones to operate on
+ */
+struct blk_zone_mgmt {
+	__u8		action;
+	__u8		resv3[3];
+	__u32		flags;
+	__u64		sector;
+	__u64		nr_sectors;
+	__u64		resv31;
+};
+
 /**
  * Zoned block device ioctl's:
  *
@@ -166,5 +198,6 @@ struct blk_zone_range {
 #define BLKOPENZONE	_IOW(0x12, 134, struct blk_zone_range)
 #define BLKCLOSEZONE	_IOW(0x12, 135, struct blk_zone_range)
 #define BLKFINISHZONE	_IOW(0x12, 136, struct blk_zone_range)
+#define BLKMGMTZONE	_IOR(0x12, 137, struct blk_zone_mgmt)
 
 #endif /* _UAPI_BLKZONED_H */
-- 
2.17.1

