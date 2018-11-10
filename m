Return-Path: <axboe@kernel.dk>
From: Jens Axboe <axboe@kernel.dk>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@kernel.dk>,
	Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org
Subject: [PATCH 1/6] nvme: don't disable local ints for polled queue
Date: Sat, 10 Nov 2018 08:13:12 -0700
Message-Id: <20181110151317.3813-2-axboe@kernel.dk>
In-Reply-To: <20181110151317.3813-1-axboe@kernel.dk>
References: <20181110151317.3813-1-axboe@kernel.dk>
List-ID: <linux-block@vger.kernel.org>

A polled queued doesn't trigger interrupts, so it's always safe
to grab the queue lock without disabling interrupts.

Cc: Keith Busch <keith.busch@intel.com>
Cc: linux-nvme@lists.infradead.org
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/nvme/host/pci.c | 17 ++++++++++++++---
 1 file changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 6aa86dfcb32c..a6e3fbddfadf 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -1061,15 +1061,26 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
 
 static int __nvme_poll(struct nvme_queue *nvmeq, unsigned int tag)
 {
+	unsigned long flags = 0; /* gcc 7.x fail */
 	u16 start, end;
-	bool found;
+	bool found, has_irq;
 
 	if (!nvme_cqe_pending(nvmeq))
 		return 0;
 
-	spin_lock_irq(&nvmeq->cq_lock);
+	/*
+	 * Polled queue doesn't have an IRQ, no need to disable ints
+	 */
+	has_irq = !nvmeq->polled;
+	if (has_irq)
+		local_irq_save(flags);
+
+	spin_lock(&nvmeq->cq_lock);
 	found = nvme_process_cq(nvmeq, &start, &end, tag);
-	spin_unlock_irq(&nvmeq->cq_lock);
+	spin_unlock(&nvmeq->cq_lock);
+
+	if (has_irq)
+		local_irq_restore(flags);
 
 	nvme_complete_cqes(nvmeq, start, end);
 	return found;
-- 
2.17.1
