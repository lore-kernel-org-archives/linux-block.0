Return-Path: <SRS0=yWSg=4X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE685C3F2D7
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8E7472073D
	for <linux-block@archiver.kernel.org>; Fri,  6 Mar 2020 02:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RPhQfe9q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727131AbgCFCNL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 5 Mar 2020 21:13:11 -0500
Received: from mail-lj1-f196.google.com ([209.85.208.196]:39426 "EHLO
        mail-lj1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727069AbgCFCNK (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 5 Mar 2020 21:13:10 -0500
Received: by mail-lj1-f196.google.com with SMTP id f10so517654ljn.6;
        Thu, 05 Mar 2020 18:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=wN+PxT1y6TdL2REZHdTdY6w1jaE17t+W6WihxJCIMPI=;
        b=RPhQfe9q/A15UWU4QtbLkcnk36g8DCDblpMf04CYoPlYPQtGDFaXFa1QCTGcIdxlp/
         yw2tpo3Tv5UVOv5fXTS8fMAUWhBtDhOUW76K+JgBSjAg7kKSIxGeWUy5x2meb8w1wViE
         I/rY5gc88/ui/AX5oGeeGnH2lS/e7/MT2R4+7FZzMITJTWZSVpGlxo25qZK5bvGdHoNJ
         sEyjro6FQ7wDjy+bqJ8Y5XUF2oRpLy5WX5MmPYmcw+Rz0lI0cUw443dh7GFbxqB623KT
         W5ls6KE/nmzZa8NK8F1txM8q4npEyl3/OgZN4uEvSjhTvhpv6UwlCRYDg+mSrBWp3lR/
         mIjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=wN+PxT1y6TdL2REZHdTdY6w1jaE17t+W6WihxJCIMPI=;
        b=hYcHXk4pcZx4ZbxqIC5o1EPLvA4TU6VVIqePOsXRs9COOTiEZecUIcmz4Zc9Jbq1xi
         qTTLOIISSzodyz+X+oHzX1uAAst3tOpO0/0f0r8gH6oSjxEQljmWh9GJaiZOn8/nRAPl
         GTpTCX414CL0h+wbBfAv1nsSVUebSLdzfEQeBQLU7tFmtfDlg9MXG6qzb8vOl2uBRcVt
         DyO8yu0r7lObiee1MfhbPlTUAN7nMFywU+UX+8dcgBklSrOjtb+ECo3bDudhHg4J9DVb
         9J7OW9x1YC5dtYarte0DfVxB9mQsOHBQRO/ZgPFWGDPGKP4esE9JcOTf6i4IMsAMy7yf
         i7mw==
X-Gm-Message-State: ANhLgQ0KfNknGuEhycA+Qd+CpjjHobh/+UPkTkP0bf3Xqe4UEGUCaTkv
        qFfYu88vQfFGub2mNsKn+zg=
X-Google-Smtp-Source: ADFU+vulm5XnfKC9jn0ksDTf+tOure9qy0t3uz9GiW6W37MrJWYpfgPl9mblri3rCCA1GWJY18JzyQ==
X-Received: by 2002:a2e:b8c3:: with SMTP id s3mr603454ljp.84.1583460787730;
        Thu, 05 Mar 2020 18:13:07 -0800 (PST)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id l11sm10592772lfg.87.2020.03.05.18.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 18:13:07 -0800 (PST)
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
Subject: [PATCH v2 8/8] partitions/tegra: Implement eMMC boot partitions scanning
Date:   Fri,  6 Mar 2020 05:12:20 +0300
Message-Id: <20200306021220.22097-9-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200306021220.22097-1-digetx@gmail.com>
References: <20200306021220.22097-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some NVIDIA Tegra devices store partition table on eMMC boot partition.
In order to support this case, the tegra-partition parser will read out
partition table from a boot partition and stash it for the main eMMC
partition.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 block/partitions/tegra.c | 122 +++++++++++++++++++++++++++++++++++----
 1 file changed, 110 insertions(+), 12 deletions(-)

diff --git a/block/partitions/tegra.c b/block/partitions/tegra.c
index 6f150a7e3275..153928eef60b 100644
--- a/block/partitions/tegra.c
+++ b/block/partitions/tegra.c
@@ -25,6 +25,7 @@
 #include <linux/mmc/blkdev.h>
 #include <linux/mmc/card.h>
 #include <linux/mmc/host.h>
+#include <linux/mmc/mmc.h>
 
 #include <soc/tegra/common.h>
 #include <soc/tegra/partition.h>
@@ -50,7 +51,10 @@
 struct tegra_partition_table_parser {
 	struct tegra_partition_table *pt;
 	struct parsed_partitions *state;
+	struct mmc_card *card;
 	bool pt_entry_checked;
+	unsigned int boot_id;
+	bool snapshot_mode;
 	sector_t sector;
 	int boot_offset;
 	u32 dev_instance;
@@ -67,6 +71,7 @@ struct tegra_partition_type {
 	char *name;
 };
 
+static struct tegra_partition_table *scratch_pt;
 static sector_t tegra_pt_sector_address;
 static sector_t tegra_pt_sectors_num;
 
@@ -224,6 +229,10 @@ static bool tegra_partition_valid(struct tegra_partition_table_parser *ptp,
 		return false;
 	}
 
+	/* size will be validated when ptp->snapshot_mode=false */
+	if (ptp->snapshot_mode && size)
+		return true;
+
 	sect_end = get_capacity(ptp->state->bdev->bd_disk);
 
 	/* eMMC boot partitions are below ptp->boot_offset */
@@ -369,6 +378,7 @@ tegra_partition_table_emmc_boot_offset(struct tegra_partition_table_parser *ptp)
 {
 	struct mmc_card *card = mmc_bdev_to_card(ptp->state->bdev);
 	const struct of_device_id *matched;
+	int part_type, area_type;
 	const u32 *sdhci_bases;
 	u32 sdhci_base;
 	unsigned int i;
@@ -404,6 +414,32 @@ tegra_partition_table_emmc_boot_offset(struct tegra_partition_table_parser *ptp)
 	ptp->dev_id       = TEGRA_PT_SDHCI_DEVICE_ID;
 	ptp->dev_instance = i;
 
+	area_type = mmc_bdev_to_area_type(ptp->state->bdev);
+
+	if (WARN_ON(area_type < 0))
+		return -1;
+
+	switch (area_type) {
+	case MMC_BLK_DATA_AREA_BOOT:
+		part_type = mmc_bdev_to_part_type(ptp->state->bdev);
+
+		if (WARN_ON(part_type < 0))
+			return -1;
+
+		ptp->boot_id = part_type - EXT_CSD_PART_CONFIG_ACC_BOOT0;
+		ptp->snapshot_mode = true;
+		break;
+
+	case MMC_BLK_DATA_AREA_MAIN:
+		break;
+
+	default:
+		TEGRA_PT_ERR(ptp, "unexpected area_type: %u\n", area_type);
+		return -1;
+	}
+
+	ptp->card = card;
+
 	/*
 	 * eMMC storage has two special boot partitions in addition to the
 	 * main one.  NVIDIA's bootloader linearizes eMMC boot0->boot1->main
@@ -427,6 +463,9 @@ static int tegra_read_partition_table(struct tegra_partition_table_parser *ptp)
 	Sector sect;
 	void *part;
 
+	if (scratch_pt)
+		return 1;
+
 	for (i = 0; i < ARRAY_SIZE(ptu->pt_parts); i++) {
 		/*
 		 * Partition table takes at maximum 4096 bytes, but
@@ -449,29 +488,77 @@ static int tegra_read_partition_table(struct tegra_partition_table_parser *ptp)
 
 int tegra_partition(struct parsed_partitions *state)
 {
-	struct tegra_partition_table_parser ptp = { .state = state };
+	struct tegra_partition_table_parser ptp = { 0 };
 	sector_t end_sector;
 	int ret = 0;
 
 	if (!soc_is_tegra())
 		return 0;
 
+	ptp.state = state;
+
 	ptp.boot_offset = tegra_partition_table_emmc_boot_offset(&ptp);
 	if (ptp.boot_offset < 0)
 		return 0;
 
-	if (tegra_pt_sector_address < ptp.boot_offset) {
-		TEGRA_PT_INFO(&ptp,
-			      "scanning eMMC boot partitions unimplemented\n");
-		return 0;
-	}
+	/*
+	 * Some devices store partition table on boot MMC partition.
+	 * In this case a "snapshot mode" will be used, which will
+	 * only read->check->store partition table, the stored table
+	 * will be used for the main MMC partition later on.
+	 */
+	if (ptp.snapshot_mode) {
+		sector_t boot_start, boot_end, boot_size;
 
-	ptp.pt = kmalloc(sizeof(*ptp.pt), GFP_KERNEL);
-	if (!ptp.pt)
-		return 0;
+		/* partition is already snapshoted, no need to proceed */
+		if (scratch_pt)
+			return 0;
+
+		boot_size  = ptp.boot_offset / MMC_NUM_BOOT_PARTITION;
+		boot_start = ptp.boot_id * boot_size;
+		boot_end   = boot_start + boot_size;
+
+		/*
+		 * Bail out if partition table isn't located here, at this MMC
+		 * partition.
+		 */
+		if (tegra_pt_sector_address < boot_start ||
+		    tegra_pt_sector_address >= boot_end)
+			return 0;
+
+		ptp.boot_offset = boot_start;
+
+		/*
+		 * Note that mmc_blk_probe() always registers boot partitions
+		 * after the main and we rely on this feature, otherwise
+		 * scratch_pt won't be released (although this is not a big
+		 * deal).
+		 */
+		ptp.pt = kmalloc(sizeof(*ptp.pt), GFP_KERNEL);
+		if (!ptp.pt)
+			return 0;
+
+		ptp.sector = tegra_pt_sector_address - ptp.boot_offset;
+		end_sector = ptp.sector + tegra_pt_sectors_num;
 
-	ptp.sector = tegra_pt_sector_address - ptp.boot_offset;
-	end_sector = ptp.sector + tegra_pt_sectors_num;
+	} else if (scratch_pt) {
+		TEGRA_PT_INFO(&ptp, "using stashed partition table\n");
+
+		ptp.pt     = scratch_pt;
+		ptp.sector = 0;
+		end_sector = 1;
+
+	} else {
+		if (tegra_pt_sector_address < ptp.boot_offset)
+			return 0;
+
+		ptp.pt = kmalloc(sizeof(*ptp.pt), GFP_KERNEL);
+		if (!ptp.pt)
+			return 0;
+
+		ptp.sector = tegra_pt_sector_address - ptp.boot_offset;
+		end_sector = ptp.sector + tegra_pt_sectors_num;
+	}
 
 	/*
 	 * Partition table is duplicated till the end_sector.
@@ -501,9 +588,20 @@ int tegra_partition(struct parsed_partitions *state)
 		ptp.sector += TEGRA_PT_SECTOR_SZ;
 	}
 
-	if (ret == 1)
+	if (ret == 1) {
+		if (ptp.snapshot_mode) {
+			ptp.card->quirks |= MMC_QUIRK_RESCAN_MAIN_BLKDEV;
+			scratch_pt = ptp.pt;
+
+			TEGRA_PT_INFO(&ptp, "stashed partition table\n");
+
+			return 0;
+		}
+
 		strlcat(state->pp_buf, "\n", PAGE_SIZE);
+	}
 
+	scratch_pt = NULL;
 	kfree(ptp.pt);
 
 	return ret;
-- 
2.25.1

