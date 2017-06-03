Return-Path: <BATV+4a135d35f30012caeec5+5032+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 5/8] genirq/affinity: update CPU affinity for CPU hotplug events
Date: Sat,  3 Jun 2017 16:04:00 +0200
Message-Id: <20170603140403.27379-6-hch@lst.de>
In-Reply-To: <20170603140403.27379-1-hch@lst.de>
References: <20170603140403.27379-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Remove a CPU from the affinity mask when it goes offline and add it
back when it returns.  In case the vetor was assigned only to the CPU
going offline it will be shutdown and re-started when the CPU
reappears.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/irq.c      |   3 +-
 include/linux/cpuhotplug.h |   1 +
 include/linux/irq.h        |   9 ++++
 kernel/cpu.c               |   6 +++
 kernel/irq/affinity.c      | 127 ++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 144 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index a54eac5d81b3..72c35ed534f1 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -453,7 +453,8 @@ void fixup_irqs(void)
 
 		data = irq_desc_get_irq_data(desc);
 		affinity = irq_data_get_affinity_mask(data);
-		if (!irq_has_action(irq) || irqd_is_per_cpu(data) ||
+		if (irqd_affinity_is_managed(data) ||
+		    !irq_has_action(irq) || irqd_is_per_cpu(data) ||
 		    cpumask_subset(affinity, cpu_online_mask)) {
 			raw_spin_unlock(&desc->lock);
 			continue;
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index 0f2a80377520..c15f22c54535 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -124,6 +124,7 @@ enum cpuhp_state {
 	CPUHP_AP_ONLINE_IDLE,
 	CPUHP_AP_SMPBOOT_THREADS,
 	CPUHP_AP_X86_VDSO_VMA_ONLINE,
+	CPUHP_AP_IRQ_AFFINITY_ONLINE,
 	CPUHP_AP_PERF_ONLINE,
 	CPUHP_AP_PERF_X86_ONLINE,
 	CPUHP_AP_PERF_X86_UNCORE_ONLINE,
diff --git a/include/linux/irq.h b/include/linux/irq.h
index f887351aa80e..ae15b8582685 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -216,6 +216,7 @@ enum {
 	IRQD_WAKEUP_ARMED		= (1 << 19),
 	IRQD_FORWARDED_TO_VCPU		= (1 << 20),
 	IRQD_AFFINITY_MANAGED		= (1 << 21),
+	IRQD_AFFINITY_SUSPENDED		= (1 << 22),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -329,6 +330,11 @@ static inline void irqd_clr_activated(struct irq_data *d)
 	__irqd_to_state(d) &= ~IRQD_ACTIVATED;
 }
 
+static inline bool irqd_affinity_is_suspended(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_AFFINITY_SUSPENDED;
+}
+
 #undef __irqd_to_state
 
 static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
@@ -1025,4 +1031,7 @@ int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest);
 int ipi_send_single(unsigned int virq, unsigned int cpu);
 int ipi_send_mask(unsigned int virq, const struct cpumask *dest);
 
+int irq_affinity_online_cpu(unsigned int cpu);
+int irq_affinity_offline_cpu(unsigned int cpu);
+
 #endif /* _LINUX_IRQ_H */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 9ae6fbe5b5cf..ef0c5b63ca0d 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -27,6 +27,7 @@
 #include <linux/smpboot.h>
 #include <linux/relay.h>
 #include <linux/slab.h>
+#include <linux/irq.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -1252,6 +1253,11 @@ static struct cpuhp_step cpuhp_ap_states[] = {
 		.startup.single		= smpboot_unpark_threads,
 		.teardown.single	= NULL,
 	},
+	[CPUHP_AP_IRQ_AFFINITY_ONLINE] = {
+		.name			= "irq/affinity:online",
+		.startup.single		= irq_affinity_online_cpu,
+		.teardown.single	= irq_affinity_offline_cpu,
+	},
 	[CPUHP_AP_PERF_ONLINE] = {
 		.name			= "perf:online",
 		.startup.single		= perf_event_init_cpu,
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 337e6ffba93f..e27ecfb4866f 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -1,4 +1,7 @@
-
+/*
+ * Copyright (C) 2016 Thomas Gleixner.
+ * Copyright (C) 2016-2017 Christoph Hellwig.
+ */
 #include <linux/interrupt.h>
 #include <linux/irq.h>
 #include <linux/kernel.h>
@@ -227,3 +230,125 @@ int irq_calc_affinity_vectors(int maxvec, const struct irq_affinity *affd)
 
 	return min_t(int, cpumask_weight(cpu_present_mask), vecs) + resv;
 }
+
+static void irq_affinity_online_irq(unsigned int irq, struct irq_desc *desc,
+				    unsigned int cpu)
+{
+	const struct cpumask *affinity;
+	struct irq_data *data;
+	struct irq_chip *chip;
+	unsigned long flags;
+	cpumask_var_t mask;
+
+	if (!desc)
+		return;
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
+		return;
+
+	raw_spin_lock_irqsave(&desc->lock, flags);
+
+	data = irq_desc_get_irq_data(desc);
+	affinity = irq_data_get_affinity_mask(data);
+	if (!irqd_affinity_is_managed(data) ||
+	    !irq_has_action(irq) ||
+	    !cpumask_test_cpu(cpu, affinity))
+		goto out_free_cpumask;
+
+	/*
+	 * The interrupt descriptor might have been cleaned up
+	 * already, but it is not yet removed from the radix tree
+	 */
+	chip = irq_data_get_irq_chip(data);
+	if (!chip)
+		goto out_free_cpumask;
+
+	if (WARN_ON_ONCE(!chip->irq_set_affinity))
+		goto out_free_cpumask;
+
+	cpumask_and(mask, affinity, cpu_online_mask);
+	cpumask_set_cpu(cpu, mask);
+	if (irqd_has_set(data, IRQD_AFFINITY_SUSPENDED)) {
+		irq_startup(desc, false);
+		irqd_clear(data, IRQD_AFFINITY_SUSPENDED);
+	} else {
+		irq_affinity_set(irq, desc, mask);
+	}
+
+out_free_cpumask:
+	free_cpumask_var(mask);
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+int irq_affinity_online_cpu(unsigned int cpu)
+{
+	struct irq_desc *desc;
+	unsigned int irq;
+
+	irq_lock_sparse();
+	for_each_irq_desc(irq, desc)
+		irq_affinity_online_irq(irq, desc, cpu);
+	irq_unlock_sparse();
+	return 0;
+}
+
+static void irq_affinity_offline_irq(unsigned int irq, struct irq_desc *desc,
+				     unsigned int cpu)
+{
+	const struct cpumask *affinity;
+	struct irq_data *data;
+	struct irq_chip *chip;
+	unsigned long flags;
+	cpumask_var_t mask;
+
+	if (!desc)
+		return;
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL))
+		return;
+
+	raw_spin_lock_irqsave(&desc->lock, flags);
+
+	data = irq_desc_get_irq_data(desc);
+	affinity = irq_data_get_affinity_mask(data);
+	if (!irqd_affinity_is_managed(data) ||
+	    !irq_has_action(irq) ||
+	    irqd_has_set(data, IRQD_AFFINITY_SUSPENDED) ||
+	    !cpumask_test_cpu(cpu, affinity))
+		goto out_free_cpumask;
+
+	/*
+	 * The interrupt descriptor might have been cleaned up
+	 * already, but it is not yet removed from the radix tree
+	 */
+	chip = irq_data_get_irq_chip(data);
+	if (!chip)
+		goto out_free_cpumask;
+
+	if (WARN_ON_ONCE(!chip->irq_set_affinity))
+		goto out_free_cpumask;
+
+
+	cpumask_copy(mask, affinity);
+	cpumask_clear_cpu(cpu, mask);
+	if (cpumask_empty(mask)) {
+		irqd_set(data, IRQD_AFFINITY_SUSPENDED);
+		irq_shutdown(desc);
+	} else {
+		irq_affinity_set(irq, desc, mask);
+	}
+
+out_free_cpumask:
+	free_cpumask_var(mask);
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+int irq_affinity_offline_cpu(unsigned int cpu)
+{
+	struct irq_desc *desc;
+	unsigned int irq;
+
+	irq_lock_sparse();
+	for_each_irq_desc(irq, desc)
+		irq_affinity_offline_irq(irq, desc, cpu);
+	irq_unlock_sparse();
+	return 0;
+}
-- 
2.11.0
