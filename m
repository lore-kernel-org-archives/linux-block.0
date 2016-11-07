Return-Path: <BATV+fd6e759d6fe7114d99bf+4824+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christogh Hellwig <hch@lst.de>
Subject: [PATCH 4/7] pci/msi: Propagate irq affinity description through the MSI code
Date: Mon,  7 Nov 2016 10:47:39 -0800
Message-Id: <1478544462-9549-5-git-send-email-hch@lst.de>
In-Reply-To: <1478544462-9549-1-git-send-email-hch@lst.de>
References: <1478544462-9549-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Christogh Hellwig <hch@lst.de>

No API change yet, just pass it down all the way from
pci_alloc_irq_vectors to the core MSI code.

Signed-off-by: Christogh Hellwig <hch@lst.de>
---
 drivers/pci/msi.c | 62 +++++++++++++++++++++++++++++--------------------------
 1 file changed, 33 insertions(+), 29 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 1761b8a..512f388 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -551,14 +551,14 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 }
 
 static struct msi_desc *
-msi_setup_entry(struct pci_dev *dev, int nvec, bool affinity)
+msi_setup_entry(struct pci_dev *dev, int nvec, const struct irq_affinity *affd)
 {
 	struct cpumask *masks = NULL;
 	struct msi_desc *entry;
 	u16 control;
 
-	if (affinity) {
-		masks = irq_create_affinity_masks(nvec, NULL);
+	if (affd) {
+		masks = irq_create_affinity_masks(nvec, affd);
 		if (!masks)
 			pr_err("Unable to allocate affinity masks, ignoring\n");
 	}
@@ -618,7 +618,8 @@ static int msi_verify_entries(struct pci_dev *dev)
  * an error, and a positive return value indicates the number of interrupts
  * which could have been allocated.
  */
-static int msi_capability_init(struct pci_dev *dev, int nvec, bool affinity)
+static int msi_capability_init(struct pci_dev *dev, int nvec,
+			       const struct irq_affinity *affd)
 {
 	struct msi_desc *entry;
 	int ret;
@@ -626,7 +627,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec, bool affinity)
 
 	pci_msi_set_enable(dev, 0);	/* Disable MSI during set up */
 
-	entry = msi_setup_entry(dev, nvec, affinity);
+	entry = msi_setup_entry(dev, nvec, affd);
 	if (!entry)
 		return -ENOMEM;
 
@@ -690,14 +691,14 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
 
 static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 			      struct msix_entry *entries, int nvec,
-			      bool affinity)
+			      const struct irq_affinity *affd)
 {
 	struct cpumask *curmsk, *masks = NULL;
 	struct msi_desc *entry;
 	int ret, i;
 
-	if (affinity) {
-		masks = irq_create_affinity_masks(nvec, NULL);
+	if (affd) {
+		masks = irq_create_affinity_masks(nvec, affd);
 		if (!masks)
 			pr_err("Unable to allocate affinity masks, ignoring\n");
 	}
@@ -753,14 +754,14 @@ static void msix_program_entries(struct pci_dev *dev,
  * @dev: pointer to the pci_dev data structure of MSI-X device function
  * @entries: pointer to an array of struct msix_entry entries
  * @nvec: number of @entries
- * @affinity: flag to indicate cpu irq affinity mask should be set
+ * @affd: Optional pointer to enable automatic affinity assignement
  *
  * Setup the MSI-X capability structure of device function with a
  * single MSI-X irq. A return of zero indicates the successful setup of
  * requested MSI-X entries with allocated irqs or non-zero for otherwise.
  **/
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
-				int nvec, bool affinity)
+				int nvec, const struct irq_affinity *affd)
 {
 	int ret;
 	u16 control;
@@ -775,7 +776,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	if (!base)
 		return -ENOMEM;
 
-	ret = msix_setup_entries(dev, base, entries, nvec, affinity);
+	ret = msix_setup_entries(dev, base, entries, nvec, affd);
 	if (ret)
 		return ret;
 
@@ -956,7 +957,7 @@ int pci_msix_vec_count(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_msix_vec_count);
 
 static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
-			     int nvec, bool affinity)
+			     int nvec, const struct irq_affinity *affd)
 {
 	int nr_entries;
 	int i, j;
@@ -988,7 +989,7 @@ static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
 		dev_info(&dev->dev, "can't enable MSI-X (MSI IRQ already assigned)\n");
 		return -EINVAL;
 	}
-	return msix_capability_init(dev, entries, nvec, affinity);
+	return msix_capability_init(dev, entries, nvec, affd);
 }
 
 /**
@@ -1008,7 +1009,7 @@ static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
  **/
 int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
 {
-	return __pci_enable_msix(dev, entries, nvec, false);
+	return __pci_enable_msix(dev, entries, nvec, NULL);
 }
 EXPORT_SYMBOL(pci_enable_msix);
 
@@ -1059,9 +1060,8 @@ int pci_msi_enabled(void)
 EXPORT_SYMBOL(pci_msi_enabled);
 
 static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
-		unsigned int flags)
+				  const struct irq_affinity *affd)
 {
-	bool affinity = flags & PCI_IRQ_AFFINITY;
 	int nvec;
 	int rc;
 
@@ -1090,13 +1090,13 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 		nvec = maxvec;
 
 	for (;;) {
-		if (affinity) {
-			nvec = irq_calc_affinity_vectors(nvec, NULL);
+		if (affd) {
+			nvec = irq_calc_affinity_vectors(nvec, affd);
 			if (nvec < minvec)
 				return -ENOSPC;
 		}
 
-		rc = msi_capability_init(dev, nvec, affinity);
+		rc = msi_capability_init(dev, nvec, affd);
 		if (rc == 0)
 			return nvec;
 
@@ -1123,28 +1123,27 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
  **/
 int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
 {
-	return __pci_enable_msi_range(dev, minvec, maxvec, 0);
+	return __pci_enable_msi_range(dev, minvec, maxvec, NULL);
 }
 EXPORT_SYMBOL(pci_enable_msi_range);
 
 static int __pci_enable_msix_range(struct pci_dev *dev,
-		struct msix_entry *entries, int minvec, int maxvec,
-		unsigned int flags)
+				   struct msix_entry *entries, int minvec,
+				   int maxvec, const struct irq_affinity *affd)
 {
-	bool affinity = flags & PCI_IRQ_AFFINITY;
 	int rc, nvec = maxvec;
 
 	if (maxvec < minvec)
 		return -ERANGE;
 
 	for (;;) {
-		if (affinity) {
-			nvec = irq_calc_affinity_vectors(nvec, NULL);
+		if (affd) {
+			nvec = irq_calc_affinity_vectors(nvec, affd);
 			if (nvec < minvec)
 				return -ENOSPC;
 		}
 
-		rc = __pci_enable_msix(dev, entries, nvec, affinity);
+		rc = __pci_enable_msix(dev, entries, nvec, affd);
 		if (rc == 0)
 			return nvec;
 
@@ -1175,7 +1174,7 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 		int minvec, int maxvec)
 {
-	return __pci_enable_msix_range(dev, entries, minvec, maxvec, 0);
+	return __pci_enable_msix_range(dev, entries, minvec, maxvec, NULL);
 }
 EXPORT_SYMBOL(pci_enable_msix_range);
 
@@ -1199,17 +1198,22 @@ EXPORT_SYMBOL(pci_enable_msix_range);
 int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 		unsigned int max_vecs, unsigned int flags)
 {
+	static const struct irq_affinity msi_default_affd;
+	const struct irq_affinity *affd = NULL;
 	int vecs = -ENOSPC;
 
+	if (flags & PCI_IRQ_AFFINITY)
+		affd = &msi_default_affd;
+
 	if (flags & PCI_IRQ_MSIX) {
 		vecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
-				flags);
+				affd);
 		if (vecs > 0)
 			return vecs;
 	}
 
 	if (flags & PCI_IRQ_MSI) {
-		vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, flags);
+		vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, affd);
 		if (vecs > 0)
 			return vecs;
 	}
-- 
2.1.4
