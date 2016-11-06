Return-Path: <BATV+fbdc7abeb5f03b4a914d+4823+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] irq,pci: allow drivers to specify complex affinity requirement
Date: Sun,  6 Nov 2016 15:07:25 -0800
Message-Id: <1478473646-12524-2-git-send-email-hch@lst.de>
In-Reply-To: <1478473646-12524-1-git-send-email-hch@lst.de>
References: <1478473646-12524-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Some drivers (various network and RDMA adapter for example) have a MSI-X
vector layout where most of the vectors are used for I/O queues and should
have CPU affinity assigned to them, but some (usually 1 but sometimes more)
at the beginning or end are used for low-performance admin or configuration
work and should not have any explicit affinity assigned to them.

This adds a new irq_affinity structure passed through a variant of
pci_irq_alloc_vectors that allows to specify these requirements (and is
extensible to any future quirks in that area) so that the core IRQ
affinity algorithm can take this quirks into account.

It also removes the unused irq_affinity mask in struct pci_dev.  If we
ever need that sort of functionality it should be passed through
struct irq_affinity.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 drivers/pci/msi.c         | 61 ++++++++++++++++++++++++--------------------
 include/linux/interrupt.h | 26 ++++++++++++++++---
 include/linux/pci.h       | 14 ++++++----
 kernel/irq/affinity.c     | 65 ++++++++++++++++++++++++-----------------------
 4 files changed, 98 insertions(+), 68 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index bfdd074..c312535 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -551,14 +551,15 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 }
 
 static struct msi_desc *
-msi_setup_entry(struct pci_dev *dev, int nvec, bool affinity)
+msi_setup_entry(struct pci_dev *dev, int nvec, bool affinity,
+		struct irq_affinity *desc)
 {
 	struct cpumask *masks = NULL;
 	struct msi_desc *entry;
 	u16 control;
 
 	if (affinity) {
-		masks = irq_create_affinity_masks(dev->irq_affinity, nvec);
+		masks = irq_create_affinity_masks(desc, nvec);
 		if (!masks)
 			pr_err("Unable to allocate affinity masks, ignoring\n");
 	}
@@ -617,7 +618,8 @@ static int msi_verify_entries(struct pci_dev *dev)
  * an error, and a positive return value indicates the number of interrupts
  * which could have been allocated.
  */
-static int msi_capability_init(struct pci_dev *dev, int nvec, bool affinity)
+static int msi_capability_init(struct pci_dev *dev, int nvec, bool affinity,
+		struct irq_affinity *desc)
 {
 	struct msi_desc *entry;
 	int ret;
@@ -625,7 +627,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec, bool affinity)
 
 	pci_msi_set_enable(dev, 0);	/* Disable MSI during set up */
 
-	entry = msi_setup_entry(dev, nvec, affinity);
+	entry = msi_setup_entry(dev, nvec, affinity, desc);
 	if (!entry)
 		return -ENOMEM;
 
@@ -689,14 +691,14 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
 
 static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 			      struct msix_entry *entries, int nvec,
-			      bool affinity)
+			      bool affinity, struct irq_affinity *desc)
 {
 	struct cpumask *curmsk, *masks = NULL;
 	struct msi_desc *entry;
 	int ret, i;
 
 	if (affinity) {
-		masks = irq_create_affinity_masks(dev->irq_affinity, nvec);
+		masks = irq_create_affinity_masks(desc, nvec);
 		if (!masks)
 			pr_err("Unable to allocate affinity masks, ignoring\n");
 	}
@@ -758,7 +760,7 @@ static void msix_program_entries(struct pci_dev *dev,
  * requested MSI-X entries with allocated irqs or non-zero for otherwise.
  **/
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
-				int nvec, bool affinity)
+		int nvec, bool affinity, struct irq_affinity *desc)
 {
 	int ret;
 	u16 control;
@@ -773,7 +775,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	if (!base)
 		return -ENOMEM;
 
-	ret = msix_setup_entries(dev, base, entries, nvec, affinity);
+	ret = msix_setup_entries(dev, base, entries, nvec, affinity, desc);
 	if (ret)
 		return ret;
 
@@ -954,7 +956,7 @@ int pci_msix_vec_count(struct pci_dev *dev)
 EXPORT_SYMBOL(pci_msix_vec_count);
 
 static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
-			     int nvec, bool affinity)
+		int nvec, bool affinity, struct irq_affinity *desc)
 {
 	int nr_entries;
 	int i, j;
@@ -986,7 +988,7 @@ static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
 		dev_info(&dev->dev, "can't enable MSI-X (MSI IRQ already assigned)\n");
 		return -EINVAL;
 	}
-	return msix_capability_init(dev, entries, nvec, affinity);
+	return msix_capability_init(dev, entries, nvec, affinity, desc);
 }
 
 /**
@@ -1006,7 +1008,7 @@ static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
  **/
 int pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries, int nvec)
 {
-	return __pci_enable_msix(dev, entries, nvec, false);
+	return __pci_enable_msix(dev, entries, nvec, false, NULL);
 }
 EXPORT_SYMBOL(pci_enable_msix);
 
@@ -1057,7 +1059,7 @@ int pci_msi_enabled(void)
 EXPORT_SYMBOL(pci_msi_enabled);
 
 static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
-		unsigned int flags)
+		unsigned int flags, struct irq_affinity *desc)
 {
 	bool affinity = flags & PCI_IRQ_AFFINITY;
 	int nvec;
@@ -1089,13 +1091,12 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 
 	for (;;) {
 		if (affinity) {
-			nvec = irq_calc_affinity_vectors(dev->irq_affinity,
-					nvec);
+			nvec = irq_calc_affinity_vectors(desc, nvec);
 			if (nvec < minvec)
 				return -ENOSPC;
 		}
 
-		rc = msi_capability_init(dev, nvec, affinity);
+		rc = msi_capability_init(dev, nvec, affinity, desc);
 		if (rc == 0)
 			return nvec;
 
@@ -1122,13 +1123,13 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
  **/
 int pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec)
 {
-	return __pci_enable_msi_range(dev, minvec, maxvec, 0);
+	return __pci_enable_msi_range(dev, minvec, maxvec, 0, NULL);
 }
 EXPORT_SYMBOL(pci_enable_msi_range);
 
 static int __pci_enable_msix_range(struct pci_dev *dev,
 		struct msix_entry *entries, int minvec, int maxvec,
-		unsigned int flags)
+		unsigned int flags, struct irq_affinity *desc)
 {
 	bool affinity = flags & PCI_IRQ_AFFINITY;
 	int rc, nvec = maxvec;
@@ -1138,13 +1139,12 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 
 	for (;;) {
 		if (affinity) {
-			nvec = irq_calc_affinity_vectors(dev->irq_affinity,
-					nvec);
+			nvec = irq_calc_affinity_vectors(desc, nvec);
 			if (nvec < minvec)
 				return -ENOSPC;
 		}
 
-		rc = __pci_enable_msix(dev, entries, nvec, affinity);
+		rc = __pci_enable_msix(dev, entries, nvec, affinity, desc);
 		if (rc == 0)
 			return nvec;
 
@@ -1175,16 +1175,17 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 int pci_enable_msix_range(struct pci_dev *dev, struct msix_entry *entries,
 		int minvec, int maxvec)
 {
-	return __pci_enable_msix_range(dev, entries, minvec, maxvec, 0);
+	return __pci_enable_msix_range(dev, entries, minvec, maxvec, 0, NULL);
 }
 EXPORT_SYMBOL(pci_enable_msix_range);
 
 /**
- * pci_alloc_irq_vectors - allocate multiple IRQs for a device
+ * pci_alloc_irq_vectors_affinity - allocate multiple IRQs for a device
  * @dev:		PCI device to operate on
  * @min_vecs:		minimum number of vectors required (must be >= 1)
  * @max_vecs:		maximum (desired) number of vectors
  * @flags:		flags or quirks for the allocation
+ * @desc:		description of the affinity requirements
  *
  * Allocate up to @max_vecs interrupt vectors for @dev, using MSI-X or MSI
  * vectors if available, and fall back to a single legacy vector
@@ -1196,20 +1197,26 @@ EXPORT_SYMBOL(pci_enable_msix_range);
  * To get the Linux IRQ number used for a vector that can be passed to
  * request_irq() use the pci_irq_vector() helper.
  */
-int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
-		unsigned int max_vecs, unsigned int flags)
+int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
+		unsigned int max_vecs, unsigned int flags,
+		struct irq_affinity *desc)
 {
 	int vecs = -ENOSPC;
+	struct irq_affinity __desc = { 0, };
+
+	if (!desc)
+		desc = &__desc;
 
 	if (flags & PCI_IRQ_MSIX) {
 		vecs = __pci_enable_msix_range(dev, NULL, min_vecs, max_vecs,
-				flags);
+				flags, desc);
 		if (vecs > 0)
 			return vecs;
 	}
 
 	if (flags & PCI_IRQ_MSI) {
-		vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, flags);
+		vecs = __pci_enable_msi_range(dev, min_vecs, max_vecs, flags,
+				desc);
 		if (vecs > 0)
 			return vecs;
 	}
@@ -1222,7 +1229,7 @@ int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
 
 	return vecs;
 }
-EXPORT_SYMBOL(pci_alloc_irq_vectors);
+EXPORT_SYMBOL(pci_alloc_irq_vectors_affinity);
 
 /**
  * pci_free_irq_vectors - free previously allocated IRQs for a device
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 72f0721..984ead8 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -232,6 +232,24 @@ struct irq_affinity_notify {
 	void (*release)(struct kref *ref);
 };
 
+/*
+ * This structure allows drivers to optionally specify complex IRQ affinity
+ * requirements.
+ */
+struct irq_affinity {
+	/*
+	 * Number of vectors before the main affinity vectors that should not
+	 * have have any CPU affinity:
+	 */
+	int		pre_vectors;
+
+	/*
+	 * Number of vectors after the main affinity vectors that should not
+	 * have have any CPU affinity:
+	 */
+	int		post_vectors;
+};
+
 #if defined(CONFIG_SMP)
 
 extern cpumask_var_t irq_default_affinity;
@@ -278,8 +296,8 @@ extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
 extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 
-struct cpumask *irq_create_affinity_masks(const struct cpumask *affinity, int nvec);
-int irq_calc_affinity_vectors(const struct cpumask *affinity, int maxvec);
+struct cpumask *irq_create_affinity_masks(struct irq_affinity *desc, int nvec);
+int irq_calc_affinity_vectors(struct irq_affinity *desc, int maxvec);
 
 #else /* CONFIG_SMP */
 
@@ -313,13 +331,13 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 }
 
 static inline struct cpumask *
-irq_create_affinity_masks(const struct cpumask *affinity, int nvec)
+irq_create_affinity_masks(struct irq_affinity *desc, int nvec)
 {
 	return NULL;
 }
 
 static inline int
-irq_calc_affinity_vectors(const struct cpumask *affinity, int maxvec)
+irq_calc_affinity_vectors(struct irq_affinity *desc, int maxvec)
 {
 	return maxvec;
 }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 0e49f70..be0abd2 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -244,6 +244,7 @@ struct pci_cap_saved_state {
 	struct pci_cap_saved_data cap;
 };
 
+struct irq_affinity;
 struct pcie_link_state;
 struct pci_vpd;
 struct pci_sriov;
@@ -332,7 +333,6 @@ struct pci_dev {
 	 * directly, use the values stored here. They might be different!
 	 */
 	unsigned int	irq;
-	struct cpumask	*irq_affinity;
 	struct resource resource[DEVICE_COUNT_RESOURCE]; /* I/O and memory regions + expansion ROMs */
 
 	bool match_driver;		/* Skip attaching driver */
@@ -1310,8 +1310,9 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 		return rc;
 	return 0;
 }
-int pci_alloc_irq_vectors(struct pci_dev *dev, unsigned int min_vecs,
-		unsigned int max_vecs, unsigned int flags);
+int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
+		unsigned int max_vecs, unsigned int flags,
+		struct irq_affinity *desc);
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
 const struct cpumask *pci_irq_get_affinity(struct pci_dev *pdev, int vec);
@@ -1339,9 +1340,9 @@ static inline int pci_enable_msix_range(struct pci_dev *dev,
 static inline int pci_enable_msix_exact(struct pci_dev *dev,
 		      struct msix_entry *entries, int nvec)
 { return -ENOSYS; }
-static inline int pci_alloc_irq_vectors(struct pci_dev *dev,
+static inline int pci_alloc_irq_vectors_affinity(struct pci_dev *dev,
 		unsigned int min_vecs, unsigned int max_vecs,
-		unsigned int flags)
+		unsigned int flags, struct irq_affinity *desc)
 {
 	if (min_vecs > 1)
 		return -EINVAL;
@@ -2130,4 +2131,7 @@ static inline bool pci_ari_enabled(struct pci_bus *bus)
 /* provide the legacy pci_dma_* API */
 #include <linux/pci-dma-compat.h>
 
+#define pci_alloc_irq_vectors(dev, min_vecs, max_vecs, flags) \
+	pci_alloc_irq_vectors_affinity(dev, min_vecs, max_vecs, flags, NULL)
+
 #endif /* LINUX_PCI_H */
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 17f51d63..151b285 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -51,16 +51,16 @@ static int get_nodes_in_cpumask(const struct cpumask *mask, nodemask_t *nodemsk)
 
 /**
  * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
- * @affinity:		The affinity mask to spread. If NULL cpu_online_mask
- *			is used
+ * @desc:		description of the affinity requirements
  * @nvecs:		The number of vectors
  *
  * Returns the masks pointer or NULL if allocation failed.
  */
-struct cpumask *irq_create_affinity_masks(const struct cpumask *affinity,
-					  int nvec)
+struct cpumask *irq_create_affinity_masks(struct irq_affinity *desc,
+					  int total_nvec)
 {
-	int n, nodes, vecs_per_node, cpus_per_vec, extra_vecs, curvec = 0;
+	int affinity_nvec = total_nvec - desc->pre_vectors - desc->post_vectors;
+	int n, nodes, vecs_per_node, cpus_per_vec, extra_vecs, curvec;
 	nodemask_t nodemsk = NODE_MASK_NONE;
 	struct cpumask *masks;
 	cpumask_var_t nmsk;
@@ -68,46 +68,48 @@ struct cpumask *irq_create_affinity_masks(const struct cpumask *affinity,
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return NULL;
 
-	masks = kzalloc(nvec * sizeof(*masks), GFP_KERNEL);
+	masks = kcalloc(total_nvec, sizeof(*masks), GFP_KERNEL);
 	if (!masks)
 		goto out;
 
+	/* Fill out vectors at the beginning that don't need affinity */
+	for (curvec = 0; curvec < desc->pre_vectors; curvec++)
+		cpumask_copy(masks + curvec, cpu_possible_mask);
+
 	/* Stabilize the cpumasks */
 	get_online_cpus();
-	/* If the supplied affinity mask is NULL, use cpu online mask */
-	if (!affinity)
-		affinity = cpu_online_mask;
-
-	nodes = get_nodes_in_cpumask(affinity, &nodemsk);
+	nodes = get_nodes_in_cpumask(cpu_online_mask, &nodemsk);
 
 	/*
 	 * If the number of nodes in the mask is less than or equal the
 	 * number of vectors we just spread the vectors across the nodes.
 	 */
-	if (nvec <= nodes) {
+	if (affinity_nvec <= nodes) {
 		for_each_node_mask(n, nodemsk) {
 			cpumask_copy(masks + curvec, cpumask_of_node(n));
-			if (++curvec == nvec)
+			if (++curvec == affinity_nvec)
 				break;
 		}
-		goto outonl;
+		goto done;
 	}
 
 	/* Spread the vectors per node */
-	vecs_per_node = nvec / nodes;
+	vecs_per_node = affinity_nvec / nodes;
 	/* Account for rounding errors */
-	extra_vecs = nvec - (nodes * vecs_per_node);
+	extra_vecs = affinity_nvec - (nodes * vecs_per_node);
 
 	for_each_node_mask(n, nodemsk) {
 		int ncpus, v, vecs_to_assign = vecs_per_node;
 
 		/* Get the cpus on this node which are in the mask */
-		cpumask_and(nmsk, affinity, cpumask_of_node(n));
+		cpumask_and(nmsk, cpu_online_mask, cpumask_of_node(n));
 
 		/* Calculate the number of cpus per vector */
 		ncpus = cpumask_weight(nmsk);
 
-		for (v = 0; curvec < nvec && v < vecs_to_assign; curvec++, v++) {
+		for (v = 0;
+		     curvec < affinity_nvec && v < vecs_to_assign;
+		     curvec++, v++) {
 			cpus_per_vec = ncpus / vecs_to_assign;
 
 			/* Account for extra vectors to compensate rounding errors */
@@ -119,12 +121,15 @@ struct cpumask *irq_create_affinity_masks(const struct cpumask *affinity,
 			irq_spread_init_one(masks + curvec, nmsk, cpus_per_vec);
 		}
 
-		if (curvec >= nvec)
+		if (curvec >= affinity_nvec)
 			break;
 	}
 
-outonl:
+done:
 	put_online_cpus();
+	/* fill out vectors at the end that don't need affinity */
+	for (; curvec < total_nvec; curvec++)
+		cpumask_copy(masks + curvec, cpu_possible_mask);
 out:
 	free_cpumask_var(nmsk);
 	return masks;
@@ -132,23 +137,19 @@ struct cpumask *irq_create_affinity_masks(const struct cpumask *affinity,
 
 /**
  * irq_calc_affinity_vectors - Calculate to optimal number of vectors for a given affinity mask
- * @affinity:		The affinity mask to spread. If NULL cpu_online_mask
- *			is used
+ * @desc:		description of the affinity requirements
  * @maxvec:		The maximum number of vectors available
  */
-int irq_calc_affinity_vectors(const struct cpumask *affinity, int maxvec)
+int irq_calc_affinity_vectors(struct irq_affinity *desc, int maxvec)
 {
-	int cpus, ret;
+	int affinity_vecs = maxvec - desc->pre_vectors - desc->post_vectors;
+	int cpus;
 
 	/* Stabilize the cpumasks */
 	get_online_cpus();
-	/* If the supplied affinity mask is NULL, use cpu online mask */
-	if (!affinity)
-		affinity = cpu_online_mask;
-
-	cpus = cpumask_weight(affinity);
-	ret = (cpus < maxvec) ? cpus : maxvec;
-
+	cpus = cpumask_weight(cpu_online_mask);
 	put_online_cpus();
-	return ret;
+
+	return min(cpus, affinity_vecs) +
+		desc->pre_vectors + desc->post_vectors;
 }
-- 
2.1.4
