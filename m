Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17A011922D9;
	Mon, 30 Sep 2024 11:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727695897; cv=none; b=bqixEEfAmPOOcXsawDDIt9UVRDsoP5A0nhDmEjuod4qb8uRPKBhvymGkKrx3GOUMBtLd8j5P0M+uJh88xdy7S7TxkU24A7zcbUiYatGWYz3c3iMOnfjyAFtnkVkut7ef5IK53RNeB88FIVhGKdofXMK2BEOOFomtoMwx9f5WihY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727695897; c=relaxed/simple;
	bh=yE40cxFZh04KBu6s6SVkX44Hz5C5JD8W7ThY0xGYShM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rQcgzwJCm2OdMGwYkkOU/fgVrAUt3vs0u4DoGHSYn07hgLOIqRuwYE8/Ls9MMN6iK6wADr6LqVaemUFdq3RZLVDtpMMdsXZsSQbo+RE0vJQrein7DJ5OBBNOPuj5EgNtorp5KOuus4jEn+UgIKMqAU4Eef6w7N7DBo/m+Fo5gBQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kb4FKNkP; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kb4FKNkP"
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-37cc810ce73so2431214f8f.1;
        Mon, 30 Sep 2024 04:31:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727695893; x=1728300693; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J7ro8140t7jZfER0itc0uIfORRrh60AX+R+4YYhssdk=;
        b=kb4FKNkP9a1aO08/lxoZOvFTqGX43tpM7CkR2zTEAvZhx+GTQBFfo3cuZl9h4b+0Cv
         prtd/z20jOZW1ggR70vJ8W6SJblNzRebXgJRX9AlUeNf3UKWhvfaZ5ezz8zv9Gh4eKcX
         YIlGwNQ3Kz4LsWvtPKvHNfKN894NVguZGqMW7FfJLfEctT4Q8BOYm72iHpUo4tTy4kQG
         MdW2+UbT5F8vyvQNqZuYQVI+El70P/ZtwrBu/c9pS9uu6UYKAWJ04UFM4gE28sTWyBN8
         PjFNX4ymMum30ro0sfkZZpWZl9jiRLf7J+sQhbk/p3+0ENNn1hKWHU3kUYajh//tbEhh
         CwVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727695893; x=1728300693;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J7ro8140t7jZfER0itc0uIfORRrh60AX+R+4YYhssdk=;
        b=iSpaRQDUZrcXqBJ1yqqsegkKAlWSyUf8GVIyrId/UaVJl/78I1EWw6u15jncOP7YIE
         H3KM2kswaKf43uV612ZemUT1d/gLcPhq06YIXTtZ+UW5EN/sfzfCASVEvjJSrLRDXhAx
         OpMy6PrjcqAjnHUVdl4YQ03N/H+AA3c8rztyP0f0zdgh/PPp+GWoNc3enbjElv1a1Nhh
         oF5NBlWol0IfJJMhDiL4MLOiCELWnN0jUp213TOQNrFk+lGg2TzeP9uqmwEbvEAKHZo/
         hODiO3pfKN/HPNyDhJ6E2Rq5LYNZgWd3cqAFMQet0ftbNCtrDh/fpL0op9U+AjupnWFP
         P3mA==
X-Forwarded-Encrypted: i=1; AJvYcCUOhrgxtjaEe+a+MarpiKfaJOzQF3AFhC14hWir5U2XMY7WEG5aQoN1w5qb21WOBn8KEYCMQpSIN1QpXc3L@vger.kernel.org, AJvYcCUe2TJcde8biovHMBOzPBL29/YvqF0FG5vBAamzdtwpy5zXVe6ck8vIEjbp/FuPgBx2DD52WDOzKmry@vger.kernel.org, AJvYcCVV2hIf8k23ebwDyl0o0KK2diXcVhmtLgO8XXcoZBr+5lmcrU0FpGkmvwPXzBz1Mz+MAVZvqhtUXWqM@vger.kernel.org, AJvYcCWqrTeRJx0b/8RhM4aKJ64kDpTw1anFxskV/JXqMowaTZ6+9EeIrQvKOjq8V/dSUmq5W2IAy5FuTmpkbSc=@vger.kernel.org, AJvYcCXB53fuueWBKwxfQcm5Lwj8RpUvM4pctX4knm12GRXPIQRR41VHszl6DpeAeyhKuIBke58f3VmHiJdt@vger.kernel.org, AJvYcCXgvQE5I/AcuLBK4EVSxPUqNqx72Bp6ry93g3Dby7Gyo3+KGavBpQn8zrfp4vVOKq24g6LzZ/qvhbOLi1EUesbN@vger.kernel.org
X-Gm-Message-State: AOJu0YwJ7aAu/7b11hW5uM1Ofkd3Z9MKB8QLmtW8dH0zXRlmjj3jsCNi
	nSGmByGAyFcxmR7C2S9Y3AdwDUS9LAqpfcc9fquEKvPmJ+CSjuGT
X-Google-Smtp-Source: AGHT+IHyo/VjiiIbUVWupxyXDYDkMDGZKFqxQoua8GZVYVLnCLkERJcCU1bt8nO/dGka4dE1CkQRXg==
X-Received: by 2002:a5d:6382:0:b0:37c:cd0c:1539 with SMTP id ffacd0b85a97d-37cd5ab70f7mr6217840f8f.24.1727695893144;
        Mon, 30 Sep 2024 04:31:33 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cd57427c6sm8889363f8f.96.2024.09.30.04.31.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Sep 2024 04:31:32 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Kees Cook <kees@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christian Heusel <christian@heusel.eu>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-hardening@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Subject: [PATCH v4 4/5] block: add support for partition table defined in OF
Date: Mon, 30 Sep 2024 13:30:11 +0200
Message-ID: <20240930113045.28616-5-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240930113045.28616-1-ansuelsmth@gmail.com>
References: <20240930113045.28616-1-ansuelsmth@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add support for partition table defined in Device Tree. Similar to how
it's done with MTD, add support for defining a fixed partition table in
device tree.

A common scenario for this is fixed block (eMMC) embedded devices that
have no MBR or GPT partition table to save storage space. Bootloader
access the block device with absolute address of data.

This is to complete the functionality with an equivalent implementation
with providing partition table with bootargs, for case where the booargs
can't be modified and tweaking the Device Tree is the only solution to
have an usabe partition table.

The implementation follow the fixed-partitions parser used on MTD
devices where a "partitions" node is expected to be declared with
"fixed-partitions" compatible in the OF node of the disk device
(mmc-card for eMMC for example) and each child node declare a label
and a reg with offset and size. If label is not declared, the node name
is used as fallback. Eventually is also possible to declare the read-only
property to flag the partition as read-only.

For eMMC block, driver scan the disk name and check if it's suffixed with
"boot0" or "boot1".
This is to handle the additional disk provided by eMMC as supported in
JEDEC 4.4+. If this suffix is detected, "partitions-boot0" or
"partitions-boot1" are used instead of the generic "partitions" for the
relevant disk.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 block/partitions/Kconfig  |   9 +++
 block/partitions/Makefile |   1 +
 block/partitions/check.h  |   1 +
 block/partitions/core.c   |   3 +
 block/partitions/of.c     | 151 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 165 insertions(+)
 create mode 100644 block/partitions/of.c

diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
index 7aff4eb81c60..ce17e41451af 100644
--- a/block/partitions/Kconfig
+++ b/block/partitions/Kconfig
@@ -270,4 +270,13 @@ config CMDLINE_PARTITION
 	  Say Y here if you want to read the partition table from bootargs.
 	  The format for the command line is just like mtdparts.
 
+config OF_PARTITION
+	bool "Device Tree partition support" if PARTITION_ADVANCED
+	depends on OF
+	help
+	  Say Y here if you want to enable support for partition table
+	  defined in Device Tree. (mainly for eMMC)
+	  The format for the device tree node is just like MTD fixed-partition
+	  schema.
+
 endmenu
diff --git a/block/partitions/Makefile b/block/partitions/Makefile
index a7f05cdb02a8..25d424922c6e 100644
--- a/block/partitions/Makefile
+++ b/block/partitions/Makefile
@@ -12,6 +12,7 @@ obj-$(CONFIG_CMDLINE_PARTITION) += cmdline.o
 obj-$(CONFIG_MAC_PARTITION) += mac.o
 obj-$(CONFIG_LDM_PARTITION) += ldm.o
 obj-$(CONFIG_MSDOS_PARTITION) += msdos.o
+obj-$(CONFIG_OF_PARTITION) += of.o
 obj-$(CONFIG_OSF_PARTITION) += osf.o
 obj-$(CONFIG_SGI_PARTITION) += sgi.o
 obj-$(CONFIG_SUN_PARTITION) += sun.o
diff --git a/block/partitions/check.h b/block/partitions/check.h
index 8d70a880c372..e5c1c61eb353 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -62,6 +62,7 @@ int karma_partition(struct parsed_partitions *state);
 int ldm_partition(struct parsed_partitions *state);
 int mac_partition(struct parsed_partitions *state);
 int msdos_partition(struct parsed_partitions *state);
+int of_partition(struct parsed_partitions *state);
 int osf_partition(struct parsed_partitions *state);
 int sgi_partition(struct parsed_partitions *state);
 int sun_partition(struct parsed_partitions *state);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index abad6c83db8f..dc21734b00ec 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -43,6 +43,9 @@ static int (*const check_part[])(struct parsed_partitions *) = {
 #ifdef CONFIG_CMDLINE_PARTITION
 	cmdline_partition,
 #endif
+#ifdef CONFIG_OF_PARTITION
+	of_partition,		/* cmdline have priority to OF */
+#endif
 #ifdef CONFIG_EFI_PARTITION
 	efi_partition,		/* this must come before msdos */
 #endif
diff --git a/block/partitions/of.c b/block/partitions/of.c
new file mode 100644
index 000000000000..d5b53f00af5c
--- /dev/null
+++ b/block/partitions/of.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/blkdev.h>
+#include <linux/major.h>
+#include <linux/of.h>
+#include <linux/string.h>
+#include "check.h"
+
+static struct device_node *get_partitions_node(struct device_node *disk_np,
+					       struct gendisk *disk)
+{
+	const char *node_name = "partitions";
+
+	/*
+	 * JEDEC specification 4.4 for eMMC introduced 3 additional partition
+	 * present on every eMMC. These additional partition are always hardcoded
+	 * from the eMMC driver as boot0, boot1 and rpmb. While rpmb is used to
+	 * store keys and exposed as a char device, the other 2 are exposed as
+	 * real separate disk with the boot0/1 appended to the disk name.
+	 *
+	 * Here we parse the disk_name in search for such suffix and select
+	 * the correct partition node.
+	 */
+	if (disk->major == MMC_BLOCK_MAJOR) {
+		const char *disk_name = disk->disk_name;
+
+		if (strends(disk_name, "boot0"))
+			node_name = "partitions-boot0";
+		if (strends(disk_name, "boot1"))
+			node_name = "partitions-boot1";
+	}
+
+	return of_get_child_by_name(disk_np, node_name);
+}
+
+static int validate_of_partition(struct device_node *np, int slot)
+{
+	int a_cells, s_cells;
+	const __be32 *reg;
+	u64 offset, size;
+	int len;
+
+	reg = of_get_property(np, "reg", &len);
+
+	a_cells = of_n_addr_cells(np);
+	s_cells = of_n_size_cells(np);
+
+	/* Make sure reg len match the expected addr and size cells */
+	if (len / sizeof(*reg) != a_cells + s_cells)
+		return -EINVAL;
+
+	/* Validate offset conversion from bytes to sectors */
+	offset = of_read_number(reg, a_cells);
+	if (offset % SECTOR_SIZE)
+		return -EINVAL;
+
+	/* Validate size conversion from bytes to sectors */
+	size = of_read_number(reg + a_cells, s_cells);
+	if (!size || size % SECTOR_SIZE)
+		return -EINVAL;
+
+	return 0;
+}
+
+static void add_of_partition(struct parsed_partitions *state, int slot,
+			     struct device_node *np)
+{
+	struct partition_meta_info *info;
+	char tmp[sizeof(info->volname) + 4];
+	int a_cells, s_cells;
+	const char *partname;
+	const __be32 *reg;
+	u64 offset, size;
+	int len;
+
+	reg = of_get_property(np, "reg", &len);
+
+	a_cells = of_n_addr_cells(np);
+	s_cells = of_n_size_cells(np);
+
+	/* Convert bytes to sector size */
+	offset = of_read_number(reg, a_cells) / SECTOR_SIZE;
+	size = of_read_number(reg + a_cells, s_cells) / SECTOR_SIZE;
+
+	put_partition(state, slot, offset, size);
+
+	if (of_property_read_bool(np, "read-only"))
+		state->parts[slot].flags |= ADDPART_FLAG_READONLY;
+
+	/*
+	 * Follow MTD label logic, search for label property,
+	 * fallback to node name if not found.
+	 */
+	info = &state->parts[slot].info;
+	partname = of_get_property(np, "label", &len);
+	if (!partname)
+		partname = of_get_property(np, "name", &len);
+	strscpy(info->volname, partname, sizeof(info->volname));
+
+	snprintf(tmp, sizeof(tmp), "(%s)", info->volname);
+	strlcat(state->pp_buf, tmp, PAGE_SIZE);
+}
+
+int of_partition(struct parsed_partitions *state)
+{
+	struct device_node *disk_np, *partitions_np, *np;
+	struct device *ddev = disk_to_dev(state->disk);
+	int slot, ret = 1;
+
+	disk_np = of_node_get(ddev->parent->of_node);
+	if (!disk_np)
+		return 0;
+
+	partitions_np = get_partitions_node(disk_np, state->disk);
+	if (!partitions_np ||
+	    !of_device_is_compatible(partitions_np, "fixed-partitions")) {
+		of_node_put(disk_np);
+		return 0;
+	}
+
+	slot = 1;
+	/* Validate parition offset and size */
+	for_each_child_of_node(partitions_np, np) {
+		if (validate_of_partition(np, slot)) {
+			of_node_put(np);
+			ret = -1;
+			goto exit;
+		}
+
+		slot++;
+	}
+
+	slot = 1;
+	for_each_child_of_node(partitions_np, np) {
+		if (slot >= state->limit) {
+			of_node_put(np);
+			break;
+		}
+
+		add_of_partition(state, slot, np);
+
+		slot++;
+	}
+
+	strlcat(state->pp_buf, "\n", PAGE_SIZE);
+
+exit:
+	of_node_put(partitions_np);
+	of_node_put(disk_np);
+	return ret;
+}
-- 
2.45.2

