Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de,
	axboe@fb.com
Subject: [PATCH 07/13] pci: Provide sensible irq vector alloc/free routines
Date: Tue, 14 Jun 2016 21:59:00 +0200
Message-Id: <1465934346-20648-8-git-send-email-hch@lst.de>
In-Reply-To: <1465934346-20648-1-git-send-email-hch@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Add a helper to allocate a range of interrupt vectors, which will
transparently use MSI-X and MSI if available or fallback to legacy
vectors.  The interrupts are available in a core managed array
in the pci_dev structure, and can also be released using a similar
helper.

The next patch will also add automatic spreading of MSI / MSI-X
vectors to this function.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/msi.c   | 110 ++++++++++++++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h |  18 +++++++++
 2 files changed, 128 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index a080f44..a33adec 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -4,6 +4,7 @@
  *
  * Copyright (C) 2003-2004 Intel
  * Copyright (C) Tom Long Nguyen (tom.l.nguyen@intel.com)
+ * Copyright (c) 2016 Christoph Hellwig.
  */
 
 #include <linux/err.h>
@@ -1120,6 +1121,115 @@ int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 }
 EXPORT_SYMBOL(pci_enable_msix_range);
 
+static unsigned int pci_nr_irq_vectors(struct pci_dev *pdev)
+{
+	int nr_entries;
+
+	nr_entries = pci_msix_vec_count(pdev);
+	if (nr_entries <= 0 && pci_msi_supported(pdev, 1))
+		nr_entries = pci_msi_vec_count(pdev);
+	if (nr_entries <= 0)
+		nr_entries = 1;
+	return nr_entries;
+}
+
+static int pci_enable_msix_range_wrapper(struct pci_dev *pdev, u32 *irqs,
+		unsigned int min_vecs, unsigned int max_vecs)
+{
+	struct msix_entry *msix_entries;
+	int vecs, i;
+
+	msix_entries = kcalloc(max_vecs, sizeof(struct msix_entry), GFP_KERNEL);
+	if (!msix_entries)
+		return -ENOMEM;
+
+	for (i = 0; i < max_vecs; i++)
+		msix_entries[i].entry = i;
+
+	vecs = pci_enable_msix_range(pdev, msix_entries, min_vecs, max_vecs);
+	if (vecs > 0) {
+		for (i = 0; i < vecs; i++)
+			irqs[i] = msix_entries[i].vector;
+	}
+
+	kfree(msix_entries);
+	return vecs;
+}
+
+/**
+ * pci_alloc_irq_vectors - allocate multiple IRQs for a device
+ * @dev:		PCI device to operate on
+ * @min_vecs:		minimum number of vectors required (must be >= 1)
+ * @max_vecs:		maximum (desired) number of vectors
+ * @flags:		flags or quirks for the allocation
+ *
+ * Allocate up to @max_vecs interrupt vectors for @dev, using MSI-X or MSI
+ * vectors if available, and fall back to a single legacy vector
+ * if neither is available.  Return the number of vectors allocated,
+ * (which might be smaller than @max_vecs) if successful, or a negative
+ * error code on error.  The Linux irq numbers for the allocated
+ * vectors are stored in pdev->irqs.  If less than @min_vecs interrupt
+ * vectors are available for @dev the function will fail with -ENOSPC.
+ */
+int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+		unsigned int max_vecs, unsigned int flags)
+{
+	unsigned int vecs, i;
+	u32 *irqs;
+
+	max_vecs = min(max_vecs, pci_nr_irq_vectors(dev));
+
+	irqs = kcalloc(max_vecs, sizeof(u32), GFP_KERNEL);
+	if (!irqs)
+		return -ENOMEM;
+
+	if (!(flags & PCI_IRQ_NOMSIX)) {
+		vecs = pci_enable_msix_range_wrapper(dev, irqs, min_vecs,
+				max_vecs);
+		if (vecs > 0)
+			goto done;
+	}
+
+	vecs = pci_enable_msi_range(dev, min_vecs, max_vecs);
+	if (vecs > 0) {
+		for (i = 0; i < vecs; i++)
+			irqs[i] = dev->irq + i;
+		goto done;
+	}
+
+	if (min_vecs > 1)
+		return -ENOSPC;
+
+	/* use legacy irq */
+	kfree(irqs);
+	dev->irqs = &dev->irq;
+	return 1;
+
+done:
+	dev->irqs = irqs;
+	return vecs;
+}
+EXPORT_SYMBOL(pci_alloc_irq_vectors);
+
+/**
+ * pci_free_irq_vectors - free previously allocated IRQs for a device
+ * @dev:		PCI device to operate on
+ *
+ * Undoes the allocations and enabling in pci_alloc_irq_vectors().
+ */
+void pci_free_irq_vectors(struct pci_dev *dev)
+{
+	if (dev->msix_enabled)
+		pci_disable_msix(dev);
+	else if (dev->msi_enabled)
+		pci_disable_msi(dev);
+
+	if (dev->irqs != &dev->irq)
+		kfree(dev->irqs);
+}
+EXPORT_SYMBOL(pci_free_irq_vectors);
+
+
 struct pci_dev *msi_desc_to_pci_dev(struct msi_desc *desc)
 {
 	return to_pci_dev(desc->dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index b67e4df..84a20fc 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -320,6 +320,7 @@ struct pci_dev {
 	 * directly, use the values stored here. They might be different!
 	 */
 	unsigned int	irq;
+	unsigned int	*irqs;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
 
 	bool match_driver;		/* Skip attaching driver */
@@ -1237,6 +1238,8 @@ resource_size_t pcibios_iov_resource_alignment(struct pci_dev *dev, int resno);
 int pci_set_vga_state(struct pci_dev *pdev, bool decode,
 		      unsigned int command_bits, u32 flags);
 
+#define PCI_IRQ_NOMSIX		(1 << 0) /* don't try to use MSI-X interrupts */
+
 /* kmem_cache style wrapper around pci_alloc_consistent() */
 
 #include <linux/pci-dma.h>
@@ -1284,6 +1287,9 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 		return rc;
 	return 0;
 }
+int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
+		unsigned int max_vecs, unsigned int flags);
+void pci_free_irq_vectors(struct pci_dev *dev);
 #else
 static inline int pci_msi_vec_count(struct pci_dev *dev) { return -ENOSYS; }
 static inline void pci_msi_shutdown(struct pci_dev *dev) { }
@@ -1307,6 +1313,18 @@ static inline int pci_enable_msix_range(struct pci_dev *dev,
 static inline int pci_enable_msix_exact(struct pci_dev *dev,
 		      struct msix_entry *entries, int nvec)
 { return -ENOSYS; }
+static inline int pci_alloc_irq_vectors(struct pci_dev *dev,
+		unsigned int min_vecs, unsigned int max_vecs,
+		unsigned int flags)
+{
+	if (min_vecs > 1)
+		return -ENOSPC;
+	dev->irqs = &dev->irq;
+	return 1;
+}
+static inline void pci_free_irq_vectors(struct pci_dev *dev)
+{
+}
 #endif
 
 #ifdef CONFIG_PCIEPORTBUS
-- 
2.1.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
