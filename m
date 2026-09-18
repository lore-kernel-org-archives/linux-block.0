Received: from mail-qk2-f13.google.com (mail-qk2-f13.google.com [74.125.230.205])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC85274670
	for <linux-block@vger.kernel.org>; Fri, 18 Sep 2026 01:40:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.205
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789695608; cv=none; b=VwPQNBVcQ1qgToaT9erpEeDL5JivTSSCX5+79Sd3cLuIG/In2DsiqepOpB64XKSF7YmjbTm5MlqaN55FjngLQBGQZmeqDfNFcEg/z4uj7iIrKr6xlOqxUaW47rfD0SsXI3FDfeCQ4aC8IhKo8gry9KNHOgwtrpDxpQ/RzFS3csg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789695608; c=relaxed/simple;
	bh=xJFZZ65XKfLwv+bQiIGeTG3P+8dFfvUx97MYkYHcW1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=snh+2u67h/E5Aa6TWOEJ8jKQFeZBG8jo5wGenPJg/+Ys4hynPjoBpIRSRrbik7GdVc3nryzeEL/7iGMUcEC03CD1iAh3v3U4QcMLdOGLV5oBDxN3U9Yq5U9Aa6l0YwtjJNkklxrhBb2XtNM7/s5ssG9X19QV8PaSEznsU8emvyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WwpUUhOJ; arc=none smtp.client-ip=74.125.230.205
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WwpUUhOJ"
Received: by mail-qk2-f13.google.com with SMTP id d75a77b69052e-52fb766bfd6so1531961cf.1
        for <linux-block@vger.kernel.org>; Thu, 17 Sep 2026 18:40:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789695604; x=1790300404; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=kRZjJWpYkaeqQD75OP3IMKeG+lgSuXv4LhpxcXrNRQY=;
        b=WwpUUhOJHhxWkfFwob3x+uAqtjaxKkdqQLWWvKK8GIA3sNI2H4+Ro/xJKUEM7jpL5H
         fnuWej2dvEj//gkgE5Mc7i4Wm201WQ4R9Qz+kClaP680sxKvlLTKTR3tCWocNw/FFG3g
         MkAwDGYgQdc4W8Y72fn7B49qhjbjUfWIYNEru2k+XKf5FxLUC6P9fGirMwSnE0DLKb6S
         tjnRsEG/5ORF7fIbS4dCnMFapmRadFg1ugwLMc65iItT8JCIEjjK02RYiP0K+s8oIuaH
         MhNE0NMnG0GQQtsCAzLr733qiPmvKMw+4f1C2i+utAfB9HHdLI1zLWpFpLVQqoZDYaMi
         v1qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789695604; x=1790300404;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=kRZjJWpYkaeqQD75OP3IMKeG+lgSuXv4LhpxcXrNRQY=;
        b=2nyqRIr/T/w79qrgi8Fhpvc9tP63g8UXqpsaK8/mBgTPbqzlW5RdqRGv/sDK5k3FkD
         bQCE4R5b0gApNy7PPpTIS+KzihcSO0NAIFRywcBdmt26UxrPGGTMi+kZHZMJATJsHgwz
         POZCmI3fqRLF0Nt+YbfO7foJrqK56ZHssqoZzG9emSZE54FVS7y5Ce2cM/twTYY9B9ok
         XE5vtkr0db9k+hj8iUip2teDcycu6jMtfrA++By76tx9VEPosN4TvDWejbfFcz4cRig1
         LUcN2eI0A1cbupEiDGURZnjtuxWG6wm2QyYII/C3hjavPvIDy7LhzyOBXaQDFoYkG5RX
         MiQw==
X-Gm-Message-State: AFuF++m/a7BWXh5w6x+htVxdSw9tn2/LEoBdPvmn9R8n8FJvzmY4zTg8
	6E2MnzfjN9COoXcCQTQEqmpzZ066mJfSczHksNuOT0M6TpApK3IcdjgrfQpphZxOCMc=
X-Gm-Gg: AYBFou0+CtyQ0wrCYHbshXWbE9MHiywMhqOmvJEnv2Ysxz9SOOgXb1n7gRkT5KN+B7I
	fr18iClVa62Y5wcIz7KfYFYItaSF9Gf2WAkjfFrAxzf5bOzEZD8fSAW4ik77CuRhj3SPs9vh/rs
	E2a/H9Teo2dDyoBCKylnOkEdvk2k0h1+vljeKuxSXvL/Yrt/bAHwM4zXY0ReDneEVo/r66IMLf5
	WIPfK8xJzDJsddUolWNWDeDy/vDiVSR+DqfIkxdBDxXCcoBY3WKHQyUTRKoOwd/ddNseRbFdL6M
	dbRMMwTcOxEKizfZhC3Xoc3hQ9/UT0RW8kXQv9Lf+VMN/i2zPqI5aUXi838gx4VBp3MaxWWjRR7
	8YQTHwV8vma9lDqr1Cacwbys4bW/MbGOcJyWb6TNWEq6DVgRKlXgPX7jaYYvN153Xbw/33dxHAa
	yxNY/O4cQiJZkQKPovSCsUzQravYVSIiTyL+xNQhQQ/epeSZRp72QQv9K1+lEKuALuSawI5W0FI
	OhPnuJjO5CEKqzUhLa3scVQdBje7aTs
X-Received: by 2002:a05:622a:a58b:b0:530:ea12:caad with SMTP id d75a77b69052e-5329e4423cdmr17106671cf.50.1789695603673;
        Thu, 17 Sep 2026 18:40:03 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([148.222.209.140])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-532a185be6bsm2157041cf.1.2026.09.17.18.40.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Sep 2026 18:40:03 -0700 (PDT)
From: Emerson Busson <emersonbusson@gmail.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	linux-kernel@vger.kernel.org,
	emersonbusson@gmail.com
Subject: [PATCH v3 1/2] drivers/block/ramshared: add hardware-accelerated VRAM block driver
Date: Thu, 17 Sep 2026 22:39:54 -0300
Message-ID: <20260917223828.ramshared-v3-1-driver@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260917223828.ramshared-v3-0-cover@gmail.com>
References: <20260917223828.ramshared-v3-0-cover@gmail.com>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add the RamShared driver core in drivers/block/ramshared/ supporting
direct PCIe DMA aperture mapping, blk-mq request dispatch, synchronous
.rw_page swap fast-path, and dedicated IOCTL input validation.

Signed-off-by: Emerson Busson <emersonbusson@gmail.com>
---
--- a/drivers/block/ramshared/Kconfig
+++ b/drivers/block/ramshared/Kconfig
@@ -0,0 +1,15 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# RamShared block driver configuration
+#
+
+config BLK_DEV_RAMSHARED
+	tristate "RamShared Hardware-Accelerated VRAM Block Device"
+	depends on BLOCK && PCI && MMU
+	select BLK_MQ_PCI
+	help
+	  This driver provides a high-performance block device backed by
+	  discrete GPU video memory (VRAM) via direct PCIe DMA transfers.
+
+	  To compile this driver as a module, choose M here: the module
+	  will be called ramshared.
--- a/drivers/block/ramshared/Makefile
+++ b/drivers/block/ramshared/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the RamShared in-tree kernel driver.
+#
+
+obj-$(CONFIG_BLK_DEV_RAMSHARED) += ramshared.o
+
+ramshared-y := main.o dma.o queue.o control.o
+
+# Standalone build support
+KDIR ?= /lib/modules/$(shell uname -r)/build
+PWD := $(shell pwd)
+
+default:
+	$(MAKE) -C $(KDIR) M=$(PWD) CONFIG_BLK_DEV_RAMSHARED=m modules
+
+clean:
+	$(MAKE) -C $(KDIR) M=$(PWD) clean
--- a/drivers/block/ramshared/compat.h
+++ b/drivers/block/ramshared/compat.h
@@ -0,0 +1,126 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * RamShared - Multi-Kernel Compatibility Abstraction Layer
+ * Supports: Linux 5.15 LTS (Ubuntu 22.04) -> 6.8 (Ubuntu 24.04) ->
+ *           6.10 (Fedora 40) -> 6.12 LTS (Arch) -> 6.18 LTS (WSL2 / Rolling LTS) ->
+ *           6.19+ Mainline
+ *
+ * Copyright (C) 2026 Emerson Busson
+ */
+
+#ifndef _RAMSHARED_COMPAT_H
+#define _RAMSHARED_COMPAT_H
+
+#include <linux/version.h>
+#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6, 11, 0)
+/* Linux 6.11+ Paradigm: Features embedded in struct queue_limits */
+#define RAMSHARED_HAVE_QUEUE_LIMITS_FEATURES	1
+#elif LINUX_VERSION_CODE >= KERNEL_VERSION(6, 9, 0)
+/* Linux 6.9 - 6.10 Paradigm: 3-arg blk_mq_alloc_disk with queue_limits */
+#define RAMSHARED_HAVE_QUEUE_LIMITS_PARAM	1
+#else
+/* Linux <= 6.8 Paradigm: 2-arg blk_mq_alloc_disk and standalone mutators */
+#define RAMSHARED_HAVE_LEGACY_BLK_ALLOC		1
+#endif
+
+/**
+ * ramshared_alloc_disk - Allocate gendisk across all kernel versions
+ * @set: Pointer to tag set
+ * @queuedata: Private device state
+ * @sector_size: Logical sector size (512)
+ * @max_sectors: Maximum hardware sectors per request
+ */
+static inline struct gendisk *ramshared_alloc_disk(struct blk_mq_tag_set *set,
+						   void *queuedata,
+						   unsigned int sector_size,
+						   unsigned int max_sectors)
+{
+#if defined(RAMSHARED_HAVE_QUEUE_LIMITS_FEATURES)
+	struct queue_limits lim = {
+		.logical_block_size	= sector_size,
+		.physical_block_size	= PAGE_SIZE,
+		.io_min			= PAGE_SIZE,
+		.io_opt			= 64 * 1024,
+		.max_hw_sectors		= max_sectors,
+		.max_segments		= USHRT_MAX,
+		.max_segment_size	= UINT_MAX,
+		.dma_alignment		= 511,
+		.max_hw_discard_sectors	= UINT_MAX,
+		.discard_granularity	= PAGE_SIZE,
+		.features		= BLK_FEAT_NOWAIT | BLK_FEAT_SYNCHRONOUS,
+	};
+	return blk_mq_alloc_disk(set, &lim, queuedata);
+
+#elif defined(RAMSHARED_HAVE_QUEUE_LIMITS_PARAM)
+	struct queue_limits lim = {
+		.logical_block_size	= sector_size,
+		.physical_block_size	= PAGE_SIZE,
+		.io_min			= PAGE_SIZE,
+		.io_opt			= 64 * 1024,
+		.max_hw_sectors		= max_sectors,
+		.max_segments		= USHRT_MAX,
+		.max_segment_size	= UINT_MAX,
+		.dma_alignment		= 511,
+		.max_hw_discard_sectors	= UINT_MAX,
+		.discard_granularity	= PAGE_SIZE,
+	};
+	struct gendisk *disk = blk_mq_alloc_disk(set, &lim, queuedata);
+
+	if (!IS_ERR(disk)) {
+		blk_queue_flag_set(QUEUE_FLAG_NONROT, disk->queue);
+		blk_queue_flag_set(QUEUE_FLAG_SYNCHRONOUS, disk->queue);
+		blk_queue_flag_set(QUEUE_FLAG_NOWAIT, disk->queue);
+	}
+	return disk;
+
+#else /* Linux <= 6.8 (Ubuntu 22.04 LTS, Ubuntu 24.04 LTS) */
+	struct gendisk *disk = blk_mq_alloc_disk(set, queuedata);
+	struct request_queue *q;
+
+	if (IS_ERR(disk))
+		return disk;
+
+	q = disk->queue;
+	blk_queue_flag_set(QUEUE_FLAG_NONROT, q);
+	blk_queue_flag_set(QUEUE_FLAG_SYNCHRONOUS, q);
+	blk_queue_flag_set(QUEUE_FLAG_NOWAIT, q);
+
+	blk_queue_logical_block_size(q, sector_size);
+	blk_queue_physical_block_size(q, PAGE_SIZE);
+	blk_queue_io_min(q, PAGE_SIZE);
+	blk_queue_io_opt(q, 64 * 1024);
+	blk_queue_max_hw_sectors(q, max_sectors);
+	blk_queue_max_segments(q, USHRT_MAX);
+	blk_queue_max_segment_size(q, UINT_MAX);
+	blk_queue_dma_alignment(q, 511);
+	blk_queue_max_discard_sectors(q, UINT_MAX);
+	q->limits.discard_granularity = PAGE_SIZE;
+
+	return disk;
+#endif
+}
+
+/**
+ * ramshared_set_capacity - Set gendisk capacity across all kernel versions
+ * @disk: Pointer to gendisk
+ * @sectors: Disk capacity in sectors
+ */
+static inline void ramshared_set_capacity(struct gendisk *disk, sector_t sectors)
+{
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(5, 15, 0)
+	set_capacity_and_notify(disk, sectors);
+#else
+	set_capacity(disk, sectors);
+#endif
+}
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(6, 5, 0)
+typedef blk_mode_t ramshared_blk_mode_t;
+#else
+typedef fmode_t ramshared_blk_mode_t;
+#endif
+
+#endif /* _RAMSHARED_COMPAT_H */
--- a/drivers/block/ramshared/control.c
+++ b/drivers/block/ramshared/control.c
@@ -0,0 +1,55 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RamShared - IOCTL control operations and bounds checking
+ *
+ * Copyright (C) 2026 Emerson Busson
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/blkdev.h>
+#include <linux/uaccess.h>
+#include "ramshared.h"
+
+int ramshared_ioctl(struct block_device *bdev, ramshared_blk_mode_t mode,
+		    unsigned int cmd, unsigned long arg)
+{
+	struct ramshared_device *rs_dev;
+	struct ramshared_info info;
+
+	if (!bdev || !bdev->bd_disk || !bdev->bd_disk->private_data)
+		return -ENODEV;
+
+	rs_dev = bdev->bd_disk->private_data;
+
+	switch (cmd) {
+	case RAMSHARED_IOC_GET_INFO:
+		if (_IOC_SIZE(cmd) < sizeof(struct ramshared_info))
+			return -EINVAL;
+
+		info.capacity_bytes = rs_dev->capacity_bytes;
+		info.queue_depth = rs_dev->tag_set.queue_depth;
+		info.reserved = 0;
+
+		if (copy_to_user((void __user *)arg, &info, sizeof(info)))
+			return -EFAULT;
+		return 0;
+
+	case RAMSHARED_IOC_SET_PARAM:
+	{
+		struct ramshared_param param;
+
+		if (_IOC_SIZE(cmd) != sizeof(struct ramshared_param))
+			return -EINVAL;
+
+		if (copy_from_user(&param, (void __user *)arg, sizeof(param)))
+			return -EFAULT;
+
+		/* Currently unsupported */
+		return -EOPNOTSUPP;
+	}
+
+	default:
+		return -ENOTTY;
+	}
+}
--- a/drivers/block/ramshared/dma.c
+++ b/drivers/block/ramshared/dma.c
@@ -0,0 +1,77 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RamShared - Direct PCIe DMA memory management for discrete GPU VRAM
+ *
+ * Copyright (C) 2026 Emerson Busson
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include <linux/io.h>
+#include "ramshared.h"
+
+int ramshared_dma_init(struct ramshared_device *rs_dev, struct pci_dev *pdev)
+{
+	int bar = 0;
+	resource_size_t bar_start, bar_len;
+
+	if (!rs_dev || !pdev)
+		return -EINVAL;
+
+	bar_start = pci_resource_start(pdev, bar);
+	bar_len = pci_resource_len(pdev, bar);
+
+	if (!bar_start) {
+		dev_err(&pdev->dev, "invalid PCIe BAR0 resource\n");
+		return -ENODEV;
+	}
+
+	/* SPEC: kernel-pci-bar-capacity-contract §RF-2. */
+	if (bar_len == 0 || (u64)bar_len < rs_dev->capacity_bytes) {
+		dev_err(&pdev->dev,
+			"BAR0 is smaller than requested capacity (%llu < %llu)\n",
+			(unsigned long long)bar_len,
+			(unsigned long long)rs_dev->capacity_bytes);
+		return -ERANGE;
+	}
+
+	if (rs_dev->capacity_bytes > SIZE_MAX) {
+		dev_err(&pdev->dev, "requested capacity exceeds mapping width\n");
+		return -EOVERFLOW;
+	}
+
+	rs_dev->dma.pci_addr = bar_start;
+	rs_dev->dma.size = (size_t)rs_dev->capacity_bytes;
+
+	if (!IS_ALIGNED(rs_dev->dma.pci_addr, PAGE_SIZE)) {
+		dev_err(&pdev->dev, "PCIe BAR0 address not %lu-byte aligned\n", PAGE_SIZE);
+		return -EINVAL;
+	}
+
+	/* Map PCIe VRAM BAR using Write-Combining for peak throughput */
+	rs_dev->dma.cpu_addr = devm_ioremap_wc(&pdev->dev, rs_dev->dma.pci_addr,
+					       rs_dev->dma.size);
+	if (!rs_dev->dma.cpu_addr) {
+		dev_err(&pdev->dev, "failed to ioremap_wc VRAM BAR0 (%zu bytes)\n",
+			rs_dev->dma.size);
+		return -ENOMEM;
+	}
+
+	dev_info(&pdev->dev, "DMA engine mapped %zu MB VRAM at %pa\n",
+		 rs_dev->dma.size >> 20, &rs_dev->dma.pci_addr);
+
+	return 0;
+}
+
+void ramshared_dma_cleanup(struct ramshared_device *rs_dev)
+{
+	if (!rs_dev)
+		return;
+
+	if (rs_dev->dma.cpu_addr) {
+		rs_dev->dma.cpu_addr = NULL;
+		rs_dev->dma.size = 0;
+	}
+}
--- a/drivers/block/ramshared/main.c
+++ b/drivers/block/ramshared/main.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RamShared - Hardware-Accelerated VRAM Block Driver
+ *
+ * Copyright (C) 2026 Emerson Busson
+ */
+
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/dma-mapping.h>
+#include "ramshared.h"
+
+MODULE_AUTHOR("Emerson Busson");
+MODULE_DESCRIPTION("Hardware-Accelerated VRAM Block Driver");
+MODULE_LICENSE("GPL");
+MODULE_VERSION(RAMSHARED_DRIVER_VERSION);
+
+static unsigned long capacity_mb = 1024;
+module_param(capacity_mb, ulong, 0444);
+MODULE_PARM_DESC(capacity_mb, "Initial VRAM block device capacity in MiB (default: 1024)");
+
+static unsigned int queue_depth = RAMSHARED_DEFAULT_QUEUE_DEPTH;
+module_param(queue_depth, uint, 0444);
+MODULE_PARM_DESC(queue_depth, "Hardware queue depth (default: 256)");
+
+static int ramshared_pci_probe(struct pci_dev *pdev,
+			       const struct pci_device_id *id)
+{
+	struct ramshared_device *rs_dev;
+	resource_size_t bar_len;
+	u64 capacity_bytes;
+	int ret;
+
+	if (!pdev || !id)
+		return -EINVAL;
+
+	dev_info(&pdev->dev, "probing RamShared hardware (capacity=%lu MiB)\n",
+		 capacity_mb);
+
+	if (capacity_mb == 0 || capacity_mb > (1UL << 20)) {
+		dev_err(&pdev->dev, "invalid capacity_mb parameter: %lu\n",
+			capacity_mb);
+		return -ERANGE;
+	}
+
+	if (check_mul_overflow((u64)capacity_mb, 1024ULL * 1024ULL,
+			       &capacity_bytes)) {
+		dev_err(&pdev->dev, "capacity_bytes integer overflow\n");
+		return -EOVERFLOW;
+	}
+
+	bar_len = pci_resource_len(pdev, 0);
+	/* SPEC: kernel-pci-bar-capacity-contract §RF-1. */
+	if (bar_len == 0 || (u64)bar_len < capacity_bytes) {
+		dev_err(&pdev->dev,
+			"BAR0 is smaller than requested capacity (%llu < %llu)\n",
+			(unsigned long long)bar_len,
+			(unsigned long long)capacity_bytes);
+		return -ERANGE;
+	}
+
+	if (queue_depth < 16 || queue_depth > 1024) {
+		dev_warn(&pdev->dev,
+			 "clamping queue_depth (%u) to bounds [16, 1024]\n",
+			 queue_depth);
+		if (queue_depth < 16)
+			queue_depth = 16;
+		else
+			queue_depth = 1024;
+	}
+
+	rs_dev = devm_kzalloc(&pdev->dev, sizeof(*rs_dev), GFP_KERNEL);
+	if (!rs_dev)
+		return -ENOMEM;
+
+	rs_dev->dev = &pdev->dev;
+	rs_dev->capacity_bytes = capacity_bytes;
+	mutex_init(&rs_dev->lock);
+	atomic64_set(&rs_dev->dma_transfers_total, 0);
+	atomic64_set(&rs_dev->read_bytes, 0);
+	atomic64_set(&rs_dev->write_bytes, 0);
+
+	ret = pci_enable_device_mem(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable PCIe memory device: %d\n",
+			ret);
+		return ret;
+	}
+
+	pci_set_master(pdev);
+
+	ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
+	if (ret) {
+		dev_warn(&pdev->dev, "64-bit DMA failed, attempting 32-bit DMA\n");
+		ret = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(32));
+		if (ret) {
+			dev_err(&pdev->dev, "no usable DMA configuration\n");
+			goto err_clear_master;
+		}
+	}
+
+	ret = pci_request_mem_regions(pdev, RAMSHARED_DRIVER_NAME);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to claim PCIe memory regions\n");
+		ret = -EBUSY;
+		goto err_clear_master;
+	}
+
+	ret = ramshared_dma_init(rs_dev, pdev);
+	if (ret)
+		goto err_release_regions;
+
+	ret = ramshared_queue_init(rs_dev, &pdev->dev, queue_depth);
+	if (ret)
+		goto err_dma_cleanup;
+
+	ret = device_add_disk(&pdev->dev, rs_dev->disk, ramshared_attr_groups);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add block disk (err=%d)\n", ret);
+		put_disk(rs_dev->disk);
+		rs_dev->disk = NULL;
+		blk_mq_free_tag_set(&rs_dev->tag_set);
+		goto err_dma_cleanup;
+	}
+
+	pci_set_drvdata(pdev, rs_dev);
+	dev_info(&pdev->dev, "block device /dev/%s registered successfully\n",
+		 rs_dev->disk->disk_name);
+	return 0;
+
+err_dma_cleanup:
+	ramshared_dma_cleanup(rs_dev);
+err_release_regions:
+	pci_release_mem_regions(pdev);
+err_clear_master:
+	pci_clear_master(pdev);
+	pci_disable_device(pdev);
+	return ret;
+}
+
+static void ramshared_pci_remove(struct pci_dev *pdev)
+{
+	struct ramshared_device *rs_dev;
+
+	if (!pdev)
+		return;
+
+	rs_dev = pci_get_drvdata(pdev);
+	if (!rs_dev)
+		return;
+
+	ramshared_queue_cleanup(rs_dev);
+	ramshared_dma_cleanup(rs_dev);
+	pci_release_mem_regions(pdev);
+	pci_clear_master(pdev);
+	pci_disable_device(pdev);
+
+	dev_info(&pdev->dev, "RamShared device removed successfully\n");
+}
+
+/* PCIe AER & Link Drop Error Handlers */
+static pci_ers_result_t ramshared_pci_error_detected(struct pci_dev *pdev,
+						     pci_channel_state_t state)
+{
+	dev_err(&pdev->dev, "PCIe error detected (state=%d)\n", state);
+	if (state == pci_channel_io_frozen)
+		return PCI_ERS_RESULT_NEED_RESET;
+	return PCI_ERS_RESULT_CAN_RECOVER;
+}
+
+static pci_ers_result_t ramshared_pci_slot_reset(struct pci_dev *pdev)
+{
+	dev_info(&pdev->dev, "PCIe slot reset recovery initiated\n");
+	pci_restore_state(pdev);
+	return PCI_ERS_RESULT_RECOVERED;
+}
+
+static void ramshared_pci_resume(struct pci_dev *pdev)
+{
+	dev_info(&pdev->dev, "PCIe link resumed\n");
+}
+
+static const struct pci_error_handlers ramshared_pci_err_handler = {
+	.error_detected = ramshared_pci_error_detected,
+	.slot_reset     = ramshared_pci_slot_reset,
+	.resume         = ramshared_pci_resume,
+};
+
+static const struct pci_device_id ramshared_pci_tbl[] = {
+	{ PCI_DEVICE_CLASS(PCI_CLASS_DISPLAY_VGA << 8, 0xffff00) },
+	{ PCI_DEVICE_CLASS(PCI_CLASS_DISPLAY_OTHER << 8, 0xffff00) },
+	{ PCI_DEVICE_CLASS(PCI_CLASS_ACCELERATOR_PROCESSING << 8, 0xffff00) },
+	{ 0, }
+};
+MODULE_DEVICE_TABLE(pci, ramshared_pci_tbl);
+
+static struct pci_driver ramshared_pci_driver = {
+	.name		= RAMSHARED_DRIVER_NAME,
+	.id_table	= ramshared_pci_tbl,
+	.probe		= ramshared_pci_probe,
+	.remove		= ramshared_pci_remove,
+	.err_handler	= &ramshared_pci_err_handler,
+};
+
+module_pci_driver(ramshared_pci_driver);
--- a/drivers/block/ramshared/queue.c
+++ b/drivers/block/ramshared/queue.c
@@ -0,0 +1,325 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * RamShared - blk-mq multi-queue request handling & hardware limit setup
+ *
+ * Copyright (C) 2026 Emerson Busson
+ */
+
+#include <linux/module.h>
+#include <linux/blk-mq.h>
+#include <linux/bio.h>
+#include <linux/dma-mapping.h>
+#include <linux/highmem.h>
+#include <linux/io.h>
+#include <linux/overflow.h>
+#include "ramshared.h"
+#include "compat.h"
+
+static blk_status_t ramshared_errno_to_blk_status(int err)
+{
+	switch (err) {
+	case -ENOMEM:
+		return BLK_STS_RESOURCE;
+	case -EOPNOTSUPP:
+		return BLK_STS_NOTSUPP;
+	default:
+		return BLK_STS_IOERR;
+	}
+}
+
+static blk_status_t ramshared_process_bio(struct ramshared_device *rs_dev,
+					  struct bio *bio, loff_t pos)
+{
+	struct bio_vec bvec;
+	struct bvec_iter iter;
+	unsigned int op = bio_op(bio);
+	void __iomem *vram_ptr;
+
+	if (unlikely(!IS_ALIGNED(pos, RAMSHARED_SECTOR_SIZE) ||
+		     !IS_ALIGNED(bio->bi_iter.bi_size, RAMSHARED_SECTOR_SIZE))) {
+		dev_err_ratelimited(rs_dev->dev,
+				    "Unaligned bio: pos=%lld, len=%u\n",
+				    pos, bio->bi_iter.bi_size);
+		return ramshared_errno_to_blk_status(-EINVAL);
+	}
+
+	if (unlikely(pos > rs_dev->dma.size ||
+		     bio->bi_iter.bi_size > rs_dev->dma.size - pos ||
+		     pos + bio->bi_iter.bi_size > rs_dev->capacity_bytes)) {
+		dev_err_ratelimited(rs_dev->dev,
+				    "Bio bounds violation: pos=%lld, len=%u, cap=%llu\n",
+				    pos, bio->bi_iter.bi_size,
+				    rs_dev->capacity_bytes);
+		return ramshared_errno_to_blk_status(-ERANGE);
+	}
+
+	vram_ptr = rs_dev->dma.cpu_addr + pos;
+
+	bio_for_each_segment(bvec, bio, iter) {
+		void *src_or_dst = bvec_kmap_local(&bvec);
+		size_t len = bvec.bv_len;
+
+		if (op == REQ_OP_READ) {
+			dma_rmb();
+			memcpy_fromio(src_or_dst, vram_ptr, len);
+			flush_dcache_page(bvec.bv_page);
+			atomic64_add(len, &rs_dev->read_bytes);
+		} else if (op == REQ_OP_WRITE) {
+			memcpy_toio(vram_ptr, src_or_dst, len);
+			dma_wmb();
+			atomic64_add(len, &rs_dev->write_bytes);
+		}
+		kunmap_local(src_or_dst);
+		vram_ptr += len;
+	}
+
+	atomic64_inc(&rs_dev->dma_transfers_total);
+	return BLK_STS_OK;
+}
+
+static blk_status_t ramshared_queue_rq(struct blk_mq_hw_ctx *hctx,
+				       const struct blk_mq_queue_data *bd)
+{
+	struct request *rq = bd->rq;
+	struct ramshared_device *rs_dev = rq->q->queuedata;
+	loff_t pos;
+	size_t len = blk_rq_bytes(rq);
+	blk_status_t status = BLK_STS_OK;
+	struct bio *bio;
+
+	if (unlikely(!rs_dev || !rs_dev->dma.cpu_addr))
+		return ramshared_errno_to_blk_status(-EIO);
+
+	if (unlikely(check_shl_overflow((loff_t)blk_rq_pos(rq), RAMSHARED_SECTOR_SHIFT, &pos)))
+		return ramshared_errno_to_blk_status(-ERANGE);
+
+	if (unlikely(!IS_ALIGNED(pos, RAMSHARED_SECTOR_SIZE) ||
+		     !IS_ALIGNED(len, RAMSHARED_SECTOR_SIZE))) {
+		dev_err_ratelimited(rs_dev->dev,
+				    "Unaligned I/O request: pos=%lld, len=%zu\n",
+				    pos, len);
+		return ramshared_errno_to_blk_status(-EINVAL);
+	}
+
+	if (unlikely(pos > rs_dev->dma.size ||
+		     len > rs_dev->dma.size - pos ||
+		     pos + len > rs_dev->capacity_bytes)) {
+		dev_err_ratelimited(rs_dev->dev,
+				    "I/O bounds violation: pos=%lld, len=%zu, cap=%llu, mapped=%zu\n",
+				    pos, len, rs_dev->capacity_bytes,
+				    rs_dev->dma.size);
+		return ramshared_errno_to_blk_status(-ERANGE);
+	}
+
+	blk_mq_start_request(rq);
+
+	switch (req_op(rq)) {
+	case REQ_OP_READ:
+	case REQ_OP_WRITE:
+		__rq_for_each_bio(bio, rq) {
+			status = ramshared_process_bio(rs_dev, bio, pos);
+			if (status != BLK_STS_OK)
+				break;
+			pos += bio->bi_iter.bi_size;
+		}
+		break;
+	case REQ_OP_FLUSH:
+		dma_wmb();
+		status = BLK_STS_OK;
+		break;
+	case REQ_OP_DISCARD:
+	case REQ_OP_SECURE_ERASE:
+		memset_io(rs_dev->dma.cpu_addr + pos, 0, len);
+		dma_wmb();
+		status = BLK_STS_OK;
+		break;
+	default:
+		status = BLK_STS_NOTSUPP;
+		break;
+	}
+
+	blk_mq_end_request(rq, status);
+	return BLK_STS_OK;
+}
+
+static const struct blk_mq_ops ramshared_mq_ops = {
+	.queue_rq = ramshared_queue_rq,
+};
+
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 12, 0)
+/* Synchronous Zero-Allocation Swap Fast-Path (Linux < 6.12) */
+static int ramshared_bdev_rw_page(struct block_device *bdev, sector_t sector,
+				  struct page *page, enum req_op op)
+{
+	struct ramshared_device *rs_dev = bdev->bd_disk->private_data;
+	loff_t pos;
+	size_t len = PAGE_SIZE;
+	void __iomem *vram_ptr;
+	void *mem;
+	int is_write = op_is_write(op);
+
+	if (unlikely(!rs_dev || !rs_dev->dma.cpu_addr))
+		return -EIO;
+
+	if (unlikely(check_shl_overflow((loff_t)sector, RAMSHARED_SECTOR_SHIFT, &pos)))
+		return -EIO;
+
+	if (unlikely(pos > rs_dev->dma.size ||
+		     len > rs_dev->dma.size - pos ||
+		     pos + len > rs_dev->capacity_bytes))
+		return -ERANGE;
+
+	vram_ptr = rs_dev->dma.cpu_addr + pos;
+	mem = kmap_local_page(page);
+
+	if (is_write) {
+		memcpy_toio(vram_ptr, mem, len);
+		dma_wmb();
+		atomic64_add(len, &rs_dev->write_bytes);
+	} else {
+		dma_rmb();
+		memcpy_fromio(mem, vram_ptr, len);
+		flush_dcache_page(page);
+		atomic64_add(len, &rs_dev->read_bytes);
+	}
+
+	kunmap_local(mem);
+	atomic64_inc(&rs_dev->dma_transfers_total);
+	page_endio(page, is_write, 0);
+	return 0;
+}
+#endif
+
+static const struct block_device_operations ramshared_fops = {
+	.owner		= THIS_MODULE,
+#if LINUX_VERSION_CODE < KERNEL_VERSION(6, 12, 0)
+	.rw_page	= ramshared_bdev_rw_page,
+#endif
+	.ioctl		= ramshared_ioctl,
+};
+
+/* Sysfs Attributes Group (Race-free via disk_groups) */
+static ssize_t capacity_bytes_show(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct ramshared_device *rs_dev = disk->private_data;
+
+	return sysfs_emit(buf, "%llu\n", rs_dev->capacity_bytes);
+}
+static DEVICE_ATTR_RO(capacity_bytes);
+
+static ssize_t dma_transfers_total_show(struct device *dev,
+					struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct ramshared_device *rs_dev = disk->private_data;
+
+	return sysfs_emit(buf, "%lld\n", atomic64_read(&rs_dev->dma_transfers_total));
+}
+static DEVICE_ATTR_RO(dma_transfers_total);
+
+static ssize_t read_bytes_show(struct device *dev,
+			       struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct ramshared_device *rs_dev = disk->private_data;
+
+	return sysfs_emit(buf, "%lld\n", atomic64_read(&rs_dev->read_bytes));
+}
+static DEVICE_ATTR_RO(read_bytes);
+
+static ssize_t write_bytes_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct ramshared_device *rs_dev = disk->private_data;
+
+	return sysfs_emit(buf, "%lld\n", atomic64_read(&rs_dev->write_bytes));
+}
+static DEVICE_ATTR_RO(write_bytes);
+
+static struct attribute *ramshared_attrs[] = {
+	&dev_attr_capacity_bytes.attr,
+	&dev_attr_dma_transfers_total.attr,
+	&dev_attr_read_bytes.attr,
+	&dev_attr_write_bytes.attr,
+	NULL,
+};
+
+static const struct attribute_group ramshared_attr_group = {
+	.name = "ramshared",
+	.attrs = ramshared_attrs,
+};
+
+const struct attribute_group *ramshared_attr_groups[] = {
+	&ramshared_attr_group,
+	NULL,
+};
+
+int ramshared_queue_init(struct ramshared_device *rs_dev,
+			 struct device *parent_dev, unsigned int q_depth)
+{
+	unsigned int valid_depth;
+	int ret;
+
+	if (!rs_dev || !parent_dev)
+		return -EINVAL;
+
+	valid_depth = clamp_t(unsigned int, q_depth, 16U, 1024U);
+
+	memset(&rs_dev->tag_set, 0, sizeof(rs_dev->tag_set));
+	rs_dev->tag_set.ops = &ramshared_mq_ops;
+	rs_dev->tag_set.nr_hw_queues = num_online_cpus();
+	rs_dev->tag_set.queue_depth = valid_depth;
+	rs_dev->tag_set.numa_node = NUMA_NO_NODE;
+#ifdef BLK_MQ_F_SHOULD_MERGE
+	rs_dev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
+#else
+	rs_dev->tag_set.flags = 0;
+#endif
+
+	ret = blk_mq_alloc_tag_set(&rs_dev->tag_set);
+	if (ret)
+		return ret;
+
+	/* Allocate disk with backward & forward kernel compatibility */
+	rs_dev->disk = ramshared_alloc_disk(&rs_dev->tag_set, rs_dev,
+					    RAMSHARED_SECTOR_SIZE, 2048);
+	if (IS_ERR(rs_dev->disk)) {
+		ret = PTR_ERR(rs_dev->disk);
+		blk_mq_free_tag_set(&rs_dev->tag_set);
+		return ret;
+	}
+
+	rs_dev->disk->queue->queuedata = rs_dev;
+
+	/* Setup gendisk descriptor */
+	rs_dev->disk->major = 0;
+	rs_dev->disk->first_minor = 0;
+	rs_dev->disk->minors = 0;
+	rs_dev->disk->fops = &ramshared_fops;
+	rs_dev->disk->private_data = rs_dev;
+	rs_dev->disk->flags |= GENHD_FL_NO_PART;
+	snprintf(rs_dev->disk->disk_name, DISK_NAME_LEN, "ramshared0");
+	set_capacity(rs_dev->disk, rs_dev->capacity_bytes >> RAMSHARED_SECTOR_SHIFT);
+
+	return 0;
+}
+
+void ramshared_queue_cleanup(struct ramshared_device *rs_dev)
+{
+	if (!rs_dev)
+		return;
+
+	if (rs_dev->disk) {
+		del_gendisk(rs_dev->disk);
+		put_disk(rs_dev->disk);
+		rs_dev->disk = NULL;
+	}
+
+	if (rs_dev->tag_set.tags) {
+		blk_mq_free_tag_set(&rs_dev->tag_set);
+		memset(&rs_dev->tag_set, 0, sizeof(rs_dev->tag_set));
+	}
+}
--- a/drivers/block/ramshared/ramshared.h
+++ b/drivers/block/ramshared/ramshared.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+#ifndef _RAMSHARED_H
+#define _RAMSHARED_H
+
+#include <linux/types.h>
+#include <linux/blkdev.h>
+#include <linux/blk-mq.h>
+#include <linux/pci.h>
+#include <linux/mutex.h>
+#include <linux/atomic.h>
+
+#define RAMSHARED_DRIVER_NAME		"ramshared"
+#define RAMSHARED_DRIVER_VERSION	"0.9.0-beta.2"
+#define RAMSHARED_SECTOR_SIZE		512
+#define RAMSHARED_SECTOR_SHIFT		9
+#define RAMSHARED_DEFAULT_QUEUE_DEPTH	256
+#define RAMSHARED_MMIO_POISON_VALUE	0xFFFFFFFFU
+
+/**
+ * struct ramshared_dma_region - PCIe DMA memory descriptor
+ * @pci_addr: Physical PCIe bus address
+ * @cpu_addr: Kernel virtual address mapped with write-combining
+ * @size: Size of the allocated region in bytes
+ * @dma_handle: DMA bus address mapping
+ */
+struct ramshared_dma_region {
+	phys_addr_t	pci_addr;
+	void __iomem	*cpu_addr;
+	size_t		size;
+	dma_addr_t	dma_handle;
+};
+
+/**
+ * struct ramshared_device - Main in-tree block device state
+ * @disk: gendisk descriptor
+ * @tag_set: blk-mq tag set
+ * @dma: DMA memory region
+ * @capacity_bytes: Total available VRAM capacity in bytes
+ * @dev: Pointer to underlying struct device
+ * @lock: Mutex protecting device state transitions
+ * @dma_transfers_total: Diagnostic counter for completed transfers
+ * @read_bytes: Total bytes read
+ * @write_bytes: Total bytes written
+ */
+struct ramshared_device {
+	struct gendisk			*disk;
+	struct blk_mq_tag_set		tag_set;
+	struct ramshared_dma_region	dma;
+	u64				capacity_bytes;
+	struct device			*dev;
+	/* Mutex serializing device registration and teardown */
+	struct mutex			lock;
+	atomic64_t			dma_transfers_total;
+	atomic64_t			read_bytes;
+	atomic64_t			write_bytes;
+};
+
+int ramshared_dma_init(struct ramshared_device *rs_dev, struct pci_dev *pdev);
+void ramshared_dma_cleanup(struct ramshared_device *rs_dev);
+int ramshared_queue_init(struct ramshared_device *rs_dev,
+			 struct device *parent_dev, unsigned int q_depth);
+void ramshared_queue_cleanup(struct ramshared_device *rs_dev);
+
+struct ramshared_info {
+	u64 capacity_bytes;
+	u32 queue_depth;
+	u32 reserved;
+};
+
+struct ramshared_param {
+	u32 param_id;
+	u32 value;
+};
+
+#define RAMSHARED_IOC_MAGIC 'R'
+#define RAMSHARED_IOC_GET_INFO	_IOR(RAMSHARED_IOC_MAGIC, 1, struct ramshared_info)
+#define RAMSHARED_IOC_SET_PARAM	_IOW(RAMSHARED_IOC_MAGIC, 2, struct ramshared_param)
+
+#include "compat.h"
+
+extern const struct attribute_group *ramshared_attr_groups[];
+
+int ramshared_ioctl(struct block_device *bdev, ramshared_blk_mode_t mode,
+		    unsigned int cmd, unsigned long arg);
+#endif /* _RAMSHARED_H */
