Return-Path: <BATV+1f42f42caf748e0126fd+4912+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/6] genirq/affinity: update CPU affinity for CPU hotplug events
Date: Fri,  3 Feb 2017 15:35:57 +0100
Message-Id: <20170203143600.32307-4-hch@lst.de>
In-Reply-To: <20170203143600.32307-1-hch@lst.de>
References: <20170203143600.32307-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Remove a CPU from the affinity mask when it goes offline and add it
back when it returns.  In case the vetor was assigned only to the CPU
going offline it will be shutdown and re-started when the CPU
reappears.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/irq.c      |   3 +-
 include/linux/cpuhotplug.h |   1 +
 include/linux/irq.h        |   9 +++
 kernel/cpu.c               |   6 ++
 kernel/irq/affinity.c      | 157 ++++++++++++++++++++++++++++++++++++++++++++-
 5 files changed, 174 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index 7c6e9ffe4424..285ef40ae290 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -449,7 +449,8 @@ void fixup_irqs(void)
 
 		data = irq_desc_get_irq_data(desc);
 		affinity = irq_data_get_affinity_mask(data);
-		if (!irq_has_action(irq) || irqd_is_per_cpu(data) ||
+		if (irqd_affinity_is_managed(data) ||
+		    !irq_has_action(irq) || irqd_is_per_cpu(data) ||
 		    cpumask_subset(affinity, cpu_online_mask)) {
 			raw_spin_unlock(&desc->lock);
 			continue;
diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
index d936a0021839..63406ae5b2df 100644
--- a/include/linux/cpuhotplug.h
+++ b/include/linux/cpuhotplug.h
@@ -127,6 +127,7 @@ enum cpuhp_state {
 	CPUHP_AP_ONLINE_IDLE,
 	CPUHP_AP_SMPBOOT_THREADS,
 	CPUHP_AP_X86_VDSO_VMA_ONLINE,
+	CPUHP_AP_IRQ_AFFINIY_ONLINE,
 	CPUHP_AP_PERF_ONLINE,
 	CPUHP_AP_PERF_X86_ONLINE,
 	CPUHP_AP_PERF_X86_UNCORE_ONLINE,
diff --git a/include/linux/irq.h b/include/linux/irq.h
index e79875574b39..4b2a542b2591 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -214,6 +214,7 @@ enum {
 	IRQD_WAKEUP_ARMED		= (1 << 19),
 	IRQD_FORWARDED_TO_VCPU		= (1 << 20),
 	IRQD_AFFINITY_MANAGED		= (1 << 21),
+	IRQD_AFFINITY_SUSPENDED		= (1 << 22),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -312,6 +313,11 @@ static inline bool irqd_affinity_is_managed(struct irq_data *d)
 	return __irqd_to_state(d) & IRQD_AFFINITY_MANAGED;
 }
 
+static inline bool irqd_affinity_is_suspended(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_AFFINITY_SUSPENDED;
+}
+
 #undef __irqd_to_state
 
 static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
@@ -989,4 +995,7 @@ int __ipi_send_mask(struct irq_desc *desc, const struct cpumask *dest);
 int ipi_send_single(unsigned int virq, unsigned int cpu);
 int ipi_send_mask(unsigned int virq, const struct cpumask *dest);
 
+int irq_affinity_online_cpu(unsigned int cpu);
+int irq_affinity_offline_cpu(unsigned int cpu);
+
 #endif /* _LINUX_IRQ_H */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 0a5f630f5c54..fe19af6a896b 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -25,6 +25,7 @@
 #include <linux/smpboot.h>
 #include <linux/relay.h>
 #include <linux/slab.h>
+#include <linux/irq.h>
 
 #include <trace/events/power.h>
 #define CREATE_TRACE_POINTS
@@ -1248,6 +1249,11 @@ static struct cpuhp_step cpuhp_ap_states[] = {
 		.startup.single		= smpboot_unpark_threads,
 		.teardown.single	= NULL,
 	},
+	[CPUHP_AP_IRQ_AFFINIY_ONLINE] = {
+		.name			= "irq/affinity:online",
+		.startup.single		= irq_affinity_online_cpu,
+		.teardown.single	= irq_affinity_offline_cpu,
+	},
 	[CPUHP_AP_PERF_ONLINE] = {
 		.name			= "perf:online",
 		.startup.single		= perf_event_init_cpu,
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 6cd20a569359..74006167892d 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -1,8 +1,12 @@
-
+/*
+ * Copyright (C) 2016 Thomas Gleixner.
+ * Copyright (C) 2016-2017 Christoph Hellwig.
+ */
 #include <linux/interrupt.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
+#include "internals.h"
 
 static cpumask_var_t node_to_present_cpumask[MAX_NUMNODES] __read_mostly;
 
@@ -148,6 +152,157 @@ int irq_calc_affinity_vectors(int maxvec, const struct irq_affinity *affd)
 	return min_t(int, cpumask_weight(cpu_present_mask), vecs) + resv;
 }
 
+static void __irq_affinity_set(unsigned int irq, struct irq_desc *desc,
+		cpumask_t *mask)
+{
+	struct irq_data *data = irq_desc_get_irq_data(desc);
+	struct irq_chip *chip = irq_data_get_irq_chip(data);
+	int ret;
+
+	if (!irqd_can_move_in_process_context(data) && chip->irq_mask)
+		chip->irq_mask(data);
+	ret = chip->irq_set_affinity(data, mask, true);
+	WARN_ON_ONCE(ret);
+
+	/*
+	 * We unmask if the irq was not marked masked by the core code.
+	 * That respects the lazy irq disable behaviour.
+	 */
+	if (!irqd_can_move_in_process_context(data) &&
+	    !irqd_irq_masked(data) && chip->irq_unmask)
+		chip->irq_unmask(data);
+}
+
+static void irq_affinity_online_irq(unsigned int irq, struct irq_desc *desc,
+		unsigned int cpu)
+{
+	const struct cpumask *affinity;
+	struct irq_data *data;
+	struct irq_chip *chip;
+	unsigned long flags;
+	cpumask_var_t mask;
+
+	if (!desc)
+		return;
+
+	raw_spin_lock_irqsave(&desc->lock, flags);
+
+	data = irq_desc_get_irq_data(desc);
+	affinity = irq_data_get_affinity_mask(data);
+	if (!irqd_affinity_is_managed(data) ||
+	    !irq_has_action(irq) ||
+	    !cpumask_test_cpu(cpu, affinity))
+		goto out_unlock;
+
+	/*
+	 * The interrupt descriptor might have been cleaned up
+	 * already, but it is not yet removed from the radix tree
+	 */
+	chip = irq_data_get_irq_chip(data);
+	if (!chip)
+		goto out_unlock;
+
+	if (WARN_ON_ONCE(!chip->irq_set_affinity))
+		goto out_unlock;
+
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
+		pr_err("failed to allocate memory for cpumask\n");
+		goto out_unlock;
+	}
+
+	cpumask_and(mask, affinity, cpu_online_mask);
+	cpumask_set_cpu(cpu, mask);
+	if (irqd_has_set(data, IRQD_AFFINITY_SUSPENDED)) {
+		irq_startup(desc, false);
+		irqd_clear(data, IRQD_AFFINITY_SUSPENDED);
+	} else {
+		__irq_affinity_set(irq, desc, mask);
+	}
+
+	free_cpumask_var(mask);
+out_unlock:
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+int irq_affinity_online_cpu(unsigned int cpu)
+{
+	struct irq_desc *desc;
+	unsigned int irq;
+
+	for_each_irq_desc(irq, desc)
+		irq_affinity_online_irq(irq, desc, cpu);
+	return 0;
+}
+
+static void irq_affinity_offline_irq(unsigned int irq, struct irq_desc *desc,
+		unsigned int cpu)
+{
+	const struct cpumask *affinity;
+	struct irq_data *data;
+	struct irq_chip *chip;
+	unsigned long flags;
+	cpumask_var_t mask;
+
+	if (!desc)
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
+		goto out_unlock;
+
+	/*
+	 * Complete the irq move. This cpu is going down and for
+	 * non intr-remapping case, we can't wait till this interrupt
+	 * arrives at this cpu before completing the irq move.
+	 */
+	irq_force_complete_move(desc);
+
+	/*
+	 * The interrupt descriptor might have been cleaned up
+	 * already, but it is not yet removed from the radix tree
+	 */
+	chip = irq_data_get_irq_chip(data);
+	if (!chip)
+		goto out_unlock;
+
+	if (WARN_ON_ONCE(!chip->irq_set_affinity))
+		goto out_unlock;
+
+	if (!zalloc_cpumask_var(&mask, GFP_KERNEL)) {
+		pr_err("failed to allocate memory for cpumask\n");
+		goto out_unlock;
+	}
+
+	cpumask_copy(mask, affinity);
+	cpumask_clear_cpu(cpu, mask);
+	if (cpumask_empty(mask)) {
+		irqd_set(data, IRQD_AFFINITY_SUSPENDED);
+		irq_shutdown(desc);
+	} else {
+		__irq_affinity_set(irq, desc, mask);
+	}
+
+	free_cpumask_var(mask);
+out_unlock:
+	raw_spin_unlock_irqrestore(&desc->lock, flags);
+}
+
+int irq_affinity_offline_cpu(unsigned int cpu)
+{
+	struct irq_desc *desc;
+	unsigned int irq;
+
+	for_each_irq_desc(irq, desc)
+		irq_affinity_offline_irq(irq, desc, cpu);
+	return 0;
+}
+
 static int __init irq_build_cpumap(void)
 {
 	int node, cpu;
-- 
2.11.0
