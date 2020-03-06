Return-Path: <SRS0=yWSg=4X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F412DC3F2D9
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CDABB2073D
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:13:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GCoNJHXM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726968AbgCFCNG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:13:06 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:46486 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726915AbgCFCNE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 21:13:04 -0500
Received: by mail-lf1-f68.google.com with SMTP id v6so559696lfo.13;
        Thu, 05 Mar 2020 18:13:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWAeNpBn6fpU/PQ3w5gvOGDJx2Ia8b1U9luMqpJSJvQ=;
        b=GCoNJHXMgArvxZ2kM/SXnSPoe6CuzS1zwwvfEYI1KlFYLoorrkITULJUx3Bh9GbnRX
         VIRRkVVr7K9gbsfOJswpMD6cS20enbneC52QYoovNurXUspOU/zpy3asyICNHQ1ArnVB
         fSBXH3nwDbRCJLt+hq9KcomdYHcWTkThHIKiugDQOvkTSmecJgx2a3mbNx2CrhYXnl76
         Bo/wWyDdQY2WTxgi/sAGjsQRRw8W/2ERuIUMiFcYZBPPD3egIen+S1TjNkjTFvYpOcD+
         Xav6wj7i0tGs4vmtA7Wt9Wz9/5U94HQQb44WriLSfgMqV/LubpewdG5Emy+RmwRK8eUC
         0YxQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWAeNpBn6fpU/PQ3w5gvOGDJx2Ia8b1U9luMqpJSJvQ=;
        b=MtrofvkbVKly0gah2Z5vp1HKxq0Wc+2bOVA/SRV1t6OnnuZ9ikN25FYFB9BGzk1vJx
         xQH3kdiOa79dKe0SGyvu418CGiy0fojKPZrkKqA50mHHB0Vrm7OZmltmIXcrrR3/3DRD
         ubI0sHSEZ33V8j/nokMDu9nSlQy1047HxUyUkyX0ctCEKKPCIv7XYqNnvHQBr7SoXNu/
         3FB5h2tcHW5Xl6f6Uk7UCu02XJhaCBslh9DLSaCkFeCdXFrGW1js3RL/DwgWD1YcJ7aX
         sM3aTWmQUcwgoNl2WHiqPKg92iluNdTa0opPF+lynQNXl/a9i5OJD/X40/EXsU0rzZ1c
         02Ww==
X-Gm-Message-State: ANhLgQ1GOXE0oEbAUkImTfEWTsA9SZ/99dF8jQYa4Fe4W8llVwsZFxoX
        /MvXsrJugPUIa2QMpKTv/QU=
X-Google-Smtp-Source: ADFU+vsi8TcyLKDcJbRMBaRh8lMXYw471TYJmJyUORBjo/b50BvSewNmK3EH0JfzbLyyIuq3k9qLVA==
X-Received: by 2002:a05:6512:3044:: with SMTP id b4mr435202lfb.10.1583460780575;
        Thu, 05 Mar 2020 18:13:00 -0800 (PST)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id l11sm10592772lfg.87.2020.03.05.18.12.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 18:13:00 -0800 (PST)
From:   Dmitry Osipenko <digetx@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        David Heidelberg <david@ixit.cz>,
        Peter Geis <pgwipeout@gmail.com>,
        Stephen Warren <swarren@wwwdotorg.org>,
        Nicolas Chauvet <kwizart@gmail.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Billy Laws <blaws05@gmail.com>
Cc:     linux-tegra@vger.kernel.org, linux-block@vger.kernel.org,
        Andrey Danin <danindrey@mail.ru>,
        Gilles Grandou <gilles@grandou.net>,
        Ryan Grachek <ryan@edited.us>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/8] mmc: block: Add mmc_bdev_to_card() helper
Date:   Fri,  6 Mar 2020 05:12:14 +0300
Message-Id: <20200306021220.22097-3-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306021220.22097-1-digetx@gmail.com>
References: <20200306021220.22097-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NVIDIA Tegra Partition Table takes into account MMC card's BOOT_SIZE_MULT
parameter, and thus, the partition parser needs to retrieve that EXT_CSD
value from the block device. There are also some other parts of struct
mmc_card that are needed for the partition parser in order to calculate
the eMMC offset and verify different things. This patch introduces new
helper which takes block device for the input argument and returns the
corresponding MMC card.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/core/block.c   | 15 +++++++++++++++
 include/linux/mmc/blkdev.h | 13 +++++++++++++
 2 files changed, 28 insertions(+)
 create mode 100644 include/linux/mmc/blkdev.h

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 7634894df853..36d84a8e182c 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -40,6 +40,7 @@
 #include <linux/debugfs.h>
 
 #include <linux/mmc/ioctl.h>
+#include <linux/mmc/blkdev.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
 #include <linux/mmc/mmc.h>
@@ -306,6 +307,20 @@ static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
 	return ret;
 }
 
+struct mmc_card *mmc_bdev_to_card(struct block_device *bdev)
+{
+	struct mmc_blk_data *md;
+
+	if (bdev->bd_disk->major != MMC_BLOCK_MAJOR)
+		return NULL;
+
+	md = mmc_blk_get(bdev->bd_disk);
+	if (!md)
+		return NULL;
+
+	return md->queue.card;
+}
+
 static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
 {
 	struct mmc_blk_data *md = mmc_blk_get(bdev->bd_disk);
diff --git a/include/linux/mmc/blkdev.h b/include/linux/mmc/blkdev.h
new file mode 100644
index 000000000000..67608c58de70
--- /dev/null
+++ b/include/linux/mmc/blkdev.h
@@ -0,0 +1,13 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ *  linux/include/linux/mmc/blkdev.h
+ */
+#ifndef LINUX_MMC_BLOCK_DEVICE_H
+#define LINUX_MMC_BLOCK_DEVICE_H
+
+struct block_device;
+struct mmc_card;
+
+struct mmc_card *mmc_bdev_to_card(struct block_device *bdev);
+
+#endif /* LINUX_MMC_BLOCK_DEVICE_H */
-- 
2.25.1

