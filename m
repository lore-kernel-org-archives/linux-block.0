Return-Path: <SRS0=yjA8=5K=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9376EC54FCF
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 15:41:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 70D3F2073E
	for <linux-block@archiver.kernel.org>; Wed, 25 Mar 2020 15:41:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hBtFmJkQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727666AbgCYPlJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 25 Mar 2020 11:41:09 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:40395 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727574AbgCYPlI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 25 Mar 2020 11:41:08 -0400
Received: by mail-pj1-f68.google.com with SMTP id kx8so1150482pjb.5
        for <linux-block@vger.kernel.org>; Wed, 25 Mar 2020 08:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mBBidG6Y7TfUWY0TRstTvAQ/yzpk9Iqr/2Qi4BPsr5Q=;
        b=hBtFmJkQNXPjeUxxFeaef3PIzjwPlb+tCjJ3Ef3XngCFNo++yUbLoDc0NA+H7UCBpu
         97U97pH4/OE5I8hQ5MzA1Vj8nPESrzDfLDyLVhdQN/JyYw3M1orWmrxqPHRBKiAfyvUq
         LE4REpzIi9jjPM2szEvujoS/daFYjoO0EWYmV7KsropAUQOXnSeGXoju1gngPIcXaxQd
         mwivnaMztS8bw0JJ16WdU7XBFyKGNat376r4nJsyRGfmFMspCwp9aVoROHPcBfktaOxC
         TGcJnDVBqrJSiNSmqGEtfxyDiGaxyc8KNfQjutNYQbBYivxrZJC/cTROHzem1mul8rhn
         pdag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mBBidG6Y7TfUWY0TRstTvAQ/yzpk9Iqr/2Qi4BPsr5Q=;
        b=S9vGZVqkkRhJCUBbNU6nalLfkuYvM/r8GqGDeEVeXP+rUYzPgKf5ILL/qRRFbn/2rz
         z51Gzo8bkgyen0HRNfeYO1uWkjCZ5uA33ijgxbvC98357RsywfQS/dguUHHUHmjWoFRt
         RdDRlG+4k5haZ+x0WLTfYVLHI83GX7Vmjtd/7hzCqr7ANTnjja8e95qG7WLhn3Y8cczQ
         rLKAahCPmQCKRXaYZEFktKPYNwkAlkJYvTPkxCt4pnnlRZ0665sPhrsn4lir4U7tYs5R
         A3kRkVJQrMeyxYGQF+Mff6cS2iprxNyMO0dccxRQxzwFuvpdt/B7aty76A+PEh7SIH9t
         861g==
X-Gm-Message-State: ANhLgQ1dv2i2cjEnwF9kvlNGojaLOEJaAm7hXlW/X+HLKQM7w9g3fBDx
        fj4YnjoaYoKRyQw4K2E2cFOdvR7j
X-Google-Smtp-Source: ADFU+vssKCKL6RKvHowkSiDTAQT/VGNaSt2gVQLu8CZDCMiifdi5tVGRGqIX7PC+4jMkiWeeuQcPtQ==
X-Received: by 2002:a17:902:b206:: with SMTP id t6mr3426732plr.75.1585150866746;
        Wed, 25 Mar 2020 08:41:06 -0700 (PDT)
Received: from localhost.localdomain ([240f:34:212d:1:a4cc:83a8:89da:2ff3])
        by smtp.gmail.com with ESMTPSA id z30sm18487376pfq.84.2020.03.25.08.41.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Mar 2020 08:41:05 -0700 (PDT)
From:   Akinobu Mita <akinobu.mita@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Akinobu Mita <akinobu.mita@gmail.com>, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] null_blk: add 'memory_backed' module parameter
Date:   Thu, 26 Mar 2020 00:40:49 +0900
Message-Id: <20200325154049.8856-1-akinobu.mita@gmail.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, the memory_backed feature is only enabled by the null block
device configured through configfs.
This adds module parameter to make device as a memory-backed block device,
and reduces a few steps required to test zonefs with zoned null block
device.

Cc: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Akinobu Mita <akinobu.mita@gmail.com>
---
 Documentation/block/null_blk.rst | 3 +++
 drivers/block/null_blk_main.c    | 5 +++++
 2 files changed, 8 insertions(+)

diff --git a/Documentation/block/null_blk.rst b/Documentation/block/null_blk.rst
index edbbab2f12f8..036970121198 100644
--- a/Documentation/block/null_blk.rst
+++ b/Documentation/block/null_blk.rst
@@ -72,6 +72,9 @@ submit_queues=[1..nr_cpus]: Default: 1
 hw_queue_depth=[0..qdepth]: Default: 64
   The hardware queue depth of the device.
 
+memory_backed=[0/1]: Default: 0
+  Device is a memory-backed or no transfer block device.
+
 Multi-queue specific parameters
 -------------------------------
 
diff --git a/drivers/block/null_blk_main.c b/drivers/block/null_blk_main.c
index 133060431dbd..1ed2ccc5960b 100644
--- a/drivers/block/null_blk_main.c
+++ b/drivers/block/null_blk_main.c
@@ -177,6 +177,10 @@ static int g_hw_queue_depth = 64;
 module_param_named(hw_queue_depth, g_hw_queue_depth, int, 0444);
 MODULE_PARM_DESC(hw_queue_depth, "Queue depth for each hardware queue. Default: 64");
 
+static bool g_memory_backed;
+module_param_named(memory_backed, g_memory_backed, bool, 0444);
+MODULE_PARM_DESC(memory_backed, "Make device as a memory-backed block device. Default: false");
+
 static bool g_use_per_node_hctx;
 module_param_named(use_per_node_hctx, g_use_per_node_hctx, bool, 0444);
 MODULE_PARM_DESC(use_per_node_hctx, "Use per-node allocation for hardware context queues. Default: false");
@@ -551,6 +555,7 @@ static struct nullb_device *null_alloc_dev(void)
 	dev->irqmode = g_irqmode;
 	dev->hw_queue_depth = g_hw_queue_depth;
 	dev->blocking = g_blocking;
+	dev->memory_backed = g_memory_backed;
 	dev->use_per_node_hctx = g_use_per_node_hctx;
 	dev->zoned = g_zoned;
 	dev->zone_size = g_zone_size;
-- 
2.20.1

