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
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8A88C54FD1
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7EB7520722
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:36:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m2OUE5YV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727678AbgCWQfp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:35:45 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:34998 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727652AbgCWQfo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 12:35:44 -0400
Received: by mail-lj1-f193.google.com with SMTP id u12so15350976ljo.2;
        Mon, 23 Mar 2020 09:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YN6wlr+SxSHAMt4dIT8x49SccG7CxZ44xau7TZEGR7U=;
        b=m2OUE5YVVMVA0++Y1OYwALT15/EvoPyUi4xHb4jj/G033Qc4tP7oVxev1xyzMwCFIZ
         5hMl9UKZI5avvD9l6uIIwTbVwKcpKYBIUCXsNAeWyPH6phcrMsucH7U4i38LY/ZU5/xT
         9YFy3E8Z3OtHJ9h7SqzhAxeYiogxXSkwPFfrskfkBEScQGXWdoIlo12mUcrtLdlDbTVN
         b7PYkiHUBlm42Jt8fe9OpbWBhm54g2bq5MsReESziQNUebeX9bJ9lGQ0Y3Oy7E+nWYTA
         X2m4NYw/DnFWQfo/4HpvU56akoSMquuplCoTUke1FyT7ePQDX2ws1auWkTcp6v/3os82
         ELmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YN6wlr+SxSHAMt4dIT8x49SccG7CxZ44xau7TZEGR7U=;
        b=hyqi4gWyt1797RBvDrzhXBMjSG92/YUcFuVwXDENny6h+YpMtHmksyy3fMNr5Rt/7g
         dkfeXhU2jMmuoYNfTT3shpb0tuAC2vEuiXJRxFZIT+9E3AJKBTU7zdGNStqMnT89Guve
         TRYjTcy+z+YdMurWAu0qXweKKZBp5hJb82b+CDfj0BsXowVBfQZZpv0W1xpW+Ma/2fDc
         ztItvMWLs85GRPEYm3ixTaFQ3bwcoHdDWnQHaVRUNjuONjR60KDXVR2hpfP+l2r4HJrp
         gg1iWU2rX2sVX/xDSM2gyTZHdeUNyecR5ZpCT2LOOUe9OEZhzRZY8VV7wqvEEY8hJ5dl
         6QtQ==
X-Gm-Message-State: ANhLgQ3awCzXmfLFcAY0Qt30vBtK3tJ5/2g6xfnAm8Okb/8TwXFOFYQn
        h2w1kNBEL7PMpmmpEMswHYyOeYNA
X-Google-Smtp-Source: ADFU+vsAVKfLP8wIKNQtB9y9of/X+P2shjDrovtop+vKqr+VzzqMO6JjwELSsjcYxmtIVFjb7DvKvw==
X-Received: by 2002:a2e:b88b:: with SMTP id r11mr14425033ljp.116.1584981340449;
        Mon, 23 Mar 2020 09:35:40 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id m14sm4820017lfo.25.2020.03.23.09.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:35:40 -0700 (PDT)
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
Subject: [PATCH v3 06/10] mmc: block: Add mmc_bdev_to_area_type() helper
Date:   Mon, 23 Mar 2020 19:34:27 +0300
Message-Id: <20200323163431.7678-7-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323163431.7678-1-digetx@gmail.com>
References: <20200323163431.7678-1-digetx@gmail.com>
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

