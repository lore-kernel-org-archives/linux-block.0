Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795620926;
	b=uvCEVleTzxi5IkWxw2LVhq5OMUpQY8t4XKZNWZ65VyNax6bAGpuy/y2HirNC+E7FxRw2
	 Qb60XmV5dfa0fUCxM2rjtDEmkPMwZkGqJo27ys8phqRvVFLVYf+7GfpH3Cov7GLYQRQH6
	 rTmGUpvjYOklHUxpXo3bfCeqJXpjlHfu5lhCiFbmKO5swzgD+g18+vGWflpEPX8io583P
	 5KOU5nrDCmrhUn9EEClxdUVvZlyknFUzz8fdLGjyYyENQF2zWlfh7kKOavBafGTpLCkZ/
	 005wJVL9qFSpaSgZJ0wmM6+ib+NnPIw+vIMnQwbkVWrVWN7sECu2vQArfeTcG9NF73A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795620926;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BiQwBS2/gR41uglJcjDGNmI+H6Qr25ofWgkYoxBcwCQ=;
	b=Ol3QHApq/evU1o7EhnagLwNqi1S4pN+vMwmZpgLgbe/MO/AjimszWNi3DsbNj01rM6jA
	 dSHW5YGe5Ck88mXqB0IPXYKaLAU0fMfX75MYKt/3TsWXadjdghrRoRQO7DRiwm554nQae
	 qSJlEFtgmy3s1CHI4iweHKOupYRcdLENSVCPbawsBI6G6NmuIOchU0TfcHAZIM4A25b4Y
	 mFmC2jZter/5tckdM/q61/NPJzJ/S2zbvCdyYlRAXGeGOG66rhtAg03ItnBZ7JYhw2MIX
	 jZNLPQsE8OgkMR7yEJb0D/wUOnSYSqPmRqFMur820bvDnXuVThIBal5xfqoXAVBd46Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linbit.com;
	spf=pass smtp.mailfrom=linbit.com;
	dkim=pass header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=eLy4lNUD;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB746606A6BB
	for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 15:35:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB746606A6BB
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linbit.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linbit.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linbit.com header.i=@linbit.com header.a=rsa-sha256 header.s=google header.b=eLy4lNUD
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-4aa5833c263so5707962f8f.2
        for <linux-block@vger.kernel.org>; Wed, 25 Nov 2026 07:35:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit.com; s=google; t=1795620924; x=1796225724; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=BiQwBS2/gR41uglJcjDGNmI+H6Qr25ofWgkYoxBcwCQ=;
        b=eLy4lNUDMucp3odoIum2kPwL6QtlzW0G+YSdFcqtsShcPYNcxO0Jt+yEB3HYl7YWTS
         03DuSptJc22zZu5AjMoOua5WE1eSR3mDxUVUMGqnGWEnMSapkQbWV8aMCkOP7Vn5LKS3
         fc7QMp+de54qt1gov9173fuwqmyScR7GqlPFtvdrc3NEQEXcnHAPnTwrZHNfVODiUzk8
         PMyLqDgFq/9ZeJgWzsfV3PpfY/7tfaGivIoP2FOthOMqNchL8sONANOghhu6RdDtM275
         BAgi+nDKYtJFc4hVXCKL8HunVhde+SFxZ1ypUbSuquOl8gRv8t5ICWI3l8Fq6XBhwiHM
         tlTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795620924; x=1796225724;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=BiQwBS2/gR41uglJcjDGNmI+H6Qr25ofWgkYoxBcwCQ=;
        b=hIYHrA7m7s/x6lYqfIZo6ULOLlTSb9YY2aabhxWzMh2ZBa+pQ1QfDya1wX8QzhuEhV
         W6LYeWmdO7I1xYCpA6KOwBZeC8+EGNOXmY4y7ZEYPhuKlGodbUQaHv2TApKbDJPbYnYC
         MSwKPvMD9IDES3P3ytZBvRGL5/mpSftxNvFN3DsxFUXu2/eebjM18zsysAeU6oYd/nxo
         QjA5x3Tw91DvE6O26ioS21eL8Y1bhZKypAEcLYM7FkCEkSc65M2IhB0g5HV35MnJ2VQS
         Mc1YpxHI4j0eNhmcwP0qwEV4ARvXaICuMEh7JtEGuz5/Zv+/RKqlNOa7QNX1ZHXGzfW5
         MUbQ==
X-Forwarded-Encrypted: i=1; AL+hErGRydskwqQQy03NVBMu3Qb2nYJKuRbsLnjOQ54LV6DnxxMcObFS69MU45FDiqzG0pblMsj6TVozp2cuYw==@vger.kernel.org
X-Gm-Message-State: APuU4Z/I9eNkVV/iL+JyitvNeE4PFh/KUamHr+5TIi9vFU/0BPqFvbvt
	mWuSNXcqQjkbU5ejjpP+QiS+VgzWZ3c/9CET46pbo3Vii1R3GbyU8EqFM+Yy8+ew8ss=
X-Gm-Gg: AZFdTZeILuBfdTqOoQ74E/eitaZRgo0+BXFcRMddznXBZkVO67abAtVAbiMVvF4m8ej
	+bWEY31aNrz6RzZs1RQnmt2cz+yv30iirdqaV3WrINfn3GKxklH6UQHekqQ1ux3OJZYRKjNAlaT
	Zg0rWuxNmV+GdhlfaW5KQcoiMNjbgGr0v3/V6yI6GFKUVxRo26/AhhgFYSBEtax5wGNQ6ZZpM4V
	9yzk3TtTqCflv0NVcLaGxCpEni4SjnDvMmqpvVQCSV2447LzPK1T+CPgEgJPW6CHFBcyNC1qBvc
	2xQ703bsOUA+lhoQya+bxb28xANWjbZ8fCNIhXzyPb/GiGTEgdUBfrcv6piZyNeKEk0lwc13C5A
	1aEaa8to19vSJaEWq+3jap5KKZoXsRDOrpx4Nse2ROICFZc+Iog6osHBYK8PxpPyB9XS42llfTv
	5Z9juGzMgNWpU5YBOtpE4SnAWMk+qXoPjNNoWwdrC8O3pQFHyFh2CPFhMXuEFsVh1twm5cbXuM/
	2JffPbBNAiKwjrn1o8qwfVJo4NTQzcW6nSDBx+DANMvda78FvQouChfw+jh1Bm8lbTN5zP/2w+3
	p2VROb8AfLZ/rlNS/uPGVtdRW7pIUxz5MoNTZdOP9ff3AV5hBUAqwvmquq5cFNNYhULUd/w0pQ=
	=
X-Received: by 2002:a05:6000:1a86:b0:4ad:d65:aaf9 with SMTP id ffacd0b85a97d-4ad0d65afa1mr37656106f8f.56.1795620924092;
        Wed, 25 Nov 2026 07:35:24 -0800 (PST)
Received: from linbit.com (h082218129081.host.wavenet.at. [82.218.129.81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab658e2d60sm35816275f8f.3.2026.11.25.07.35.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Nov 2026 07:35:23 -0800 (PST)
From: =?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: drbd-dev@lists.linux.dev,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Philipp Reisner <philipp.reisner@linbit.com>,
	Lars Ellenberg <lars.ellenberg@linbit.com>,
	=?UTF-8?q?Christoph=20B=C3=B6hmwalder?= <christoph.boehmwalder@linbit.com>,
	Dan Williams <djbw@kernel.org>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>,
	Alison Schofield <alison.schofield@intel.com>,
	nvdimm@lists.linux.dev
Subject: [PATCH v4 07/21] drbd: add DAX/PMEM support for metadata access
Date: Wed, 25 Nov 2026 16:34:57 +0100
Message-ID: <20261125153511.3060599-8-christoph.boehmwalder@linbit.com>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261125153511.3060599-1-christoph.boehmwalder@linbit.com>
References: <20261125153511.3060599-1-christoph.boehmwalder@linbit.com>
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Post: <mailto:linux-block@vger.kernel.org>
List-Help: <mailto:linux-block+help@vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-block+owner@vger.kernel.org>
Precedence: list
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

The PMEM path is compiled in when the kernel has filesystem DAX
support (CONFIG_FS_DAX) and the architecture can write CPU caches back
to persistent memory (CONFIG_ARCH_HAS_PMEM_API). The hidden symbol
CONFIG_DRBD_DAX stands for both.

Co-developed-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Philipp Reisner <philipp.reisner@linbit.com>
Signed-off-by: Christoph Böhmwalder <christoph.boehmwalder@linbit.com>
---
 drivers/block/drbd/Kconfig         |   4 +
 drivers/block/drbd/Makefile        |   1 +
 drivers/block/drbd/drbd_dax_pmem.c | 175 +++++++++++++++++++++++++++++
 drivers/block/drbd/drbd_dax_pmem.h |  43 +++++++
 4 files changed, 223 insertions(+)
 create mode 100644 drivers/block/drbd/drbd_dax_pmem.c
 create mode 100644 drivers/block/drbd/drbd_dax_pmem.h

diff --git a/drivers/block/drbd/Kconfig b/drivers/block/drbd/Kconfig
index 615516941fb7..fbf1d5011aa3 100644
--- a/drivers/block/drbd/Kconfig
+++ b/drivers/block/drbd/Kconfig
@@ -99,3 +99,7 @@ config BLK_DEV_DRBD_TCP_TLS
 	  https://github.com/oracle/ktls-utils.
 
 	  If unsure, say N.
+
+config DRBD_DAX
+	def_bool y
+	depends on BLK_DEV_DRBD && FS_DAX && ARCH_HAS_PMEM_API
diff --git a/drivers/block/drbd/Makefile b/drivers/block/drbd/Makefile
index 9f05f74e619c..750202bce516 100644
--- a/drivers/block/drbd/Makefile
+++ b/drivers/block/drbd/Makefile
@@ -5,6 +5,7 @@ drbd-y += drbd_main.o drbd_strings.o drbd_nl.o
 drbd-y += drbd_interval.o drbd_state.o
 drbd-y += drbd_nl_gen.o
 drbd-y += drbd_transport.o
+drbd-$(CONFIG_DRBD_DAX) += drbd_dax_pmem.o
 drbd-$(CONFIG_DEBUG_FS) += drbd_debugfs.o
 
 obj-$(CONFIG_BLK_DEV_DRBD)     += drbd.o
diff --git a/drivers/block/drbd/drbd_dax_pmem.c b/drivers/block/drbd/drbd_dax_pmem.c
new file mode 100644
index 000000000000..1fb22e57cf5d
--- /dev/null
+++ b/drivers/block/drbd/drbd_dax_pmem.c
@@ -0,0 +1,175 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2017, LINBIT HA-Solutions GmbH.
+ */
+
+/*
+ * In case DRBD's meta-data resides in persistent memory do a few things
+ * different.
+ *
+ * 1 direct access the bitmap in place. Do not load it into DRAM, do not
+ *   write it back from DRAM.
+ * 2 Use a better fitting format for the on-disk activity log. Instead of
+ *   writing transactions, the unmangled LRU-cache hash table is there.
+ */
+
+#include <linux/vmalloc.h>
+#include <linux/slab.h>
+#include <linux/dax.h>
+#include <linux/libnvdimm.h>
+#include <linux/blkdev.h>
+#include <linux/sizes.h>
+#include "drbd_int.h"
+#include "drbd_dax_pmem.h"
+#include "drbd_meta_data.h"
+
+/*
+ * Unit conversions for addressing the metadata area through DAX.
+ * DRBD keeps metadata offsets in sectors, dax_direct_access() works in pages.
+ */
+static pgoff_t md_sector_to_pgoff(sector_t sector)
+{
+	return sector >> (PAGE_SHIFT - SECTOR_SHIFT);
+}
+
+static long md_sectors_to_pages(sector_t nr_sectors)
+{
+	return nr_sectors >> (PAGE_SHIFT - SECTOR_SHIFT);
+}
+
+/* Signed, since the bitmap offset relative to the superblock may be negative. */
+static long md_sector_offset_to_bytes(long sector_offset)
+{
+	return sector_offset * SECTOR_SIZE;
+}
+
+static int map_superblock_for_dax(struct drbd_backing_dev *bdev, struct dax_device *dax_dev)
+{
+	long want = 1;
+	pgoff_t pgoff = md_sector_to_pgoff(bdev->md.md_offset);
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
+	long want = md_sectors_to_pages(drbd_md_last_sector(bdev) + 1 - first_sector);
+	pgoff_t pgoff = md_sector_to_pgoff(first_sector);
+	long md_offset_byte = md_sector_offset_to_bytes(bdev->md.md_offset - first_sector);
+	long al_offset_byte = md_sector_offset_to_bytes(al_sector - first_sector);
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
+	/* The activity log area holds the magic followed by the slots. */
+	int i, al_slots = device->ldev->md.al_size_4k * (SZ_4K / sizeof(*slots)) - 1;
+
+	al_on_pmem->magic = cpu_to_be32(DRBD_AL_PMEM_MAGIC);
+	/*
+	 * Initialize all slots rather than just the configured number in case
+	 * the configuration is later changed.
+	 */
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
+	return md_on_pmem + md_sector_offset_to_bytes(bdev->md.bm_offset);
+}
diff --git a/drivers/block/drbd/drbd_dax_pmem.h b/drivers/block/drbd/drbd_dax_pmem.h
new file mode 100644
index 000000000000..8e3ecf74a557
--- /dev/null
+++ b/drivers/block/drbd/drbd_dax_pmem.h
@@ -0,0 +1,43 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (C) 2017, LINBIT HA-Solutions GmbH.
+ */
+#ifndef DRBD_DAX_H
+#define DRBD_DAX_H
+
+#include <linux/kconfig.h>
+
+#if IS_ENABLED(CONFIG_DRBD_DAX)
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
+#endif /* IS_ENABLED(CONFIG_DRBD_DAX) */
+
+#endif /* DRBD_DAX_H */
-- 
2.56.0

