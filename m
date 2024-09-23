Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BAE9198E81;
	Mon, 23 Sep 2024 11:00:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727089215; cv=none; b=bAXf5z2kqxejGWMcnkY+QXKtRNc5M4nv2Hqpuppo1N3IyGUwBVnu2LMFZt9CsezY/VYnSCMaDaqVxTXl76MrFwhziFf2krWXnK4InnXwk5lNWUyE+bv2kRdX9pwKNyyDgmNi0S/UDkyaC6SPSSodcSSE/BhN4COvndDrKtBjlZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727089215; c=relaxed/simple;
	bh=AAUW5AeuiKrXpIHD/TmOnrKvsD3GPu+ctHY8R9WVrbw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AXaj1tncZawqu6EMjqqOJC0YdlHeJX1I3c71NGuI9eGD4brvcXROXIasFno5DmR+t7p0cwT61bJd/xk/NtqrVPGfvUzTgpBou/7ROJlVuBcxXsD8H2nAYOdu4XpBn5PdDsxueKYzRTckPdoezVxNNVT4NtReGw5Vn7TVsN9OJug=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Wh6FPr4E; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Wh6FPr4E"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42cb7a2e4d6so38068295e9.0;
        Mon, 23 Sep 2024 04:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727089211; x=1727694011; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0J8gDMucjxpOg+RLl5wRybpqYOL20vywcDEytKDdvEc=;
        b=Wh6FPr4EzoBUSHyU4cvFmIpaH/Dfgd5oep1Lbz28d6FahA46Z9VTcNuVzIUUbbhwW8
         SwPi+TejIBU68/2Cil0v3794aoiAdRO78Jr3U7jDZ+Dd+yI7n8SVeOyhXgRQnw/A5GeD
         ACbhsMk9PiKt7aX/s3iG2F3O+QedUsrTL6gNvGOHwWiIjwFJDH+svbVCqXBkUKUAFqEy
         YGTqQag8awGyRocermWGuUYgPIYi/oq/rt6yr4FpWUMC1nIoG+/NafOLHlENQoji7CN3
         X/tUTTqFFtKQEOht6bVINTE47Dvo62t6noyGkgK3EFlV09nrnch5551dNY1pci/fGZuU
         mxVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727089211; x=1727694011;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0J8gDMucjxpOg+RLl5wRybpqYOL20vywcDEytKDdvEc=;
        b=Vk60W3Q9CFoYHDopQOb/O+GksXqqE6KvzrWnjyELBPAJh3kQgIkFKSxk68mjxS7jUr
         i+6btTnG74HtAkttt30vP6+PzM9QigjIadCyvlUjKXJpoJ999jdd2kFf0RveeDFJgcMC
         v9jBhCtUa6gwMKF+TwfZgiEyXIBtJcwW2Cn8npAzHPHTiqDzZU6iRc1j7y4SW7C+auKI
         nfSXcM/RIOznedA94MkNAfFX3WXOA125Q0weUSqrIntXnVq1F2acKmyjaL8vldAH456j
         F8U5YVKf9XgGo/c5eS4QSDSvNsRCoc3wGNGoJnjT33pGSaJ2tnUWW170h5GqfVSzN2j+
         tDwA==
X-Forwarded-Encrypted: i=1; AJvYcCU3FzJKRQEAa/+GABl7Klv+BoyntHyCCqqly7HUZLOES7norOiwJ67cGRD5eKtu+BEyl4RE+UA30eIijU0=@vger.kernel.org, AJvYcCVuaCX8KZw6LchblAYYb3AS7dlZScf6l1b4o+HiJVT4UufjWFRoXufnv4yhiUE5tZCrZiexwUE2lrn2zsVV@vger.kernel.org, AJvYcCWDXzV8Fdx0XOeapuC+UwkDaZrj1g9O0EXtvWG0+Qrumxajd4XtqkLJSwi9/DAGvha444vIVdVG88Bk@vger.kernel.org, AJvYcCWZhXXw3t8smBs205GGBv5UjOlrNcr6AgeckwYI2bJSsU1FUnNIb3E0XUc9QNcR/CfQSmpSpZ5If04e@vger.kernel.org, AJvYcCXN9L+s6RkhifMt8qun94U+2ls8k7a3EMHbE+1cs1DdxP4zcp9/M/tdRQtlht/6Vy2AJl6IHzz9MfUk@vger.kernel.org
X-Gm-Message-State: AOJu0Ywhv8g7R1xhSgLMGYiqju15CMXbsdTNvXG4L4Zg7GTvaP8731F1
	+HS+7ce4WiddhN9HStfxOCqNDOJbH/ySf9yEIGjCtFJn3F6NEnEE
X-Google-Smtp-Source: AGHT+IFeb78k1+laVLSiQw856wlmUQHHbPVCt0dUfiaaxlf+k4rQ9ERm4Xf6Ji92ZB1ddQNxoAu1uQ==
X-Received: by 2002:a5d:4c44:0:b0:371:8319:4dcc with SMTP id ffacd0b85a97d-37a422520c3mr6639710f8f.2.1727089211311;
        Mon, 23 Sep 2024 04:00:11 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42e7afd7490sm97856615e9.28.2024.09.23.04.00.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Sep 2024 04:00:11 -0700 (PDT)
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
	Ming Lei <ming.lei@redhat.com>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Lorenzo Bianconi <lorenzo@kernel.org>
Subject: [RFC PATCH 3/4] block: add support for partition table defined in OF
Date: Mon, 23 Sep 2024 12:59:32 +0200
Message-ID: <20240923105937.4374-4-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240923105937.4374-1-ansuelsmth@gmail.com>
References: <20240923105937.4374-1-ansuelsmth@gmail.com>
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

The driver scan the disk name and check if it's suffixed with boot0 or
boot1. This is to handle the additional disk provided by eMMC or UFS
devices in general. If this suffix is detected, "partitions-boot0" or
"partitions-boot1" are used instead of the generic "partitions"

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
---
 block/partitions/Kconfig  |  8 ++++
 block/partitions/Makefile |  1 +
 block/partitions/of.c     | 85 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 94 insertions(+)
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
diff --git a/block/partitions/of.c b/block/partitions/of.c
new file mode 100644
index 000000000000..1c420b7f53c0
--- /dev/null
+++ b/block/partitions/of.c
@@ -0,0 +1,85 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/blkdev.h>
+#include <linux/of.h>
+#include "check.h"
+
+#define BOOT0_STR	"boot0"
+#define BOOT1_STR	"boot1"
+
+static struct device_node *get_partitions_node(struct device_node *disk_np,
+					       const char *disk_name)
+{
+	const char *node_name = "partitions";
+
+	/* Check if we are parsing boot0 or boot1 */
+	if (!memcmp(disk_name + strlen(disk_name) - strlen(BOOT0_STR),
+		    BOOT0_STR, sizeof(BOOT0_STR)))
+		node_name = "partitions-boot0";
+	if (!memcmp(disk_name + strlen(disk_name) - strlen(BOOT1_STR),
+		    BOOT1_STR, sizeof(BOOT1_STR)))
+		node_name = "partitions-boot1";
+
+	return of_get_child_by_name(disk_np, node_name);
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
+	offset = of_read_number(reg, a_cells);
+	size = of_read_number(reg + a_cells, s_cells);
+
+	put_partition(state, slot, offset, size);
+
+	if (of_property_read_bool(pp, "read-only"))
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
+	int slot = 1;
+
+	disk_np = of_node_get(ddev->parent->of_node);
+	if (!disk_np)
+		return 0;
+
+	partitions_np = get_partitions_node(disk_np,
+					    state->disk->disk_name);
+	if (!partitions_np)
+		return 0;
+
+	for_each_child_of_node(partitions_np, np) {
+		if (slot >= state->limit)
+			return -1;
+
+		add_of_partition(state, slot, np);
+
+		slot++;
+	}
+
+	strlcat(state->pp_buf, "\n", PAGE_SIZE);
+
+	return 1;
+}
-- 
2.45.2

