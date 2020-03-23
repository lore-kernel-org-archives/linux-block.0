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
	by smtp.lore.kernel.org (Postfix) with ESMTP id C62AEC54FCF
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:35:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 919AA20658
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:35:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HmajspLK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727772AbgCWQfz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:35:55 -0400
Received: from mail-lj1-f193.google.com ([209.85.208.193]:44775 "EHLO
        mail-lj1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727689AbgCWQfs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 12:35:48 -0400
Received: by mail-lj1-f193.google.com with SMTP id w4so15289678lji.11;
        Mon, 23 Mar 2020 09:35:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QniCpQjPJXTAwB46jjMW57nPV4Kx9N7fme8aB82yFro=;
        b=HmajspLKp94NMbwJgNkK9F+3DreNcShuPTxmQie5bnGBkmLFBLrZ1hdjQgG36En68G
         RIKiSvCWyf/i9H0sVfcccBxhhCujmIFtVk5uqwOt5NyMDsXSfqVLEZb7DrGuwrlvHpie
         RZh7HUEufQo8Cgb7Y/kx+cMg2SYz3Rc6PRKqVEPmF0n4aI90H9eWEgs0LI1eOptut6rL
         JrhOJVQPEA1vZwDwLDqlVQ07gYPWC/hHh9wKABaAJoS7UkFzeefnauZUXEaEx1OHF9ol
         ObYrl65IwlTFNeb3MKgeyVTDUHQqj7m+GLuuiQebM5/8fP8nVYpSX5P3GUVtB36pYGvA
         Wj3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QniCpQjPJXTAwB46jjMW57nPV4Kx9N7fme8aB82yFro=;
        b=Lx/2ogsCNtkaFawTZKPgWUbO5/khdKYT4rmYpkwaaTbZ0L7EF0o/L12Wib37hhYDv8
         91A8MEFoPuXlKv7/7NGjYTM77APwOoBMtlZ6C2kAroYYkPov/BpaLG1aC4PxuPGmeMsN
         5F28D9xs/hvAKidFpANzFvdt64a4d3QaetSaJGUhLuRb0AYbuHAF5dzVtlp6MvEPz1A2
         sbWylfCqua6VrY3BLUlfFQG1m0hCnNmJ9N4JonLzEDi4oFIv8Q1spC1eAC46fc11KQou
         vHSZKnPqbl69azdMzqkpKx8d0z+sUA4A+lEB4E0+7Jp7MBNJktl1u5K7yUyzKYZCpKVw
         N4WA==
X-Gm-Message-State: ANhLgQ17ttWrLUnmXRhXrg6htB2zix0bfA0vdFOvljnPUcZcm4xFZiZ5
        RmKMsbJpaXPXNTWjIEGWa4Q=
X-Google-Smtp-Source: ADFU+vv7x9KQTUFEfdMp/RNH6gi82I774PfSv5dAfz6Culd+uLgWQ7cCiPrxd20mWcn/9n44DuCr5w==
X-Received: by 2002:a2e:9a54:: with SMTP id k20mr7111758ljj.272.1584981345380;
        Mon, 23 Mar 2020 09:35:45 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id m14sm4820017lfo.25.2020.03.23.09.35.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:35:44 -0700 (PDT)
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
Subject: [PATCH v3 10/10] partitions/tegra: Implement eMMC boot partitions scanning
Date:   Mon, 23 Mar 2020 19:34:31 +0300
Message-Id: <20200323163431.7678-11-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323163431.7678-1-digetx@gmail.com>
References: <20200323163431.7678-1-digetx@gmail.com>
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
 1 file changed, 111 insertions(+), 11 deletions(-)

diff --git a/block/partitions/tegra.c b/block/partitions/tegra.c
index 4cb8064bf458..09c300330f81 100644
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
@@ -254,6 +263,9 @@ static bool tegra_partitions_parse(struct tegra_partition_table_parser *ptp,
 	sector_t sector, size;
 	int i, slot = 1;
 
+	if (ptp->snapshot_mode && !check_only)
+		return true;
+
 	ptp->pt_entry_checked = false;
 
 	for (i = 0; i < pt->secure.num_partitions; i++) {
@@ -369,6 +381,7 @@ tegra_partition_table_emmc_boot_offset(struct tegra_partition_table_parser *ptp)
 {
 	struct mmc_card *card = mmc_bdev_to_card(ptp->state->bdev);
 	const struct of_device_id *matched;
+	int part_type, area_type;
 	const u32 *sdhci_bases;
 	u32 sdhci_base;
 	unsigned int i;
@@ -404,6 +417,32 @@ tegra_partition_table_emmc_boot_offset(struct tegra_partition_table_parser *ptp)
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
@@ -427,6 +466,9 @@ static int tegra_read_partition_table(struct tegra_partition_table_parser *ptp)
 	Sector sect;
 	void *part;
 
+	if (scratch_pt)
+		return 1;
+
 	for (i = 0; i < ARRAY_SIZE(ptu->pt_parts); i++) {
 		/*
 		 * Partition table takes at maximum 4096 bytes, but
@@ -462,18 +504,64 @@ int tegra_partition(struct parsed_partitions *state)
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
 
-	ptp.pt = kmalloc(TEGRA_PT_LOGICAL_SECTOR_SIZE, GFP_KERNEL);
-	if (!ptp.pt)
-		return 0;
+		/* partition is already snapshoted, no need to proceed */
+		if (scratch_pt)
+			return 0;
+
+		boot_size  = ptp.boot_offset / MMC_NUM_BOOT_PARTITION;
+		boot_start = ptp.boot_id * boot_size;
+		boot_end   = boot_start + boot_size;
 
-	ptp.sector = tegra_pt_sector_address - ptp.boot_offset;
-	end_sector = ptp.sector + tegra_pt_sectors_num;
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
+		ptp.pt = kmalloc(TEGRA_PT_LOGICAL_SECTOR_SIZE, GFP_KERNEL);
+		if (!ptp.pt)
+			return 0;
+
+		ptp.sector = tegra_pt_sector_address - ptp.boot_offset;
+		end_sector = ptp.sector + tegra_pt_sectors_num;
+
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
+		ptp.pt = kmalloc(TEGRA_PT_LOGICAL_SECTOR_SIZE, GFP_KERNEL);
+		if (!ptp.pt)
+			return 0;
+
+		ptp.sector = tegra_pt_sector_address - ptp.boot_offset;
+		end_sector = ptp.sector + tegra_pt_sectors_num;
+	}
 
 	/*
 	 * Partition table is duplicated till the end_sector.
@@ -503,9 +591,21 @@ int tegra_partition(struct parsed_partitions *state)
 		ptp.sector += TEGRA_PT_SECTOR_SZ;
 	}
 
-	if (ret == 1)
+	if (ret == 1) {
+		if (ptp.snapshot_mode) {
+			ptp.card->quirks |= MMC_QUIRK_RESCAN_MAIN_BLKDEV;
+			scratch_pt = ptp.pt;
+
+			strlcat(state->pp_buf,
+				" stashed tegra-partition table\n", PAGE_SIZE);
+
+			return ret;
+		}
+
 		strlcat(state->pp_buf, "\n", PAGE_SIZE);
+	}
 
+	scratch_pt = NULL;
 	kfree(ptp.pt);
 
 	return ret;
-- 
2.25.1

