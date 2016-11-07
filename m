Return-Path: <BATV+fd6e759d6fe7114d99bf+4824+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christogh Hellwig <hch@lst.de>
Subject: [PATCH 1/7] genirq/affinity: Introduce struct irq_affinity
Date: Mon,  7 Nov 2016 10:47:36 -0800
Message-Id: <1478544462-9549-2-git-send-email-hch@lst.de>
In-Reply-To: <1478544462-9549-1-git-send-email-hch@lst.de>
References: <1478544462-9549-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Christogh Hellwig <hch@lst.de>

Some drivers (various network and RDMA adapter for example) have a MSI-X
vector layout where most of the vectors are used for I/O queues and should
have CPU affinity assigned to them, but some (usually 1 but sometimes more)
at the beginning or end are used for low-performance admin or configuration
work and should not have any explicit affinity assigned to them.

This adds a new irq_affinity structure, which will be passed through a
variant of pci_irq_alloc_vectors that allows to specify these
requirements (and is extensible to any future quirks in that area) so that
the core IRQ affinity algorithm can take this quirks into account.

Signed-off-by: Christogh Hellwig <hch@lst.de>
---
 include/linux/interrupt.h | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 72f0721..7284bcd 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -232,6 +232,18 @@ struct irq_affinity_notify {
 	void (*release)(struct kref *ref);
 };
 
+/**
+ * struct irq_affinity - Description for auto irq affinity assignements
+ * @pre_vectors:	Reserved vectors at the beginning of the MSIX
+ *			vector space
+ * @post_vectors:	Reserved vectors at the end of the MSIX
+ *			vector space
+ */
+struct irq_affinity {
+	int	pre_vectors;
+	int	post_vectors;
+};
+
 #if defined(CONFIG_SMP)
 
 extern cpumask_var_t irq_default_affinity;
-- 
2.1.4
