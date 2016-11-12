Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 3/3] irq-poll: Reduce local_irq_save/restore operations in irq_poll_softirq
Date: Sun, 13 Nov 2016 01:02:35 +0200
Message-Id: <1478991755-28153-4-git-send-email-sagi@grimberg.me>
In-Reply-To: <1478991755-28153-1-git-send-email-sagi@grimberg.me>
References: <1478991755-28153-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

splice to a local list (and splice back when done) so we won't
need to enable/disable local_irq in each iteration.

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 lib/irq_poll.c | 31 ++++++++++++++++---------------
 1 file changed, 16 insertions(+), 15 deletions(-)

diff --git a/lib/irq_poll.c b/lib/irq_poll.c
index 44a5d1da4260..dc4c7ace9b41 100644
--- a/lib/irq_poll.c
+++ b/lib/irq_poll.c
@@ -75,13 +75,16 @@ EXPORT_SYMBOL(irq_poll_complete);
 
 static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
 {
-	struct list_head *list = this_cpu_ptr(&blk_cpu_iopoll);
+	struct list_head *iop_list = this_cpu_ptr(&blk_cpu_iopoll);
 	int rearm = 0, budget = irq_poll_budget;
 	unsigned long start_time = jiffies;
+	LIST_HEAD(list);
 
 	local_irq_disable();
+	list_splice_init(iop_list, &list);
+	local_irq_enable();
 
-	while (!list_empty(list)) {
+	while (!list_empty(&list)) {
 		struct irq_poll *iop;
 		int work, weight;
 
@@ -93,14 +96,7 @@ static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
 			break;
 		}
 
-		local_irq_enable();
-
-		/* Even though interrupts have been re-enabled, this
-		 * access is safe because interrupts can only add new
-		 * entries to the tail of this list, and only ->poll()
-		 * calls can remove this head entry from the list.
-		 */
-		iop = list_entry(list->next, struct irq_poll, list);
+		iop = list_first_entry(&list, struct irq_poll, list);
 
 		weight = iop->weight;
 		work = 0;
@@ -109,8 +105,6 @@ static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
 
 		budget -= work;
 
-		local_irq_disable();
-
 		/*
 		 * Drivers must not modify the iopoll state, if they
 		 * consume their assigned weight (or more, some drivers can't
@@ -120,13 +114,20 @@ static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
 		 * move the instance around on the list at-will.
 		 */
 		if (work >= weight) {
-			if (unlikely(test_bit(IRQ_POLL_F_DISABLE, &iop->state)))
+			if (unlikely(test_bit(IRQ_POLL_F_DISABLE, &iop->state))) {
+				local_irq_disable();
 				__irq_poll_complete(iop);
-			else
-				list_move_tail(&iop->list, list);
+				local_irq_enable();
+			} else {
+				list_move_tail(&iop->list, &list);
+			}
 		}
 	}
 
+	local_irq_disable();
+	list_splice_tail_init(iop_list, &list);
+	list_splice(&list, iop_list);
+
 	if (rearm)
 		__raise_softirq_irqoff(IRQ_POLL_SOFTIRQ);
 
-- 
2.7.4
