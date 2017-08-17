Return-Path: <axboe@kernel.dk>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Cc: "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>,
 Keith Busch <keith.busch@intel.com>, Christoph Hellwig <hch@infradead.org>
From: Jens Axboe <axboe@kernel.dk>
Subject: [RFC PATCH] nvme: always return IRQ_HANDLED
Message-ID: <06b85884-efb4-e419-4b31-3aa4751bb338@kernel.dk>
Date: Thu, 17 Aug 2017 13:32:20 -0600
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-ID: <linux-block@vger.kernel.org>

We currently have an issue with nvme when polling is used. Just
ran some testing on 4.13-rc5, and it's trivial to trigger an IRQ
disable ala:

[   52.412851] irq 77: nobody cared (try booting with the "irqpoll" option)
[   52.415310] irq 70: nobody cared (try booting with the "irqpoll" option)

when running a few processes polling. The reason is pretty obvious - if
we're effective at polling, the triggered IRQ will never find any
events. If this happens enough times in a row, the kernel disables our
IRQ since we keep returning IRQ_NONE.

Question is, what's the best way to solve this. Ideally we should not be
triggering an IRQ at all, but that's still not in mainline. Can we
safely just return IRQ_HANDLED always? That should work except for the
case where we happen to run into an IRQ flood where DO want to turn off
the nvme irq. For now, I think that's small price to pay, since the
current issue is much worse and leaves the device in a weird non-working
state where some queue interrupts are turned off.

Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 74a124a06264..21a35faff86f 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -160,7 +160,6 @@ struct nvme_queue {
 	u16 cq_head;
 	u16 qid;
 	u8 cq_phase;
-	u8 cqe_seen;
 	u32 *dbbuf_sq_db;
 	u32 *dbbuf_cq_db;
 	u32 *dbbuf_sq_ei;
@@ -830,22 +829,19 @@ static void nvme_process_cq(struct nvme_queue *nvmeq)
 		consumed++;
 	}
 
-	if (consumed) {
+	if (consumed)
 		nvme_ring_cq_doorbell(nvmeq);
-		nvmeq->cqe_seen = 1;
-	}
 }
 
 static irqreturn_t nvme_irq(int irq, void *data)
 {
-	irqreturn_t result;
 	struct nvme_queue *nvmeq = data;
+
 	spin_lock(&nvmeq->q_lock);
 	nvme_process_cq(nvmeq);
-	result = nvmeq->cqe_seen ? IRQ_HANDLED : IRQ_NONE;
-	nvmeq->cqe_seen = 0;
 	spin_unlock(&nvmeq->q_lock);
-	return result;
+
+	return IRQ_HANDLED;
 }
 
 static irqreturn_t nvme_irq_check(int irq, void *data)

-- 
Jens Axboe
