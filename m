Return-Path: <SRS0=mBf9=44=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A487C2BAEE
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 23:57:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 062AF206BE
	for <linux-block@archiver.kernel.org>; Wed, 11 Mar 2020 23:57:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qQKGWHsU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731507AbgCKX47 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Mar 2020 19:56:59 -0400
Received: from mail-pl1-f202.google.com ([209.85.214.202]:44669 "EHLO
        mail-pl1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731399AbgCKX47 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Mar 2020 19:56:59 -0400
Received: by mail-pl1-f202.google.com with SMTP id c7so2230754plr.11
        for <linux-block@vger.kernel.org>; Wed, 11 Mar 2020 16:56:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=AZPvh30KFy43kEyQxHv/V8BBQfdFAAHiyFrKXoYvQuk=;
        b=qQKGWHsUgueSRuYYMEeO9BJHhAqNhnEDm4a4u2vIWrV7QPwxnMvqGBbrOV1hFNvnFi
         Wv4JNNWBAZQMPQVwJQgHqNRIwVYd1TTCgkwSpP54uV3FgDlV1+mvI+NOWGkhv3nyLG0v
         LfVITDV/O88Vbx+AiFKkLTL9x5GLbwiKpgWh0f+JDOQDjwq6fSqFbqVqpNBIbNu1+zqi
         ujvkyMhj4Y1zwsxrql4z1biEcYbJKEFsTtRQDjtunklUG28jYob32PKKJsDeLKXxVye4
         vGrUCKd64tFQYO13tF7S67Gze+k4+C86w4F1UhTuWs5vnGRS566m/hilIdx7gvEHK6T6
         1//A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=AZPvh30KFy43kEyQxHv/V8BBQfdFAAHiyFrKXoYvQuk=;
        b=pfIm/EXZkWEWP0B+BEoVCH/MMST9kYYq6ad+EpQmrybsohmu1Cn/mwGqSbAXcWX/19
         IDtLqfvzKZh24oSZZywbshqkY8vfo2YoAN6xi7GF7Rt4qkks7YuCq297SyD1AYIJtT1m
         kTDs+ivNLDLSaU+d5MbGhsMdVwzKZZMIKznekGJvlr1T3PeAwPtTXZDLU/J+R3WMJUSF
         vVqVVhBZkcBcpnJAPyGgd0rIgScE3kZe/Ek+6/4iSZAvfEpKZrnQARhWsf4XrBEkHZ21
         0r4z5SJo7R0EdDvDGczXmToPacoN6NtZ3EgOMMA5J1/YQtZJX7iEgKOiCTVryWqov0mR
         9TzA==
X-Gm-Message-State: ANhLgQ2WU0n7t+BRWAHGyAfc1TCyk+7tkbkSEO1RPAAiC1ehvFeYuEwO
        pd3Wb0TfQYId+6LfF7cXHj0/DF/nLFVQ6ngE
X-Google-Smtp-Source: ADFU+vsGYMhXTgL/gZ5yx4VyViO6yE42G1cxQ//ozErPQaXqA7QqLze49WYhyRqfOIKsiOTk+DtFaoj77v0RiABu
X-Received: by 2002:a63:6b8a:: with SMTP id g132mr4899758pgc.359.1583971017911;
 Wed, 11 Mar 2020 16:56:57 -0700 (PDT)
Date:   Wed, 11 Mar 2020 16:56:53 -0700
Message-Id: <20200311235653.141701-1-rammuthiah@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH] Inline contents of BLK_MQ_VIRTIO config
From:   Ram Muthiah <rammuthiah@google.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@android.com, Ram Muthiah <rammuthiah@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The config contains one symbol and is a dep of only two configs.
Inlined this symbol so that it's built in by the two configs
which need it and deleted the config.

Signed-off-by: Ram Muthiah <rammuthiah@google.com>
---
 block/Kconfig                 |  5 ----
 block/Makefile                |  1 -
 block/blk-mq-virtio.c         | 46 -----------------------------------
 include/linux/blk-mq-virtio.h | 43 +++++++++++++++++++++++++++++---
 4 files changed, 39 insertions(+), 56 deletions(-)
 delete mode 100644 block/blk-mq-virtio.c

diff --git a/block/Kconfig b/block/Kconfig
index 3bc76bb113a0..953744daff7c 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -203,11 +203,6 @@ config BLK_MQ_PCI
 	depends on BLOCK && PCI
 	default y
 
-config BLK_MQ_VIRTIO
-	bool
-	depends on BLOCK && VIRTIO
-	default y
-
 config BLK_MQ_RDMA
 	bool
 	depends on BLOCK && INFINIBAND
diff --git a/block/Makefile b/block/Makefile
index 1a43750f4b01..709695f54150 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -29,7 +29,6 @@ obj-$(CONFIG_BLK_CMDLINE_PARSER)	+= cmdline-parser.o
 obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o
 obj-$(CONFIG_BLK_DEV_INTEGRITY_T10)	+= t10-pi.o
 obj-$(CONFIG_BLK_MQ_PCI)	+= blk-mq-pci.o
-obj-$(CONFIG_BLK_MQ_VIRTIO)	+= blk-mq-virtio.o
 obj-$(CONFIG_BLK_MQ_RDMA)	+= blk-mq-rdma.o
 obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
 obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
deleted file mode 100644
index 488341628256..000000000000
--- a/block/blk-mq-virtio.c
+++ /dev/null
@@ -1,46 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2016 Christoph Hellwig.
- */
-#include <linux/device.h>
-#include <linux/blk-mq.h>
-#include <linux/blk-mq-virtio.h>
-#include <linux/virtio_config.h>
-#include <linux/module.h>
-#include "blk-mq.h"
-
-/**
- * blk_mq_virtio_map_queues - provide a default queue mapping for virtio device
- * @qmap:	CPU to hardware queue map.
- * @vdev:	virtio device to provide a mapping for.
- * @first_vec:	first interrupt vectors to use for queues (usually 0)
- *
- * This function assumes the virtio device @vdev has at least as many available
- * interrupt vetors as @set has queues.  It will then queuery the vector
- * corresponding to each queue for it's affinity mask and built queue mapping
- * that maps a queue to the CPUs that have irq affinity for the corresponding
- * vector.
- */
-int blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
-		struct virtio_device *vdev, int first_vec)
-{
-	const struct cpumask *mask;
-	unsigned int queue, cpu;
-
-	if (!vdev->config->get_vq_affinity)
-		goto fallback;
-
-	for (queue = 0; queue < qmap->nr_queues; queue++) {
-		mask = vdev->config->get_vq_affinity(vdev, first_vec + queue);
-		if (!mask)
-			goto fallback;
-
-		for_each_cpu(cpu, mask)
-			qmap->mq_map[cpu] = qmap->queue_offset + queue;
-	}
-
-	return 0;
-fallback:
-	return blk_mq_map_queues(qmap);
-}
-EXPORT_SYMBOL_GPL(blk_mq_virtio_map_queues);
diff --git a/include/linux/blk-mq-virtio.h b/include/linux/blk-mq-virtio.h
index 687ae287e1dc..b3ddb8b6da76 100644
--- a/include/linux/blk-mq-virtio.h
+++ b/include/linux/blk-mq-virtio.h
@@ -1,11 +1,46 @@
 /* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2016 Christoph Hellwig.
+ */
 #ifndef _LINUX_BLK_MQ_VIRTIO_H
 #define _LINUX_BLK_MQ_VIRTIO_H
 
-struct blk_mq_queue_map;
-struct virtio_device;
+#include <linux/blk-mq.h>
+#include <linux/virtio_config.h>
 
-int blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
-		struct virtio_device *vdev, int first_vec);
+/**
+ * blk_mq_virtio_map_queues - provide a default queue mapping for virtio device
+ * @qmap:	CPU to hardware queue map.
+ * @vdev:	virtio device to provide a mapping for.
+ * @first_vec:	first interrupt vectors to use for queues (usually 0)
+ *
+ * This function assumes the virtio device @vdev has at least as many available
+ * interrupt vetors as @set has queues.  It will then queuery the vector
+ * corresponding to each queue for it's affinity mask and built queue mapping
+ * that maps a queue to the CPUs that have irq affinity for the corresponding
+ * vector.
+ */
+static inline int blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
+		struct virtio_device *vdev, int first_vec)
+{
+	const struct cpumask *mask;
+	unsigned int queue, cpu;
+
+	if (!vdev->config->get_vq_affinity)
+		goto fallback;
+
+	for (queue = 0; queue < qmap->nr_queues; queue++) {
+		mask = vdev->config->get_vq_affinity(vdev, first_vec + queue);
+		if (!mask)
+			goto fallback;
+
+		for_each_cpu(cpu, mask)
+			qmap->mq_map[cpu] = qmap->queue_offset + queue;
+	}
+
+	return 0;
+fallback:
+	return blk_mq_map_queues(qmap);
+}
 
 #endif /* _LINUX_BLK_MQ_VIRTIO_H */
-- 
2.25.1.481.gfbce0eb801-goog

