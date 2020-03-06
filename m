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
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE814C3F2D2
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:13:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 85CB82073D
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:13:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XbnhSUzY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726892AbgCFCNC (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:13:02 -0500
Received: from mail-lf1-f65.google.com ([209.85.167.65]:34888 "EHLO
        mail-lf1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726251AbgCFCNB (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 21:13:01 -0500
Received: by mail-lf1-f65.google.com with SMTP id z9so618922lfa.2;
        Thu, 05 Mar 2020 18:13:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=jejQGCo3/dKT87eFE/c6xAtPYJMhaon/XfB+5DRbZ5Y=;
        b=XbnhSUzYHR6gKBULM08LwL6vsrJQrsf9oWJvekTmLoG56JfN++5jmyVYmwGbX3BvcR
         WLJpE0/DKB4QQVHoX8Bn/aMbM0nUe2Roglgsjj7V1a6GGuxvi7WKtLwZrRIp/Pi2X9Tn
         ZwwGtvo2npzCRAoBf2iWujBXDqI7c5ggt0y+tU50J0n8qZdqtfopyPGqTbOJy2A0ZKFp
         7T0ePdYuqVVPuYJR2hyIbGl1m/Sg68DIcA0hu5duSsqhTTrv5Shp4DHku3FIO+41C8UD
         oqzKIinizHHzgh3KOzZ3p3Yit8g/HjLxaTP29ZL/zqWMQTGKK8Gue5UnWTMeybiOtziS
         /b5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=jejQGCo3/dKT87eFE/c6xAtPYJMhaon/XfB+5DRbZ5Y=;
        b=fgdlfWKCadDhfueRY8fu/FqyaIkyh7vVxiGfyP8JsiLcXCW/Kns7MpvMUBZk9mglzm
         rM6AeNnJgwyVI4Y7hg0xlyI6ejCRqShX+Sei3rUUk6QnHKgWr1LlD1ioQXEyxYJPAF2t
         tTQMP7AJY3KcBHMEOMFYeTlX11T8scCM/z+OPh9r3z7Xlumd7WZbpyEf0KIrB3jZ9hmh
         OZsm2aGBwuQMXBAOb/0xFgkWgMMivPrUjPJYAaGUlopQ1CvCIldHZ199qeArK8V+7OPF
         gTUYfpQYqFwv8WSW4X3w0igwE4Yygwwq7CYgcndOvWf5CNBkvHdTDxe9VxYVTJye0YyB
         g5fg==
X-Gm-Message-State: ANhLgQ3ctWgAMd3+lJMGXM3oXOwurbIaPgrI2ZibL6AWzKxmRxMM/eEn
        bt1uKZsyHE6n5EzwDesTecQ=
X-Google-Smtp-Source: ADFU+vt88u4LrlKWoer2lF5Hftx8VQAQGdpfjKy86Gfc6QoyQP8URDMPI5CTpWsuEfUuNfKeAKCZfQ==
X-Received: by 2002:ac2:555a:: with SMTP id l26mr420092lfk.48.1583460779399;
        Thu, 05 Mar 2020 18:12:59 -0800 (PST)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id l11sm10592772lfg.87.2020.03.05.18.12.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 18:12:58 -0800 (PST)
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
Subject: [PATCH v2 1/8] mmc: core: Add raw_boot_mult field to mmc_ext_csd
Date:   Fri,  6 Mar 2020 05:12:13 +0300
Message-Id: <20200306021220.22097-2-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306021220.22097-1-digetx@gmail.com>
References: <20200306021220.22097-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In order to support parsing of NVIDIA Tegra Partition Table format, we
need to know the BOOT_SIZE_MULT value of the Extended CSD register because
NVIDIA's bootloader linearizes the boot0/boot1/main partitions into a
single virtual space, and thus, all partition addresses are shifted by
the size of boot0 + boot1 partitions.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/core/mmc.c   | 2 ++
 include/linux/mmc/card.h | 1 +
 2 files changed, 3 insertions(+)

diff --git a/drivers/mmc/core/mmc.c b/drivers/mmc/core/mmc.c
index c2abd417a84a..ec91d503bc73 100644
--- a/drivers/mmc/core/mmc.c
+++ b/drivers/mmc/core/mmc.c
@@ -417,6 +417,8 @@ static int mmc_decode_ext_csd(struct mmc_card *card, u8 *ext_csd)
 		ext_csd[EXT_CSD_ERASE_TIMEOUT_MULT];
 	card->ext_csd.raw_hc_erase_grp_size =
 		ext_csd[EXT_CSD_HC_ERASE_GRP_SIZE];
+	card->ext_csd.raw_boot_mult =
+		ext_csd[EXT_CSD_BOOT_MULT];
 	if (card->ext_csd.rev >= 3) {
 		u8 sa_shift = ext_csd[EXT_CSD_S_A_TIMEOUT];
 		card->ext_csd.part_config = ext_csd[EXT_CSD_PART_CONFIG];
diff --git a/include/linux/mmc/card.h b/include/linux/mmc/card.h
index cf3780a6ccc4..90b1d83ce675 100644
--- a/include/linux/mmc/card.h
+++ b/include/linux/mmc/card.h
@@ -108,6 +108,7 @@ struct mmc_ext_csd {
 	u8			raw_hc_erase_gap_size;	/* 221 */
 	u8			raw_erase_timeout_mult;	/* 223 */
 	u8			raw_hc_erase_grp_size;	/* 224 */
+	u8			raw_boot_mult;		/* 226 */
 	u8			raw_sec_trim_mult;	/* 229 */
 	u8			raw_sec_erase_mult;	/* 230 */
 	u8			raw_sec_feature_support;/* 231 */
-- 
2.25.1

