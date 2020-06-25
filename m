Return-Path: <SRS0=Z/Mq=AG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 44CFCC433DF
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 24D8D20707
	for <linux-block@archiver.kernel.org>; Thu, 25 Jun 2020 12:22:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=javigon-com.20150623.gappssmtp.com header.i=@javigon-com.20150623.gappssmtp.com header.b="ifgHFoOG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404611AbgFYMWT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404343AbgFYMWS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jun 2020 08:22:18 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84569C061573
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 05:22:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a6so5629032wrm.4
        for <linux-block@vger.kernel.org>; Thu, 25 Jun 2020 05:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=javigon-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3bkv5TGbl7wYs9nS4zaCevytBrOA5cQbuULXOr6pl3k=;
        b=ifgHFoOGFnPjkhUJyWlsM6iDVmY6+dXBQ2RYy98T9hw6pqwoNJQ5ekXb4B1EPGXQT0
         MRKbDXdW2C/DboFLHOyBCoGGwN+6j0+r7IzErzD0WL5hOjs9oiNUhb162G9nRHs62jlV
         kz9ifdRLxZeqPD3rLCIttiz6uUFMXBjw4pIScjnHGIM05F+7MWOtgNFrfcMmkAtZrep6
         awZ96tfAVb0b9WvH7FJxTqrg8ZbWfmMDu/Tp8AixYn8oDKO8m+1iPpzIhs+cgICilSlt
         Bl1qzXwe+FYUTlI8xI6uvMzkgQgWE7/zuZofBLsJyuPoIn1fOgPlUcnSSoVBq8s3++4U
         bQLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3bkv5TGbl7wYs9nS4zaCevytBrOA5cQbuULXOr6pl3k=;
        b=ox3CofCDsuEsjx2xGlH1RwZB/Quw7NdhYE0cu90bROo2YZK3XtTQbnK7Hd6uh2wDbX
         wO6Vke9JL+Jc0MCZf2WdYNzOphn5W7/uce4jNHF1tiwfyNaAhTEjZpdOFMRv4HRdJKqS
         6XjwEv5QCE53WL4PxMBtW34VWP0W4/HdtS0X2Y8fa8h3pXnBWBKtBqFfWXOM1EeyOZwo
         IqrUnDehRG7RtIfHoQ6Ra9cow2nCxaITWM+Kr0UjT9r7GWdgowI++7smg8otbCXlon+i
         rjVAjIxutRPqzPHfQTjxNNMXlqUjBQ54thiTRq8akca3n5g1oJDnx+mxZrI4/KXKEp9L
         0lOw==
X-Gm-Message-State: AOAM533rWU6Xd5CgkJViQsWtop3ouElqMGEHtO/MoHmKR4QSvkErYqct
        QxOKr4z28pA1niOllbOmHCYlhg==
X-Google-Smtp-Source: ABdhPJzF8GY0GnEa29w1laEfJi/6dSjQwhhYGR9JKKjHg3d8xUSjch6Sz0P0cntsTzsVn5L/uRebXw==
X-Received: by 2002:adf:f54b:: with SMTP id j11mr20889677wrp.206.1593087737294;
        Thu, 25 Jun 2020 05:22:17 -0700 (PDT)
Received: from localhost.localdomain ([194.62.217.57])
        by smtp.gmail.com with ESMTPSA id f186sm11934307wmf.29.2020.06.25.05.22.15
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 25 Jun 2020 05:22:16 -0700 (PDT)
From:   =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier@javigon.com>
To:     linux-nvme@lists.infradead.org
Cc:     linux-block@vger.kernel.org, hch@lst.de, kbusch@kernel.org,
        sagi@grimberg.me, axboe@kernel.dk,
        =?UTF-8?q?Javier=20Gonz=C3=A1lez?= <javier.gonz@samsung.com>,
        SelvaKumar S <selvakuma.s1@samsung.com>,
        Kanchan Joshi <joshi.k@samsung.com>,
        Nitesh Shetty <nj.shetty@samsung.com>
Subject: [PATCH 2/6] block: add support for selecting all zones
Date:   Thu, 25 Jun 2020 14:21:48 +0200
Message-Id: <20200625122152.17359-3-javier@javigon.com>
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

Add flag to allow selecting all zones on a single zone management
operation

Signed-off-by: Javier González <javier.gonz@samsung.com>
Signed-off-by: SelvaKumar S <selvakuma.s1@samsung.com>
Signed-off-by: Kanchan Joshi <joshi.k@samsung.com>
Signed-off-by: Nitesh Shetty <nj.shetty@samsung.com>
---
 block/blk-zoned.c             | 3 +++
 include/linux/blk_types.h     | 3 ++-
 include/uapi/linux/blkzoned.h | 9 +++++++++
 3 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/blk-zoned.c b/block/blk-zoned.c
index e87c60004dc5..29194388a1bb 100644
--- a/block/blk-zoned.c
+++ b/block/blk-zoned.c
@@ -420,6 +420,9 @@ int blkdev_zone_mgmt_ioctl(struct block_device *bdev, fmode_t mode,
 		return -ENOTTY;
 	}
 
+	if (zmgmt.flags & BLK_ZONE_SELECT_ALL)
+		op |= REQ_ZONE_ALL;
+
 	return blkdev_zone_mgmt(bdev, op, zmgmt.sector, zmgmt.nr_sectors,
 				GFP_KERNEL);
 }
diff --git a/include/linux/blk_types.h b/include/linux/blk_types.h
index ccb895f911b1..16b57fb2b99c 100644
--- a/include/linux/blk_types.h
+++ b/include/linux/blk_types.h
@@ -351,6 +351,7 @@ enum req_flag_bits {
 	 * work item to avoid such priority inversions.
 	 */
 	__REQ_CGROUP_PUNT,
+	__REQ_ZONE_ALL,		/* apply zone operation to all zones */
 
 	/* command specific flags for REQ_OP_WRITE_ZEROES: */
 	__REQ_NOUNMAP,		/* do not free blocks when zeroing */
@@ -378,7 +379,7 @@ enum req_flag_bits {
 #define REQ_BACKGROUND		(1ULL << __REQ_BACKGROUND)
 #define REQ_NOWAIT		(1ULL << __REQ_NOWAIT)
 #define REQ_CGROUP_PUNT		(1ULL << __REQ_CGROUP_PUNT)
-
+#define REQ_ZONE_ALL		(1ULL << __REQ_ZONE_ALL)
 #define REQ_NOUNMAP		(1ULL << __REQ_NOUNMAP)
 #define REQ_HIPRI		(1ULL << __REQ_HIPRI)
 
diff --git a/include/uapi/linux/blkzoned.h b/include/uapi/linux/blkzoned.h
index 07b5fde21d9f..a8c89fe58f97 100644
--- a/include/uapi/linux/blkzoned.h
+++ b/include/uapi/linux/blkzoned.h
@@ -157,6 +157,15 @@ enum blk_zone_action {
 	BLK_ZONE_MGMT_RESET	= 0x4,
 };
 
+/**
+ * enum blk_zone_mgmt_flags - Flags for blk_zone_mgmt
+ *
+ * BLK_ZONE_SELECT_ALL: Select all zones for current zone action
+ */
+enum blk_zone_mgmt_flags {
+	BLK_ZONE_SELECT_ALL	= 1 << 0,
+};
+
 /**
  * struct blk_zone_mgmt - Extended zoned management
  *
-- 
2.17.1

