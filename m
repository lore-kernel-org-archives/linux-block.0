Received: from smtp.gentoo.org (woodpecker.gentoo.org [140.211.166.183])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C9E1225761
	for <linux-block@vger.kernel.org>; Fri,  4 Jul 2025 18:30:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.183
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751653806; cv=none; b=lv7P3flAWLO8OS9vY667RK6LIubIZWPFSD/28pZQIyoGvJzo6de9QaMXJqpHmnI9/jJSMykOJfa0zLSVKFliHlSuu6LeW46gOolnxZ0BZctQhu+Kwsn3fHjYhztblldCmZR1gT3ODV5XNfUFtUbUrL6DytkFqynrmyI+ENsfa40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751653806; c=relaxed/simple;
	bh=l1XUot6t31BKfQ2g+v50CHmHImQMZroV95qQTp5JJ44=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GiXvJ8DraIcCjOa9QO6s0Wuqdr0hSXb1gvrA1ebnL35GF9vJ+TNdZwEskTPkVbLFKhrstr8tq+BWPaXB7cyNdAlxMw2rqXDxZf1hEvI7gqAyJRrfTxH4ZPdlWw3nFQCAcwSdxFdk6TkFq+7RMQFjw6ml5lG/5nmC3+Oq4u2nXFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org; spf=pass smtp.mailfrom=gentoo.org; arc=none smtp.client-ip=140.211.166.183
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gentoo.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gentoo.org
Received: from doudna.orbis-terrarum.net (doudna.orbis-terrarum.net [IPv6:2a01:4f9:4b:19c2::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: relay-lists.gentoo.org@gentoo.org)
	by smtp.gentoo.org (Postfix) with ESMTPSA id CF1DD340FAB;
	Fri, 04 Jul 2025 18:30:02 +0000 (UTC)
Received: from bohr-int.orbis-terrarum.net (node-1w7jr9qj3rbr48myelzfsw8ag.ipv6.telus.net [IPv6:2001:569:72ba:9300:305f:add3:6c04:99f8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (prime256v1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: robbat2-bohr@orbis-terrarum.net)
	by doudna.orbis-terrarum.net (Postfix) with ESMTPSA id 4bYhxy4kTPzB6WB;
	Fri, 04 Jul 2025 18:29:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.10.3 doudna.orbis-terrarum.net 4bYhxy4kTPzB6WB
Authentication-Results: OpenDKIM@doudna/4bYhxy4kTPzB6WB; dkim=none;
	dkim-atps=neutral
Received: (nullmailer pid 3870 invoked by uid 10000);
	Fri, 04 Jul 2025 18:28:54 -0000
From: "Robin H. Johnson" <robbat2@gentoo.org>
To: linux-block@vger.kernel.org
Cc: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: [PATCH] block/partitions: detect LUKS-formatted disks
Date: Fri,  4 Jul 2025 11:28:53 -0700
Message-ID: <20250704182853.3857-1-robbat2@gentoo.org>
X-Mailer: git-send-email 2.47.0
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If an entire device is formatted as LUKS, there is a small chance it
maybe be detected as an Atari/AHDI disk - causing the kernel to create
partitions, and confusing other systems.

Detect the LUKS header before the Atari partition table to prevent this
from creating partitions on top of the LUKS volume.

Link: https://unix.stackexchange.com/questions/561745/what-are-the-md-partitions-under-a-mdadm-array
Link: https://github.com/rook/rook/issues/7940
Link: https://bugs.launchpad.net/ubuntu/+source/util-linux/+bug/1531404
Signed-off-by: Robin H. Johnson <robbat2@gentoo.org>
---
 block/partitions/Kconfig  |  8 +++++++
 block/partitions/Makefile |  1 +
 block/partitions/check.h  |  1 +
 block/partitions/core.c   |  3 +++
 block/partitions/luks.c   | 46 +++++++++++++++++++++++++++++++++++++++
 5 files changed, 59 insertions(+)
 create mode 100644 block/partitions/luks.c

diff --git a/block/partitions/Kconfig b/block/partitions/Kconfig
index ce17e41451af..341880eeb8f1 100644
--- a/block/partitions/Kconfig
+++ b/block/partitions/Kconfig
@@ -96,6 +96,14 @@ config AMIGA_PARTITION
 	  Say Y here if you would like to use hard disks under Linux which
 	  were partitioned under AmigaOS.
 
+config LUKS_PARTITION
+	bool "LUKS partition support" if PARTITION_ADVANCED
+	default y if ATARI_PARTITION
+	help
+	  Say Y here to detect hard disks which have a LUKS header instead of a
+	  partition table. This is valuable as LUKS header may also be wrongly
+	  detected as other partition types.
+
 config ATARI_PARTITION
 	bool "Atari partition table support" if PARTITION_ADVANCED
 	default y if ATARI
diff --git a/block/partitions/Makefile b/block/partitions/Makefile
index 25d424922c6e..d6a68b45bb2f 100644
--- a/block/partitions/Makefile
+++ b/block/partitions/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_AIX_PARTITION) += aix.o
 obj-$(CONFIG_CMDLINE_PARTITION) += cmdline.o
 obj-$(CONFIG_MAC_PARTITION) += mac.o
 obj-$(CONFIG_LDM_PARTITION) += ldm.o
+obj-$(CONFIG_LUKS_PARTITION) += luks.o
 obj-$(CONFIG_MSDOS_PARTITION) += msdos.o
 obj-$(CONFIG_OF_PARTITION) += of.o
 obj-$(CONFIG_OSF_PARTITION) += osf.o
diff --git a/block/partitions/check.h b/block/partitions/check.h
index e5c1c61eb353..eddab0d5b4ec 100644
--- a/block/partitions/check.h
+++ b/block/partitions/check.h
@@ -60,6 +60,7 @@ int efi_partition(struct parsed_partitions *state);
 int ibm_partition(struct parsed_partitions *);
 int karma_partition(struct parsed_partitions *state);
 int ldm_partition(struct parsed_partitions *state);
+int luks_partition(struct parsed_partitions *state);
 int mac_partition(struct parsed_partitions *state);
 int msdos_partition(struct parsed_partitions *state);
 int of_partition(struct parsed_partitions *state);
diff --git a/block/partitions/core.c b/block/partitions/core.c
index 815ed33caa1b..fb21a9e08024 100644
--- a/block/partitions/core.c
+++ b/block/partitions/core.c
@@ -67,6 +67,9 @@ static int (*const check_part[])(struct parsed_partitions *) = {
 #ifdef CONFIG_AMIGA_PARTITION
 	amiga_partition,
 #endif
+#ifdef CONFIG_LUKS_PARTITION
+	luks_partition, /* this must come before atari */
+#endif
 #ifdef CONFIG_ATARI_PARTITION
 	atari_partition,
 #endif
diff --git a/block/partitions/luks.c b/block/partitions/luks.c
new file mode 100644
index 000000000000..4185ca64630d
--- /dev/null
+++ b/block/partitions/luks.c
@@ -0,0 +1,46 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ *  fs/partitions/luks.c
+ *  LUKS on raw partition; this is important because a LUKS volume may detected
+ *  as a valid Atari partition table, breaking other detection.
+ *
+ *  Copyright (C) 2025 Robin H. Johnson (robbat2@gentoo.org)
+ *
+ *  Reference: https://gitlab.com/cryptsetup/LUKS2-docs/blob/master/luks2_doc_wip.pdf
+ *  Page 5, Figure 2: LUKS2 binary header on-disk structure
+ *  This only looks for the Magic & version; and NOT a UUID that starts at
+ *  offset 0xA8.
+ */
+
+#include <linux/ctype.h>
+#include <linux/compiler.h>
+#include "check.h"
+
+#define LUKS_MAGIC_1ST_V1		"LUKS\xba\xbe\x00\x01"
+#define LUKS_MAGIC_1ST_V2		"LUKS\xba\xbe\x00\x02"
+#define LUKS_MAGIC_2ND_V1		"SKUL\xba\xbe\x00\x01"
+#define LUKS_MAGIC_2ND_V2		"SKUL\xba\xbe\x00\x02"
+
+int luks_partition(struct parsed_partitions *state)
+{
+	Sector sect;
+	int ret = 0;
+	unsigned char *data;
+
+	data = read_part_sector(state, 0, &sect);
+
+	if (!data)
+		return -1;
+
+	if (memcmp(data, LUKS_MAGIC_1ST_V1, 8) == 0
+		|| memcmp(data, LUKS_MAGIC_2ND_V1, 8) == 0) {
+		strlcat(state->pp_buf, "LUKSv1\n", PAGE_SIZE);
+		ret = 1;
+	} else if (memcmp(data, LUKS_MAGIC_1ST_V2, 8) == 0
+		|| memcmp(data, LUKS_MAGIC_2ND_V2, 8) == 0) {
+		strlcat(state->pp_buf, "LUKSv2\n", PAGE_SIZE);
+		ret = 1;
+	}
+	put_dev_sector(sect);
+	return ret;
+}
-- 
2.47.0

