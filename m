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
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCA77C34031
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 23:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 904CB21556
	for <linux-block@archiver.kernel.org>; Mon, 24 Feb 2020 23:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ym7vmmJ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728614AbgBXXWQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 24 Feb 2020 18:22:16 -0500
Received: from mail-lf1-f66.google.com ([209.85.167.66]:34453 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728575AbgBXXWO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 24 Feb 2020 18:22:14 -0500
Received: by mail-lf1-f66.google.com with SMTP id l18so8158391lfc.1;
        Mon, 24 Feb 2020 15:22:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=IXpxfmvhilbP5WN8bob/AjAFkA/qj/3CPWSZIMs8z6Y=;
        b=Ym7vmmJ8qm8gK+2Wxoy8RGjsVbKgIlH7iMYNXINa2EFe43TOaXnBG18SB9AHqArHOo
         fFhQH2ZoVcEBKpGEFhX9q/wjwN9YPd6zHoGXpF/oi01ScsWeZrlrX1oi5yCLP17x0esH
         bNavvx1gQSaFZAzD5fUdhzOJ4kVYtZOu8zek/VAebKS3l3C+GQ0HoW/mxw2xGepJpvSL
         dizegdTK9KrZb0Ny5dYc+uNxepw5eGi3n/lpgaluCjGMcAxqSyP7fLLYn2qVso5xYdlO
         Kg4TtDu5K5owsT66DkGz8bj20rhJDGPmIK2AI8E5zdCfQmJJCPJPMeTfhYmnG0jKDXuM
         lwYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IXpxfmvhilbP5WN8bob/AjAFkA/qj/3CPWSZIMs8z6Y=;
        b=Rqd/tEUT2E/gEQZ7H9hiQgWEnUBg8pifqluDETCU6xhy8HxVe9cKoUI5LEwe80U24i
         ShRMf0JDr3rjahYdCojCxpOWvdTHv/Ersm+RKRtKxq5/WA1NOjsnYF3UX6aF8kONwubk
         cm+3+9MiXVzx4wmlVbP1BXpt9mLcuMwBlukJ9/4zVAyygZHUg1mQLxsgwBrXUaj/7/1Y
         RSRXlY/2aTsa4s9NZdpa6ySe9F0jstdFNobQ/OUpvDM0mFP4dTwLmhfxIZdmm9EmeNYe
         F/wP9cM9avhsxq1RWF43KoxPySGdTBU34RTj2AIlWaIW5cX9t0pEaRaX5I59VdRUl1gU
         BiAw==
X-Gm-Message-State: APjAAAVerYPur1fRIRuF3XK7MRU3GpWMPs275uQ+zq2XtEUa+JUvSxRX
        hQRYH8pf+NBTxSk8AjOAdBo=
X-Google-Smtp-Source: APXvYqyaSOMVAyYWLg+BwNmlN4ouHZqEywbZFRUw4YU69g0L569SWlhRcuY5w83WQV1G+snAuXD5kg==
X-Received: by 2002:a19:8c4d:: with SMTP id i13mr28756053lfj.42.1582586531784;
        Mon, 24 Feb 2020 15:22:11 -0800 (PST)
Received: from localhost.localdomain (79-139-233-37.dynamic.spd-mgts.ru. [79.139.233.37])
        by smtp.gmail.com with ESMTPSA id r10sm8154071ljk.9.2020.02.24.15.22.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Feb 2020 15:22:11 -0800 (PST)
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
Subject: [PATCH v1 1/3] mmc: core: Add raw_boot_mult field to mmc_ext_csd
Date:   Tue, 25 Feb 2020 02:18:39 +0300
Message-Id: <20200224231841.26550-2-digetx@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20200224231841.26550-1-digetx@gmail.com>
References: <20200224231841.26550-1-digetx@gmail.com>
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
index f6912ded652d..88e5b4224d3c 100644
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
2.24.0

