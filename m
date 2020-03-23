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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A63DC54FD0
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 028992076E
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:36:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hnxrr2z1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgCWQgF (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:36:05 -0400
Received: from mail-lj1-f196.google.com ([209.85.208.196]:44769 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727646AbgCWQfo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 12:35:44 -0400
Received: by mail-lj1-f196.google.com with SMTP id w4so15289435lji.11;
        Mon, 23 Mar 2020 09:35:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MD6xGZ4xORI+tNtNZZDwyKjUfBMMQlzk74IcvklWY7A=;
        b=hnxrr2z14XgP3gYDZJf1VnWxpBTjP+LA97XCUK7xTr7Cya02gHwDGMsxt+If5NdrZG
         UFANZiVW2p7/l9DtPiu7w2o5/4m0USqs4MvPhYLO/M6qyQCsvncX+mCg2dZJFricfchL
         LWXeq7O1PG41a+mE9bqcnWyWjxopRLzYDTmkQkHDVIhID7yF6vPKXcF/Jlc/pWCFx899
         kgJfkQsWJCUpGfL/wuRLooRukLDrkBykqF+mAK9BHwzRb7lcwczsy8wyPN5IblZ9glyn
         msn0ZsQ0IAyK6VLYikcsjcHzX5lbY5z/Qr9UYPtn2eYcTzXqY0U4a5TLJZ1wb32XN0xj
         t1CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MD6xGZ4xORI+tNtNZZDwyKjUfBMMQlzk74IcvklWY7A=;
        b=XPqHakrbvNvyc4Xzzs1D7/RLewpT6x91Pe9+BcFS8kRXb4meB538opmT+HIltZyjnv
         JuhitmE6QslC2cyZmeufVTAV2b4UJSFtoMKwqF+ibsLndiWXWsmU/yEuyNJEnudOx8p4
         t1SWNJ+4+rblAWqoRyKrzUpjibkMjHAx3ZLzElTQioLjvZCGKv3OXai34VgQlEdrhAnc
         q3Wbx6MMKELL47C/DnSkYqQ3sF/jQlv0g4T83I85cjzr1Ui8dQbhcdZE0FHRkXV7Qhkr
         kEspxXor0tlahJq1M1adF32yrWBkv+uxf0YzBfhWbRdVt7hEf7XcQdY2cIvzstXSBOHZ
         u1QA==
X-Gm-Message-State: ANhLgQ19YwL2mKTJO7hixJUT9ru/xk15P0fglW+LAh9/VUepcoRviInz
        Qr9uhz9np5H3A4+tgrH3ZQw=
X-Google-Smtp-Source: ADFU+vuiTGI7tGqS5jeAw/PSMsEFiIhB8ZSLCL1XV0mlcTGg0/REiOy/H7BcJXDm+lBefKsMAZkh1w==
X-Received: by 2002:a2e:9017:: with SMTP id h23mr14685724ljg.144.1584981341741;
        Mon, 23 Mar 2020 09:35:41 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id m14sm4820017lfo.25.2020.03.23.09.35.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:35:41 -0700 (PDT)
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
Subject: [PATCH v3 07/10] mmc: block: Add MMC_QUIRK_RESCAN_MAIN_BLKDEV
Date:   Mon, 23 Mar 2020 19:34:28 +0300
Message-Id: <20200323163431.7678-8-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323163431.7678-1-digetx@gmail.com>
References: <20200323163431.7678-1-digetx@gmail.com>
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

