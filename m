Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40165 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1763237AbcINOT0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2016 10:19:26 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com, tglx@linutronix.de
Cc: agordeev@redhat.com, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 05/13] pci/msi: Retrieve affinity for a vector
Date: Wed, 14 Sep 2016 16:18:51 +0200
Message-Id: <1473862739-15032-6-git-send-email-hch@lst.de>
In-Reply-To: <1473862739-15032-1-git-send-email-hch@lst.de>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Add a helper to get the affinity mask for a given PCI irq vector.  For MSI or
MSI-X vectors these are stored by the IRQ core, while for legacy interrupts
we will always return cpu_possible_map.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
[hch: updated to follow the style of pci_irq_vector()]
Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/msi.c   | 31 +++++++++++++++++++++++++++++++
 include/linux/pci.h |  6 ++++++
 2 files changed, 37 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 06100dd..9da5ecb 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1270,6 +1270,37 @@ int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 }
 EXPORT_SYMBOL(pci_irq_vector);
 
+/**
+ * pci_irq_get_affinity - return the affinity of a particular msi vector
+ * @dev:	PCI device to operate on
+ * @nr:		device-relative interrupt vector index (0-based).
+ */
+const struct cpumask *pci_irq_get_affinity(struct pci_dev *dev, int nr)
+{
+	if (dev->msix_enabled) {
+		struct msi_desc *entry;
+		int i = 0;
+
+		for_each_pci_msi_entry(entry, dev) {
+			if (i == nr)
+				return entry->affinity;
+			i++;
+		}
+		WARN_ON_ONCE(1);
+		return NULL;
+	} else if (dev->msi_enabled) {
+		struct msi_desc *entry = first_pci_msi_entry(dev);
+
+		if (WARN_ON_ONCE(!entry || nr >= entry->nvec_used))
+			return NULL;
+
+		return &entry->affinity[nr];
+	} else {
+		return cpu_possible_mask;
+	}
+}
+EXPORT_SYMBOL(pci_irq_get_affinity);
+
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
 {
 	return to_pci_dev(desc->dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0ab8359..3b0a800 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1300,6 +1300,7 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 		unsigned int max_vecs, unsigned int flags);
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
+const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
 
 #else
 static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
@@ -1342,6 +1343,11 @@ static inline int pci_irq_vector(struct pci_dev *dev, unsigned int nr)
 		return -EINVAL;
 	return dev->irq;
 }
+static inline const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev,
+		int vec)
+{
+	return cpu_possible_mask;
+}
 #endif
 
 #ifdef CONFIG_PCIEPORTBUS
-- 
2.1.4

