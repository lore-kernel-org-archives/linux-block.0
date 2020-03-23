Return-Path: <SRS0=J0qc=5I=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A682DC54EEB
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:36:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5E4F920722
	for <linux-block@archiver.kernel.org>; Mon, 23 Mar 2020 16:36:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gk+Vyj1R"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727663AbgCWQfo (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 23 Mar 2020 12:35:44 -0400
Received: from mail-lf1-f67.google.com ([209.85.167.67]:33674 "EHLO
        mail-lf1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727627AbgCWQfn (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 23 Mar 2020 12:35:43 -0400
Received: by mail-lf1-f67.google.com with SMTP id c20so10785356lfb.0;
        Mon, 23 Mar 2020 09:35:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RILIObRT9JS8XulPHlWPQ9vH/RJe3I5zeLXUMy0kxJ0=;
        b=gk+Vyj1R1kxyD1ehldnOTxnUwn+nfjwX8TCNqq2SOhwe1lJxBWDi5DMYIXC/WnCQuJ
         exFhGyZUEMvgx5s7hFOiA8mUx3Rv2ndbdgp1cKEpmEJyVwYg3S2oPNp9nF0i14jH89Ik
         dPmeHleYDYBgm0D3mLbCDwgAmh+pclqSEuBfPyQh8LBsueq6LKQsgF06CatciEjKX1WR
         s6Morkix+lY4BHl+rJ+J64uylKZmwGsHu02MhW4XA3S19GhlUBag/zrNVvGcSg5H3tsi
         5WxPAWQjeF9Z5BQbu2ztVEzYh5iU52mICiDi52Ztg1blULPoIP7UNrGJ5jkBOGF1p9LB
         FMYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RILIObRT9JS8XulPHlWPQ9vH/RJe3I5zeLXUMy0kxJ0=;
        b=C8B3Wbr3hqoIW9zJC+J2BPKXNf4RkByS5fXuHSHYpiVi7ck4UIgSlJao5A0SIxIkrC
         AhCh3chCWHxrH+/7Ml9tLYv1NCFzK7rwMZgvsvH+WxK/vxTQ/odVMerj6/mSCVbv/D+7
         lyIrIZ7yS28DgvaZk+hOTZYwFeXAXz2RLThIM3Q3xkPSX03RtxVyatlXzElF99mZuiBC
         Y5c3Ob/D0pRTXGxwz5xo2oJnfWQDqR2x4oOMwj7ZFo7D4fGaf+liyZZDEPbp+c25JBTC
         BgA+eFCj9GSiZ0Kl+GX0RLTdX/xLCBDARzIT3hIq+9+PEOESX693MeySW8kQySAZc6NL
         ymGQ==
X-Gm-Message-State: ANhLgQ2D+sCRNmsKqremRWe7+Ku39ln2IKIJr29f10lhaeSN4aYEVqZ0
        lJpbw0v19rLcsE07CydqbiM=
X-Google-Smtp-Source: ADFU+vv8Jkwt6S4BvRYnbtskRc4pkAFOtNKOvIA51gHCMmcjbaJVPAStXaS0SIj8dYEHhBdOTh0tJg==
X-Received: by 2002:a19:660a:: with SMTP id a10mr13723651lfc.9.1584981336899;
        Mon, 23 Mar 2020 09:35:36 -0700 (PDT)
Received: from localhost.localdomain (94-29-39-224.dynamic.spd-mgts.ru. [94.29.39.224])
        by smtp.gmail.com with ESMTPSA id m14sm4820017lfo.25.2020.03.23.09.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 09:35:36 -0700 (PDT)
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
Subject: [PATCH v3 03/10] partitions: Introduce NVIDIA Tegra Partition Table
Date:   Mon, 23 Mar 2020 19:34:24 +0300
Message-Id: <20200323163431.7678-4-digetx@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200323163431.7678-1-digetx@gmail.com>
References: <20200323163431.7678-1-digetx@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

All NVIDIA Tegra devices use a special partition table format for the
internal storage partitioning. Most of Tegra devices have GPT partition
in addition to TegraPT, but some older Android consumer-grade devices do
not or GPT is placed in a wrong sector, and thus, the TegraPT is needed
in order to support these devices properly in the upstream kernel. This
patch adds support for NVIDIA Tegra Partition Table format that is used
at least by all NVIDIA Tegra20 and Tegra30 devices.

Signed-off-by: Dmitry Osipenko <digetx@gmail.com>
---
 arch/arm/mach-tegra/tegra.c   |  54 ++++
 block/partitions/Kconfig      |  10 +
 block/partitions/Makefile     |   1 +
 block/partitions/check.c      |   4 +
 block/partitions/tegra.c      | 512 ++++++++++++++++++++++++++++++++++
 block/partitions/tegra.h      |   8 +
 include/soc/tegra/bootdata.h  |  46 +++
 include/soc/tegra/common.h    |   9 +
 include/soc/tegra/partition.h |  91 ++++++
 9 files changed, 735 insertions(+)
 create mode 100644 block/partitions/tegra.c
 create mode 100644 block/partitions/tegra.h
 create mode 100644 include/soc/tegra/bootdata.h
 create mode 100644 include/soc/tegra/partition.h

diff --git a/arch/arm/mach-tegra/tegra.c b/arch/arm/mach-tegra/tegra.c
index 3882a6c66969..9236819c5a2f 100644
--- a/arch/arm/mach-tegra/tegra.c
+++ b/arch/arm/mach-tegra/tegra.c
@@ -28,7 +28,9 @@
 
 #include <linux/firmware/trusted_foundations.h>
 
+#include <soc/tegra/bootdata.h>
 #include <soc/tegra/fuse.h>
+#include <soc/tegra/partition.h>
 #include <soc/tegra/pmc.h>
 
 #include <asm/firmware.h>
@@ -62,9 +64,61 @@ u32 tegra_uart_config[3] = {
 	0,
 };
 
+static void __init tegra_boot_config_table_init(void)
+{
+	struct tegra30_boot_config_table __iomem *t30_bct;
+	struct tegra20_boot_config_table __iomem *t20_bct;
+	struct tegra20_boot_info_table   __iomem *t20_bit;
+	u32 iram_end   = TEGRA_IRAM_BASE + TEGRA_IRAM_SIZE;
+	u32 iram_start = TEGRA_IRAM_BASE;
+	u32 pt_addr, pt_size, bct_size;
+
+	t20_bit = IO_ADDRESS(TEGRA_IRAM_BASE);
+
+	if (of_machine_is_compatible("nvidia,tegra20")) {
+		bct_size = sizeof(*t20_bct);
+
+		if (t20_bit->bct_size != bct_size ||
+		    t20_bit->bct_ptr < iram_start ||
+		    t20_bit->bct_ptr > iram_end - bct_size)
+			return;
+
+		t20_bct = IO_ADDRESS(t20_bit->bct_ptr);
+
+		if (t20_bct->boot_data_version != TEGRA_BOOTDATA_VERSION_T20)
+			return;
+
+		pt_addr = t20_bct->partition_table_logical_sector_address;
+		pt_size = t20_bct->partition_table_num_logical_sectors;
+
+	} else if (of_machine_is_compatible("nvidia,tegra30")) {
+		bct_size = sizeof(*t30_bct);
+
+		if (t20_bit->bct_size != bct_size ||
+		    t20_bit->bct_ptr < iram_start ||
+		    t20_bit->bct_ptr > iram_end - bct_size)
+			return;
+
+		t30_bct = IO_ADDRESS(t20_bit->bct_ptr);
+
+		if (t30_bct->boot_data_version != TEGRA_BOOTDATA_VERSION_T30)
+			return;
+
+		pt_addr = t30_bct->partition_table_logical_sector_address;
+		pt_size = t30_bct->partition_table_num_logical_sectors;
+	} else {
+		return;
+	}
+
+	pr_info("%s: BCT found in IRAM\n", __func__);
+
+	tegra_partition_table_setup(pt_addr, pt_size);
+}
+
 static void __init tegra_init_early(void)
 {
 	of_register_trusted_foundations();
+	tegra_boot_config_table_init();
 	tegra_cpu_reset_handler_init();
 	call_firmware_op(l2x0_init);
 }
diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
index 702689a628f0..2e38fde39b9c 100644
--- a/block/partitions/Kconfig
+++ b/block/partitions/Kconfig
@@ -268,3 +268,13 @@ config CMDLINE_PARTITION
 	help
 	  Say Y here if you want to read the partition table from bootargs.
 	  The format for the command line is just like mtdparts.
+
+config TEGRA_PARTITION
+	bool "NVIDIA Tegra Partition support" if PARTITION_ADVANCED
+	default y if ARCH_TEGRA
+	depends on ARCH_TEGRA || COMPILE_TEST
+	depends on MMC
+	select MMC_BLOCK
+	help
+	  Say Y here if you would like to be able to read the hard disk
+	  partition table format used by NVIDIA Tegra machines.
diff --git a/block/partitions/Makefile b/block/partitions/Makefile
index 2f276b677c81..807319883a18 100644
--- a/block/partitions/Makefile
+++ b/block/partitions/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_IBM_PARTITION) += ibm.o
 obj-$(CONFIG_EFI_PARTITION) += efi.o
 obj-$(CONFIG_KARMA_PARTITION) += karma.o
 obj-$(CONFIG_SYSV68_PARTITION) += sysv68.o
+obj-$(CONFIG_TEGRA_PARTITION) += tegra.o
diff --git a/block/partitions/check.c b/block/partitions/check.c
index ffe408fead0c..91268773b6ce 100644
--- a/block/partitions/check.c
+++ b/block/partitions/check.c
@@ -36,6 +36,7 @@
 #include "karma.h"
 #include "sysv68.h"
 #include "cmdline.h"
+#include "tegra.h"
 
 int warn_no_part = 1; /*This is ugly: should make genhd removable media aware*/
 
@@ -108,6 +109,9 @@ static int (*check_part[])(struct parsed_partitions *) = {
 #endif
 #ifdef CONFIG_SYSV68_PARTITION
 	sysv68_partition,
+#endif
+#ifdef CONFIG_TEGRA_PARTITION
+	tegra_partition,
 #endif
 	NULL
 };
diff --git a/block/partitions/tegra.c b/block/partitions/tegra.c
new file mode 100644
index 000000000000..4cb8064bf458
--- /dev/null
+++ b/block/partitions/tegra.c
@@ -0,0 +1,512 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * NVIDIA Tegra Partition Table
+ *
+ * Copyright (C) 2020 GRATE-DRIVER project
+ * Copyright (C) 2020 Dmitry Osipenko <digetx@gmail.com>
+ *
+ * Credits for the partition table format:
+ *
+ *   Andrey Danin <danindrey@mail.ru>       (Toshiba AC100 TegraPT format)
+ *   Gilles Grandou <gilles@grandou.net>    (Toshiba AC100 TegraPT format)
+ *   Ryan Grachek <ryan@edited.us>          (Google TV "Molly" TegraPT format)
+ *   Stephen Warren <swarren@wwwdotorg.org> (Useful suggestions about eMMC/etc)
+ */
+
+#define pr_fmt(fmt) "tegra-partition: " fmt
+
+#include <linux/blkdev.h>
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/sizes.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+
+#include <linux/mmc/blkdev.h>
+#include <linux/mmc/card.h>
+#include <linux/mmc/host.h>
+
+#include <soc/tegra/common.h>
+#include <soc/tegra/partition.h>
+
+#include "check.h"
+#include "tegra.h"
+
+#define TEGRA_PT_SECTOR_SZ	(TEGRA_PT_LOGICAL_SECTOR_SIZE / SECTOR_SIZE)
+#define TEGRA_PT_SECTOR(s)	(TEGRA_PT_SECTOR_SZ * (s))
+
+#define TEGRA_PT_INFO(ptp, fmt, ...)					\
+	pr_info("%s: " fmt,						\
+		(ptp)->state->bdev->bd_disk->disk_name, ##__VA_ARGS__)
+
+#define TEGRA_PT_ERR(ptp, fmt, ...)					\
+	pr_err("%s: " fmt,						\
+		(ptp)->state->bdev->bd_disk->disk_name, ##__VA_ARGS__)
+
+#define TEGRA_PT_PARSE_ERR(ptp, fmt, ...)				\
+	TEGRA_PT_ERR(ptp, "sector %llu: invalid " fmt,			\
+		     (ptp)->sector, ##__VA_ARGS__)
+
+struct tegra_partition_table_parser {
+	struct tegra_partition_table *pt;
+	struct parsed_partitions *state;
+	bool pt_entry_checked;
+	sector_t sector;
+	int boot_offset;
+	u32 dev_instance;
+	u32 dev_id;
+};
+
+union tegra_partition_table_u {
+	struct tegra_partition_table pt;
+	u8 pt_parts[TEGRA_PT_SECTOR_SZ][SECTOR_SIZE];
+};
+
+struct tegra_partition_type {
+	unsigned int type;
+	char *name;
+};
+
+static sector_t tegra_pt_sector_address;
+static sector_t tegra_pt_sectors_num;
+
+void tegra_partition_table_setup(sector_t logical_sector_address,
+				 sector_t logical_sectors_num)
+{
+	tegra_pt_sector_address = TEGRA_PT_SECTOR(logical_sector_address);
+	tegra_pt_sectors_num    = TEGRA_PT_SECTOR(logical_sectors_num);
+
+	pr_info("initialized to sector = %llu sectors_num = %llu\n",
+		tegra_pt_sector_address, tegra_pt_sectors_num);
+}
+
+/*
+ * Some partitions are very sensitive, changing data on them may brick device.
+ *
+ * For more details about partitions see:
+ *
+ *  "https://docs.nvidia.com/jetson/l4t/Tegra Linux Driver Package Development Guide/part_config.html"
+ */
+static const char * const partitions_blacklist[] = {
+	"BCT", "EBT", "EKS", "GP1", "GPT", "MBR", "PT",
+};
+
+static bool tegra_partition_name_match(struct tegra_partition *p,
+				       const char *name)
+{
+	return !strncmp(p->partition_name, name, TEGRA_PT_NAME_SIZE);
+}
+
+static bool tegra_partition_skip(struct tegra_partition *p,
+				 struct tegra_partition_table_parser *ptp,
+				 sector_t sector)
+{
+	unsigned int i;
+
+	/* skip eMMC boot partitions */
+	if (sector < ptp->boot_offset)
+		return true;
+
+	for (i = 0; i < ARRAY_SIZE(partitions_blacklist); i++) {
+		if (tegra_partition_name_match(p, partitions_blacklist[i]))
+			return true;
+	}
+
+	return false;
+}
+
+static const struct tegra_partition_type tegra_partition_expected_types[] = {
+	{ .type = TEGRA_PT_PART_TYPE_BCT,	.name = "BCT", },
+	{ .type = TEGRA_PT_PART_TYPE_EBT,	.name = "EBT", },
+	{ .type = TEGRA_PT_PART_TYPE_PT,	.name = "PT",  },
+	{ .type = TEGRA_PT_PART_TYPE_GP1,	.name = "GP1", },
+	{ .type = TEGRA_PT_PART_TYPE_GPT,	.name = "GPT", },
+	{ .type = TEGRA_PT_PART_TYPE_GENERIC,	.name = NULL,  },
+};
+
+static int tegra_partition_type_valid(struct tegra_partition_table_parser *ptp,
+				      struct tegra_partition *p)
+{
+	const struct tegra_partition_type *ptype;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(tegra_partition_expected_types); i++) {
+		ptype = &tegra_partition_expected_types[i];
+
+		if (ptype->name && !tegra_partition_name_match(p, ptype->name))
+			continue;
+
+		if (p->part_info.partition_type == ptype->type)
+			return 0;
+
+		/*
+		 * Unsure about all possible types, let's emit error and
+		 * allow to continue for now.
+		 */
+		if (!ptype->name)
+			return 1;
+	}
+
+	return -1;
+}
+
+static bool tegra_partition_valid(struct tegra_partition_table_parser *ptp,
+				  struct tegra_partition *p,
+				  struct tegra_partition *prev,
+				  sector_t sector,
+				  sector_t size)
+{
+	struct tegra_partition_info *prev_pi = &prev->part_info;
+	sector_t sect_end = TEGRA_PT_SECTOR(prev_pi->logical_sector_address +
+					    prev_pi->logical_sectors_num);
+	char *type, name[2][TEGRA_PT_NAME_SIZE + 1];
+	int err;
+
+	strscpy(name[0], p->partition_name,    sizeof(name[0]));
+	strscpy(name[1], prev->partition_name, sizeof(name[1]));
+
+	/* validate expected partition name/type */
+	err = tegra_partition_type_valid(ptp, p);
+	if (err) {
+		TEGRA_PT_PARSE_ERR(ptp, "partition_type: [%s] partition_type=%u\n",
+				   name[0], p->part_info.partition_type);
+		if (err < 0)
+			return false;
+	}
+
+	/* validate partition table BCT addresses */
+	if (tegra_partition_name_match(p, "PT")) {
+		if (sector != tegra_pt_sector_address &&
+		    size   != tegra_pt_sectors_num) {
+			TEGRA_PT_PARSE_ERR(ptp, "PT location: sector=%llu size=%llu\n",
+					   sector, size);
+			return false;
+		}
+
+		if (ptp->pt_entry_checked) {
+			TEGRA_PT_PARSE_ERR(ptp, "(duplicated) PT\n");
+			return false;
+		}
+
+		ptp->pt_entry_checked = true;
+	}
+
+	if (sector + size < sector) {
+		TEGRA_PT_PARSE_ERR(ptp, "size: [%s] integer overflow sector=%llu size=%llu\n",
+				   name[0], sector, size);
+		return false;
+	}
+
+	/* validate allocation_policy=sequential (absolute unsupported) */
+	if (p != prev && sect_end > sector) {
+		TEGRA_PT_PARSE_ERR(ptp, "allocation_policy: [%s] end=%llu [%s] sector=%llu size=%llu\n",
+				   name[1], sect_end, name[0], sector, size);
+		return false;
+	}
+
+	if (ptp->dev_instance != p->mount_info.device_instance) {
+		TEGRA_PT_PARSE_ERR(ptp, "device_instance: [%s] device_instance=%u|%u\n",
+				   name[0], ptp->dev_instance,
+				   p->mount_info.device_instance);
+		return false;
+	}
+
+	if (ptp->dev_id != p->mount_info.device_id) {
+		TEGRA_PT_PARSE_ERR(ptp, "device_id: [%s] device_id=%u|%u\n",
+				   name[0], ptp->dev_id,
+				   p->mount_info.device_id);
+		return false;
+	}
+
+	if (p->partition_id > 127) {
+		TEGRA_PT_PARSE_ERR(ptp, "partition_id: [%s] partition_id=%u\n",
+				   name[0], p->partition_id);
+		return false;
+	}
+
+	sect_end = get_capacity(ptp->state->bdev->bd_disk);
+
+	/* eMMC boot partitions are below ptp->boot_offset */
+	if (sector < ptp->boot_offset) {
+		sect_end += ptp->boot_offset;
+		type = "boot";
+	} else {
+		sector -= ptp->boot_offset;
+		type = "main";
+	}
+
+	/* validate size */
+	if (!size || sector + size > sect_end) {
+		TEGRA_PT_PARSE_ERR(ptp, "size: [%s] %s partition boot_offt=%d end=%llu sector=%llu size=%llu\n",
+				   name[0], type, ptp->boot_offset, sect_end,
+				   sector, size);
+		return false;
+	}
+
+	return true;
+}
+
+static bool tegra_partitions_parse(struct tegra_partition_table_parser *ptp,
+				   bool check_only)
+{
+	struct parsed_partitions *state = ptp->state;
+	struct tegra_partition_table *pt = ptp->pt;
+	sector_t sector, size;
+	int i, slot = 1;
+
+	ptp->pt_entry_checked = false;
+
+	for (i = 0; i < pt->secure.num_partitions; i++) {
+		struct tegra_partition *p = &pt->partitions[i];
+		struct tegra_partition *prev = &pt->partitions[max(i - 1, 0)];
+		struct tegra_partition_info *pi = &p->part_info;
+
+		if (slot == state->limit && !check_only)
+			break;
+
+		sector = TEGRA_PT_SECTOR(pi->logical_sector_address);
+		size   = TEGRA_PT_SECTOR(pi->logical_sectors_num);
+
+		if (!tegra_partition_valid(ptp, p, prev, sector, size))
+			return false;
+
+		if (check_only ||
+		    tegra_partition_skip(p, ptp, sector))
+			continue;
+
+		put_partition(state, slot++, sector - ptp->boot_offset, size);
+	}
+
+	if (!ptp->pt_entry_checked) {
+		TEGRA_PT_PARSE_ERR(ptp, "PT: table entry not found\n");
+		return false;
+	}
+
+	return true;
+}
+
+static bool
+tegra_partition_table_parsed(struct tegra_partition_table_parser *ptp)
+{
+	if (ptp->pt->secure.num_partitions == 0 ||
+	    ptp->pt->secure.num_partitions > TEGRA_PT_MAX_PARTITIONS) {
+		TEGRA_PT_PARSE_ERR(ptp, "num_partitions=%u\n",
+				   ptp->pt->secure.num_partitions);
+		return false;
+	}
+
+	return tegra_partitions_parse(ptp, true) &&
+	       tegra_partitions_parse(ptp, false);
+}
+
+static int
+tegra_partition_table_insec_hdr_valid(struct tegra_partition_table_parser *ptp)
+{
+	if (ptp->pt->insecure.magic   != TEGRA_PT_MAGIC ||
+	    ptp->pt->insecure.version != TEGRA_PT_VERSION) {
+		TEGRA_PT_PARSE_ERR(ptp, "insecure header: magic=0x%llx ver=0x%x\n",
+				   ptp->pt->insecure.magic,
+				   ptp->pt->insecure.version);
+		return 0;
+	}
+
+	return 1;
+}
+
+static int
+tegra_partition_table_sec_hdr_valid(struct tegra_partition_table_parser *ptp)
+{
+	size_t pt_size = ptp->pt->secure.num_partitions;
+
+	pt_size *= sizeof(ptp->pt->partitions[0]);
+	pt_size += TEGRA_PT_HEADER_SZ;
+
+	if (ptp->pt->secure.magic   != TEGRA_PT_MAGIC ||
+	    ptp->pt->secure.version != TEGRA_PT_VERSION ||
+	    ptp->pt->secure.length  != ptp->pt->insecure.length ||
+	    ptp->pt->secure.length  < pt_size) {
+		TEGRA_PT_PARSE_ERR(ptp, "secure header: magic=0x%llx ver=0x%x length=%u|%u|%zu\n",
+				   ptp->pt->secure.magic,
+				   ptp->pt->secure.version,
+				   ptp->pt->secure.length,
+				   ptp->pt->insecure.length,
+				   pt_size);
+		return 0;
+	}
+
+	return 1;
+}
+
+static int
+tegra_partition_table_unencrypted(struct tegra_partition_table_parser *ptp)
+{
+	/* AES IV, all zeros if unencrypted */
+	if (ptp->pt->secure.random_data[0] || ptp->pt->secure.random_data[1] ||
+	    ptp->pt->secure.random_data[2] || ptp->pt->secure.random_data[3]) {
+		pr_err_once("encrypted partition table unsupported\n");
+		return 0;
+	}
+
+	return 1;
+}
+
+static const u32 tegra20_sdhci_bases[TEGRA_PT_SDHCI_DEVICE_INSTANCES] = {
+	0xc8000000, 0xc8000200, 0xc8000400, 0xc8000600,
+};
+
+static const u32 tegra30_sdhci_bases[TEGRA_PT_SDHCI_DEVICE_INSTANCES] = {
+	0x78000000, 0x78000200, 0x78000400, 0x78000600,
+};
+
+static const struct of_device_id tegra_sdhci_match[] = {
+	{ .compatible = "nvidia,tegra20-sdhci", .data = tegra20_sdhci_bases, },
+	{ .compatible = "nvidia,tegra30-sdhci", .data = tegra30_sdhci_bases, },
+	{}
+};
+
+static int
+tegra_partition_table_emmc_boot_offset(struct tegra_partition_table_parser *ptp)
+{
+	struct mmc_card *card = mmc_bdev_to_card(ptp->state->bdev);
+	const struct of_device_id *matched;
+	const u32 *sdhci_bases;
+	u32 sdhci_base;
+	unsigned int i;
+	int err;
+
+	/* filter out unexpected/untested boot sources */
+	if (!card || card->ext_csd.rev < 3 ||
+	    !mmc_card_is_blockaddr(card) ||
+	     mmc_card_is_removable(card->host))
+		return -1;
+
+	/* skip everything unrelated to Tegra eMMC */
+	matched = of_match_node(tegra_sdhci_match, card->host->parent->of_node);
+	if (!matched)
+		return -1;
+
+	sdhci_bases = matched->data;
+
+	/* figure out SDHCI instance ID by the base address */
+	err = of_property_read_u32_index(card->host->parent->of_node,
+					 "reg", 0, &sdhci_base);
+	if (err)
+		return -1;
+
+	for (i = 0; i < TEGRA_PT_SDHCI_DEVICE_INSTANCES; i++) {
+		if (sdhci_base == sdhci_bases[i])
+			break;
+	}
+
+	if (i == TEGRA_PT_SDHCI_DEVICE_INSTANCES)
+		return -1;
+
+	ptp->dev_id       = TEGRA_PT_SDHCI_DEVICE_ID;
+	ptp->dev_instance = i;
+
+	/*
+	 * eMMC storage has two special boot partitions in addition to the
+	 * main one.  NVIDIA's bootloader linearizes eMMC boot0->boot1->main
+	 * accesses, this means that the partition table addresses are shifted
+	 * by the size of boot partitions.  In accordance with the eMMC
+	 * specification, the boot partition size is calculated as follows:
+	 *
+	 *	boot partition size = 128K byte x BOOT_SIZE_MULT
+	 *
+	 * This function returns number of sectors occupied by the both boot
+	 * partitions.
+	 */
+	return card->ext_csd.raw_boot_mult * SZ_128K /
+	       SECTOR_SIZE * MMC_NUM_BOOT_PARTITION;
+}
+
+static int tegra_read_partition_table(struct tegra_partition_table_parser *ptp)
+{
+	union tegra_partition_table_u *ptu = (typeof(ptu))ptp->pt;
+	unsigned int i;
+	Sector sect;
+	void *part;
+
+	for (i = 0; i < ARRAY_SIZE(ptu->pt_parts); i++) {
+		/*
+		 * Partition table takes at maximum 4096 bytes, but
+		 * read_part_sector() guarantees only that SECTOR_SIZE will
+		 * be read at minimum.
+		 */
+		part = read_part_sector(ptp->state, ptp->sector + i, &sect);
+		if (!part) {
+			TEGRA_PT_ERR(ptp, "failed to read sector %llu\n",
+				     ptp->sector + i);
+			return 0;
+		}
+
+		memcpy(ptu->pt_parts[i], part, SECTOR_SIZE);
+		put_dev_sector(sect);
+	}
+
+	return 1;
+}
+
+int tegra_partition(struct parsed_partitions *state)
+{
+	struct tegra_partition_table_parser ptp = {};
+	sector_t end_sector;
+	int ret = 0;
+
+	if (!soc_is_tegra())
+		return 0;
+
+	ptp.state = state;
+
+	ptp.boot_offset = tegra_partition_table_emmc_boot_offset(&ptp);
+	if (ptp.boot_offset < 0)
+		return 0;
+
+	if (tegra_pt_sector_address < ptp.boot_offset) {
+		TEGRA_PT_INFO(&ptp,
+			      "scanning eMMC boot partitions unimplemented\n");
+		return 0;
+	}
+
+	ptp.pt = kmalloc(TEGRA_PT_LOGICAL_SECTOR_SIZE, GFP_KERNEL);
+	if (!ptp.pt)
+		return 0;
+
+	ptp.sector = tegra_pt_sector_address - ptp.boot_offset;
+	end_sector = ptp.sector + tegra_pt_sectors_num;
+
+	/*
+	 * Partition table is duplicated till the end_sector.
+	 * If first table is corrupted, we will try next.
+	 */
+	while (ptp.sector < end_sector) {
+		ret = tegra_read_partition_table(&ptp);
+		if (!ret)
+			goto next_sector;
+
+		ret = tegra_partition_table_insec_hdr_valid(&ptp);
+		if (!ret)
+			goto next_sector;
+
+		ret = tegra_partition_table_unencrypted(&ptp);
+		if (!ret)
+			goto next_sector;
+
+		ret = tegra_partition_table_sec_hdr_valid(&ptp);
+		if (!ret)
+			goto next_sector;
+
+		ret = tegra_partition_table_parsed(&ptp);
+		if (ret)
+			break;
+next_sector:
+		ptp.sector += TEGRA_PT_SECTOR_SZ;
+	}
+
+	if (ret == 1)
+		strlcat(state->pp_buf, "\n", PAGE_SIZE);
+
+	kfree(ptp.pt);
+
+	return ret;
+}
diff --git a/block/partitions/tegra.h b/block/partitions/tegra.h
new file mode 100644
index 000000000000..cd1fe0b3a4a1
--- /dev/null
+++ b/block/partitions/tegra.h
@@ -0,0 +1,8 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef __FS_PART_TEGRA_H__
+#define __FS_PART_TEGRA_H__
+
+int tegra_partition(struct parsed_partitions *state);
+
+#endif /* __FS_PART_TEGRA_H__ */
diff --git a/include/soc/tegra/bootdata.h b/include/soc/tegra/bootdata.h
new file mode 100644
index 000000000000..7be207cb2519
--- /dev/null
+++ b/include/soc/tegra/bootdata.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_TEGRA_BOOTDATA_H__
+#define __SOC_TEGRA_BOOTDATA_H__
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+#define TEGRA_BOOTDATA_VERSION_T20	NVBOOT_BOOTDATA_VERSION(0x2, 0x1)
+#define TEGRA_BOOTDATA_VERSION_T30	NVBOOT_BOOTDATA_VERSION(0x3, 0x1)
+
+#define NVBOOT_BOOTDATA_VERSION(a, b)	((((a) & 0xffff) << 16) | \
+					  ((b) & 0xffff))
+#define NVBOOT_CMAC_AES_HASH_LENGTH	4
+
+struct tegra20_boot_info_table {
+	u32 unused_data1[14];
+	u32 bct_size;
+	u32 bct_ptr;
+} __packed;
+
+struct tegra20_boot_config_table {
+	u32 crypto_hash[NVBOOT_CMAC_AES_HASH_LENGTH];
+	u32 random_aes_blk[NVBOOT_CMAC_AES_HASH_LENGTH];
+	u32 boot_data_version;
+	u32 unused_data1[712];
+	u32 unused_consumer_data1;
+	u16 partition_table_logical_sector_address;
+	u16 partition_table_num_logical_sectors;
+	u32 unused_consumer_data[294];
+	u32 unused_data[3];
+} __packed;
+
+struct tegra30_boot_config_table {
+	u32 crypto_hash[NVBOOT_CMAC_AES_HASH_LENGTH];
+	u32 random_aes_blk[NVBOOT_CMAC_AES_HASH_LENGTH];
+	u32 boot_data_version;
+	u32 unused_data1[1016];
+	u32 unused_consumer_data1;
+	u16 partition_table_logical_sector_address;
+	u16 partition_table_num_logical_sectors;
+	u32 unused_consumer_data[502];
+	u32 unused_data[3];
+} __packed;
+
+#endif /* __SOC_TEGRA_BOOTDATA_H__ */
diff --git a/include/soc/tegra/common.h b/include/soc/tegra/common.h
index 98027a76ce3d..744280ecab5f 100644
--- a/include/soc/tegra/common.h
+++ b/include/soc/tegra/common.h
@@ -6,6 +6,15 @@
 #ifndef __SOC_TEGRA_COMMON_H__
 #define __SOC_TEGRA_COMMON_H__
 
+#include <linux/types.h>
+
+#ifdef CONFIG_ARCH_TEGRA
 bool soc_is_tegra(void);
+#else
+static inline bool soc_is_tegra(void)
+{
+	return false;
+}
+#endif
 
 #endif /* __SOC_TEGRA_COMMON_H__ */
diff --git a/include/soc/tegra/partition.h b/include/soc/tegra/partition.h
new file mode 100644
index 000000000000..17f5fbdaf49e
--- /dev/null
+++ b/include/soc/tegra/partition.h
@@ -0,0 +1,91 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+
+#ifndef __SOC_TEGRA_PARTITION_H__
+#define __SOC_TEGRA_PARTITION_H__
+
+#include <linux/compiler.h>
+#include <linux/types.h>
+
+#define TEGRA_PT_MAGIC				0xffffffff8f9e8d8bULL
+#define TEGRA_PT_VERSION			0x100
+#define TEGRA_PT_LOGICAL_SECTOR_SIZE		4096
+#define TEGRA_PT_AES_HASH_SIZE			4
+#define TEGRA_PT_NAME_SIZE			4
+
+#define TEGRA_PT_SDHCI_DEVICE_ID		18
+#define TEGRA_PT_SDHCI_DEVICE_INSTANCES		4
+
+#define TEGRA_PT_PART_TYPE_BCT			1
+#define TEGRA_PT_PART_TYPE_EBT			2
+#define TEGRA_PT_PART_TYPE_PT			3
+#define TEGRA_PT_PART_TYPE_GENERIC		6
+#define TEGRA_PT_PART_TYPE_GP1			9
+#define TEGRA_PT_PART_TYPE_GPT			10
+
+#define TEGRA_PT_HEADER_SZ						\
+	(sizeof(struct tegra_partition_header_insecure) +		\
+	 sizeof(struct tegra_partition_header_secure))			\
+
+#define TEGRA_PT_MAX_PARTITIONS						\
+	((TEGRA_PT_LOGICAL_SECTOR_SIZE - TEGRA_PT_HEADER_SZ) /		\
+	 sizeof(struct tegra_partition))
+
+struct tegra_partition_mount_info {
+	u32 device_id;
+	u32 device_instance;
+	u32 device_attr;
+	u8  mount_path[TEGRA_PT_NAME_SIZE];
+	u32 file_system_type;
+	u32 file_system_attr;
+} __packed;
+
+struct tegra_partition_info {
+	u32 partition_attr;
+	u32 __pad1;
+	u64 logical_sector_address;
+	u64 logical_sectors_num;
+	u64 __pad2[2];
+	u32 partition_type;
+	u32 __pad3;
+} __packed;
+
+struct tegra_partition {
+	u32 partition_id;
+	u8  partition_name[TEGRA_PT_NAME_SIZE];
+	struct tegra_partition_mount_info mount_info;
+	struct tegra_partition_info part_info;
+} __packed;
+
+struct tegra_partition_header_insecure {
+	u64 magic;
+	u32 version;
+	u32 length;
+	u32 signature[TEGRA_PT_AES_HASH_SIZE];
+} __packed;
+
+struct tegra_partition_header_secure {
+	u32 random_data[TEGRA_PT_AES_HASH_SIZE];
+	u64 magic;
+	u32 version;
+	u32 length;
+	u32 num_partitions;
+	u32 __pad;
+} __packed;
+
+struct tegra_partition_table {
+	struct tegra_partition_header_insecure insecure;
+	struct tegra_partition_header_secure secure;
+	struct tegra_partition partitions[TEGRA_PT_MAX_PARTITIONS];
+} __packed;
+
+#ifdef CONFIG_TEGRA_PARTITION
+void tegra_partition_table_setup(sector_t logical_sector_address,
+				 sector_t logical_sectors_num);
+#else
+static inline void tegra_partition_table_setup(sector_t logical_sector_address,
+					       sector_t logical_sectors_num)
+{
+}
+#endif
+
+#endif /* __SOC_TEGRA_PARTITION_H__ */
-- 
2.25.1

