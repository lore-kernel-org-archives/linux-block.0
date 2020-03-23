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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9211BC54FCF
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:36:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6821C20658
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:36:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ef2iJrYZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727559AbgCWQfi (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:35:38 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:43043 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727501AbgCWQfh (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 12:35:37 -0400
Received: by mail-lj1-f194.google.com with SMTP id g27so6507091ljn.10;
        Mon, 23 Mar 2020 09:35:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/RLSJi41laq14R6Fyebh+5anpy5ZQa7HSMlFcMs1a5Q=;
        b=Ef2iJrYZ+VqQJlD1zunGiT/ix1DJWcis4iUic1fpS0zjbCF80XLwo0IiyF1Z2/Ntda
         78hsveibseERJXNdYfFw9SriyYlwhJ9hB6MGCcV9DTpLVPMUoq9nkgDu084n0yKLbSbn
         6K1B2Yd0aS6y7oZasQYkMF9iCfk8vXvkSqfcKbOb+qCabAWwdLn6zm6Im4BI8ZfsyHBV
         Jh1tx4l7LF0PaaR1JnWkefwDgfl2rGNwF/udhV//n4gWC3qj8YyQ9ANZwCquKSn7HSi/
         a0okrLpe11tagutRMVuV5magv8FsvxyFEILlHAYLt/ddsgSyjzaga85S58bWGCk0BZLE
         RcFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/RLSJi41laq14R6Fyebh+5anpy5ZQa7HSMlFcMs1a5Q=;
        b=ecgBaFZQ8H4NidVfYYSpQt0WNk3knJ/+a0c0pvqg4FIB5c4qRYMqTjK0fXHnioAFWs
         26StF5CPANCYiu2LSBgvbtfw651XpPwh9GUIgg2/rKZlNINHm4K9cek9p7Aaqww12Khb
         wnKOXKodH41BdmGvTWIz+1H0oS8zrKqQFRIZovo78sVEFGvZGpPTM+prH8Bj/6p1eJxu
         7PfYMj7hgHpSSGS6aaiFisVMZN4JNtnOuQJHAgRTeL6OIm3mm47H5X+5HPt2zMxnOl2k
         wtsnoyq24vHtGYl9PnUsQ1MIXgkVSjo/injF6Gw0KlKbDCSr+SHVh8Koz2CjODK+oiKz
         RtEg==
X-Gm-Message-State: ANhLgQ1ucqbzlaP0/GTofKnGUDrHr1C/58TvXhrvWO8eOC44TbxrBraN
        2t3rqv53Lht8nkjlH0gJIJI=
X-Google-Smtp-Source: ADFU+vu8aPwBt+XKez2hsewcNmJHhffh+1MzKUMzZ6fo5sv1njcxQEgPBpIYBy3JVQIe8XKAU8uhiA==
X-Received: by 2002:a2e:7a0f:: with SMTP id v15mr14770161ljc.156.1584981334413;
        Mon, 23 Mar 2020 09:35:34 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id m14sm4820017lfo.25.2020.03.23.09.35.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:35:33 -0700 (PDT)
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
Subject: [PATCH v3 01/10] mmc: core: Add raw_boot_mult field to mmc_ext_csd
Date:   Mon, 23 Mar 2020 19:34:22 +0300
Message-Id: <20200323163431.7678-2-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323163431.7678-1-digetx@gmail.com>
References: <20200323163431.7678-1-digetx@gmail.com>
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
index de94fbe629bd..4b7261fbc332 100644
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

