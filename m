Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de,
	axboe@fb.com
Subject: [PATCH 02/13] irq: Introduce IRQD_AFFINITY_MANAGED flag
Date: Mon,  4 Jul 2016 17:39:23 +0900
Message-Id: <1467621574-8277-3-git-send-email-hch@lst.de>
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

Interupts marked with this flag are excluded from user space interrupt
affinity changes. Contrary to the IRQ_NO_BALANCING flag, the kernel internal
affinity mechanism is not blocked.

This flag will be used for multi-queue device interrupts.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/irq.h    |  7 +++++++
 kernel/irq/internals.h |  2 ++
 kernel/irq/manage.c    | 21 ++++++++++++++++++---
 kernel/irq/proc.c      |  2 +-
 4 files changed, 28 insertions(+), 4 deletions(-)

diff --git a/include/linux/irq.h b/include/linux/irq.h
index 4d758a7..f607481 100644
--- a/include/linux/irq.h
+++ b/include/linux/irq.h
@@ -197,6 +197,7 @@ struct irq_data {
  * IRQD_IRQ_INPROGRESS		- In progress state of the interrupt
  * IRQD_WAKEUP_ARMED		- Wakeup mode armed
  * IRQD_FORWARDED_TO_VCPU	- The interrupt is forwarded to a VCPU
+ * IRQD_AFFINITY_MANAGED	- Affinity is auto-managed by the kernel
  */
 enum {
 	IRQD_TRIGGER_MASK		= 0xf,
@@ -212,6 +213,7 @@ enum {
 	IRQD_IRQ_INPROGRESS		= (1 << 18),
 	IRQD_WAKEUP_ARMED		= (1 << 19),
 	IRQD_FORWARDED_TO_VCPU		= (1 << 20),
+	IRQD_AFFINITY_MANAGED		= (1 << 21),
 };
 
 #define __irqd_to_state(d) ACCESS_PRIVATE((d)->common, state_use_accessors)
@@ -305,6 +307,11 @@ static inline void irqd_clr_forwarded_to_vcpu(struct irq_data *d)
 	__irqd_to_state(d) &= ~IRQD_FORWARDED_TO_VCPU;
 }
 
+static inline bool irqd_affinity_is_managed(struct irq_data *d)
+{
+	return __irqd_to_state(d) & IRQD_AFFINITY_MANAGED;
+}
+
 #undef __irqd_to_state
 
 static inline irq_hw_number_t irqd_to_hwirq(struct irq_data *d)
diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index 09be2c9..b15aa3b 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -105,6 +105,8 @@ static inline void unregister_handler_proc(unsigned int irq,
 					   struct irqaction *action) { }
 #endif
 
+extern bool irq_can_set_affinity_usr(unsigned int irq);
+
 extern int irq_select_affinity_usr(unsigned int irq, struct cpumask *mask);
 
 extern void irq_set_thread_affinity(struct irq_desc *desc);
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index ef0bc02..30658e9 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -115,12 +115,12 @@ EXPORT_SYMBOL(synchronize_irq);
 #ifdef CONFIG_SMP
 cpumask_var_t irq_default_affinity;
 
-static int __irq_can_set_affinity(struct irq_desc *desc)
+static bool __irq_can_set_affinity(struct irq_desc *desc)
 {
 	if (!desc || !irqd_can_balance(&desc->irq_data) ||
 	    !desc->irq_data.chip || !desc->irq_data.chip->irq_set_affinity)
-		return 0;
-	return 1;
+		return false;
+	return true;
 }
 
 /**
@@ -134,6 +134,21 @@ int irq_can_set_affinity(unsigned int irq)
 }
 
 /**
+ * irq_can_set_affinity_usr - Check if affinity of a irq can be set from user space
+ * @irq:	Interrupt to check
+ *
+ * Like irq_can_set_affinity() above, but additionally checks for the
+ * AFFINITY_MANAGED flag.
+ */
+bool irq_can_set_affinity_usr(unsigned int irq)
+{
+	struct irq_desc *desc = irq_to_desc(irq);
+
+	return __irq_can_set_affinity(desc) &&
+		!irqd_affinity_is_managed(&desc->irq_data);
+}
+
+/**
  *	irq_set_thread_affinity - Notify irq threads to adjust affinity
  *	@desc:		irq descriptor which has affitnity changed
  *
diff --git a/kernel/irq/proc.c b/kernel/irq/proc.c
index 4e1b947..40bdcdc 100644
--- a/kernel/irq/proc.c
+++ b/kernel/irq/proc.c
@@ -96,7 +96,7 @@ static ssize_t write_irq_affinity(int type, struct file *file,
 	cpumask_var_t new_value;
 	int err;
 
-	if (!irq_can_set_affinity(irq) || no_irq_affinity)
+	if (!irq_can_set_affinity_usr(irq) || no_irq_affinity)
 		return -EIO;
 
 	if (!alloc_cpumask_var(&new_value, GFP_KERNEL))
-- 
2.1.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
