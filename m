Return-Path: <hare@suse.de>
From: Hannes Reinecke <hare@suse.de>
To: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Linux Kernel Mailinglist <linux-kernel@vger.kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Hannes Reinecke <hare@suse.com>
Subject: [RFC PATCH] pci: add pci_irq_get_affinity_vector()
Date: Tue,  8 Nov 2016 08:47:21 +0100
Message-Id: <1478591241-123356-1-git-send-email-hare@suse.de>
List-ID: <linux-block@vger.kernel.org>

Add a reverse-mapping function to return the interrupt vector for
any CPU if interrupt affinity is enabled.

Signed-off-by: Hannes Reinecke <hare@suse.com>
---
 drivers/pci/msi.c   | 36 ++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  1 +
 2 files changed, 37 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index bfdd074..de5ed32 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1302,6 +1302,42 @@ const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
 }
 EXPORT_SYMBOL(pci_irq_get_affinity);
 
+/**
+ * pci_irq_get_affinity_vector - return the vector number for a given CPU
+ * @dev:	PCI device to operate on
+ * @cpu:	cpu number
+ *
+ * Returns the vector number for CPU @cpu or a negative error number
+ * if interrupt affinity is not set.
+ */
+int pci_irq_get_affinity_vector(struct pci_dev *dev, int cpu)
+{
+	if (dev->msix_enabled) {
+		struct msi_desc *entry;
+
+		for_each_pci_msi_entry(entry, dev) {
+			if (cpumask_test_cpu(cpu, entry->affinity))
+				return entry->irq;
+		}
+		return -EINVAL;
+	} else if (dev->msi_enabled) {
+		struct msi_desc *entry = first_pci_msi_entry(dev);
+		int nr;
+
+		if (!entry)
+			return -ENOENT;
+
+		for (nr = 0; nr < entry->nvec_used; nr++) {
+			if (cpumask_test_cpu(cpu, &entry->affinity[nr]))
+				return dev->irq + nr;
+		}
+		return -EINVAL;
+	} else {
+		return dev->irq;
+	}
+}
+EXPORT_SYMBOL(pci_irq_get_affinity_vector);
+
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
 {
 	return to_pci_dev(desc->dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e49f70..2dd0817 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1315,6 +1315,7 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
+int pci_irq_get_affinity_vector(struct pci_dev *pdev, int cpu);
 
 #else
 static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
-- 
1.8.5.6
