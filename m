Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FAE819F118;
	Wed,  2 Oct 2024 22:13:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727907238; cv=none; b=nPYaZZh4bG7mP0DbEXXHFYSkD1tHb6J6Cye7x/9cojV4J4tTZp8q+jUDQ7O0rOhJMvAQBaRtyOrC7OoN1bz1Dq11GNmAsfXDZj0ZguB//Ou16WSZAqAsnhHACMjdklm06FdpQxdXDW4i0As5dlcK4F1XANVCvenWMkuTvOHlDRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727907238; c=relaxed/simple;
	bh=q+7Rx61HQ8wAyF0VBzlMN/9HWZXUHIpSk8xFA2Mt5yk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QtsFq+p/jc3EvZ4rpszzfyPvnljYw/g26y8+YXMdyUjCEKvJTbYQ053mtxLj8aia3VONtEyAIDgMQaGv600Jn+otUDBa56AxRZDEKZs9g68RnXUSx7y6+O26avsOvNigXrKgv2J0ywmAOYpXQan1jdJfc/sUfZp3DqbTMkdGoQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X0w4cg+Z; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X0w4cg+Z"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-42cb8dac900so1913195e9.3;
        Wed, 02 Oct 2024 15:13:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727907234; x=1728512034; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O5BLqLkzjd+8imWtdXlNJCotcWIcabn4SehzzKXfQR8=;
        b=X0w4cg+ZkvkOhWv3YZKhLOJsbg8N8c1Eyb0eESombmxlxiMu4aGqQxcpWAXM9gXylm
         BD7N5786eEDlXo2DUVBbOZqvlEOS9hWtgXEHjJ1Ig4orZEYfu1qt+64lCnMCPZuT3ga1
         KZgr8AxBxraf2f18RDjSe2LkyQi0XydjX3d2Wl6ZRdZ0uGvCAfgcv324jQbaqpnlGHaL
         HYDHYMd4cJYalHuz4qx0fS5zKqpsr3nD829ubYUeqQDP66MH23PaRSMv217+YZjzuQIv
         nyPkSgWekkm9HqH8KN0h0avT3unYmFzImJR12tXvbP13WNe/wptYoMKvlkA/3vg6LxQH
         GpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727907234; x=1728512034;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O5BLqLkzjd+8imWtdXlNJCotcWIcabn4SehzzKXfQR8=;
        b=T2sUfLkkCF7h1HhJ0WKbeRmB5LqJc5FlutVGCy1WX3gMHHO+zHylqSDX3zGvaOhaQp
         Wrt+gNteBpKdu4U1JzR464v36om75/uAy+PWv2s/f/bD2f9EgJJnd1LARz6Tgho59y2c
         OWX7PEkMea4KSC5UyCQyU7UcpwuaRKlvWMqvUnzWtRqtajWRS3451PTGBjsWyKa1ZNI3
         ALgIojbeBlvEhM3fbXJEr3nxTAl49vzYDjVWHCbaK7y8KaQ9jHdhpeID79EjIWDArC/H
         p5wRH/r+y3lO8juYq+F/4kBCKKmr6B2bGVV3mVwOuPXDS+534/Uu5TpeAViK95vKnxAi
         KSew==
X-Forwarded-Encrypted: i=1; AJvYcCU9QtW+BvzkBXAIwWSdREcT6cNfxlOz7PJj7iWwc9zMliTCU4UAX7oq4XN/Zq7tDgib7N7JmmLtStjdwUM=@vger.kernel.org, AJvYcCUeKZ30NF7OT0qroS7U43jRrUieNH4NyaCK//xJAUeusgnMXO0+ftaZZQcP5cdT3kvIytBq/A1sQRUr@vger.kernel.org, AJvYcCUjvI0ZzdCQBdgBYoSa1Oi28Y9dUICI2AQrapo9GwMlCbhwDTtoYfMh+edAul3SpEAy0hfxz2lapC2k@vger.kernel.org, AJvYcCVvKP9EdUvN13qb9eKWELiiS/MGTbRvzSoJ15jkyfasAcECVj4vhRcCAu6yJzYbU9h9Welusv087CeQd3Gu@vger.kernel.org, AJvYcCWUZsh47LH9alOe3lxqjBfCqpkIfW6kACRzfgQtM0aI5Oi9tD6MXTQwdddU78CVbpPOC1qg410blTcA@vger.kernel.org
X-Gm-Message-State: AOJu0YypXbVX9hzh2f3V2cpfRTh3x2TVYZ8mpFAsNYpXO08X0gGHlsrf
	x4kqJVLfuXuwAuoWxKAx47H4cdtMSptOFtRfYcSiFOGDSrAjOK/2
X-Google-Smtp-Source: AGHT+IE2dHx3HMbl76J81laPZhJX3CXS3d/10Coh3qgcJxdllqn+R5iCbku56fuFzLCOMy4uYffQtQ==
X-Received: by 2002:a05:600c:4f4a:b0:42c:af06:703 with SMTP id 5b1f17b1804b1-42f778f4393mr35430025e9.31.1727907234211;
        Wed, 02 Oct 2024 15:13:54 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id 5b1f17b1804b1-42f79ead1absm29218245e9.17.2024.10.02.15.13.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:13:53 -0700 (PDT)
From: Christian Marangi <ansuelsmth@gmail.com>
To: Jens Axboe <axboe@kernel.dk>,
	Jonathan Corbet <corbet@lwn.net>,
	Ulf Hansson <ulf.hansson@linaro.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Christian Marangi <ansuelsmth@gmail.com>,
	Daniel Golle <daniel@makrotopia.org>,
	INAGAKI Hiroshi <musashino.open@gmail.com>,
	Christian Brauner <brauner@kernel.org>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Ming Lei <ming.lei@redhat.com>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Avri Altman <avri.altman@wdc.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Jorge Ramirez-Ortiz <jorge@foundries.io>,
	Li Zhijian <lizhijian@fujitsu.com>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	upstream@airoha.com,
	Christoph Hellwig <hch@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH v6 5/6] block: add support for partition table defined in OF
Date: Thu,  3 Oct 2024 00:11:45 +0200
Message-ID: <20241002221306.4403-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241002221306.4403-1-ansuelsmth@gmail.com>
References: <20241002221306.4403-1-ansuelsmth@gmail.com>
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

Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
 block/partitions/Kconfig  |   9 ++++
 block/partitions/Makefile |   1 +
 block/partitions/check.h  |   1 +
 block/partitions/core.c   |   3 ++
 block/partitions/of.c     | 110 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 124 insertions(+)
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
index 000000000000..4e760fdffb3f
--- /dev/null
+++ b/block/partitions/of.c
@@ -0,0 +1,110 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/blkdev.h>
+#include <linux/major.h>
+#include <linux/of.h>
+#include <linux/string.h>
+#include "check.h"
+
+static int validate_of_partition(struct device_node *np, int slot)
+{
+	u64 offset, size;
+	int len;
+
+	const __be32 *reg = of_get_property(np, "reg", &len);
+	int a_cells = of_n_addr_cells(np);
+	int s_cells = of_n_size_cells(np);
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
+	const char *partname;
+	int len;
+
+	const __be32 *reg = of_get_property(np, "reg", &len);
+	int a_cells = of_n_addr_cells(np);
+	int s_cells = of_n_size_cells(np);
+
+	/* Convert bytes to sector size */
+	u64 offset = of_read_number(reg, a_cells) / SECTOR_SIZE;
+	u64 size = of_read_number(reg + a_cells, s_cells) / SECTOR_SIZE;
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
+	struct device *ddev = disk_to_dev(state->disk);
+	struct device_node *np;
+	int slot;
+
+	struct device_node *partitions_np = of_node_get(ddev->of_node);
+
+	if (!partitions_np ||
+	    !of_device_is_compatible(partitions_np, "fixed-partitions"))
+		return 0;
+
+	slot = 1;
+	/* Validate parition offset and size */
+	for_each_child_of_node(partitions_np, np) {
+		if (validate_of_partition(np, slot)) {
+			of_node_put(np);
+			of_node_put(partitions_np);
+
+			return -1;
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
+	return 1;
+}
-- 
2.45.2

