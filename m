Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40398 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763722AbcINOTm (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2016 10:19:42 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com, tglx@linutronix.de
Cc: agordeev@redhat.com, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 10/13] blk-mq: provide a default queue mapping for PCI device
Date: Wed, 14 Sep 2016 16:18:56 +0200
Message-Id: <1473862739-15032-11-git-send-email-hch@lst.de>
In-Reply-To: <1473862739-15032-1-git-send-email-hch@lst.de>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 block/Makefile             |  2 +-
 block/blk-mq-pci.c         | 45 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq-pci.h |  9 +++++++++
 3 files changed, 55 insertions(+), 1 deletion(-)
 create mode 100644 block/blk-mq-pci.c
 create mode 100644 include/linux/blk-mq-pci.h

diff --git a/block/Makefile b/block/Makefile
index 9eda232..2447a0b 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -22,4 +22,4 @@ obj-$(CONFIG_IOSCHED_CFQ)	+= cfq-iosched.o
 obj-$(CONFIG_BLOCK_COMPAT)	+= compat_ioctl.o
 obj-$(CONFIG_BLK_CMDLINE_PARSER)	+= cmdline-parser.o
 obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o t10-pi.o
-
+obj-$(CONFIG_PCI)		+= blk-mq-pci.o
diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
new file mode 100644
index 0000000..33c7bd7
--- /dev/null
+++ b/block/blk-mq-pci.c
@@ -0,0 +1,45 @@
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
+#include <linux/blk-mq.h>
+#include <linux/blk-mq-pci.h>
+#include <linux/pci.h>
+#include <linux/module.h>
+
+/**
+ * blk_mq_pci_map_queues - provide a default queue mapping for PCI device
+ * @set:	tagset to provide the mapping for
+ * @pdev:	PCI device associated with @set.
+ *
+ * This function assumes the PCI device @pdev has at least as many available
+ * interrupt vetors as @set has queues.  It will then queuery the vector
+ * corresponding to each queue for it's affinity mask and built queue mapping
+ * that maps a queue to the CPUs that have irq affinity for the corresponding
+ * vector.
+ */
+int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev)
+{
+	const struct cpumask *mask;
+	unsigned int queue, cpu;
+
+	for (queue = 0; queue < set->nr_hw_queues; queue++) {
+		mask = pci_irq_get_affinity(pdev, queue);
+		if (!mask)
+			return -EINVAL;
+
+		for_each_cpu(cpu, mask)
+			set->mq_map[cpu] = queue;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(blk_mq_pci_map_queues);
diff --git a/include/linux/blk-mq-pci.h b/include/linux/blk-mq-pci.h
new file mode 100644
index 0000000..6ab5952
--- /dev/null
+++ b/include/linux/blk-mq-pci.h
@@ -0,0 +1,9 @@
+#ifndef _LINUX_BLK_MQ_PCI_H
+#define _LINUX_BLK_MQ_PCI_H
+
+struct blk_mq_tag_set;
+struct pci_dev;
+
+int blk_mq_pci_map_queues(struct blk_mq_tag_set *set, struct pci_dev *pdev);
+
+#endif /* _LINUX_BLK_MQ_PCI_H */
-- 
2.1.4

