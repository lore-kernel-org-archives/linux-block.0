Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5BB283A875E
	for <linux-block@vger.kernel.org>; Fri,  4 Sep 2026 07:38:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788507510; cv=none; b=nhhKfSse9B2wP3+3dqZeqmQYBhpTd5zhOwC+nR6Pi2L85VbRMkvKxTxcUNgZOxlSXtO3JFotQIHzoCn7szZ3WK0DZUW+oX1bkxaLJi1CCgKmcWpCT0PNfr3XBqRi8oihYPOa+k6un5bCeDqYvgfMcxyy15GSFdCUnuol5n08GUQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788507510; c=relaxed/simple;
	bh=2YRgAiAluH7jXFae1uQGGkdkJ2Xj5vzlPetyVYLl4Fs=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=XylJJFTtAUVcMHyFdhUWK5yQfxVz09CVBFyccsGt0b4IOD/pnbLeAiltpdt57JkOYhkg2RfNQbrXsmcwhtYWEKYxHiydtPV/kbr+1SDOVgKUYDka2fAHL+qw7c0DCFs6NS/Ces3ulj16SWf+sq4rErSPKcSE88CHdwY8Sn7Gldg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W0ne5X2a; arc=none smtp.client-ip=74.125.224.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W0ne5X2a"
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-66e64e6e3fbso620097d50.2
        for <linux-block@vger.kernel.org>; Fri, 04 Sep 2026 00:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788507507; x=1789112307; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=TBRH/eykEOzGK52UYAJOkrkn1jwAKfla4+wLrEBoe1g=;
        b=W0ne5X2a/fEKZFqAGuOwDm/8ETjKP4RAk3w7gntUJdQ7vrlec9k8/G5xuvKVx0USpn
         +WlcA3iw2E1gqWR0CucX+MXrQj55qi8s7D/fTpajCO08yCoUzO28F+HEK62+5r038tjK
         q3N2QyS51hkgE8UVu7ZlxlIJpobCwlmJVMABXWLeCvVaRcHaS7Slu65rquB6rzEZdfKD
         acF9fI+ZBBd43zdjOA6YF5nY6czSO+r82xevsRhd1Di/HVf6c2E36CtBA+OEH26yRRHr
         LVObnb1aPEEHRNvARqH6Q4qpcHPlmYTdCQe8nYMZFy1cJbc7axiq9PZhjsFwjmQUFmRh
         bp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788507507; x=1789112307;
        h=content-transfer-encoding:mime-version:references:in-reply-to:date
         :subject:cc:to:from:message-id:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to:content-type;
        bh=TBRH/eykEOzGK52UYAJOkrkn1jwAKfla4+wLrEBoe1g=;
        b=jjOD6bha0Twb/ltru8WNM5ld5GbwCPFuV33x+oiD2FWwTbLhb2Pdet3m8DGjNe/gil
         mYxUXLiOUj3Ain/2/vn8kgNYb83mn/RR+dZVq5LVfWoSTNvREgZuagpi2/EXXIIwx4FB
         nw6pjfKmF7wCtJ808d8ssFDK0XD3ji9HqoefJ9z8v2oW9dYHuJT8t91r9YeCYiu9u3mD
         lmlEU0/qhQhPXwegIcQGgyZMBks7i4n2FMbHVAbw2mV/2EkWSUFukZ4DhvKpH3vCW7Se
         KJJF2Fx629GGtEYBrzq0aIA5cBkB64zr3LSJu7q6HRx3vykJq7yxQriVWI2Qp8Wrl0+o
         2aBw==
X-Gm-Message-State: AFuF++lY4fHyJmbABnXSZZRJ+O37ZjHsLvxDHYGur4PjtY2byWKVeoVa
	FfZgP/yAtPp4Dj1gladw7XoG1ndEhsVtBgKO2UAj16Vwj6yz7icmmL+Zr1TDX+E3
X-Gm-Gg: AYBFou302TI7ubCOLwcjuMN3oEsXVruOAiR1a8o6QrOQ1JnXO4ol2NVJ09sXaOv10ns
	FvmRgYRnMppuRzo7f3ny5gyINpIdkkyRkWxOXGFbWiHkHTEvCuMYmKsb7UlbLqnKCfzS7Ug3DTK
	Z1MtpVveFUN6bGQE3qAFIwsRC/Ew4FW5WQ+vPRi6N9ZzWmRRcmzLuBGl6oEs4ypBT8aB0WV1/Sy
	a/EGFO22psUU3fTdD+sJAbwx7Ps6otoZuTZ7ToXoEF4PyD0k2cvhw/yEyfafXFoZHjDmwVnBR1q
	2C0mx5HemZCYW94Z25sgm6UrtCMoUeVugI9oebUOrIL+S5XgtByF0VbfwXKZc9ECbq6ADZhMljH
	TWL4uDWWJaauWWwkYX453snNoxrlG9BPWzXHcuxjZdw9dleoaEOMN6whIrDjygQvUs5svi+ImDl
	KT+SeL2if+5pcXMLF+OoblafArvcqKCCXHfYEjjCdnsyPOKegcLyfRxEaFI5K9FOK7NjrytxIjZ
	zdWZbIhSQ==
X-Received: by 2002:a05:690e:42ce:b0:66e:461c:428b with SMTP id 956f58d0204a3-66fb5a0146amr1233004d50.30.1788507507113;
        Fri, 04 Sep 2026 00:38:27 -0700 (PDT)
Received: from emedev.tailf75c28.ts.net ([179.238.17.208])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-66fb48f1646sm1691157d50.9.2026.09.04.00.38.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Sep 2026 00:38:26 -0700 (PDT)
Message-ID: <6a9a7572.4675fc7e.263ae0.6725@mx.google.com>
X-Google-Original-Message-ID: <20260904041501.ramshared-v2-driver>
From: emersonbusson <emersonbusson@gmail.com>
To: linux-block@vger.kernel.org
Cc: axboe@kernel.dk,
	linux-kernel@vger.kernel.org,
	emersonbusson <emersonbusson@gmail.com>
Subject: [RFC PATCH v2 1/2] drivers/block/ramshared: add hardware-accelerated VRAM block driver
Date: Fri,  4 Sep 2026 04:38:14 -0300
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260904041500.ramshared-v2-cover>
References: <20260904041500.ramshared-v2-cover>
Precedence: bulk
X-Mailing-List: linux-block@vger.kernel.org
List-Id: <linux-block.vger.kernel.org>
List-Subscribe: <mailto:linux-block+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-block+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the RamShared driver core in drivers/block/ramshared/ supporting
direct PCIe DMA aperture mapping, blk-mq request dispatch, and
synchronous .rw_page swap fast-path.

Signed-off-by: emersonbusson <emersonbusson@gmail.com>
---
v1 -> v2 changes:
  - queue.c: use check_shl_overflow() to prevent 64-bit integer overflow
    when shifting sector to byte offsets.
  - queue.c: enforce PCIe BAR0 boundary validation before memory-mapped I/O.
  - main.c: ensure pci_clear_master() is called during linear error unwinding
    in probe failure paths and device teardown.
  - main.c: clamp queue_depth module parameter within [1..4096].
  - ramshared.h: wrap function declarations to conform to 80-column kernel
    coding style.

 drivers/block/ramshared/Kconfig     | 15 +
 drivers/block/ramshared/Makefile    | 18 +
 drivers/block/ramshared/compat.h    | 105 +++++
 drivers/block/ramshared/dma.c       | 56 +++
 drivers/block/ramshared/main.c      | 181 ++++++++
 drivers/block/ramshared/queue.c     | 264 ++++++++++
 drivers/block/ramshared/ramshared.h | 63 +++
 7 files changed, 702 insertions(+)

diff --git a/drivers/block/ramshared/Kconfig b/drivers/block/ramshared/Kconfig
new file mode 100644
--- /dev/null
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
diff --git a/drivers/block/ramshared/Makefile b/drivers/block/ramshared/Makefile
new file mode 100644
--- /dev/null
+++ b/drivers/block/ramshared/Makefile
@@ -0,0 +1,18 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+# Makefile for the RamShared in-tree kernel driver.
+#
+
+obj-$(CONFIG_BLK_DEV_RAMSHARED) += ramshared.o
+
+ramshared-y := main.o dma.o queue.o
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
diff --git a/drivers/block/ramshared/compat.h b/drivers/block/ramshared/compat.h
new file mode 100644
--- /dev/null
+++ b/drivers/block/ramshared/compat.h
@@ -0,0 +1,105 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * RamShared - Multi-Kernel Compatibility Abstraction Layer
+ * Supports: Linux 5.15 LTS (Ubuntu 22.04) -> 6.8 (Ubuntu 24.04) ->
+ *           6.10 (Fedora 40) -> 6.12 LTS (Arch) -> 6.13+ Mainline
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
+#endif /* _RAMSHARED_COMPAT_H */
diff --git a/drivers/block/ramshared/dma.c b/drivers/block/ramshared/dma.c
new file mode 100644
--- /dev/null
+++ b/drivers/block/ramshared/dma.c
@@ -0,0 +1,56 @@
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
+	if (!bar_start || bar_len == 0) {
+		dev_err(&pdev->dev, "invalid PCIe BAR0 resource\n");
+		return -ENODEV;
+	}
+
+	rs_dev->dma.pci_addr = bar_start;
+	rs_dev->dma.size = min_t(size_t, bar_len, rs_dev->capacity_bytes);
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
+	rs_dev->dma.cpu_addr = NULL;
+	rs_dev->dma.size = 0;
+}
diff --git a/drivers/block/ramshared/main.c b/drivers/block/ramshared/main.c
new file mode 100644
--- /dev/null
+++ b/drivers/block/ramshared/main.c
@@ -0,0 +1,181 @@
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
+		return -EINVAL;
+	}
+
+	if (queue_depth < 1 || queue_depth > 4096) {
+		dev_warn(&pdev->dev, "clamping queue_depth (%lu) to default (256)\n", queue_depth);
+		queue_depth = 256;
+	}
+
+	rs_dev = devm_kzalloc(&pdev->dev, sizeof(*rs_dev), GFP_KERNEL);
+	if (!rs_dev)
+		return -ENOMEM;
+
+	rs_dev->dev = &pdev->dev;
+	rs_dev->capacity_bytes = (u64)capacity_mb * 1024 * 1024;
+	mutex_init(&rs_dev->lock);
+	atomic64_set(&rs_dev->dma_transfers_total, 0);
+	atomic64_set(&rs_dev->read_bytes, 0);
+	atomic64_set(&rs_dev->write_bytes, 0);
+
+	ret = pci_enable_device_mem(pdev);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to enable PCIe memory device\n");
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
+	ret = add_disk(rs_dev->disk);
+	if (ret) {
+		dev_err(&pdev->dev, "failed to add block disk (err=%d)\n", ret);
+		goto err_queue_cleanup;
+	}
+
+	pci_set_drvdata(pdev, rs_dev);
+	dev_info(&pdev->dev, "block device /dev/%s registered successfully\n",
+		 rs_dev->disk->disk_name);
+	return 0;
+
+err_queue_cleanup:
+	ramshared_queue_cleanup(rs_dev);
+err_dma_cleanup:
+	ramshared_dma_cleanup(rs_dev);
+err_release_regions:
+	pci_release_mem_regions(pdev);
+err_clear_master:
+	pci_clear_master(pdev);
+err_disable_pci:
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
diff --git a/drivers/block/ramshared/queue.c b/drivers/block/ramshared/queue.c
new file mode 100644
--- /dev/null
+++ b/drivers/block/ramshared/queue.c
@@ -0,0 +1,264 @@
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
+static blk_status_t ramshared_process_bio(struct ramshared_device *rs_dev,
+					  struct bio *bio, loff_t pos)
+{
+	struct bio_vec bvec;
+	struct bvec_iter iter;
+	unsigned int op = bio_op(bio);
+	void __iomem *vram_ptr = rs_dev->dma.cpu_addr + pos;
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
+		return BLK_STS_IOERR;
+
+	if (unlikely(check_shl_overflow((loff_t)blk_rq_pos(rq), RAMSHARED_SECTOR_SHIFT, &pos)))
+		return BLK_STS_IOERR;
+
+	if (unlikely(pos > rs_dev->dma.size ||
+		     len > rs_dev->dma.size - pos ||
+		     pos + len > rs_dev->capacity_bytes)) {
+		dev_err_ratelimited(rs_dev->dev,
+			"I/O bounds violation: pos=%lld, len=%zu, cap=%llu, mapped=%zu\n",
+			pos, len, rs_dev->capacity_bytes, rs_dev->dma.size);
+		return BLK_STS_IOERR;
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
+/* Synchronous Zero-Allocation Swap Fast-Path */
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
+
+static const struct block_device_operations ramshared_fops = {
+	.owner		= THIS_MODULE,
+	.rw_page	= ramshared_bdev_rw_page,
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
+static ssize_t read_bytes_show(struct device *dev,
+				struct device_attribute *attr, char *buf)
+{
+	struct gendisk *disk = dev_to_disk(dev);
+	struct ramshared_device *rs_dev = disk->private_data;
+
+	return sysfs_emit(buf, "%lld\n", atomic64_read(&rs_dev->read_bytes));
+}
+static DEVICE_ATTR_RO(read_bytes);
+
+static ssize_t write_bytes_show(struct device *dev,
+				 struct device_attribute *attr, char *buf)
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
+static const struct attribute_group *ramshared_attr_groups[] = {
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
+	if (!rs_dev)
+		return -EINVAL;
+
+	valid_depth = clamp_t(unsigned int, q_depth, 16U, 2048U);
+
+	memset(&rs_dev->tag_set, 0, sizeof(rs_dev->tag_set));
+	rs_dev->tag_set.ops = &ramshared_mq_ops;
+	rs_dev->tag_set.nr_hw_queues = num_online_cpus();
+	rs_dev->tag_set.queue_depth = valid_depth;
+	rs_dev->tag_set.numa_node = NUMA_NO_NODE;
+	rs_dev->tag_set.flags = BLK_MQ_F_SHOULD_MERGE;
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
+	rs_dev->disk->minors = 1;
+	rs_dev->disk->fops = &ramshared_fops;
+	rs_dev->disk->private_data = rs_dev;
+	rs_dev->disk->disk_groups = ramshared_attr_groups;
+	rs_dev->disk->flags |= GENHD_FL_NO_PART;
+	rs_dev->disk->parent = parent_dev;
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
+	blk_mq_free_tag_set(&rs_dev->tag_set);
+}
diff --git a/drivers/block/ramshared/ramshared.h b/drivers/block/ramshared/ramshared.h
new file mode 100644
--- /dev/null
+++ b/drivers/block/ramshared/ramshared.h
@@ -0,0 +1,63 @@
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
+#endif /* _RAMSHARED_H */
