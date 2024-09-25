Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D385F176FDB;
	Wed, 25 Sep 2024 21:46:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727300809; cv=none; b=CkNRYsvP1vqAL4u21Xdk7tfNVWulvLPjRZKu70+GGWMEN9S6OUm7ZIf1SwDXGhMTDw+Xu3y0q9A2kqpOu+IlIych9z180xt+hnNV/pKR6nIR4fTrIAoI72viwAqeRJpbbBYVBl86Q3iQA5uEZM3c9adxNhAciMFbvnxwx3iwsq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727300809; c=relaxed/simple;
	bh=VWdNWKlk1VbmM4tp0dnQsKVCo70kSvcOAXNbnEvLBaM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dMdB2CB5DSEqCXe07zMsopFlH7yhnh5mRG2JTC/CCV1MpL/AS7/HnYh2GgyZA89rk5vUKMvVqOyVqv5wLMpUqN7EFUL2oUx5tB8SNDDi67erMYTTb72legf9UHGcrvqHMcVlfFpuki4z5NtCbz6JXLmmNcnH4tl5r+X29qdPVOk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R8IXZBgC; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R8IXZBgC"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-42cc8782869so2335015e9.2;
        Wed, 25 Sep 2024 14:46:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727300806; x=1727905606; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QgWHUdLDjVwovONqyKU9lTcOJXUFIpT+3p6c+7n8kok=;
        b=R8IXZBgCFiz6lf4gOp/Oe/uCIGoWl/rNqfd+KBFT5nHqvP6OBtZ34NeUhy593DKqyY
         VroxTba7n0CrgUIo8tPHeEH8B57bBpVY0Sai2I3gpRVjrBr0vgplHcUR/QQSGdnQxXXj
         VQlHoK57BW1jxw/weXoDsEU0zc19yPqW8auvedPu80RdLmdCVm6fhNQT/PKUDSICQlFO
         OvAVn+Q+XDXhFa0VX1M5VN93/ofPIMDdGP92rmmEGqSi66U4sdWTT5jGAm8cXKXY0zHh
         /EKB7VoHEZojE0Ld9334n1tgvQWLpziq4kNGJfXFHOp356tgsVnCe1wJZBUzktp6kyKR
         RInA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727300806; x=1727905606;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QgWHUdLDjVwovONqyKU9lTcOJXUFIpT+3p6c+7n8kok=;
        b=tSCDKwOTnyOOuBF5GwW32q2VRrof8xmDNTCh/JdkfzQkQP2fif5DZ3UzaR2GzKKuzv
         KcTg4XKZ8aswWe8WS1rXIeb9488llmNi2YolJhf5sepynObOqA2Ryo6BSl5QaC7syAYt
         rj/qej3xVMyecZ6tDNdc766MZC1o3NTyYLHGREUt+tTczyvyVPOgSoxTTN+Vj1wuTnMT
         ZxZVT680l28czdqLkC0vy1pWLVJE1uovLVXFsBXRUqzJXthkwC6kb9urO60r0tj7xu7C
         JrlQYpUXpVU/DwXEoCnGm1pFBsqAh3F969Lf07IvyufMWK3ryCKiEpIRiO3fniqliPgL
         srKQ==
X-Forwarded-Encrypted: i=1; AJvYcCUhYaSxCORd6720K8+I2LAT9kEME2xUFIopOmyMwTcVp01LRsyrb/qKrRlD9lfaKgLegcvbB1MWHKtCU0I=@vger.kernel.org, AJvYcCV7MRm8bz6cnaMJWSUlkb32Ns+9YLa1/Sae/ZkFeYyHvS+ZcaDQ43nKRcZJGKpEimAOWbRfYvBnWJo8@vger.kernel.org, AJvYcCVA/gBgCEXkKeC0luAxiTZe6hvhEBEKchFlstwQ1FcV5Bh8m+x3fl7fbZ0OfUs1MyFYC2ieyRBdbFOE@vger.kernel.org, AJvYcCVn/cAtf1+xvte+XuRA8PgJkqmqxxvU0tjWmErYIVP8Jz32JD597jYEPTU/RlKDVTs6jjNv9HskUImrdxOA@vger.kernel.org, AJvYcCXSedE2K5/DPZ1ttnvohe9n+Ylv2Lpd5kXY5eFqRHldm/BPaAciicmJw14/tXyKPxpgM1TMaj4biva3@vger.kernel.org
X-Gm-Message-State: AOJu0YxD7Q0pZWZLglq+oJvyf3difTrT4ZpkhuytDB8XgKPjwjsHPDA7
	SwOhnQNHLuk3ntcP3Q++Ln4D4uDauWFHlKsNrGp/9VXXLCBfEWyS
X-Google-Smtp-Source: AGHT+IGXWHc3SskqLSYMunnZyVA254pi7dL+8Z+sk0Sjekr3pSPLjz3SFgIh9FFj6RbWe7uRZFuSaA==
X-Received: by 2002:a05:600c:1c05:b0:42c:b63e:fea6 with SMTP id 5b1f17b1804b1-42e961362e8mr29653805e9.22.1727300805834;
        Wed, 25 Sep 2024 14:46:45 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42e96a1f2aasm28802565e9.45.2024.09.25.14.46.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Sep 2024 14:46:44 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Richard Weinberger <richard@nod.at>,
	Vignesh Raghavendra <vigneshr@ti.com>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Simon Glass <sjg@chromium.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Christian Brauner <brauner@kernel.org>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	=?UTF-8?q?Rafa=C5=82=20Mi=C5=82ecki?= <rafal@milecki.pl>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	linux-mtd@lists.infradead.org,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [RFC PATCH v2 3/5] block: add support for partition table defined in OF
Date: Wed, 25 Sep 2024 23:45:23 +0200
Message-ID: <20240925214544.6114-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240925214544.6114-1-ansuelsmth@gmail.com>
References: <20240925214544.6114-1-ansuelsmth@gmail.com>
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
devices where a "partitions" node is expected to be declared in the OF
node of the disk device (mmc-card for eMMC for example) and each child
node declare a label and a reg with offset and size. Eventually is also
possible to declare the read-only property to flag the partition as
read-only.

For eMMC block, driver scan the disk name and check if it's suffixed with
"boot0" or "boot1".
This is to handle the additional disk provided by eMMC as supported in
JEDEC 4.4+. If this suffix is detected, "partitions-boot0" or
"partitions-boot1" are used instead of the generic "partitions" for the
relevant disk.

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 block/partitions/Kconfig  |   8 +++
 block/partitions/Makefile |   1 +
 block/partitions/check.h  |   1 +
 block/partitions/core.c   |   3 +
 block/partitions/of.c     | 144 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 157 insertions(+)
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
index 000000000000..fdc033107bcb
--- /dev/null
+++ b/block/partitions/of.c
@@ -0,0 +1,144 @@
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
+	info = &state->parts[slot].info;
+	partname = of_get_property(np, "label", &len);
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
+	if (!partitions_np)
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

