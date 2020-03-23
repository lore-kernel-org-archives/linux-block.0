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
	by smtp.lore.kernel.org (Postfix) with ESMTP id D15F1C3F2CD
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:36:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DF320722
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXoD7Lgk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727711AbgCWQfr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:35:47 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:33683 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727671AbgCWQfr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 12:35:47 -0400
Received: by mail-lf1-f68.google.com with SMTP id c20so10785581lfb.0;
        Mon, 23 Mar 2020 09:35:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=PNUW8UPO4mmlNCoO/hi+s09smb8KB9KTLjiOmh4I/TY=;
        b=nXoD7LgkcBotLjD1LYcKthzHM4CbwCYJQbZ2BYwSBm5Bq9t822+sUewc37047Tkz1V
         vRFTmC4e08tfGKjtvADWPXlNic8qOiTheRYIjqeVChCUgG4L0M4hTBg3N1a5IITNWV6A
         2BQOVu29XqqFk6+jafwbJCSuK4nxR0VqQB0SSFXjpv1DT4uLIT0FsJvC4JYH/UfCY7aM
         2VcpLdwrpMnTVWbi9riZWAvq3pnEFleol1W2P+l9SvjpQWysB1QVVxcgG++BbJGeuEjS
         7qVRkUqVn9E8MMVJHMRrmHN1rGU4UjSRI6C76QSy9kDFZ418TQnUv4Z2PHpylzx0kRv3
         p8eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PNUW8UPO4mmlNCoO/hi+s09smb8KB9KTLjiOmh4I/TY=;
        b=N3BTKxCUtGs+/drh/vFrGpkhNkF3KaQkiGTx+aFmblJZXEgcBZACMY6cdpkT8vUBqz
         WsVFf1j6/V2V5sSc0kt/kE+59g99tFIpiSwpJfLhzcLkD6eoOWYQPc+QbUuIgqu1Csxp
         Kg2HE3BDfshdadGVQdUD1wpwuBE6xnYvOvtYtPzfEJs1OAW9gT4SGJWQtiXSFYBtKt94
         KII8hw/gooRZAplLEeGzXzGsyqZykCbqal0G6JPzCI+EVjdJj9XsfLqJmxtMeMgY94NN
         KTxTdjN7bgHywGzJ7zOJVnfiQNgYMCmT4NHJ7iKXaOeQQmMUft5CMIrqYyvGZGJddGKT
         LBBA==
X-Gm-Message-State: ANhLgQ0woiZX9f0wivHunZbx9Rz65Z0/ImdV+b/8U+gvAArbR4fIZ5Y6
        WYbDUlXYyQIQOJT7h9Sls90=
X-Google-Smtp-Source: ADFU+vvY9IK1Nh7xDm+lse/+L4JK9O+uzzO3t7BI36zVpgJ8+9EmUWUJ/vezzXL4quIyV8j5cT/iaw==
X-Received: by 2002:a05:6512:10c4:: with SMTP id k4mr13490533lfg.98.1584981342888;
        Mon, 23 Mar 2020 09:35:42 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id m14sm4820017lfo.25.2020.03.23.09.35.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:35:42 -0700 (PDT)
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
Subject: [PATCH v3 08/10] mmc: block: Support partition-table scanning on boot partitions
Date:   Mon, 23 Mar 2020 19:34:29 +0300
Message-Id: <20200323163431.7678-9-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323163431.7678-1-digetx@gmail.com>
References: <20200323163431.7678-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some NVIDIA Tegra devices store partition table on a boot eMMC partition,
and thus, boot partitions need to be scanned. This patch enables scanning
of the boot MMC partitions, but only if MMC host allows to do that. This
patch adds new scan_mmc_boot_partitions field to the struct MMC host,
which should be set to true by the platform-specific SDHCI drivers if
MMC boot partitions scanning is desired.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 drivers/mmc/core/block.c | 26 ++++++++++++++++++++++++++
 include/linux/mmc/host.h |  2 ++
 2 files changed, 28 insertions(+)

diff --git a/drivers/mmc/core/block.c b/drivers/mmc/core/block.c
index 2c2bec114fd6..d22498bd9968 100644
--- a/drivers/mmc/core/block.c
+++ b/drivers/mmc/core/block.c
@@ -2334,6 +2334,22 @@ static inline int mmc_blk_readonly(struct mmc_card *card)
 	       !(card->csd.cmdclass & CCC_BLOCK_WRITE);
 }
 
+static bool mmc_blk_boot_part_scan(struct mmc_blk_data *md,
+				   struct mmc_card *card)
+{
+	if (!(md->area_type & MMC_BLK_DATA_AREA_BOOT))
+		return false;
+
+	/*
+	 * Platform driver shall explicitly allow the boot partitions
+	 * scanning because this is a non-standard behavior.
+	 */
+	if (!card->host->scan_mmc_boot_partitions)
+		return false;
+
+	return true;
+}
+
 static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 					      struct device *parent,
 					      sector_t size,
@@ -2414,6 +2430,16 @@ static struct mmc_blk_data *mmc_blk_alloc_req(struct mmc_card *card,
 		md->disk->flags |= GENHD_FL_NO_PART_SCAN
 				   | GENHD_FL_SUPPRESS_PARTITION_INFO;
 
+	/*
+	 * Some embedded devices store FS partition table on a boot eMMC
+	 * partition (NVIDIA Tegra for example).  In this case partition
+	 * scanner will scan the boot partitions, but the found partitions
+	 * won't be assigned to the boot block device.  It's up to a
+	 * partition scanner what to do with the found partitions.
+	 */
+	if (mmc_blk_boot_part_scan(md, card))
+		md->disk->flags |= GENHD_FL_PART_SCAN_ONCE;
+
 	/*
 	 * As discussed on lkml, GENHD_FL_REMOVABLE should:
 	 *
diff --git a/include/linux/mmc/host.h b/include/linux/mmc/host.h
index c318fb5b6a94..e3d47c7e9c48 100644
--- a/include/linux/mmc/host.h
+++ b/include/linux/mmc/host.h
@@ -468,6 +468,8 @@ struct mmc_host {
 	/* Host Software Queue support */
 	bool			hsq_enabled;
 
+	bool			scan_mmc_boot_partitions;
+
 	unsigned long		private[] ____cacheline_aligned;
 };
 
-- 
2.25.1

