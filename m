Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF080C54FCE
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C485F20658
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tIuzq/gr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727581AbgCWQfj (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:35:39 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:45931 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbgCWQfi (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 12:35:38 -0400
Received: by mail-lf1-f66.google.com with SMTP id v4so7067600lfo.12;
        Mon, 23 Mar 2020 09:35:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=kWAeNpBn6fpU/PQ3w5gvOGDJx2Ia8b1U9luMqpJSJvQ=;
        b=tIuzq/gr6LMfw5IhTrkX52zxdsdrWBcVd++BnjQqbifbF/uTfnv3vU/uWT5GolNcGv
         fzIP6Xj8xKWfGM/c7axoGJBIG2hJJUV3PdBR/SamU9FuWO25HSXAOxPI6xDcHtUIdjS1
         F6uLuPUQuP7b+zPugUhBWFGus7uAhAp1Iac4T7BpEU1Fngb/fuyE+C6YTXyRVDcdJYQQ
         Jv2pU5fKWmWJa4dFyDBdf3k5GR+b+KVG2V4n6iSyvYsGtZNXm1sJxmdTUSZu5cMgQPVv
         N7EjQhHhyBKZYKEiQ8gvUfdQnle1abEBG6SW5xmv6PS/7VLg68ZHaHlqADSpB+rHxfOD
         ufBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kWAeNpBn6fpU/PQ3w5gvOGDJx2Ia8b1U9luMqpJSJvQ=;
        b=H7Ey5JYaizluCPShEZyGSeWE5pX/vYDbmOYIkaFgZ1vVOwCR6dk1GqbXrWLhBrhW2Y
         8z575xNx2ywJoHNtk9/O0oPNDgXR0/fEzBv7NdPo85OXE91ewwhLjlQrgZZ8UuFw65ib
         FJH+A/PHhr+qSIrMXBwNmqmxlUYbxLddu+FZsvGXqEreZgn6kJzmbK7M+BItkUMf2opj
         OoPb4ukR+EMo0VdpDzYE7dKqGlazabOrDnB2pAFoU0dpB3/FdTphx4ZSeKeWh0eYnpFc
         6ICae/LYsEHLEQvAvjOF6XZNXsk7CJ5dELGxm0GqqdixQYMF15BimtynN5bz5gljkkFk
         luzw==
X-Gm-Message-State: ANhLgQ0M4RMYeifgfD+xhL0V+tWMO49Ro0XxFRLe0ErLKn89vcYTGNV5
        cPKmdvOC8f4xYs3EA4XscLsTgnSu
X-Google-Smtp-Source: ADFU+vuS8o+ndODomWoUKADlFVTMveigNiAwppJWlBrao3k3C+IGzWVzvm8Hl+ovIgarsZgVtWqVAA==
X-Received: by 2002:ac2:4c33:: with SMTP id u19mr13431354lfq.195.1584981335547;
        Mon, 23 Mar 2020 09:35:35 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id m14sm4820017lfo.25.2020.03.23.09.35.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:35:35 -0700 (PDT)
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
Subject: [PATCH v3 02/10] mmc: block: Add mmc_bdev_to_card() helper
Date:   Mon, 23 Mar 2020 19:34:23 +0300
Message-Id: <20200323163431.7678-3-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323163431.7678-1-digetx@gmail.com>
References: <20200323163431.7678-1-digetx@gmail.com>
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

