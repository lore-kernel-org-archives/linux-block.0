Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E431CF7DF;
	Tue,  1 Oct 2024 22:20:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727821251; cv=none; b=nVMqf5nNLutsC+no0IGJ0COu5t81qJ6gOlfz1vjXL5/R8tj8WRo8BXJOUilcwY/E2HrWkdOo+lLJh0QLi25sF+jFvlsS0WEpUIP8oomDeYCxnv7hU66ZhY4uR87saUIyhIS7oNf+ESI5ssyWXUDPwa5hKJCx+nYmGRJBnTXNFjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727821251; c=relaxed/simple;
	bh=OwoSKnytU2lo8Y70wF6lF1REL5Hoitw9aEPEvbYRD/I=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lDL+xn9ueOS5KVszOfYCqOuH6oTRIR4hHGp0QpoG0XBRdXZe18VRcSeAHIed3vldnnPJe+MAdKkJ/ey1Oqa/lOO8IenRg3gMLMkYaCaefVjCKK22u2KAutJ2EElN2NPgDuJPvxSf5P8YaqZdCTTEEC5YadwCgRvTljxxNtQ5oVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WcFqdIU+; arc=none smtp.client-ip=209.85.128.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WcFqdIU+"
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-42cafda818aso57940655e9.2;
        Tue, 01 Oct 2024 15:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727821248; x=1728426048; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k4AkUu8bjS9tIJ6QbG7OaPFKTVmhOX5XEg0AdMpU3gU=;
        b=WcFqdIU+gSV0Dx32kbUbuGW4+rOUvHt2GTwRDFDMoA60o/IMZD5dDWWoCKOtNDIAxP
         jhVn6Wo1f/pyBOel6vNzJhp4OrHCRp0XQMWgh7txtu3H9hvAvqRxAxmNljB+txPIp1hw
         zLCm4GGp816wvMYZQcXcB8TfbDA5EKO0UOGvlqh7Agl2DcRmpFdn/s7r53+IY/9rGIt2
         /CDxMyQwFoX6YiTF7u7Fe84rmOXdAKfPkP6+fWgXJpsRIpEjCZS7+WsZw/PUpia8meRS
         RTsAtkTjJ1QiBKw82mVAuqYi4iues2kncIg1aerM1uibuobXviMkX6O/KE4npBHjhWzB
         +IDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727821248; x=1728426048;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4AkUu8bjS9tIJ6QbG7OaPFKTVmhOX5XEg0AdMpU3gU=;
        b=hx0Hi6MlwwwBNpHfstwgOqJAaIAymypYHzjsiCtCwJGdqiE7mVDSbqPF3+hY75tcFF
         194fPt5pYrRbCAc4/BFOT9DpPL2NVMpotcVWVzGW31RJ+6lRcQ5hIoqMx0F2fsuO3dGR
         +wNm5IYy4ses4VKUYMwOzZE/eIFXG/v+pYr/42pDi1SJekmnuE8knjKd82SG17dttdIt
         FdBya+vjS/l0X+ZXNwGZaq0j7oKXG+VdTXFUbdwPwOOIkdNVKw7igdpwR8d0sz7Al1K7
         4HNQ4kve9PSOzbkzfKt12iUOhXqCpI+xI3RGUiVspbUCUniV9Jo9e9TW13xHaci+VuG9
         TM9A==
X-Forwarded-Encrypted: i=1; AJvYcCUJGKBLunKigQQEdQzaS5GTNoKqQXS2WwjgkrtGdqDtj4la5pN5+jYmdMeUEbR0uIjOtDOenLTliPIi@vger.kernel.org, AJvYcCV0IvMJiaBz0dTYMV4mN14QsINhAvF+vomwV37FZfdVKSsE+GdAXr0a+RwkdeTKOdRWwZc46odSRci/@vger.kernel.org, AJvYcCVNb4CkjS6LwJAPu3pI1Tjt9mhyQvzeg4i/KYz+PeEadWXP9j+WFPqKflLJ4z79rb0tTWDNQ4bqrmyeB3o=@vger.kernel.org, AJvYcCXNfSrZYlwrzmNYWsHmqi/oBiqV+9oKt4bVyvcIc66TpGvZC0NIwu9nWVQ+6j3fQjH56l+IGKwNAu3qJcTs@vger.kernel.org, AJvYcCXkNIGf8Mxgbsochb1a+f29PQLqnojwZWA+f4Cb6rE6svNwqhrq+I/CunQ4pLunXkdNpJKg73am5lPQ@vger.kernel.org
X-Gm-Message-State: AOJu0Yy8lELI4QWuV+pD6NRemaaB/czwTgoYAGVhvI6vWXWUfwfYpDhw
	CAJtDZ2TeSh+AFS5UVpxHm/rCDkk8Fykj2eTgmDQXsAi6AICVEHk
X-Google-Smtp-Source: AGHT+IEB0pxd++8ewSjqWqNceMDYbX1czBZlzOasDEvdeiL50XPFZ+s6vBysrS7bvy9zMGbP7yMudQ==
X-Received: by 2002:adf:cd09:0:b0:37c:ced2:843b with SMTP id ffacd0b85a97d-37cfb8c744bmr760852f8f.20.1727821247236;
        Tue, 01 Oct 2024 15:20:47 -0700 (PDT)
Received: from localhost.localdomain (93-34-90-105.ip49.fastwebnet.it. [93.34.90.105])
        by smtp.googlemail.com with ESMTPSA id ffacd0b85a97d-37cd57427fbsm12677089f8f.100.2024.10.01.15.20.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Oct 2024 15:20:46 -0700 (PDT)
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
	Jan Kara <jack@suse.cz>,
	Li Lingfeng <lilingfeng3@huawei.com>,
	Christian Heusel <christian@heusel.eu>,
	Avri Altman <avri.altman@wdc.com>,
	Adrian Hunter <adrian.hunter@intel.com>,
	Linus Walleij <linus.walleij@linaro.org>,
	Mikko Rapeli <mikko.rapeli@linaro.org>,
	Riyan Dhiman <riyandhiman14@gmail.com>,
	Jorge Ramirez-Ortiz <jorge@foundries.io>,
	Dominique Martinet <dominique.martinet@atmark-techno.com>,
	Jens Wiklander <jens.wiklander@linaro.org>,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	Li Zhijian <lizhijian@fujitsu.com>,
	linux-block@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-mmc@vger.kernel.org,
	devicetree@vger.kernel.org,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	upstream@airoha.com
Subject: [PATCH v5 5/6] block: add support for partition table defined in OF
Date: Wed,  2 Oct 2024 00:18:57 +0200
Message-ID: <20241001221931.9309-6-ansuelsmth@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241001221931.9309-1-ansuelsmth@gmail.com>
References: <20241001221931.9309-1-ansuelsmth@gmail.com>
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
---
 block/partitions/Kconfig  |   9 +++
 block/partitions/Makefile |   1 +
 block/partitions/check.h  |   1 +
 block/partitions/core.c   |   3 +
 block/partitions/of.c     | 116 ++++++++++++++++++++++++++++++++++++++
 5 files changed, 130 insertions(+)
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
index 000000000000..7ddde69bcdc2
--- /dev/null
+++ b/block/partitions/of.c
@@ -0,0 +1,116 @@
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
+	struct device_node *partitions_np, *np;
+	struct device *ddev = disk_to_dev(state->disk);
+	int slot;
+
+	partitions_np = of_node_get(ddev->of_node);
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

