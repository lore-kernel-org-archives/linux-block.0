Return-Path: <BATV+1f42f42caf748e0126fd+4912+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/6] genirq: allow assigning affinity to present but not online CPUs
Date: Fri,  3 Feb 2017 15:35:55 +0100
Message-Id: <20170203143600.32307-2-hch@lst.de>
In-Reply-To: <20170203143600.32307-1-hch@lst.de>
References: <20170203143600.32307-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This will allow us to spread MSI/MSI-X affinity over all present CPUs and
thus better deal with systems where cpus are take on and offline all the
time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/irq/manage.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 6b669593e7eb..7a1424330f9c 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -354,22 +354,22 @@ static int setup_affinity(struct irq_desc *desc, struct cpumask *mask)
 
 	/*
 	 * Preserve the managed affinity setting and an userspace affinity
-	 * setup, but make sure that one of the targets is online.
+	 * setup, but make sure that one of the targets is present.
 	 */
 	if (irqd_affinity_is_managed(&desc->irq_data) ||
 	    irqd_has_set(&desc->irq_data, IRQD_AFFINITY_SET)) {
 		if (cpumask_intersects(desc->irq_common_data.affinity,
-				       cpu_online_mask))
+				       cpu_present_mask))
 			set = desc->irq_common_data.affinity;
 		else
 			irqd_clear(&desc->irq_data, IRQD_AFFINITY_SET);
 	}
 
-	cpumask_and(mask, cpu_online_mask, set);
+	cpumask_and(mask, cpu_present_mask, set);
 	if (node != NUMA_NO_NODE) {
 		const struct cpumask *nodemask = cpumask_of_node(node);
 
-		/* make sure at least one of the cpus in nodemask is online */
+		/* make sure at least one of the cpus in nodemask is present */
 		if (cpumask_intersects(mask, nodemask))
 			cpumask_and(mask, mask, nodemask);
 	}
-- 
2.11.0
