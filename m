Return-Path: <BATV+fd6e759d6fe7114d99bf+4824+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christogh Hellwig <hch@lst.de>
Subject: [PATCH 5/7] pci/msi: Provide pci_alloc_irq_vectors_affinity()
Date: Mon,  7 Nov 2016 10:47:40 -0800
Message-Id: <1478544462-9549-6-git-send-email-hch@lst.de>
In-Reply-To: <1478544462-9549-1-git-send-email-hch@lst.de>
References: <1478544462-9549-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Christogh Hellwig <hch@lst.de>

This is a variant of pci_alloc_irq_vectors() that allows passing a
struct irq_affinity to provide fine-grainded IRQ affinity control.
For now this means being able to exclude vectors at the beginning or
end of the MSI vector space, but it could also be used for any other
quirks needed in the future (e.g. more vectors than CPUs, or exluding
CPUs from the spreading).

Signed-off-by: Christogh Hellwig <hch@lst.de>
---
 drivers/pci/msi.c   | 20 +++++++++++++-------
 include/linux/pci.h | 24 +++++++++++++++++++-----
 2 files changed, 32 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 512f388..dd27f73 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1179,11 +1179,12 @@ int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 EXPORT_SYMBOL(pci_enable_msix_range);
 
 /**
- * pci_alloc_irq_vectors - allocate multiple IRQs for a device
+ * pci_alloc_irq_vectors_affinity - allocate multiple IRQs for a device
  * @dev:		PCI device to operate on
  * @min_vecs:		minimum number of vectors required (must be >= 1)
  * @max_vecs:		maximum (desired) number of vectors
  * @flags:		flags or quirks for the allocation
+ * @affd:		optional description of the affinity requirements
  *
  * Allocate up to @max_vecs interrupt vectors for @dev, using MSI-X or MSI
  * vectors if available, and fall back to a single legacy vector
@@ -1195,15 +1196,20 @@ EXPORT_SYMBOL(pci_enable_msix_range);
  * To get the Linux IRQ number used for a vector that can be passed to
  * request_irq() use the pci_irq_vector() helper.
  */
-int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
-		unsigned int max_vecs, unsigned int flags)
+int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
+				   unsigned int max_vecs, unsigned int flags,
+				   const struct irq_affinity *affd)
 {
 	static const struct irq_affinity msi_default_affd;
-	const struct irq_affinity *affd = NULL;
 	int vecs = -ENOSPC;
 
-	if (flags & PCI_IRQ_AFFINITY)
-		affd = &msi_default_affd;
+	if (flags & PCI_IRQ_AFFINITY) {
+		if (!affd)
+			affd = &msi_default_affd;
+	} else {
+		if (WARN_ON(affd))
+			affd = NULL;
+	}
 
 	if (flags & PCI_IRQ_MSIX) {
 		vecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
@@ -1226,7 +1232,7 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 
 	return vecs;
 }
-EXPORT_SYMBOL(pci_alloc_irq_vectors);
+EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
 
 /**
  * pci_free_irq_vectors - free previously allocated IRQs for a device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e49f70..7090f5f 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -244,6 +244,7 @@ struct pci_cap_saved_state {
 	struct pci_cap_saved_data cap;
 };
 
+struct irq_affinity;
 struct pcie_link_state;
 struct pci_vpd;
 struct pci_sriov;
@@ -1310,8 +1311,10 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 		return rc;
 	return 0;
 }
-int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
-		unsigned int max_vecs, unsigned int flags);
+int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
+				   unsigned int max_vecs, unsigned int flags,
+				   const struct irq_affinity *affd);
+
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
@@ -1339,14 +1342,17 @@ static inline int pci_enable_msix_range(struct pci_dev *dev,
 static inline int pci_enable_msix_exact(struct pci_dev *dev,
 		      struct msix_entry *entries, int nvec)
 { return -ENOSYS; }
-static inline int pci_alloc_irq_vectors(struct pci_dev *dev,
-		unsigned int min_vecs, unsigned int max_vecs,
-		unsigned int flags)
+
+static inline int
+pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
+			       unsigned int max_vecs, unsigned int flags,
+			       const struct irq_affinity *aff_desc)
 {
 	if (min_vecs > 1)
 		return -EINVAL;
 	return 1;
 }
+
 static inline void pci_free_irq_vectors(struct pci_dev *dev)
 {
 }
@@ -1364,6 +1370,14 @@ static inline const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev,
 }
 #endif
 
+static inline int
+pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+		      unsigned int max_vecs, unsigned int flags)
+{
+	return pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs, flags,
+					      NULL);
+}
+
 #ifdef CONFIG_PCIEPORTBUS
 extern bool pcie_ports_disabled;
 extern bool pcie_ports_auto;
-- 
2.1.4
