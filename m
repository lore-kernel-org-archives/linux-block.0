Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED5639E19C
	for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 22:39:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774651147; cv=none; b=vEcOguq1+CMIqWwnNUvSIqCg0PxC9OtkYRHDxViQlG0FfZ+NxLvg9WeHk71yhe5C3y9tzIeKTcJxrm+3J/pm18RrfD/PuJuAlyOQE1Rk7OCBcviDVQ08jj/QKLh0+U1AkaNrr+xRNRGWRQbZDHU6Ffj3vocyxolR39HCH+OOjn8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774651147; c=relaxed/simple;
	bh=ja6fQL3xzEp+MifD3C46o4W+jVIPpva2DNjqEa3dgp4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Hp5V0cc+ym5cHJ8ZAn5v9k3pvP3vXxtumL+J90kLBaX0tZgQOTZB4hy09JbjWuWIZO7QB61a2zRXNhWfB0zAoJ4x0qOrq1SYHYZSux+e013URw3/f1wHKNgqnDWJFGh9hzmyZOCzrW/5YbsUHNTZT3Su1OAPe5zrfXbs6x8AcHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com; spf=pass smtp.mailfrom=linbit.com; dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b=Y+WVAU7M; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit-com.20230601.gappssmtp.com header.i=@linbit-com.20230601.gappssmtp.com header.b="Y+WVAU7M"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-439c6fc2910so1821645f8f.0
        for <linux-block@vger.kernel.org>; Fri, 27 Mar 2026 15:39:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20230601.gappssmtp.com; s=20230601; t=1774651143; x=1775255943; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IhOnn/wb7WFobwQqumEySh09VTDzjUSgTL5/07+X8/Q=;
        b=Y+WVAU7MAycdzXTrhIZg3XZeBznoOSIs8yaEbLIGj3KlarIPivIjOrwzFm9AoAJJd/
         EhPTgVPWxmk9KUJFB3GTzsImpMniN5rNAZt+cNBw7qgl/dWpKi46P8+i17TZIVrPhA1T
         HbIthBN+Hhmj5qGbEM+Q59DoVK5AKU+fApHkxAIQq2dsKY64okTZkAufCwUDnV1YIe0S
         6H412tn8+p/ppGjIIfsIWBwuLZOnRTianPm8k3BW6kWbwnxdULIMj3O6+Ip6sUzzHBIG
         uDWqOnNSMAzNxaS5fhNY3vwUQT0uc5kBNxteXrkH9BMQY6d8f61+eJ5xqXF8J1/rN2SL
         hiTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774651143; x=1775255943;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=IhOnn/wb7WFobwQqumEySh09VTDzjUSgTL5/07+X8/Q=;
        b=CcWHMbdVgbNd+NN1RQsBGgo6tjJJtybCpjNSWVw1qK1ne4m+jrmrK/y/xVVKZAy71g
         dbELaj3EvDTH11bHiWOtq0OcBylEkoSc73xtDlnrenCa4hPneAqW7n+ynoGGw44VoWHT
         m3yRnw2F3cySaXBOZMNNnAxUBKGdfuDOQ5AQOjSqYFO6HcBGvk20rFQLTbHuErUDdI2T
         NbNkEyDVTxjMcig7rDAbnEWSM5B+KSjZmCrpT3rguSDGEg7z+t9FI7zKVPRNryFFW5Zk
         pe+vZnGG6REGODKMyXIM5/cPji/e/eKcYmHk+N610HorNJcSUa3po/e+sw1FqYHkGngO
         gQ/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVVOCoCBurWgxMN5risUb8tbfEUn9ObLj/cOGdXPXFOzSxGgtebn4kW0Ze/LC7Y1YYGZJey+5MOV7MB7g==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy3EaujlUPVd+BA5RWBDLJdRl3HvdahB/6tcleYBvQjiNG33NyN
	YBIDyaPDlLwVDT68KC6nt9bzHRy8ddSLTLM8aQC6OWx0UxYpps3E+c3+nBTJu9uqmuo=
X-Gm-Gg: ATEYQzwZ6qvsorAJD94CI7wd/4bKULdeW67Y/hqh7Ro1UCFKEfIWqReW1I+NvsFNjlj
	4z54NL6poJ7UgaZKUPcQOUFRwZIU4I82j2DHbW7+RswhI3P2wy4hgr0u7IaC5ySem3Khif5e55c
	+KU79vNaPigCaQ/ZsFMuu+G8mrbAH7qB5PgGcV22crD2ZvB0QfdfkVlfzaBRCQzAeLNP0UXuXZQ
	KYuXEWTFuQyJr4uZojh4P1Yce7Jvd0oFNvOzwys7aLA1lyXGvYpgbaHOfxrA66rQQGRYHlvBY/p
	r0aQZDn549ZjIX60yqGat8EdavSnxtbEfV89rG2a2+FONXWffk0SbK216NMdj5ABEdSXwdNad4s
	YoMVH+Wr0B2Ph0yt7o8vxk8f4HziVejgt/VPtgRrn93kIvO4jNRlDlQPyI0DSAchA1b9+KUymUN
	1kUXuSzyMFK0bjf+0p21D6WjgiZrAJRl5dNTnm67aPo5a1xg4rUemuJbWUH/X78nVq9U5O0T+I/
	ByL3+QiUpGxYigroIguoQ==
X-Received: by 2002:a05:600c:c178:b0:487:59c:2bb8 with SMTP id 5b1f17b1804b1-48727ef16bamr70779795e9.27.1774651143284;
        Fri, 27 Mar 2026 15:39:03 -0700 (PDT)
Received: from localhost.localdomain (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43cf247079esm998990f8f.25.2026.03.27.15.39.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Mar 2026 15:39:02 -0700 (PDT)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linbit.com,
	linux-kernel@vger.kernel.org,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	Philipp Reisner <philipp.reisner@linbit.com>,
	linux-block@vger.kernel.org,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Joel Colledge <joel.colledge@linbit.com>
Subject: [PATCH 08/20] drbd: add DAX/PMEM support for metadata access
Date: Fri, 27 Mar 2026 23:38:08 +0100
Message-ID: <20260327223820.2244227-9-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
References: <20260327223820.2244227-1-christoph.boehmwalder@linbit.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

When DRBD's metadata device resides on persistent memory (PMEM/NVDIMM),
accessing it by reading and writing full blocks is unnecessarily
costly.
Add a DAX-based metadata path that directly maps the metadata region,
enabling byte-granular, IRQ-safe access without having to go through
the block layer.

The PMEM path also introduces a more efficient activity log layout:
instead of writing journal transactions, the in-memory LRU-cache hash
table is stored directly in persistent memory and updated in-place.
Similarly, the resync bitmap is accessed directly from PMEM rather than
being loaded into and flushed from DRAM.

This is compiled in only when CONFIG_DEV_DAX_PMEM is enabled.

Co-developed-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Co-developed-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Signed-off-by: Lars Ellenberg <lars.ellenberg@linbit.com>
Co-developed-by: Joel Colledge <joel.colledge@linbit.com>
Signed-off-by: Joel Colledge <joel.colledge@linbit.com>
Co-developed-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Makefile        |   1 +
 drivers/block/drbd/drbd_dax_pmem.c | 158 +++++++++++++++++++++++++++++
 drivers/block/drbd/drbd_dax_pmem.h |  40 ++++++++
 3 files changed, 199 insertions(+)
 create mode 100644 drivers/block/drbd/drbd_dax_pmem.c
 create mode 100644 drivers/block/drbd/drbd_dax_pmem.h

diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index 7f2655a206aa..4b58eb83fc22 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -5,6 +5,7 @@ drbd-y += drbd_main.o drbd_strings.o drbd_nl.o
 drbd-y += drbd_interval.o drbd_state.o
 drbd-y += drbd_nla.o
 drbd-y += drbd_transport.o
+drbd-$(CONFIG_DEV_DAX_PMEM) += drbd_dax_pmem.o
 drbd-$(CONFIG_DEBUG_FS) += drbd_debugfs.o
 
 obj-$(CONFIG_BLK_DEV_DRBD)     += drbd.o
diff --git a/drivers/block/drbd/drbd_dax_pmem.c b/drivers/block/drbd/drbd_dax_pmem.c
new file mode 100644
index 000000000000..6f29dfd763a3
--- /dev/null
+++ b/drivers/block/drbd/drbd_dax_pmem.c
@@ -0,0 +1,158 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+   drbd_dax.c
+
+   This file is part of DRBD by Philipp Reisner and Lars Ellenberg.
+
+   Copyright (C) 2017, LINBIT HA-Solutions GmbH.
+
+
+ */
+
+/*
+  In case DRBD's meta-data resides in persistent memory do a few things
+   different.
+
+   1 direct access the bitmap in place. Do not load it into DRAM, do not
+     write it back from DRAM.
+   2 Use a better fitting format for the on-disk activity log. Instead of
+     writing transactions, the unmangled LRU-cache hash table is there.
+*/
+
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/dax.h>
+#include <linux/libnvdimm.h>
+#include <linux/blkdev.h>
+#include "drbd_int.h"
+#include "drbd_dax_pmem.h"
+#include "drbd_meta_data.h"
+
+static int map_superblock_for_dax(struct drbd_backing_dev *bdev, struct dax_device *dax_dev)
+{
+	long want = 1;
+	pgoff_t pgoff = bdev->md.md_offset >> (PAGE_SHIFT - SECTOR_SHIFT);
+	void *kaddr;
+	long len;
+	int id;
+
+	id = dax_read_lock();
+	len = dax_direct_access(dax_dev, pgoff, want, DAX_ACCESS, &kaddr, NULL);
+	dax_read_unlock(id);
+
+	if (len < want)
+		return -EIO;
+
+	bdev->md_on_pmem = kaddr;
+
+	return 0;
+}
+
+/**
+ * drbd_dax_open() - Open device for dax and map metadata superblock
+ * @bdev: backing device to be opened
+ */
+int drbd_dax_open(struct drbd_backing_dev *bdev)
+{
+	struct dax_device *dax_dev;
+	int err;
+	u64 part_off;
+
+	dax_dev = fs_dax_get_by_bdev(bdev->md_bdev, &part_off, NULL, NULL);
+	if (!dax_dev)
+		return -ENODEV;
+
+	err = map_superblock_for_dax(bdev, dax_dev);
+	if (!err)
+		bdev->dax_dev = dax_dev;
+	else
+		put_dax(dax_dev);
+
+	return err;
+}
+
+void drbd_dax_close(struct drbd_backing_dev *bdev)
+{
+	put_dax(bdev->dax_dev);
+}
+
+/**
+ * drbd_dax_map() - Map metadata for dax
+ * @bdev: backing device whose metadata is to be mapped
+ */
+int drbd_dax_map(struct drbd_backing_dev *bdev)
+{
+	struct dax_device *dax_dev = bdev->dax_dev;
+	sector_t first_sector = drbd_md_first_sector(bdev);
+	sector_t al_sector = bdev->md.md_offset + bdev->md.al_offset;
+	long want = (drbd_md_last_sector(bdev) + 1 - first_sector) >> (PAGE_SHIFT - SECTOR_SHIFT);
+	pgoff_t pgoff = first_sector >> (PAGE_SHIFT - SECTOR_SHIFT);
+	long md_offset_byte = (bdev->md.md_offset - first_sector) << SECTOR_SHIFT;
+	long al_offset_byte = (al_sector - first_sector) << SECTOR_SHIFT;
+	void *kaddr;
+	long len;
+	int id;
+
+	id = dax_read_lock();
+	len = dax_direct_access(dax_dev, pgoff, want, DAX_ACCESS, &kaddr, NULL);
+	dax_read_unlock(id);
+
+	if (len < want)
+		return -EIO;
+
+	bdev->md_on_pmem = kaddr + md_offset_byte;
+	bdev->al_on_pmem = kaddr + al_offset_byte;
+
+	return 0;
+}
+
+void drbd_dax_al_update(struct drbd_device *device, struct lc_element *al_ext)
+{
+	struct al_on_pmem *al_on_pmem = device->ldev->al_on_pmem;
+	__be32 *slot = &al_on_pmem->slots[al_ext->lc_index];
+
+	*slot = cpu_to_be32(al_ext->lc_new_number);
+	arch_wb_cache_pmem(slot, sizeof(*slot));
+}
+
+
+void drbd_dax_al_begin_io_commit(struct drbd_device *device)
+{
+	struct lc_element *e;
+
+	spin_lock_irq(&device->al_lock);
+
+	list_for_each_entry(e, &device->act_log->to_be_changed, list)
+		drbd_dax_al_update(device, e);
+
+	lc_committed(device->act_log);
+
+	spin_unlock_irq(&device->al_lock);
+}
+
+int drbd_dax_al_initialize(struct drbd_device *device)
+{
+	struct al_on_pmem *al_on_pmem = device->ldev->al_on_pmem;
+	__be32 *slots = al_on_pmem->slots;
+	int i, al_slots = (device->ldev->md.al_size_4k << (12 - 2)) - 1;
+
+	al_on_pmem->magic = cpu_to_be32(DRBD_AL_PMEM_MAGIC);
+	/* initialize all slots rather than just the configured number in case
+	 * the configuration is later changed */
+	for (i = 0; i < al_slots; i++) {
+		unsigned int extent_nr = i < device->act_log->nr_elements ?
+			lc_element_by_index(device->act_log, i)->lc_number :
+			LC_FREE;
+		slots[i] = cpu_to_be32(extent_nr);
+	}
+
+	return 0;
+}
+
+void *drbd_dax_bitmap(struct drbd_device *device, unsigned long want)
+{
+	struct drbd_backing_dev *bdev = device->ldev;
+	unsigned char *md_on_pmem = (unsigned char *)bdev->md_on_pmem;
+
+	return md_on_pmem + (long)bdev->md.bm_offset * SECTOR_SIZE;
+}
diff --git a/drivers/block/drbd/drbd_dax_pmem.h b/drivers/block/drbd/drbd_dax_pmem.h
new file mode 100644
index 000000000000..9a929969ff27
--- /dev/null
+++ b/drivers/block/drbd/drbd_dax_pmem.h
@@ -0,0 +1,40 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef DRBD_DAX_H
+#define DRBD_DAX_H
+
+#include <linux/kconfig.h>
+
+#if IS_ENABLED(CONFIG_DEV_DAX_PMEM)
+
+int drbd_dax_open(struct drbd_backing_dev *bdev);
+void drbd_dax_close(struct drbd_backing_dev *bdev);
+int drbd_dax_map(struct drbd_backing_dev *bdev);
+void drbd_dax_al_update(struct drbd_device *device, struct lc_element *al_ext);
+void drbd_dax_al_begin_io_commit(struct drbd_device *device);
+int drbd_dax_al_initialize(struct drbd_device *device);
+void *drbd_dax_bitmap(struct drbd_device *device, unsigned long want);
+
+static inline bool drbd_md_dax_active(struct drbd_backing_dev *bdev)
+{
+	return bdev->dax_dev != NULL;
+}
+static inline struct meta_data_on_disk_9 *drbd_dax_md_addr(struct drbd_backing_dev *bdev)
+{
+	return bdev->md_on_pmem;
+}
+#else
+
+#define drbd_dax_open(B) do { } while (0)
+#define drbd_dax_close(B) do { } while (0)
+#define drbd_dax_map(B) (-ENOTSUPP)
+#define drbd_dax_al_begin_io_commit(D) do { } while (0)
+#define drbd_dax_al_initialize(D) (-EIO)
+#define drbd_dax_bitmap(D, L) (NULL)
+#define drbd_md_dax_active(B) (false)
+#define drbd_dax_md_addr(B) (NULL)
+
+#define arch_wb_cache_pmem(A, L) do { } while (0)
+
+#endif /* IS_ENABLED(CONFIG_DEV_DAX_PMEM) */
+
+#endif /* DRBD_DAX_H */
-- 
2.53.0

