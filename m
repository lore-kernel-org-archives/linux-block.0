Return-Path: <BATV+4a135d35f30012caeec5+5032+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 3/8] genirq/affinity: factor out a irq_affinity_set helper
Date: Sat,  3 Jun 2017 16:03:58 +0200
Message-Id: <20170603140403.27379-4-hch@lst.de>
In-Reply-To: <20170603140403.27379-1-hch@lst.de>
References: <20170603140403.27379-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

Factor out code from the x86 cpu hot plug code to program the affinity
for a vector for a hot plug / hot unplug event.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 arch/x86/kernel/irq.c     | 23 ++---------------------
 include/linux/interrupt.h |  1 +
 kernel/irq/affinity.c     | 28 ++++++++++++++++++++++++++++
 3 files changed, 31 insertions(+), 21 deletions(-)

diff --git a/arch/x86/kernel/irq.c b/arch/x86/kernel/irq.c
index f34fe7444836..a54eac5d81b3 100644
--- a/arch/x86/kernel/irq.c
+++ b/arch/x86/kernel/irq.c
@@ -437,7 +437,6 @@ void fixup_irqs(void)
 	struct irq_desc *desc;
 	struct irq_data *data;
 	struct irq_chip *chip;
-	int ret;
 
 	for_each_irq_desc(irq, desc) {
 		int break_affinity = 0;
@@ -482,26 +481,8 @@ void fixup_irqs(void)
 			continue;
 		}
 
-		if (!irqd_can_move_in_process_context(data) && chip->irq_mask)
-			chip->irq_mask(data);
-
-		if (chip->irq_set_affinity) {
-			ret = chip->irq_set_affinity(data, affinity, true);
-			if (ret == -ENOSPC)
-				pr_crit("IRQ %d set affinity failed because there are no available vectors.  The device assigned to this IRQ is unstable.\n", irq);
-		} else {
-			if (!(warned++))
-				set_affinity = 0;
-		}
-
-		/*
-		 * We unmask if the irq was not marked masked by the
-		 * core code. That respects the lazy irq disable
-		 * behaviour.
-		 */
-		if (!irqd_can_move_in_process_context(data) &&
-		    !irqd_irq_masked(data) && chip->irq_unmask)
-			chip->irq_unmask(data);
+		if (!irq_affinity_set(irq, desc, affinity) && !warned++)
+			set_affinity = 0;
 
 		raw_spin_unlock(&desc->lock);
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index a6fba4804672..afd3aa33e9b0 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -292,6 +292,7 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 
 struct cpumask *irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
 int irq_calc_affinity_vectors(int maxvec, const struct irq_affinity *affd);
+bool irq_affinity_set(int irq, struct irq_desc *desc, const cpumask_t *mask);
 
 #else /* CONFIG_SMP */
 
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index e2d356dd7581..3cec0042fad2 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -1,8 +1,36 @@
 
 #include <linux/interrupt.h>
+#include <linux/irq.h>
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/cpu.h>
+#include "internals.h"
+
+bool irq_affinity_set(int irq, struct irq_desc *desc, const cpumask_t *mask)
+{
+	struct irq_data *data = irq_desc_get_irq_data(desc);
+	struct irq_chip *chip = irq_data_get_irq_chip(data);
+	bool ret = false;
+
+	if (!irq_can_move_pcntxt(data) && chip->irq_mask)
+		chip->irq_mask(data);
+
+	if (chip->irq_set_affinity) {
+		if (chip->irq_set_affinity(data, mask, true) == -ENOSPC)
+			pr_crit("IRQ %d set affinity failed because there are no available vectors.  The device assigned to this IRQ is unstable.\n", irq);
+		ret = true;
+	}
+
+	/*
+	 * We unmask if the irq was not marked masked by the core code.
+	 * That respects the lazy irq disable behaviour.
+	 */
+	if (!irq_can_move_pcntxt(data) &&
+	    !irqd_irq_masked(data) && chip->irq_unmask)
+		chip->irq_unmask(data);
+
+	return ret;
+}
 
 static void irq_spread_init_one(struct cpumask *irqmsk, struct cpumask *nmsk,
 				int cpus_per_vec)
-- 
2.11.0
