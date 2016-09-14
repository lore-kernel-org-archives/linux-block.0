Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40088 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762296AbcINOTT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2016 10:19:19 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com, tglx@linutronix.de
Cc: agordeev@redhat.com, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 03/13] genirq/msi: Switch to new irq spreading infrastructure
Date: Wed, 14 Sep 2016 16:18:49 +0200
Message-Id: <1473862739-15032-4-git-send-email-hch@lst.de>
In-Reply-To: <1473862739-15032-1-git-send-email-hch@lst.de>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Switch MSI over to the new spreading code. If a pci device contains a valid
pointer to a cpumask, then this mask is used for spreading otherwise the
online cpu mask is used. This allows a driver to restrict the spread to a
subset of CPUs, e.g. cpus on a particular node.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/pci/msi.c    | 128 +++++++++++++++++++++++++++++----------------------
 kernel/irq/irqdesc.c |  31 ++++++-------
 2 files changed, 87 insertions(+), 72 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0db72ba..06100dd 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -549,15 +549,23 @@ error_attrs:
 	return ret;
 }
 
-static struct msi_desc *msi_setup_entry(struct pci_dev *dev, int nvec)
+static struct msi_desc *
+msi_setup_entry(struct pci_dev *dev, int nvec, bool affinity)
 {
-	u16 control;
+	struct cpumask *masks = NULL;
 	struct msi_desc *entry;
+	u16 control;
+
+	if (affinity) {
+		masks = irq_create_affinity_masks(dev->irq_affinity, nvec);
+		if (!masks)
+			pr_err("Unable to allocate affinity masks, ignoring\n");
+	}
 
 	/* MSI Entry Initialization */
-	entry = alloc_msi_entry(&dev->dev, nvec, NULL);
+	entry = alloc_msi_entry(&dev->dev, nvec, masks);
 	if (!entry)
-		return NULL;
+		goto out;
 
 	pci_read_config_word(dev, dev->msi_cap + PCI_MSI_FLAGS, &control);
 
@@ -568,7 +576,6 @@ static struct msi_desc *msi_setup_entry(struct pci_dev *dev, int nvec)
 	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
 	entry->msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
 	entry->msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
-	entry->affinity			= dev->irq_affinity;
 
 	if (control & PCI_MSI_FLAGS_64BIT)
 		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
@@ -579,6 +586,8 @@ static struct msi_desc *msi_setup_entry(struct pci_dev *dev, int nvec)
 	if (entry->msi_attrib.maskbit)
 		pci_read_config_dword(dev, entry->mask_pos, &entry->masked);
 
+out:
+	kfree(masks);
 	return entry;
 }
 
@@ -607,7 +616,7 @@ static int msi_verify_entries(struct pci_dev *dev)
  * an error, and a positive return value indicates the number of interrupts
  * which could have been allocated.
  */
-static int msi_capability_init(struct pci_dev *dev, int nvec)
+static int msi_capability_init(struct pci_dev *dev, int nvec, bool affinity)
 {
 	struct msi_desc *entry;
 	int ret;
@@ -615,7 +624,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec)
 
 	pci_msi_set_enable(dev, 0);	/* Disable MSI during set up */
 
-	entry = msi_setup_entry(dev, nvec);
+	entry = msi_setup_entry(dev, nvec, affinity);
 	if (!entry)
 		return -ENOMEM;
 
@@ -678,28 +687,29 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
 }
 
 static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
-			      struct msix_entry *entries, int nvec)
+			      struct msix_entry *entries, int nvec,
+			      bool affinity)
 {
-	const struct cpumask *mask = NULL;
+	struct cpumask *curmsk, *masks = NULL;
 	struct msi_desc *entry;
-	int cpu = -1, i;
-
-	for (i = 0; i < nvec; i++) {
-		if (dev->irq_affinity) {
-			cpu = cpumask_next(cpu, dev->irq_affinity);
-			if (cpu >= nr_cpu_ids)
-				cpu = cpumask_first(dev->irq_affinity);
-			mask = cpumask_of(cpu);
-		}
+	int ret, i;
 
-		entry = alloc_msi_entry(&dev->dev, 1, NULL);
+	if (affinity) {
+		masks = irq_create_affinity_masks(dev->irq_affinity, nvec);
+		if (!masks)
+			pr_err("Unable to allocate affinity masks, ignoring\n");
+	}
+
+	for (i = 0, curmsk = masks; i < nvec; i++) {
+		entry = alloc_msi_entry(&dev->dev, 1, curmsk);
 		if (!entry) {
 			if (!i)
 				iounmap(base);
 			else
 				free_msi_irqs(dev);
 			/* No enough memory. Don't try again */
-			return -ENOMEM;
+			ret = -ENOMEM;
+			goto out;
 		}
 
 		entry->msi_attrib.is_msix	= 1;
@@ -710,11 +720,14 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 			entry->msi_attrib.entry_nr = i;
 		entry->msi_attrib.default_irq	= dev->irq;
 		entry->mask_base		= base;
-		entry->affinity			= mask;
 
 		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
+		if (masks)
+			curmsk++;
 	}
-
+	ret = 0;
+out:
+	kfree(masks);
 	return 0;
 }
 
@@ -743,8 +756,8 @@ static void msix_program_entries(struct pci_dev *dev,
  * single MSI-X irq. A return of zero indicates the successful setup of
  * requested MSI-X entries with allocated irqs or non-zero for otherwise.
  **/
-static int msix_capability_init(struct pci_dev *dev,
-				struct msix_entry *entries, int nvec)
+static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
+				int nvec, bool affinity)
 {
 	int ret;
 	u16 control;
@@ -759,7 +772,7 @@ static int msix_capability_init(struct pci_dev *dev,
 	if (!base)
 		return -ENOMEM;
 
-	ret = msix_setup_entries(dev, base, entries, nvec);
+	ret = msix_setup_entries(dev, base, entries, nvec, affinity);
 	if (ret)
 		return ret;
 
@@ -939,22 +952,8 @@ int pci_msix_vec_count(struct pci_dev *dev)
 }
 EXPORT_SYMBOL(pci_msix_vec_count);
 
-/**
- * pci_enable_msix - configure device's MSI-X capability structure
- * @dev: pointer to the pci_dev data structure of MSI-X device function
- * @entries: pointer to an array of MSI-X entries (optional)
- * @nvec: number of MSI-X irqs requested for allocation by device driver
- *
- * Setup the MSI-X capability structure of device function with the number
- * of requested irqs upon its software driver call to request for
- * MSI-X mode enabled on its hardware device function. A return of zero
- * indicates the successful configuration of MSI-X capability structure
- * with new allocated MSI-X irqs. A return of < 0 indicates a failure.
- * Or a return of > 0 indicates that driver request is exceeding the number
- * of irqs or MSI-X vectors available. Driver should use the returned value to
- * re-send its request.
- **/
-int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
+static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
+			     int nvec, bool affinity)
 {
 	int nr_entries;
 	int i, j;
@@ -986,7 +985,27 @@ int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
 		dev_info(&dev->dev, "can't enable MSI-X (MSI IRQ already assigned)\n");
 		return -EINVAL;
 	}
-	return msix_capability_init(dev, entries, nvec);
+	return msix_capability_init(dev, entries, nvec, affinity);
+}
+
+/**
+ * pci_enable_msix - configure device's MSI-X capability structure
+ * @dev: pointer to the pci_dev data structure of MSI-X device function
+ * @entries: pointer to an array of MSI-X entries (optional)
+ * @nvec: number of MSI-X irqs requested for allocation by device driver
+ *
+ * Setup the MSI-X capability structure of device function with the number
+ * of requested irqs upon its software driver call to request for
+ * MSI-X mode enabled on its hardware device function. A return of zero
+ * indicates the successful configuration of MSI-X capability structure
+ * with new allocated MSI-X irqs. A return of < 0 indicates a failure.
+ * Or a return of > 0 indicates that driver request is exceeding the number
+ * of irqs or MSI-X vectors available. Driver should use the returned value to
+ * re-send its request.
+ **/
+int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
+{
+	return __pci_enable_msix(dev, entries, nvec, false);
 }
 EXPORT_SYMBOL(pci_enable_msix);
 
@@ -1039,6 +1058,7 @@ EXPORT_SYMBOL(pci_msi_enabled);
 static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 		unsigned int flags)
 {
+	bool affinity = flags & PCI_IRQ_AFFINITY;
 	int nvec;
 	int rc;
 
@@ -1067,19 +1087,17 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 		nvec = maxvec;
 
 	for (;;) {
-		if (flags & PCI_IRQ_AFFINITY) {
-			dev->irq_affinity = irq_create_affinity_mask(&nvec);
+		if (affinity) {
+			nvec = irq_calc_affinity_vectors(dev->irq_affinity,
+					nvec);
 			if (nvec < minvec)
 				return -ENOSPC;
 		}
 
-		rc = msi_capability_init(dev, nvec);
+		rc = msi_capability_init(dev, nvec, affinity);
 		if (rc == 0)
 			return nvec;
 
-		kfree(dev->irq_affinity);
-		dev->irq_affinity = NULL;
-
 		if (rc < 0)
 			return rc;
 		if (rc < minvec)
@@ -1111,26 +1129,24 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 		struct msix_entry *entries, int minvec, int maxvec,
 		unsigned int flags)
 {
-	int nvec = maxvec;
-	int rc;
+	bool affinity = flags & PCI_IRQ_AFFINITY;
+	int rc, nvec = maxvec;
 
 	if (maxvec < minvec)
 		return -ERANGE;
 
 	for (;;) {
-		if (flags & PCI_IRQ_AFFINITY) {
-			dev->irq_affinity = irq_create_affinity_mask(&nvec);
+		if (affinity) {
+			nvec = irq_calc_affinity_vectors(dev->irq_affinity,
+					nvec);
 			if (nvec < minvec)
 				return -ENOSPC;
 		}
 
-		rc = pci_enable_msix(dev, entries, nvec);
+		rc = __pci_enable_msix(dev, entries, nvec, affinity);
 		if (rc == 0)
 			return nvec;
 
-		kfree(dev->irq_affinity);
-		dev->irq_affinity = NULL;
-
 		if (rc < 0)
 			return rc;
 		if (rc < minvec)
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index a623b44..5a5a685 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -236,25 +236,24 @@ static int alloc_descs(unsigned int start, unsigned int cnt, int node,
 	const struct cpumask *mask = NULL;
 	struct irq_desc *desc;
 	unsigned int flags;
-	int i, cpu = -1;
+	int i;
 
-	if (affinity && cpumask_empty(affinity))
-		return -EINVAL;
+	/* Validate affinity mask(s) */
+	if (affinity) {
+		for (i = 0, mask = affinity; i < cnt; i++, mask++) {
+			if (cpumask_empty(mask))
+				return -EINVAL;
+		}
+	}
 
 	flags = affinity ? IRQD_AFFINITY_MANAGED : 0;
+	mask = NULL;
 
 	for (i = 0; i < cnt; i++) {
 		if (affinity) {
-			cpu = cpumask_next(cpu, affinity);
-			if (cpu >= nr_cpu_ids)
-				cpu = cpumask_first(affinity);
-			node = cpu_to_node(cpu);
-
-			/*
-			 * For single allocations we use the caller provided
-			 * mask otherwise we use the mask of the target cpu
-			 */
-			mask = cnt == 1 ? affinity : cpumask_of(cpu);
+			node = cpu_to_node(cpumask_first(affinity));
+			mask = affinity;
+			affinity++;
 		}
 		desc = alloc_desc(start + i, node, flags, mask, owner);
 		if (!desc)
@@ -481,9 +480,9 @@ EXPORT_SYMBOL_GPL(irq_free_descs);
  * @cnt:	Number of consecutive irqs to allocate.
  * @node:	Preferred node on which the irq descriptor should be allocated
  * @owner:	Owning module (can be NULL)
- * @affinity:	Optional pointer to an affinity mask which hints where the
- *		irq descriptors should be allocated and which default
- *		affinities to use
+ * @affinity:	Optional pointer to an affinity mask array of size @cnt which
+ *		hints where the irq descriptors should be allocated and which
+ *		default affinities to use
  *
  * Returns the first irq number or error code
  */
-- 
2.1.4

