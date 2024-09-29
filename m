Received: from mail-wm1-f44.google.com (mail-wm1-f44.google.com [209.85.128.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1D0117E010;
	Sun, 29 Sep 2024 14:08:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727618903; cv=none; b=hTg8jBj5MtFlK80i5TV0BF8832BfyrjWXN0fRtUSa4gckvqIn3wqY6P/2YGq+AQWrwl4gMg+JaJSo2Kr2RkfOkBJKhF14bpNNQmbaucbKnPzLFqgpCRQcYarbd9I3qR7hJPQGe727nPgSZAm0e+Y3lznhJM2eBR9T5fTz2c08iU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727618903; c=relaxed/simple;
	bh=79+YTCuE+nGtBBK5CsMbE/fpmVU9X3PbsTZUsAU/s6k=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R4NKCVLSKXJGgRy2ghx7bqdtHvgEjiq3qK8C7wt7zv1+R1uXTyyvs+QvBEahMnQt9/XzmHMr/choDYPRM6K/aLDhnMHYLRbOIu1hwLsIUfLk53kj3hcDjLH3QmCvwc/Y//9LI9yia9VW1z+9raFbUk7GOj02oyvgHKvw8Ldquks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=J1kdL71U; arc=none smtp.client-ip=209.85.128.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J1kdL71U"
Received: by mail-wm1-f44.google.com with SMTP id 5b1f17b1804b1-42e82f7f36aso28560045e9.0;
        Sun, 29 Sep 2024 07:08:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727618900; x=1728223700; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2aNy8YATrUKUVxCjxxfbuqSzgonHJFsBBqc3Ny2lq0=;
        b=J1kdL71UphO9j9GnCnPFSdFnbbrkXh60dLL6BxB+9rImxcIEJuCrd+JvJaP82lVbml
         wEGIDQixKUxFQgOOQ+ZsNkHBzmfc/owWiGrYXH/SM44PBdrZ+fUt3bm/FpqeZYo5B4DI
         wuhtmtft1sp48r3E0yqzp4n/KssFvwd/AJVGIopC2z0QmQ6kVwkA9QcC8l1HeMmUeAHs
         SaoelD+ax4FBMXrSj8lRzZ6MSiD0/PmzQQdguhxvDNC9k6SuaWzBaWSXiIZuFKwANp3Q
         FZvqu74vuI5a/7aowDqARQxGJ8HuLAOWQFIN6KPXOIazTNLtX4dIMm24dAP3+mUx6gvH
         NEcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727618900; x=1728223700;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2aNy8YATrUKUVxCjxxfbuqSzgonHJFsBBqc3Ny2lq0=;
        b=g47JLLnae+srDFH5mYzUyy/CJ777u4kr0tKhKUfguRsLSunzzTyJXGguCgiXthF3kg
         6kGjnfgZtAxHv6981/YXn6Sv5+54v1uTBMrerjj+QxwS/m40y2XyGjqn/Q3ZEJzI+TtK
         LQMGyrFYDlskxJuQKHMJtEuXrCPqTqbCH8H+Dv13rJ5ETaz/awHc4Hk1ggTqn/4uHzyK
         U0UwfrmhX2cn2MXiezzetLKbK1Qw4plr16a3foNUXKsTj/X9ApiKMRwu9RHdZs+zkbPw
         atNXhiRRkYFIpYIKJNQZma6julemNJMOb2vJqxb5esoCMk6P1rXwXaNcAl1RAIZnk63N
         DZaw==
X-Forwarded-Encrypted: i=1; AJvYcCVEtxg+sIxoQZVODItYZS2JF6o85kJ+PzxmiwUDVW4FArH0mHWSyER+uZn1AJ0XJBux7r8fvnMv2KLr6MAg@vger.kernel.org, AJvYcCVhmob7PGkDX2sYH6VXIN0lrqgNZfbzQx34xoBdWeLrxbLrlrjzlEqk4/M1jNmf0axgM9NScok3AZ1K@vger.kernel.org, AJvYcCWEgJVXNbBQTB1agHfSL1WzcYw1qOxgkipYoYtxUi2lErlwcOzhqA2oshoJWJnw7nAfZpBdGpwhK0vn@vger.kernel.org, AJvYcCX4WnK0n3EOv+3zHBRzt1paDBELi+mTxqIYcaVhJdCUJOZAeeQyqiigJOzPPtmPcBd6SleRI2CMtVGMQfk=@vger.kernel.org, AJvYcCXRmhL7qL1G5T5ohUK+lszFhkDPhGiQVLUDKbO4HTb9mZ/HMJ3c/SNDdNOuvV0DrTagIKdjdbDGOCA3@vger.kernel.org
X-Gm-Message-State: AOJu0YyvoglFNdyAC4hJOKjQxiBl72+XOH9XjK8y507UgNVFYKD3UuQR
	dxQdpaAd86PRVUxsYaR5ew2pCh6in+Zz4iI7t1cLx81b6u6zj+8m
X-Google-Smtp-Source: AGHT+IF5QLLtYkupxeYRXy9xFNBDsGm27nPREth8VQ0bhxdAXdenUSNHO+8sTvEjg5JLWzkylT8E3A==
X-Received: by 2002:a05:600c:209:b0:42f:68e8:d874 with SMTP id 5b1f17b1804b1-42f68e8da4fmr9334735e9.31.1727618900053;
        Sun, 29 Sep 2024 07:08:20 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f57dd3106sm77856005e9.7.2024.09.29.07.08.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Sep 2024 07:08:18 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Jan Kara <jack@suse.cz>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	upstream@airoha.com
Subject: [PATCH v3 3/4] block: add support for partition table defined in OF
Date: Sun, 29 Sep 2024 16:06:19 +0200
Message-ID: <20240929140713.6883-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240929140713.6883-1-ansuelsmth@gmail.com>
References: <20240929140713.6883-1-ansuelsmth@gmail.com>
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
 block/partitions/Kconfig  |   8 ++
 block/partitions/Makefile |   1 +
 block/partitions/check.h  |   1 +
 block/partitions/core.c   |   3 +
 block/partitions/of.c     | 151 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 164 insertions(+)
 create mode 100644 block/partitions/of.c

diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
index 7aff4eb81c60..8534f7544f26 100644
--- a/block/partitions/Kconfig
+++ b/block/partitions/Kconfig
@@ -270,4 +270,12 @@ config CMDLINE_PARTITION
 	  Say Y here if you want to read the partition table from bootargs.
 	  The format for the command line is just like mtdparts.
 
+config OF_PARTITION
+	bool "Command line partition support" if PARTITION_ADVANCED
+	depends on OF
+	help
+	  Say Y here if you want to enable support for partition table
+	  defined in Device Tree. (mainly for eMMC)
+	  The format for the command line is just like MTD fixed-partition schema.
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
index 000000000000..bc6200eb86b3
--- /dev/null
+++ b/block/partitions/of.c
@@ -0,0 +1,151 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/blkdev.h>
+#include <linux/major.h>
+#include <linux/of.h>
+#include "check.h"
+
+#define BOOT0_STR	"boot0"
+#define BOOT1_STR	"boot1"
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
+		if (!memcmp(disk_name + strlen(disk_name) - strlen(BOOT0_STR),
+			    BOOT0_STR, sizeof(BOOT0_STR)))
+			node_name = "partitions-boot0";
+		if (!memcmp(disk_name + strlen(disk_name) - strlen(BOOT1_STR),
+			    BOOT1_STR, sizeof(BOOT1_STR)))
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
+	/*
+	 * Validate offset conversion from bytes to sectors.
+	 * Only the first partition is allowed to have offset 0.
+	 */
+	offset = of_read_number(reg, a_cells);
+	if (do_div(offset, SECTOR_SIZE) ||
+	    (slot > 1 && !offset))
+		return -EINVAL;
+
+	/* Validate size conversion from bytes to sectors */
+	size = of_read_number(reg + a_cells, s_cells);
+	if (do_div(size, SECTOR_SIZE) || !size)
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
+	int slot;
+
+	disk_np = of_node_get(ddev->parent->of_node);
+	if (!disk_np)
+		return 0;
+
+	partitions_np = get_partitions_node(disk_np, state->disk);
+	if (!partitions_np ||
+	    !of_device_is_compatible(partitions_np, "fixed-partitions"))
+		return 0;
+
+	/* Check if child are over the limit */
+	slot = of_get_child_count(partitions_np);
+	if (slot >= state->limit)
+		goto err;
+
+	slot = 1;
+	/* Validate parition offset and size */
+	for_each_child_of_node(partitions_np, np) {
+		if (validate_of_partition(np, slot))
+			goto err;
+
+		slot++;
+	}
+
+	slot = 1;
+	for_each_child_of_node(partitions_np, np) {
+		add_of_partition(state, slot, np);
+
+		slot++;
+	}
+
+	strlcat(state->pp_buf, "\n", PAGE_SIZE);
+
+	return 1;
+err:
+	of_node_put(partitions_np);
+	of_node_put(disk_np);
+	return -1;
+}
-- 
2.45.2

