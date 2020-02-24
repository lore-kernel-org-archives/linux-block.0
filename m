Return-Path: <SRS0=9TSA=4M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F46C34050
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 23:22:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0228021556
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 23:22:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L/QD2NWl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728602AbgBXXWQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:22:16 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:39199 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728601AbgBXXWP (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 18:22:15 -0500
Received: by mail-lf1-f68.google.com with SMTP id n30so7318717lfh.6;
        Mon, 24 Feb 2020 15:22:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0WbwisyovPdHh7n4bXAVF0naVkmF9FhNybnanTU/DvE=;
        b=L/QD2NWlOoATb3n4pe/WkpwegJ+eSQdE69qR5elj74A01FRPVQeTbbZaUvbB2T3aRK
         XeuZrQq2UrK/jCsxi1FENcbGh3gTrieDZSgypUWGCBdPuqhJm7NkSoMFjvaFvvYy+fo5
         CnoJ0e2ldWNZ8Z/wpoPJL64nTzvlNMVhIU9iTWlQR+4WR2u3Mv34U2Q34GkebPyLdeU3
         16ffg4vzu8ajfSJPMmHBr3tWJKObFFiy3PtyaVQ2uhVxmXa0ZQ1zYGMiWYZHQWyobs+u
         iSohkTigTMhiqitHrB/JWg7YD6/Q0ifjNk/uNwghpNGa/pd9p+0o+WEsiD5IN9k0Uyu8
         ePqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0WbwisyovPdHh7n4bXAVF0naVkmF9FhNybnanTU/DvE=;
        b=kGufi6nys0cJMsAU2tQmSLB3iPon5qNhKbUzr6CN2hbvaE1TrivaVCy1VQIMZ6ILCK
         KWjnaFIYT7oqy2iF+yEZnJavq3prdAnKLQzgW7xqyujc4brp2YfU8oa8Ljhi6bEdJl7t
         eIWf9yAZ+Q4luRRY5eSuncM7Y7vzni9mzx/U1dZ5vvp5/JoNnzKhDbkI2b6+eSd7KgVu
         lCuyKtkOIA58L+yL2QK4RdQQDFT5ncY/WxVRbjsuiIVhVgwJIJ0B8IpDSci25QCjcQjz
         EUtbKFQ+o6exGEIu2cVXGlkcbDW0q40fl00hKz87L5RniuSzf2JRkSWQxfp56MogF8t5
         W9oA==
X-Gm-Message-State: APjAAAW4TYekV1ECMXOh3WCUfHpEvRs6slC2ZYxmUwUy0I+P4YAIYOMn
        ACHpAe5DYxTDp2Y69YTFU6s=
X-Google-Smtp-Source: APXvYqxafMZRO9DsBweskGBjWJG4F055WbsYEBgXwBngwRHxDKevzJcykEixDVZfgY/3AbhgNCtnqA==
X-Received: by 2002:ac2:5106:: with SMTP id q6mr12758402lfb.54.1582586532904;
        Mon, 24 Feb 2020 15:22:12 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id r10sm8154071ljk.9.2020.02.24.15.22.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 15:22:12 -0800 (PST)
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
Subject: [PATCH v1 2/3] mmc: block: Add mmc_bdev_to_card() helper
Date:   Tue, 25 Feb 2020 02:18:40 +0300
Message-Id: <20200224231841.26550-3-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200224231841.26550-1-digetx@gmail.com>
References: <20200224231841.26550-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NVIDIA Tegra Partition Table takes into account MMC card's BOOT_SIZE_MULT
parameter, and thus, the partition parser needs to retrieve that EXT_CSD
value from the block device. This patch introduces new helper which takes
block device for the input argument and returns corresponding MMC card.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/core/block.c | 14 ++++++++++++++
 include/linux/mmc/card.h |  3 +++
 2 files changed, 17 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 663d87924e5e..5d853450c764 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -301,6 +301,20 @@ static ssize_t force_ro_store(struct device *dev, struct device_attribute *attr,
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
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index 90b1d83ce675..daccb0cc25f8 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -7,6 +7,7 @@
 #ifndef LINUX_MMC_CARD_H
 #define LINUX_MMC_CARD_H
 
+#include <linux/blkdev.h>
 #include <linux/device.h>
 #include <linux/mod_devicetable.h>
 
@@ -324,4 +325,6 @@ bool mmc_card_is_blockaddr(struct mmc_card *card);
 #define mmc_card_sd(c)		((c)->type == MMC_TYPE_SD)
 #define mmc_card_sdio(c)	((c)->type == MMC_TYPE_SDIO)
 
+struct mmc_card *mmc_bdev_to_card(struct block_device *bdev);
+
 #endif /* LINUX_MMC_CARD_H */
-- 
2.24.0

