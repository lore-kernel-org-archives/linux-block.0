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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B5EEC3F2D1
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:13:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D89DE20848
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:13:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jx7+ypvb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727018AbgCFCNH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:13:07 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:36514 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726490AbgCFCNG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 21:13:06 -0500
Received: by mail-lf1-f66.google.com with SMTP id s1so610702lfd.3;
        Thu, 05 Mar 2020 18:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YN6wlr+SxSHAMt4dIT8x49SccG7CxZ44xau7TZEGR7U=;
        b=Jx7+ypvbC80brAY/Gha594a/i/lBbvNebyh9jVnMeiq4NZ0467KVdUQQbUlcBMgq+E
         HvN2WEwpZD+UNr9EUJwxcT3O1+0uIASmmGmz0mFpxy+9K4PY4udqTIciQ/pdj4oUL64r
         yNIvhBU+SIa6dXMFV7Sm5wukgH95gp3hizlZIT4Tz8meBVMv7nr2jaS7DirywMhzxyKQ
         JE3MBpS8HIWdEdg05hCFFtn5CHp7bRkXhHLMH5/txcQl6TRg8C6OvLmp0L+B5dYGhYvN
         YDXgzajsH+OK/k1qI29x53wtaKwNBBgPqqRUNN9C76uVPLUUqf3DLWpooHE55TdBVqwe
         veHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YN6wlr+SxSHAMt4dIT8x49SccG7CxZ44xau7TZEGR7U=;
        b=B9bE9BNxChwES5QzNRm8Ulhkk4N/EExF+5GLQpslt+4MlgYdQfKWnuhigzXAl3WUvT
         qNHEeKvvEH9NtQXmTs8u2OrEaMOJfppGxJ32zyCZBHVacGm14upZMxQX9Cx3ak3lRYHD
         BPDxHjuHjVzLv2hNWvBEuLeXMrTXlqhWTGp+sapvTbnTgvi2V+4Hc96Cvs3rKhJkf8xi
         tPcZx+zZa8Yp5zsnSWD6lf60JyhHniO78xDBxUU+SS6WsxeB2D/H8iURBUTdTUPdEpVX
         9Y5MrQm+cMK3YKKMw2oGVre5xh8K6+20jDB8TcMjQQ1Q6ppX7U61tL1DlMvi3Kgo8e7x
         wgDA==
X-Gm-Message-State: ANhLgQ2SY1fTAeSyIrkyKuDfDNgOYw/NtPFV1qzJDgO1ylcPoz7zgs6O
        F29wPl3oirwx7ZyKQ62tXQ4=
X-Google-Smtp-Source: ADFU+vvTceBXi8aJvLfj04kqqObBlzYK7DQWM7JZXu8umtbwBSvF3gK3rosGoh7gVG/pUB+B4TF52w==
X-Received: by 2002:ac2:4199:: with SMTP id z25mr416158lfh.90.1583460784112;
        Thu, 05 Mar 2020 18:13:04 -0800 (PST)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id l11sm10592772lfg.87.2020.03.05.18.13.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 18:13:03 -0800 (PST)
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
Subject: [PATCH v2 5/8] mmc: block: Add mmc_bdev_to_area_type() helper
Date:   Fri,  6 Mar 2020 05:12:17 +0300
Message-Id: <20200306021220.22097-6-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306021220.22097-1-digetx@gmail.com>
References: <20200306021220.22097-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NVIDIA Tegra Partition Table parser needs to know eMMC partition type
in order to validate and parse partition table properly. This patch adds
new mmc_bdev_to_area_type() helper which takes block device for the input
and returns a corresponding MMC card partition type.

This allows tegra-partition parser to distinguish boot eMMC partition from
the main eMMC partition.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/core/block.c   | 16 ++++++++++++++++
 include/linux/mmc/blkdev.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2cee57c7388d..ec69b613ee92 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -337,6 +337,22 @@ int mmc_bdev_to_part_type(struct block_device *bdev)
 	return md->part_type;
 }
 
+int mmc_bdev_to_area_type(struct block_device *bdev)
+{
+	struct mmc_blk_data *md;
+	struct mmc_card *card;
+
+	card = mmc_bdev_to_card(bdev);
+	if (!card)
+		return -EINVAL;
+
+	md = mmc_blk_get(bdev->bd_disk);
+	if (!md)
+		return -EINVAL;
+
+	return md->area_type;
+}
+
 static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
 {
 	struct mmc_blk_data *md = mmc_blk_get(bdev->bd_disk);
diff --git a/include/linux/mmc/blkdev.h b/include/linux/mmc/blkdev.h
index 24e73ac02b4b..5fa5ef35ac25 100644
--- a/include/linux/mmc/blkdev.h
+++ b/include/linux/mmc/blkdev.h
@@ -10,5 +10,6 @@ struct mmc_card;
 
 struct mmc_card *mmc_bdev_to_card(struct block_device *bdev);
 int mmc_bdev_to_part_type(struct block_device *bdev);
+int mmc_bdev_to_area_type(struct block_device *bdev);
 
 #endif /* LINUX_MMC_BLOCK_DEVICE_H */
-- 
2.25.1

