Return-Path: <BATV+4a135d35f30012caeec5+5032+infradead.org+hch@bombadil.srs.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: Thomas Gleixner <tglx@linutronix.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 1/8] genirq: allow assigning affinity to present but not online CPUs
Date: Sat,  3 Jun 2017 16:03:56 +0200
Message-Id: <20170603140403.27379-2-hch@lst.de>
In-Reply-To: <20170603140403.27379-1-hch@lst.de>
References: <20170603140403.27379-1-hch@lst.de>
List-ID: <linux-block@vger.kernel.org>

This will allow us to spread MSI/MSI-X affinity over all present CPUs and
thus better deal with systems where cpus are take on and offline all the
time.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 kernel/irq/manage.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/kernel/irq/manage.c b/kernel/irq/manage.c
index 070be980c37a..5c25d4a5dc46 100644
--- a/kernel/irq/manage.c
+++ b/kernel/irq/manage.c
@@ -361,17 +361,17 @@ static int setup_affinity(struct irq_desc *desc, struct cpumask *mask)
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
