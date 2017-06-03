Return-Path: <BATV+4a135d35f30012caeec5+5032+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/8] genirq: move pending helpers to internal.h
Date: Sat,  3 Jun 2017 16:03:57 +0200
Message-Id: <20170603140403.27379-3-hch@lst.de>
In-Reply-To: <20170603140403.27379-1-hch@lst.de>
References: <20170603140403.27379-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

So that the affinity code can reuse them.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/irq/internals.h | 38 ++++++++++++++++++++++++++++++++++++++
 kernel/irq/manage.c    | 28 ----------------------------
 2 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/kernel/irq/internals.h b/kernel/irq/internals.h
index bc226e783bd2..b81f6ce73a68 100644
--- a/kernel/irq/internals.h
+++ b/kernel/irq/internals.h
@@ -226,3 +226,41 @@ irq_pm_install_action(struct irq_desc *desc, struct irqaction *action) { }
 static inline void
 irq_pm_remove_action(struct irq_desc *desc, struct irqaction *action) { }
 #endif
+
+#ifdef CONFIG_GENERIC_PENDING_IRQ
+static inline bool irq_can_move_pcntxt(struct irq_data *data)
+{
+	return irqd_can_move_in_process_context(data);
+}
+static inline bool irq_move_pending(struct irq_data *data)
+{
+	return irqd_is_setaffinity_pending(data);
+}
+static inline void
+irq_copy_pending(struct irq_desc *desc, const struct cpumask *mask)
+{
+	cpumask_copy(desc->pending_mask, mask);
+}
+static inline void
+irq_get_pending(struct cpumask *mask, struct irq_desc *desc)
+{
+	cpumask_copy(mask, desc->pending_mask);
+}
+#else /* CONFIG_GENERIC_PENDING_IRQ */
+static inline bool irq_can_move_pcntxt(struct irq_data *data)
+{
+	return true;
+}
+static inline bool irq_move_pending(struct irq_data *data)
+{
+	return false;
+}
+static inline void
+irq_copy_pending(struct irq_desc *desc, const struct cpumask *mask)
+{
+}
+static inline void
+irq_get_pending(struct cpumask *mask, struct irq_desc *desc)
+{
+}
+#endif /* CONFIG_GENERIC_PENDING_IRQ */
diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 5c25d4a5dc46..5fa334e5c046 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -168,34 +168,6 @@ void irq_set_thread_affinity(struct irq_desc *desc)
 			set_bit(IRQTF_AFFINITY, &action->thread_flags);
 }
 
-#ifdef CONFIG_GENERIC_PENDING_IRQ
-static inline bool irq_can_move_pcntxt(struct irq_data *data)
-{
-	return irqd_can_move_in_process_context(data);
-}
-static inline bool irq_move_pending(struct irq_data *data)
-{
-	return irqd_is_setaffinity_pending(data);
-}
-static inline void
-irq_copy_pending(struct irq_desc *desc, const struct cpumask *mask)
-{
-	cpumask_copy(desc->pending_mask, mask);
-}
-static inline void
-irq_get_pending(struct cpumask *mask, struct irq_desc *desc)
-{
-	cpumask_copy(mask, desc->pending_mask);
-}
-#else
-static inline bool irq_can_move_pcntxt(struct irq_data *data) { return true; }
-static inline bool irq_move_pending(struct irq_data *data) { return false; }
-static inline void
-irq_copy_pending(struct irq_desc *desc, const struct cpumask *mask) { }
-static inline void
-irq_get_pending(struct cpumask *mask, struct irq_desc *desc) { }
-#endif
-
 int irq_do_set_affinity(struct irq_data *data, const struct cpumask *mask,
 			bool force)
 {
-- 
2.11.0
