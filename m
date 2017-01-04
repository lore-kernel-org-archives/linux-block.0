Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Jens Axboe <axboe@kernel.dk>,
	Jens Axboe <axboe@fb.com>,
	Christoph Hellwig <hch@lst.de>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: Marc Merlin <marc@merlins.org>,
	Keith Busch <keith.busch@intel.com>
Subject: [PATCH 2/6] irq/affinity: Assign offline CPUs a vector
Date: Wed,  4 Jan 2017 17:41:07 -0500
Message-Id: <1483569671-1462-3-git-send-email-keith.busch@intel.com>
In-Reply-To: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
References: <1483569671-1462-1-git-send-email-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

The offline CPUs need to assigned to something incase they come online
later, otherwise anyone using the mapping for things other than affinity
will have blank entries for that online CPU.

Signed-off-by: Keith Busch <keith.busch@intel.com>
---
 kernel/irq/affinity.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index b25dce0..2367531 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -129,6 +129,14 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	}
 
 done:
+	/*
+	 * Assign offline CPUs to first mask in case they come online later. A
+	 * driver can rerun this from a cpu notifier if they want a more optimal
+	 * spread.
+	 */
+	cpumask_andnot(nmsk, cpu_possible_mask, cpu_online_mask);
+	irq_spread_init_one(masks, nmsk, cpumask_weight(nmsk));
+
 	put_online_cpus();
 
 	/* Fill out vectors at the end that don't need affinity */
-- 
2.5.5
