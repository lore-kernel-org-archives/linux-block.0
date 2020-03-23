Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9EDF5C54EEB
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 763E920658
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CyNyeMKW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727659AbgCWQfo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:35:44 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43052 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727507AbgCWQfm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 12:35:42 -0400
Received: by mail-lj1-f194.google.com with SMTP id g27so6507421ljn.10;
        Mon, 23 Mar 2020 09:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=w0YlAmpluZ5D3NO8kHqv749YNcVtvXYMv+8BYDY6gX8=;
        b=CyNyeMKW8PFLFOs7Bf7yjiDE4vIvnA+m7J9nEYRxdr+Gx1hmxopSIb5ynvJR2d9yYu
         FYzHnpeLwnV7RWIcWnXZnyTP+PsSoYJ5rbQjBQ5kWKyzAeJgpJ8yjaureGlZGmefXBvh
         EY+bpzSo2CeGLmzEfaVHgMJ9F/SalVmxfsm+vZouSgpfMu8I0HWYpK9c4dNMlk60iH2S
         p/AnZlnl3PKdLdg1R6EfJiBS3XoSqkrtGMqe7AqPuh+JxJRNEkEe7UvpTE3HrtLrgJZI
         sSWP/L9WQstfoR8glEAbL3+37AIMouj+vfXg5vc0e56Ltz+1BPzomgmMYe1cEv57J2Ap
         4frA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=w0YlAmpluZ5D3NO8kHqv749YNcVtvXYMv+8BYDY6gX8=;
        b=Hb51vSoE5wnThK8bahflY4zf+i67/F8c9U88AQsl4zr50tR7sfBB63LfXkDkKtKJ21
         1CY8fyH56PEKd7EeAgWmOzS3HfYLv/dG2c4qU/l+Yiu/Je3GkQYbOA8e/Mnb9Nyhq/LZ
         cRaiSf3edZWLpWmSnqmcgePLdie5BJecOHjPptIV/IuhWba5jecIbSsw7L7Ir80Undo+
         /QwazAYRfN5dMAhD/6Swvu8S1B2LUR+CZHo1hUQo+6HK/CbBbcVxMcnOXALoldxnPvHN
         BR5fmR+MIY/+OCDbYKkOYhNDcfQ/4x6dRyOsVBIxUYdy6QQqSvZHyxXY1jjeHWxjD6TS
         EKuw==
X-Gm-Message-State: ANhLgQ2V88b/V4OCIlEVOYRxMZZ5NJCE+38nuEjy0PMn56sz5ULkius+
        m1W5yxI04BIMSRjqtoRk6ik=
X-Google-Smtp-Source: ADFU+vuaNbeMeWKlKJCFpCe6dFW/Y2Ycr+EGB6ZeJQNghi8JRS+awpjDqrGdi02SL38G0Vf4wvZl5w==
X-Received: by 2002:a2e:984d:: with SMTP id e13mr13623932ljj.275.1584981339297;
        Mon, 23 Mar 2020 09:35:39 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id m14sm4820017lfo.25.2020.03.23.09.35.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:35:38 -0700 (PDT)
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
Subject: [PATCH v3 05/10] mmc: block: Add mmc_bdev_to_part_type() helper
Date:   Mon, 23 Mar 2020 19:34:26 +0300
Message-Id: <20200323163431.7678-6-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323163431.7678-1-digetx@gmail.com>
References: <20200323163431.7678-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

NVIDIA Tegra Partition Table parser needs to know eMMC boot partition ID
that is associated with the block device in order to validate and parse
partition table properly. This patch adds new mmc_bdev_to_part_type()
helper which takes block device for the input and returns a corresponding
MMC card partition ID (part_type).

This is needed by tegra-partition parser in order to distinguish boot0
eMMC partition from boot1.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/core/block.c   | 16 ++++++++++++++++
 include/linux/mmc/blkdev.h |  1 +
 2 files changed, 17 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 36d84a8e182c..2cee57c7388d 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -321,6 +321,22 @@ struct mmc_card *mmc_bdev_to_card(struct block_device *bdev)
 	return md->queue.card;
 }
 
+int mmc_bdev_to_part_type(struct block_device *bdev)
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
+	return md->part_type;
+}
+
 static int mmc_blk_open(struct block_device *bdev, fmode_t mode)
 {
 	struct mmc_blk_data *md = mmc_blk_get(bdev->bd_disk);
diff --git a/include/linux/mmc/blkdev.h b/include/linux/mmc/blkdev.h
index 67608c58de70..24e73ac02b4b 100644
--- a/include/linux/mmc/blkdev.h
+++ b/include/linux/mmc/blkdev.h
@@ -9,5 +9,6 @@ struct block_device;
 struct mmc_card;
 
 struct mmc_card *mmc_bdev_to_card(struct block_device *bdev);
+int mmc_bdev_to_part_type(struct block_device *bdev);
 
 #endif /* LINUX_MMC_BLOCK_DEVICE_H */
-- 
2.25.1

