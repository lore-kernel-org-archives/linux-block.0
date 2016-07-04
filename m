Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de,
	axboe@fb.com
Subject: [PATCH 03/13] irq: Add affinity hint to irq allocation
Date: Mon,  4 Jul 2016 17:39:24 +0900
Message-Id: <1467621574-8277-4-git-send-email-hch@lst.de>
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

From: Thomas Gleixner <tglx@linutronix.de>

Add an extra argument to the irq(domain) allocation functions, so we can hand
down affinity hints to the allocator. Thats necessary to implement proper
support for multiqueue devices.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 arch/sparc/kernel/irq_64.c     |  2 +-
 arch/x86/kernel/apic/io_apic.c |  5 +++--
 include/linux/irq.h            |  4 ++--
 include/linux/irqdomain.h      |  9 ++++++---
 kernel/irq/ipi.c               |  2 +-
 kernel/irq/irqdesc.c           | 12 ++++++++----
 kernel/irq/irqdomain.c         | 22 ++++++++++++++--------
 kernel/irq/manage.c            |  7 ++++---
 kernel/irq/msi.c               |  3 ++-
 9 files changed, 41 insertions(+), 25 deletions(-)

diff --git a/arch/sparc/kernel/irq_64.c b/arch/sparc/kernel/irq_64.c
index e22416c..34a7930 100644
--- a/arch/sparc/kernel/irq_64.c
+++ b/arch/sparc/kernel/irq_64.c
@@ -242,7 +242,7 @@ unsigned int irq_alloc(unsigned int dev_handle, unsigned int dev_ino)
 {
 	int irq;
 
-	irq = __irq_alloc_descs(-1, 1, 1, numa_node_id(), NULL);
+	irq = __irq_alloc_descs(-1, 1, 1, numa_node_id(), NULL, NULL);
 	if (irq <= 0)
 		goto out;
 
diff --git a/arch/x86/kernel/apic/io_apic.c b/arch/x86/kernel/apic/io_apic.c
index 84e33ff..bca0c81 100644
--- a/arch/x86/kernel/apic/io_apic.c
+++ b/arch/x86/kernel/apic/io_apic.c
@@ -981,7 +981,7 @@ static int alloc_irq_from_domain(struct irq_domain *domain, int ioapic, u32 gsi,
 
 	return __irq_domain_alloc_irqs(domain, irq, 1,
 				       ioapic_alloc_attr_node(info),
-				       info, legacy);
+				       info, legacy, NULL);
 }
 
 /*
@@ -1014,7 +1014,8 @@ static int alloc_isa_irq_from_domain(struct irq_domain *domain,
 					  info->ioapic_pin))
 			return -ENOMEM;
 	} else {
-		irq = __irq_domain_alloc_irqs(domain, irq, 1, node, info, true);
+		irq = __irq_domain_alloc_irqs(domain, irq, 1, node, info, true,
+					      NULL);
 		if (irq >= 0) {
 			irq_data = irq_domain_get_irq_data(domain, irq);
 			data = irq_data->chip_data;
diff --git a/include/linux/irq.h b/include/linux/irq.h
index f607481..39ce46a 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -708,11 +708,11 @@ static inline struct cpumask *irq_data_get_affinity_mask(struct irq_data *d)
 unsigned int arch_dynirq_lower_bound(unsigned int from);
 
 int __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
-		struct module *owner);
+		      struct module *owner, const struct cpumask *affinity);
 
 /* use macros to avoid needing export.h for THIS_MODULE */
 #define irq_alloc_descs(irq, from, cnt, node)	\
-	__irq_alloc_descs(irq, from, cnt, node, THIS_MODULE)
+	__irq_alloc_descs(irq, from, cnt, node, THIS_MODULE, NULL)
 
 #define irq_alloc_desc(node)			\
 	irq_alloc_descs(-1, 0, 1, node)
diff --git a/include/linux/irqdomain.h b/include/linux/irqdomain.h
index f1f36e0..1aee0fb 100644
--- a/include/linux/irqdomain.h
+++ b/include/linux/irqdomain.h
@@ -39,6 +39,7 @@ struct irq_domain;
 struct of_device_id;
 struct irq_chip;
 struct irq_data;
+struct cpumask;
 
 /* Number of irqs reserved for a legacy isa controller */
 #define NUM_ISA_INTERRUPTS	16
@@ -217,7 +218,8 @@ extern struct irq_domain *irq_find_matching_fwspec(struct irq_fwspec *fwspec,
 						   enum irq_domain_bus_token bus_token);
 extern void irq_set_default_host(struct irq_domain *host);
 extern int irq_domain_alloc_descs(int virq, unsigned int nr_irqs,
-				  irq_hw_number_t hwirq, int node);
+				  irq_hw_number_t hwirq, int node,
+				  const struct cpumask *affinity);
 
 static inline struct fwnode_handle *of_node_to_fwnode(struct device_node *node)
 {
@@ -389,7 +391,7 @@ static inline struct irq_domain *irq_domain_add_hierarchy(struct irq_domain *par
 
 extern int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 				   unsigned int nr_irqs, int node, void *arg,
-				   bool realloc);
+				   bool realloc, const struct cpumask *affinity);
 extern void irq_domain_free_irqs(unsigned int virq, unsigned int nr_irqs);
 extern void irq_domain_activate_irq(struct irq_data *irq_data);
 extern void irq_domain_deactivate_irq(struct irq_data *irq_data);
@@ -397,7 +399,8 @@ extern void irq_domain_deactivate_irq(struct irq_data *irq_data);
 static inline int irq_domain_alloc_irqs(struct irq_domain *domain,
 			unsigned int nr_irqs, int node, void *arg)
 {
-	return __irq_domain_alloc_irqs(domain, -1, nr_irqs, node, arg, false);
+	return __irq_domain_alloc_irqs(domain, -1, nr_irqs, node, arg, false,
+				       NULL);
 }
 
 extern int irq_domain_alloc_irqs_recursive(struct irq_domain *domain,
diff --git a/kernel/irq/ipi.c b/kernel/irq/ipi.c
index 89b49f6..4fd2351 100644
--- a/kernel/irq/ipi.c
+++ b/kernel/irq/ipi.c
@@ -76,7 +76,7 @@ int irq_reserve_ipi(struct irq_domain *domain,
 		}
 	}
 
-	virq = irq_domain_alloc_descs(-1, nr_irqs, 0, NUMA_NO_NODE);
+	virq = irq_domain_alloc_descs(-1, nr_irqs, 0, NUMA_NO_NODE, NULL);
 	if (virq <= 0) {
 		pr_warn("Can't reserve IPI, failed to alloc descs\n");
 		return -ENOMEM;
diff --git a/kernel/irq/irqdesc.c b/kernel/irq/irqdesc.c
index 8731e1c..b8df4fc 100644
--- a/kernel/irq/irqdesc.c
+++ b/kernel/irq/irqdesc.c
@@ -223,7 +223,7 @@ static void free_desc(unsigned int irq)
 }
 
 static int alloc_descs(unsigned int start, unsigned int cnt, int node,
-		       struct module *owner)
+		       const struct cpumask *affinity, struct module *owner)
 {
 	struct irq_desc *desc;
 	int i;
@@ -333,6 +333,7 @@ static void free_desc(unsigned int irq)
 }
 
 static inline int alloc_descs(unsigned int start, unsigned int cnt, int node,
+			      const struct cpumask *affinity,
 			      struct module *owner)
 {
 	u32 i;
@@ -453,12 +454,15 @@ EXPORT_SYMBOL_GPL(irq_free_descs);
  * @cnt:	Number of consecutive irqs to allocate.
  * @node:	Preferred node on which the irq descriptor should be allocated
  * @owner:	Owning module (can be NULL)
+ * @affinity:	Optional pointer to an affinity mask which hints where the
+ *		irq descriptors should be allocated and which default
+ *		affinities to use
  *
  * Returns the first irq number or error code
  */
 int __ref
 __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
-		  struct module *owner)
+		  struct module *owner, const struct cpumask *affinity)
 {
 	int start, ret;
 
@@ -494,7 +498,7 @@ __irq_alloc_descs(int irq, unsigned int from, unsigned int cnt, int node,
 
 	bitmap_set(allocated_irqs, start, cnt);
 	mutex_unlock(&sparse_irq_lock);
-	return alloc_descs(start, cnt, node, owner);
+	return alloc_descs(start, cnt, node, affinity, owner);
 
 err:
 	mutex_unlock(&sparse_irq_lock);
@@ -512,7 +516,7 @@ EXPORT_SYMBOL_GPL(__irq_alloc_descs);
  */
 unsigned int irq_alloc_hwirqs(int cnt, int node)
 {
-	int i, irq = __irq_alloc_descs(-1, 0, cnt, node, NULL);
+	int i, irq = __irq_alloc_descs(-1, 0, cnt, node, NULL, NULL);
 
 	if (irq < 0)
 		return 0;
diff --git a/kernel/irq/irqdomain.c b/kernel/irq/irqdomain.c
index 8798b6c..79459b7 100644
--- a/kernel/irq/irqdomain.c
+++ b/kernel/irq/irqdomain.c
@@ -481,7 +481,7 @@ unsigned int irq_create_mapping(struct irq_domain *domain,
 	}
 
 	/* Allocate a virtual interrupt number */
-	virq = irq_domain_alloc_descs(-1, 1, hwirq, of_node_to_nid(of_node));
+	virq = irq_domain_alloc_descs(-1, 1, hwirq, of_node_to_nid(of_node), NULL);
 	if (virq <= 0) {
 		pr_debug("-> virq allocation failed\n");
 		return 0;
@@ -835,19 +835,23 @@ const struct irq_domain_ops irq_domain_simple_ops = {
 EXPORT_SYMBOL_GPL(irq_domain_simple_ops);
 
 int irq_domain_alloc_descs(int virq, unsigned int cnt, irq_hw_number_t hwirq,
-			   int node)
+			   int node, const struct cpumask *affinity)
 {
 	unsigned int hint;
 
 	if (virq >= 0) {
-		virq = irq_alloc_descs(virq, virq, cnt, node);
+		virq = __irq_alloc_descs(virq, virq, cnt, node, THIS_MODULE,
+					 affinity);
 	} else {
 		hint = hwirq % nr_irqs;
 		if (hint == 0)
 			hint++;
-		virq = irq_alloc_descs_from(hint, cnt, node);
-		if (virq <= 0 && hint > 1)
-			virq = irq_alloc_descs_from(1, cnt, node);
+		virq = __irq_alloc_descs(-1, hint, cnt, node, THIS_MODULE,
+					 affinity);
+		if (virq <= 0 && hint > 1) {
+			virq = __irq_alloc_descs(-1, 1, cnt, node, THIS_MODULE,
+						 affinity);
+		}
 	}
 
 	return virq;
@@ -1160,6 +1164,7 @@ int irq_domain_alloc_irqs_recursive(struct irq_domain *domain,
  * @node:	NUMA node id for memory allocation
  * @arg:	domain specific argument
  * @realloc:	IRQ descriptors have already been allocated if true
+ * @affinity:	Optional irq affinity mask for multiqueue devices
  *
  * Allocate IRQ numbers and initialized all data structures to support
  * hierarchy IRQ domains.
@@ -1175,7 +1180,7 @@ int irq_domain_alloc_irqs_recursive(struct irq_domain *domain,
  */
 int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 			    unsigned int nr_irqs, int node, void *arg,
-			    bool realloc)
+			    bool realloc, const struct cpumask *affinity)
 {
 	int i, ret, virq;
 
@@ -1193,7 +1198,8 @@ int __irq_domain_alloc_irqs(struct irq_domain *domain, int irq_base,
 	if (realloc && irq_base >= 0) {
 		virq = irq_base;
 	} else {
-		virq = irq_domain_alloc_descs(irq_base, nr_irqs, 0, node);
+		virq = irq_domain_alloc_descs(irq_base, nr_irqs, 0, node,
+					      affinity);
 		if (virq < 0) {
 			pr_debug("cannot allocate IRQ(base %d, count %d)\n",
 				 irq_base, nr_irqs);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 30658e9..ad0aac6 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -353,10 +353,11 @@ static int setup_affinity(struct irq_desc *desc, struct cpumask *mask)
 		return 0;
 
 	/*
-	 * Preserve an userspace affinity setup, but make sure that
-	 * one of the targets is online.
+	 * Preserve the managed affinity setting and an userspace affinity
+	 * setup, but make sure that one of the targets is online.
 	 */
-	if (irqd_has_set(&desc->irq_data, IRQD_AFFINITY_SET)) {
+	if (irqd_affinity_is_managed(&desc->irq_data) ||
+	    irqd_has_set(&desc->irq_data, IRQD_AFFINITY_SET)) {
 		if (cpumask_intersects(desc->irq_common_data.affinity,
 				       cpu_online_mask))
 			set = desc->irq_common_data.affinity;
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index eb5bf2b..58dbbac 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -334,7 +334,8 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 		ops->set_desc(&arg, desc);
 
 		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
-					       dev_to_node(dev), &arg, false);
+					       dev_to_node(dev), &arg, false,
+					       NULL);
 		if (virq < 0) {
 			ret = -ENOSPC;
 			if (ops->handle_error)
-- 
2.1.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
