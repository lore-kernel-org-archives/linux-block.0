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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DC38C3F2D8
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:13:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16D74207FD
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:13:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BrQ3TxdT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726766AbgCFCNX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:13:23 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:33239 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726957AbgCFCNI (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 21:13:08 -0500
Received: by mail-lf1-f65.google.com with SMTP id c20so630224lfb.0;
        Thu, 05 Mar 2020 18:13:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MD6xGZ4xORI+tNtNZZDwyKjUfBMMQlzk74IcvklWY7A=;
        b=BrQ3TxdTprBb4eSSxaLqFHnbM/+U/tPxgTJ0glnciTf2irzC04pjVRWt7vvn4hbJqz
         R4F6J6rcZ7+l+ykEC+mQ3kO+Q3CoD6BxRy5tdG+YJYtrC3FOTCGkAF1WHNv/MXaqYpE6
         VhE4e63Mrgm5Mtkfc69IJf9BRDMbRwN7RiM8jYSgA4+exS4J9/lb1RdC7JOe6oAj0b3X
         O+PPZl4Dccgdc63LBnCBlkjQN6oquHz6yX0hJGkPAy1XB+L0dF+oiWnH5UFLDwRpTc4m
         g0WGUL8HBLYuLueiE8jA2FyCiWw17MvCexPCeywvHs8B0tPYFjiStQZEuadWjYdBnW2R
         nOCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MD6xGZ4xORI+tNtNZZDwyKjUfBMMQlzk74IcvklWY7A=;
        b=GyYC1LiWJttDATKZbSfKPi4Rs1yVq+hjf21xhfRxOG5uLCUgYbbYxPw0aKaobIHNoT
         vWq9FbZXZKLzjCs6LVuNJx0aKmBc5PhbeswkIkIB6iTWukyZaMvtbUx8y/d7KK04YKpq
         FX7BPby1bMddElQEKxm048RY1Qd/+HXHCc0M07AaRiyfzCkqEaysjx8l74Dc13SVV1mw
         QZI4kZDqG64oEGnB7wBpIeat8RR0RkxXJSCeh77I5Wi1qvZx2oTK8pwTkOrUixBg3Tk9
         AulSTpkG+JJ/WRLTxlgxOTh8sPyF/lF7TxNinL+kgElG400/mIQjCYIlHrGVpSmsV1a/
         1Xpg==
X-Gm-Message-State: ANhLgQ0kHH3abbh/zmfHm7DGJn4OqI3OvlZgN+uyu5v9NxcF/cgAP/oP
        K82or6v7RvVa86mUwhOWtEk=
X-Google-Smtp-Source: ADFU+vveYHEwu/jjmm9qd6Po2zGPfAIH8wer39yJagxuJWLIFc8zFnHZhdGONFQQjYKpeMQxDY9Fcg==
X-Received: by 2002:a05:6512:203c:: with SMTP id s28mr404120lfs.117.1583460785364;
        Thu, 05 Mar 2020 18:13:05 -0800 (PST)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id l11sm10592772lfg.87.2020.03.05.18.13.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 18:13:04 -0800 (PST)
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
Subject: [PATCH v2 6/8] mmc: block: Add MMC_QUIRK_RESCAN_MAIN_BLKDEV
Date:   Fri,  6 Mar 2020 05:12:18 +0300
Message-Id: <20200306021220.22097-7-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306021220.22097-1-digetx@gmail.com>
References: <20200306021220.22097-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NVIDIA Tegra Partition Table location isn't restricted by the main eMMC
partition. This patch introduces new MMC-card quirk which is needed by
some NVIDIA Tegra devices in order to set up partition table if it is
stored on a eMMC boot partition.

The tegra-partition parser will read out FS partition table from the eMMC
boot partition and stash it for the main eMMC partition. In this case
block device of the main eMMC partition needs to be re-scanned in order
to assign the stashed partition table to the main MMC block device by
tegra-partition parser.

This patch adds new MMC card flag that is applied by tegra-partition
parser to the scanned MMC card if partition table is found on a boot
eMMC partition. This flag tells MMC_BLOCK core that main MMC partition
needs to be re-scanned once all block devices of the MMC card are
instantiated.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/core/block.c | 31 +++++++++++++++++++++++++++++++
 include/linux/mmc/card.h |  1 +
 2 files changed, 32 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index ec69b613ee92..2c2bec114fd6 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2955,6 +2955,27 @@ static void mmc_blk_remove_debugfs(struct mmc_card *card,
 
 #endif /* CONFIG_DEBUG_FS */
 
+static int mmc_blk_rescan_disk(struct mmc_blk_data *md)
+{
+	struct block_device *bdev;
+
+	bdev = blkdev_get_by_dev(disk_devt(md->disk), FMODE_READ | FMODE_EXCL,
+				 md);
+	if (IS_ERR(bdev)) {
+		pr_err("%s: %s: failed to get block device\n",
+		       __func__, md->disk->disk_name);
+		return PTR_ERR(bdev);
+	}
+
+	mutex_lock(&bdev->bd_mutex);
+	bdev_disk_changed(bdev, false);
+	mutex_unlock(&bdev->bd_mutex);
+
+	blkdev_put(bdev, FMODE_READ | FMODE_EXCL);
+
+	return 0;
+}
+
 static int mmc_blk_probe(struct mmc_card *card)
 {
 	struct mmc_blk_data *md, *part_md;
@@ -2998,6 +3019,16 @@ static int mmc_blk_probe(struct mmc_card *card)
 			goto out;
 	}
 
+	/*
+	 * Quirk for NVIDIA Tegra devices that store FS partition table
+	 * on a boot partition.  Tegra-partition scanner found partition
+	 * table on a boot MMC partition and stashed it for the main MMC
+	 * partition if MMC_QUIRK_RESCAN_MAIN_BLKDEV is set, and thus,
+	 * the main partition needs to be re-scanned.
+	 */
+	if (card->quirks & MMC_QUIRK_RESCAN_MAIN_BLKDEV)
+		mmc_blk_rescan_disk(md);
+
 	/* Add two debugfs entries */
 	mmc_blk_add_debugfs(card, md);
 
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 90b1d83ce675..550d50e57cc4 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -270,6 +270,7 @@ struct mmc_card {
 #define MMC_QUIRK_BROKEN_IRQ_POLLING	(1<<11)	/* Polling SDIO_CCCR_INTx could create a fake interrupt */
 #define MMC_QUIRK_TRIM_BROKEN	(1<<12)		/* Skip trim */
 #define MMC_QUIRK_BROKEN_HPI	(1<<13)		/* Disable broken HPI support */
+#define MMC_QUIRK_RESCAN_MAIN_BLKDEV	(1<<14)	/* Main partition needs to be re-scanned after instantiating all partitions */
 
 	bool			reenable_cmdq;	/* Re-enable Command Queue */
 
-- 
2.25.1

