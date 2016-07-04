Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de,
	axboe@fb.com
Subject: [PATCH 08/13] pci: spread interrupt vectors in pci_alloc_irq_vectors
Date: Mon,  4 Jul 2016 17:39:29 +0900
Message-Id: <1467621574-8277-9-git-send-email-hch@lst.de>
In-Reply-To: <1467621574-8277-1-git-send-email-hch@lst.de>
References: <1467621574-8277-1-git-send-email-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, linux-pci@vger.kernel.org, agordeev@redhat.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

Set the affinity_mask in the PCI device before allocating vectors so that
the affinity can be propagated through the MSI descriptor structures to
the core IRQ code.  Add a new helper __pci_enable_msi_range which is
similar to __pci_enable_msix_range introduced in the last patch so that
we can allocate the affinity mask in a self-contained fashion and for the
right number of vectors.

A new PCI_IRQ_NOAFFINITY flag is added to pci_alloc_irq_vectors so that
this function can also be used by drivers that don't wish to use the
automatic affinity assignment.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 Documentation/PCI/MSI-HOWTO.txt |  3 +-
 drivers/pci/msi.c               | 72 ++++++++++++++++++++++++++++++++++++++---
 include/linux/pci.h             |  2 ++
 3 files changed, 72 insertions(+), 5 deletions(-)

diff --git a/Documentation/PCI/MSI-HOWTO.txt b/Documentation/PCI/MSI-HOWTO.txt
index 35d1326..dcd3f6d 100644
--- a/Documentation/PCI/MSI-HOWTO.txt
+++ b/Documentation/PCI/MSI-HOWTO.txt
@@ -95,7 +95,8 @@ argument set to this limit, and the PCI core will return -ENOSPC if it can't
 meet the minimum number of vectors.
 The flags argument should normally be set to 0, but can be used to
 pass the PCI_IRQ_NOMSI and PCI_IRQ_NOMSIX flag in case a device claims
-to support MSI or MSI-X, but the support is broken.
+to support MSI or MSI-X, but the support is broken, or to PCI_IRQ_NOAFFINITY
+if the driver does not wish to use the automatic affinity assignment feature.
 
 To get the Linux IRQ numbers passed to request_irq and free_irq
 and the vectors use the following function:
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 6b0834d..7f38e07 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -568,6 +568,7 @@ static struct msi_desc *msi_setup_entry(struct pci_dev *dev, int nvec)
 	entry->msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
 	entry->msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
 	entry->nvec_used		= nvec;
+	entry->affinity			= dev->irq_affinity;
 
 	if (control & PCI_MSI_FLAGS_64BIT)
 		entry->mask_pos = dev->msi_cap + PCI_MSI_MASK_64;
@@ -679,10 +680,18 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
 static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 			      struct msix_entry *entries, int nvec)
 {
+	const struct cpumask *mask = NULL;
 	struct msi_desc *entry;
-	int i;
+	int cpu = -1, i;
 
 	for (i = 0; i < nvec; i++) {
+		if (dev->irq_affinity) {
+			cpu = cpumask_next(cpu, dev->irq_affinity);
+			if (cpu >= nr_cpu_ids)
+				cpu = cpumask_first(dev->irq_affinity);
+			mask = cpumask_of(cpu);
+		}
+
 		entry = alloc_msi_entry(&dev->dev);
 		if (!entry) {
 			if (!i)
@@ -699,6 +708,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 		entry->msi_attrib.default_irq	= dev->irq;
 		entry->mask_base		= base;
 		entry->nvec_used		= 1;
+		entry->affinity			= mask;
 
 		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
 	}
@@ -1121,8 +1131,53 @@ int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 }
 EXPORT_SYMBOL(pci_enable_msix_range);
 
+static int __pci_enable_msi_range(struct pci_dev *dev, int min_vecs, int max_vecs,
+		unsigned int flags)
+{
+	int vecs, ret;
+
+	if (!pci_msi_supported(dev, min_vecs))
+		return -EINVAL;
+
+	vecs = pci_msi_vec_count(dev);
+	if (vecs < 0)
+		return vecs;
+	if (vecs < min_vecs)
+		return -EINVAL;
+	if (vecs > max_vecs)
+		vecs = max_vecs;
+
+retry:
+	if (vecs < min_vecs)
+		return -ENOSPC;
+
+	if (!(flags & PCI_IRQ_NOAFFINITY)) {
+		dev->irq_affinity = irq_create_affinity_mask(&vecs);
+		if (vecs < min_vecs) {
+			ret = -ERANGE;
+			goto out_fail;
+		}
+	}
+
+	ret = msi_capability_init(dev, vecs);
+	if (ret)
+		goto out_fail;
+
+	return vecs;
+
+out_fail:
+	kfree(dev->irq_affinity);
+	if (ret >= 0) {
+		/* retry with the actually supported number of vectors */
+		vecs = ret;
+		goto retry;
+	}
+
+	return ret;
+}
+
 static int __pci_enable_msix_range(struct pci_dev *dev, unsigned int min_vecs,
-		unsigned int max_vecs)
+		unsigned int max_vecs, unsigned int flags)
 {
 	int vecs = max_vecs, ret, i;
 
@@ -1138,6 +1193,13 @@ retry:
 	for (i = 0; i < vecs; i++)
 		dev->msix_vectors[i].entry = i;
 
+	if (!(flags & PCI_IRQ_NOAFFINITY)) {
+		dev->irq_affinity = irq_create_affinity_mask(&vecs);
+		ret = -ENOSPC;
+		if (vecs < min_vecs)
+			goto out_fail;
+	}
+
 	ret = pci_enable_msix(dev, dev->msix_vectors, vecs);
 	if (ret)
 		goto out_fail;
@@ -1147,6 +1209,8 @@ retry:
 out_fail:
 	kfree(dev->msix_vectors);
 	dev->msix_vectors = NULL;
+	kfree(dev->irq_affinity);
+	dev->irq_affinity = NULL;
 
 	if (ret >= 0) {
 		/* retry with the actually supported number of vectors */
@@ -1180,13 +1244,13 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 	int vecs;
 
 	if (!(flags & PCI_IRQ_NOMSIX)) {
-		vecs = __pci_enable_msix_range(dev, min_vecs, max_vecs);
+		vecs = __pci_enable_msix_range(dev, min_vecs, max_vecs, flags);
 		if (vecs > 0)
 			return vecs;
 	}
 
 	if (!(flags & PCI_IRQ_NOMSI)) {
-		vecs = pci_enable_msi_range(dev, min_vecs, max_vecs);
+		vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, flags);
 		if (vecs > 0)
 			return vecs;
 	}
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 129871f..6a64c54 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -321,6 +321,7 @@ struct pci_dev {
 	 */
 	unsigned int	irq;
 	struct msix_entry *msix_vectors;
+	struct cpumask	*irq_affinity;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
 
 	bool match_driver;		/* Skip attaching driver */
@@ -1240,6 +1241,7 @@ int pci_set_vga_state(struct pci_dev *pdev, bool decode,
 
 #define PCI_IRQ_NOMSI		(1 << 0) /* don't try to use MSI interrupts */
 #define PCI_IRQ_NOMSIX		(1 << 1) /* don't try to use MSI-X interrupts */
+#define PCI_IRQ_NOAFFINITY	(1 << 2) /* don't auto-assign affinity */
 
 /* kmem_cache style wrapper around pci_alloc_consistent() */
 
-- 
2.1.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
