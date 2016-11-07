Return-Path: <BATV+fd6e759d6fe7114d99bf+4824+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de
Cc: axboe@kernel.dk,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christogh Hellwig <hch@lst.de>
Subject: [PATCH 2/7] genirq/affinity: Handle pre/post vectors in irq_calc_affinity_vectors()
Date: Mon,  7 Nov 2016 10:47:37 -0800
Message-Id: <1478544462-9549-3-git-send-email-hch@lst.de>
In-Reply-To: <1478544462-9549-1-git-send-email-hch@lst.de>
References: <1478544462-9549-1-git-send-email-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

From: Christogh Hellwig <hch@lst.de>

Only calculate the affinity for the main I/O vectors, and skip the
pre or post vectors specified by struct irq_affinity.

Also remove the irq_affinity cpumask argument that has never been used.
If we ever need it in the future we can pass it through struct
irq_affinity.

Signed-off-by: Christogh Hellwig <hch@lst.de>
---
 drivers/pci/msi.c         |  6 ++----
 include/linux/interrupt.h |  4 ++--
 kernel/irq/affinity.c     | 24 ++++++++++--------------
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index ad70507..c58d3c2 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1091,8 +1091,7 @@ static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
 
 	for (;;) {
 		if (affinity) {
-			nvec = irq_calc_affinity_vectors(dev->irq_affinity,
-					nvec);
+			nvec = irq_calc_affinity_vectors(nvec, NULL);
 			if (nvec < minvec)
 				return -ENOSPC;
 		}
@@ -1140,8 +1139,7 @@ static int __pci_enable_msix_range(struct pci_dev *dev,
 
 	for (;;) {
 		if (affinity) {
-			nvec = irq_calc_affinity_vectors(dev->irq_affinity,
-					nvec);
+			nvec = irq_calc_affinity_vectors(nvec, NULL);
 			if (nvec < minvec)
 				return -ENOSPC;
 		}
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 7284bcd..092adfb 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -291,7 +291,7 @@ extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 
 struct cpumask *irq_create_affinity_masks(const struct cpumask *affinity, int nvec);
-int irq_calc_affinity_vectors(const struct cpumask *affinity, int maxvec);
+int irq_calc_affinity_vectors(int maxvec, const struct irq_affinity *affd);
 
 #else /* CONFIG_SMP */
 
@@ -331,7 +331,7 @@ irq_create_affinity_masks(const struct cpumask *affinity, int nvec)
 }
 
 static inline int
-irq_calc_affinity_vectors(const struct cpumask *affinity, int maxvec)
+irq_calc_affinity_vectors(int maxvec, const struct irq_affinity *affd)
 {
 	return maxvec;
 }
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 17f51d63..8d92597 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -131,24 +131,20 @@ struct cpumask *irq_create_affinity_masks(const struct cpumask *affinity,
 }
 
 /**
- * irq_calc_affinity_vectors - Calculate to optimal number of vectors for a given affinity mask
- * @affinity:		The affinity mask to spread. If NULL cpu_online_mask
- *			is used
- * @maxvec:		The maximum number of vectors available
+ * irq_calc_affinity_vectors - Calculate the optimal number of vectors
+ * @maxvec:	The maximum number of vectors available
+ * @affd:	Description of the affinity requirements
  */
-int irq_calc_affinity_vectors(const struct cpumask *affinity, int maxvec)
+int irq_calc_affinity_vectors(int maxvec, const struct irq_affinity *affd)
 {
-	int cpus, ret;
+	int resv = affd->pre_vectors + affd->post_vectors;
+	int vecs = maxvec - resv;
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
+	return min(cpus, vecs) + resv;
 }
-- 
2.1.4
