Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D77C433E0
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D48C206EB
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="Kh44WkYO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404612AbgFYMWV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404343AbgFYMWU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 08:22:20 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54966C061573
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 05:22:20 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id t194so5706113wmt.4
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 05:22:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2L00CNHKBCbfy3cMWAQy/pd7OUpZtWDs/eSSmk8PMi4=;
        b=Kh44WkYOain0Pp75DcY1C7bHN1YW5+QHFdo0wKvqm9K7NX2tVMrXpvj0g6MLYu+In9
         6l8Xk8BxfTXc6h02EsJj/CABUJVdAsbvA4lCOPPMgSOEnZXXp9t7zWzNnf65+lyl6Lyz
         zjRuKiajCZJBs3MdoA4P9WnKTWsYDL9rOITff9JoBR5oxIwH8PgFJ1J2HcbLzt18F1dq
         n8xTt4fzX3bFSM/myHNFJPFcraZDxYSu+DnKkSXsaeU7QHUfT8Naodsb+K6Fb6LTrD+K
         a+mUhAfxMtNS+cS0JuxLOjLeIYaqPvdllhcjxmDI+pLRpnG7a4JmFLELeZ3nSRO8Mc6R
         P7OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2L00CNHKBCbfy3cMWAQy/pd7OUpZtWDs/eSSmk8PMi4=;
        b=jcl8yXe7aytOs/3aicQt0Cgfzyo3VOsSl96QvjBP74/3ouTNrMS9XmQfqOW7Es8lNi
         tbYqg8iHdx9+ZwiHel3wHDYHcjq8e1yrk3e93sQz4vkvSnf9pwgXHmJkmgB/Ig5GMJBX
         aawIlhyRJXZ/FxGq5pAkC+m61d3hNRz2zV/wCyaTeIsaygF51Sa3M6vci5Wkc2Z9Ecm+
         HmNDdB5f/0DwGuiormJ4FMhIIv2YadeGen27tzf93IbNWUKiYnPDwrp5TbG4COqI6al2
         byXWukIU1ZMtKMMlmV/Kh6bzIFrQslHkpZvYtOVLpP7qE8IU5UHZS8oTjldZo5LVVpAA
         Orvw==
X-Gm-Message-State: AOAM532q1jNxxApHYPk6qxiqyChpKLcxgHgyj0RMPS3oY/xAOEahOlnP
        //bLpJ7hhpDnwLXPR+K4TFXang==
X-Google-Smtp-Source: ABdhPJwLQKCVAuxkPWqx617ggfLTUwSVHSwvKTQYrG5rXSz42pycHLAu2PUhv9lJFRFCtaThehrtNw==
X-Received: by 2002:a1c:bc8a:: with SMTP id m132mr2389198wmf.1.1593087738990;
        Thu, 25 Jun 2020 05:22:18 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id f186sm11934307wmf.29.2020.06.25.05.22.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 05:22:18 -0700 (PDT)
From:   =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH 3/6] block: add support for zone offline transition
Date:   Thu, 25 Jun 2020 14:21:49 +0200
Message-Id: <20200625122152.17359-4-javier@javigon.com>
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

Add support for offline transition on the zoned block device using the
new zone management IOCTL

Signed-off-by: Javier González <javier.gonz@samsung.com>
Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-core.c              | 2 ++
 block/blk-zoned.c             | 3 +++
 drivers/nvme/host/core.c      | 3 +++
 include/linux/blk_types.h     | 3 +++
 include/linux/blkdev.h        | 1 -
 include/uapi/linux/blkzoned.h | 1 +
 6 files changed, 12 insertions(+), 1 deletion(-)

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
index 29194388a1bb..704fc15813d1 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -416,6 +416,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 	case BLK_ZONE_MGMT_RESET:
 		op = REQ_OP_ZONE_RESET;
 		break;
+	case BLK_ZONE_MGMT_OFFLINE:
+		op = REQ_OP_ZONE_OFFLINE;
+		break;
 	default:
 		return -ENOTTY;
 	}
diff --git a/drivers/nvme/host/core.c b/drivers/nvme/host/core.c
index f1215523792b..5b95c81d2a2d 100644
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
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index 16b57fb2b99c..b3921263c3dd 100644
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
@@ -456,6 +458,7 @@ static inline bool op_is_zone_mgmt(enum req_opf op)
 	case REQ_OP_ZONE_OPEN:
 	case REQ_OP_ZONE_CLOSE:
 	case REQ_OP_ZONE_FINISH:
+	case REQ_OP_ZONE_OFFLINE:
 		return true;
 	default:
 		return false;
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index bd8521f94dc4..8308d8a3720b 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -372,7 +372,6 @@ extern int blkdev_zone_ops_ioctl(struct block_device *bdev, fmode_t mode,
 				  unsigned int cmd, unsigned long arg);
 extern int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 				  unsigned int cmd, unsigned long arg);
-
 #else /* CONFIG_BLK_DEV_ZONED */
 
 static inline unsigned int blkdev_nr_zones(struct gendisk *disk)
diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index a8c89fe58f97..d0978ee10fc7 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -155,6 +155,7 @@ enum blk_zone_action {
 	BLK_ZONE_MGMT_FINISH	= 0x2,
 	BLK_ZONE_MGMT_OPEN	= 0x3,
 	BLK_ZONE_MGMT_RESET	= 0x4,
+	BLK_ZONE_MGMT_OFFLINE	= 0x5,
 };
 
 /**
-- 
2.17.1

