Return-Path: <BATV+c11f2a9076c546b906d6+4834+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: mst@redhat.com
Cc: axboe@kernel.dk,
	virtualization@lists.linux-foundation.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 10/11] blk-mq: provide a default queue mapping for virtio device
Date: Thu, 17 Nov 2016 11:43:22 +0100
Message-Id: <1479379403-27880-11-git-send-email-hch@lst.de>
In-Reply-To: <1479379403-27880-1-git-send-email-hch@lst.de>
References: <1479379403-27880-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Similar to the PCI version, just calling into virtio instead.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Kconfig                 |  5 ++++
 block/Makefile                |  1 +
 block/blk-mq-virtio.c         | 55 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq-virtio.h | 10 ++++++++
 4 files changed, 71 insertions(+)
 create mode 100644 block/blk-mq-virtio.c
 create mode 100644 include/linux/blk-mq-virtio.h

diff --git a/block/Kconfig b/block/Kconfig
index 1d4d624..2f69b45 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -130,4 +130,9 @@ config BLK_MQ_PCI
 	depends on BLOCK && PCI
 	default y
 
+config BLK_MQ_VIRTIO
+	bool
+	depends on BLOCK && VIRTIO
+	default y
+
 source block/Kconfig.iosched
diff --git a/block/Makefile b/block/Makefile
index 36acdd75..3530a58 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -23,3 +23,4 @@ obj-$(CONFIG_BLOCK_COMPAT)	+= compat_ioctl.o
 obj-$(CONFIG_BLK_CMDLINE_PARSER)	+= cmdline-parser.o
 obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o t10-pi.o
 obj-$(CONFIG_BLK_MQ_PCI)	+= blk-mq-pci.o
+obj-$(CONFIG_BLK_MQ_VIRTIO)	+= blk-mq-virtio.o
diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
new file mode 100644
index 0000000..44d3f0d
--- /dev/null
+++ b/block/blk-mq-virtio.c
@@ -0,0 +1,55 @@
+/*
+ * Copyright (c) 2016 Christoph Hellwig.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms and conditions of the GNU General Public License,
+ * version 2, as published by the Free Software Foundation.
+ *
+ * This program is distributed in the hope it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ */
+#include <linux/device.h>
+#include <linux/blk-mq.h>
+#include <linux/blk-mq-virtio.h>
+#include <linux/virtio_config.h>
+#include <linux/module.h>
+#include "blk-mq.h"
+
+/**
+ * blk_mq_virtio_map_queues - provide a default queue mapping for virtio device
+ * @set:	tagset to provide the mapping for
+ * @vdev:	virtio device associated with @set.
+ * @first_vec:	first interrupt vectors to use for queues (usually 0)
+ *
+ * This function assumes the virtio device @vdev has at least as many available
+ * interrupt vetors as @set has queues.  It will then queuery the vector
+ * corresponding to each queue for it's affinity mask and built queue mapping
+ * that maps a queue to the CPUs that have irq affinity for the corresponding
+ * vector.
+ */
+int blk_mq_virtio_map_queues(struct blk_mq_tag_set *set,
+		struct virtio_device *vdev, int first_vec)
+{
+	const struct cpumask *mask;
+	unsigned int queue, cpu;
+
+	if (!vdev->config->get_vq_affinity)
+		goto fallback;
+
+	/* the very first virtqueue is used internally by virtio, skip it */
+	for (queue = 0; queue < set->nr_hw_queues; queue++) {
+		mask = vdev->config->get_vq_affinity(vdev, first_vec + queue);
+		if (!mask)
+			goto fallback;
+
+		for_each_cpu(cpu, mask)
+			set->mq_map[cpu] = queue;
+	}
+
+	return 0;
+fallback:
+	return blk_mq_map_queues(set);
+}
+EXPORT_SYMBOL_GPL(blk_mq_virtio_map_queues);
diff --git a/include/linux/blk-mq-virtio.h b/include/linux/blk-mq-virtio.h
new file mode 100644
index 0000000..b1ef6e1
--- /dev/null
+++ b/include/linux/blk-mq-virtio.h
@@ -0,0 +1,10 @@
+#ifndef _LINUX_BLK_MQ_VIRTIO_H
+#define _LINUX_BLK_MQ_VIRTIO_H
+
+struct blk_mq_tag_set;
+struct virtio_device;
+
+int blk_mq_virtio_map_queues(struct blk_mq_tag_set *set,
+		struct virtio_device *vdev, int first_vec);
+
+#endif /* _LINUX_BLK_MQ_VIRTIO_H */
-- 
2.1.4
