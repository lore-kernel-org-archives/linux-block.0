Return-Path: <linux-block-owner@vger.kernel.org>
Received: from bombadil.infradead.org ([198.137.202.9]:40013 "EHLO
        bombadil.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1762296AbcINOTM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 14 Sep 2016 10:19:12 -0400
From: Christoph Hellwig <hch@lst.de>
To: axboe@fb.com, tglx@linutronix.de
Cc: agordeev@redhat.com, keith.busch@intel.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 01/13] genirq/msi: Add cpumask allocation to alloc_msi_entry
Date: Wed, 14 Sep 2016 16:18:47 +0200
Message-Id: <1473862739-15032-2-git-send-email-hch@lst.de>
In-Reply-To: <1473862739-15032-1-git-send-email-hch@lst.de>
References: <1473862739-15032-1-git-send-email-hch@lst.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

For irq spreading want to store affinity masks in the msi_entry. Add the
infrastructure for it.

We allocate an array of cpumasks with an array size of the number of used
vectors in the entry, so we can hand in the information per linux interrupt
later.

As we hand in the number of used vectors, we assign them right
away. Convert all the call sites.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 drivers/base/platform-msi.c         |  3 +--
 drivers/pci/msi.c                   |  6 ++----
 drivers/staging/fsl-mc/bus/mc-msi.c |  3 +--
 include/linux/msi.h                 |  5 +++--
 kernel/irq/msi.c                    | 26 ++++++++++++++++++++++++--
 5 files changed, 31 insertions(+), 12 deletions(-)

diff --git a/drivers/base/platform-msi.c b/drivers/base/platform-msi.c
index 279e539..be6a599 100644
--- a/drivers/base/platform-msi.c
+++ b/drivers/base/platform-msi.c
@@ -142,13 +142,12 @@ static int platform_msi_alloc_descs_with_irq(struct device *dev, int virq,
 	}
 
 	for (i = 0; i < nvec; i++) {
-		desc = alloc_msi_entry(dev);
+		desc = alloc_msi_entry(dev, 1, NULL);
 		if (!desc)
 			break;
 
 		desc->platform.msi_priv_data = data;
 		desc->platform.msi_index = base + i;
-		desc->nvec_used = 1;
 		desc->irq = virq ? virq + i : 0;
 
 		list_add_tail(&desc->list, dev_to_msi_list(dev));
diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 98f1222..0db72ba 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -555,7 +555,7 @@ static struct msi_desc *msi_setup_entry(struct pci_dev *dev, int nvec)
 	struct msi_desc *entry;
 
 	/* MSI Entry Initialization */
-	entry = alloc_msi_entry(&dev->dev);
+	entry = alloc_msi_entry(&dev->dev, nvec, NULL);
 	if (!entry)
 		return NULL;
 
@@ -568,7 +568,6 @@ static struct msi_desc *msi_setup_entry(struct pci_dev *dev, int nvec)
 	entry->msi_attrib.default_irq	= dev->irq;	/* Save IOAPIC IRQ */
 	entry->msi_attrib.multi_cap	= (control & PCI_MSI_FLAGS_QMASK) >> 1;
 	entry->msi_attrib.multiple	= ilog2(__roundup_pow_of_two(nvec));
-	entry->nvec_used		= nvec;
 	entry->affinity			= dev->irq_affinity;
 
 	if (control & PCI_MSI_FLAGS_64BIT)
@@ -693,7 +692,7 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 			mask = cpumask_of(cpu);
 		}
 
-		entry = alloc_msi_entry(&dev->dev);
+		entry = alloc_msi_entry(&dev->dev, 1, NULL);
 		if (!entry) {
 			if (!i)
 				iounmap(base);
@@ -711,7 +710,6 @@ static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 			entry->msi_attrib.entry_nr = i;
 		entry->msi_attrib.default_irq	= dev->irq;
 		entry->mask_base		= base;
-		entry->nvec_used		= 1;
 		entry->affinity			= mask;
 
 		list_add_tail(&entry->list, dev_to_msi_list(&dev->dev));
diff --git a/drivers/staging/fsl-mc/bus/mc-msi.c b/drivers/staging/fsl-mc/bus/mc-msi.c
index c7be156..4fd8e41 100644
--- a/drivers/staging/fsl-mc/bus/mc-msi.c
+++ b/drivers/staging/fsl-mc/bus/mc-msi.c
@@ -213,7 +213,7 @@ static int fsl_mc_msi_alloc_descs(struct device *dev, unsigned int irq_count)
 	struct msi_desc *msi_desc;
 
 	for (i = 0; i < irq_count; i++) {
-		msi_desc = alloc_msi_entry(dev);
+		msi_desc = alloc_msi_entry(dev, 1, NULL);
 		if (!msi_desc) {
 			dev_err(dev, "Failed to allocate msi entry\n");
 			error = -ENOMEM;
@@ -221,7 +221,6 @@ static int fsl_mc_msi_alloc_descs(struct device *dev, unsigned int irq_count)
 		}
 
 		msi_desc->fsl_mc.msi_index = i;
-		msi_desc->nvec_used = 1;
 		INIT_LIST_HEAD(&msi_desc->list);
 		list_add_tail(&msi_desc->list, dev_to_msi_list(dev));
 	}
diff --git a/include/linux/msi.h b/include/linux/msi.h
index e8c81fb..0db320b 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -68,7 +68,7 @@ struct msi_desc {
 	unsigned int			nvec_used;
 	struct device			*dev;
 	struct msi_msg			msg;
-	const struct cpumask		*affinity;
+	struct cpumask			*affinity;
 
 	union {
 		/* PCI MSI/X specific data */
@@ -123,7 +123,8 @@ static inline void *msi_desc_to_pci_sysdata(struct msi_desc *desc)
 }
 #endif /* CONFIG_PCI_MSI */
 
-struct msi_desc *alloc_msi_entry(struct device *dev);
+struct msi_desc *alloc_msi_entry(struct device *dev, int nvec,
+				 const struct cpumask *affinity);
 void free_msi_entry(struct msi_desc *entry);
 void __pci_read_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
 void __pci_write_msi_msg(struct msi_desc *entry, struct msi_msg *msg);
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 19e9dfb..8a3e8727 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -18,20 +18,42 @@
 /* Temparory solution for building, will be removed later */
 #include <linux/pci.h>
 
-struct msi_desc *alloc_msi_entry(struct device *dev)
+/**
+ * alloc_msi_entry - Allocate an initialize msi_entry
+ * @dev:	Pointer to the device for which this is allocated
+ * @nvec:	The number of vectors used in this entry
+ * @affinity:	Optional pointer to an affinity mask array size of @nvec
+ *
+ * If @affinity is not NULL then a an affinity array[@nvec] is allocated
+ * and the affinity masks from @affinity are copied.
+ */
+struct msi_desc *
+alloc_msi_entry(struct device *dev, int nvec, const struct cpumask *affinity)
 {
-	struct msi_desc *desc = kzalloc(sizeof(*desc), GFP_KERNEL);
+	struct msi_desc *desc;
+
+	desc = kzalloc(sizeof(*desc), GFP_KERNEL);
 	if (!desc)
 		return NULL;
 
 	INIT_LIST_HEAD(&desc->list);
 	desc->dev = dev;
+	desc->nvec_used = nvec;
+	if (affinity) {
+		desc->affinity = kmemdup(affinity,
+			nvec * sizeof(*desc->affinity), GFP_KERNEL);
+		if (!desc->affinity) {
+			kfree(desc);
+			return NULL;
+		}
+	}
 
 	return desc;
 }
 
 void free_msi_entry(struct msi_desc *entry)
 {
+	kfree(entry->affinity);
 	kfree(entry);
 }
 
-- 
2.1.4

