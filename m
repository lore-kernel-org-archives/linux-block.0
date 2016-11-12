Return-Path: <sagi@grimberg.me>
From: Sagi Grimberg <sagi@grimberg.me>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@lst.de>
Subject: [PATCH 2/3] irq-poll: micro optimize some branch predictions
Date: Sun, 13 Nov 2016 01:02:34 +0200
Message-Id: <1478991755-28153-3-git-send-email-sagi@grimberg.me>
In-Reply-To: <1478991755-28153-1-git-send-email-sagi@grimberg.me>
References: <1478991755-28153-1-git-send-email-sagi@grimberg.me>
List-ID: <linux-block@vger.kernel.org>

Signed-off-by: Sagi Grimberg <sagi@grimberg.me>
---
 lib/irq_poll.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/lib/irq_poll.c b/lib/irq_poll.c
index 22d033e6ded2..44a5d1da4260 100644
--- a/lib/irq_poll.c
+++ b/lib/irq_poll.c
@@ -26,9 +26,9 @@ void irq_poll_sched(struct irq_poll *iop)
 {
 	unsigned long flags;
 
-	if (test_bit(IRQ_POLL_F_DISABLE, &iop->state))
+	if (unlikely(test_bit(IRQ_POLL_F_DISABLE, &iop->state)))
 		return;
-	if (test_and_set_bit(IRQ_POLL_F_SCHED, &iop->state))
+	if (likely(test_and_set_bit(IRQ_POLL_F_SCHED, &iop->state)))
 		return;
 
 	local_irq_save(flags);
@@ -120,7 +120,7 @@ static void __latent_entropy irq_poll_softirq(struct softirq_action *h)
 		 * move the instance around on the list at-will.
 		 */
 		if (work >= weight) {
-			if (test_bit(IRQ_POLL_F_DISABLE, &iop->state))
+			if (unlikely(test_bit(IRQ_POLL_F_DISABLE, &iop->state)))
 				__irq_poll_complete(iop);
 			else
 				list_move_tail(&iop->list, list);
-- 
2.7.4
