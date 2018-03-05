Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@infradead.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	linux-kernel@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Laurence Oberman <loberman@redhat.com>,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>
Subject: [PATCH V2 2/5] genirq/affinity: mark 'node_to_cpumask' as const for get_nodes_in_cpumask()
Date: Mon,  5 Mar 2018 11:13:54 +0800
Message-Id: <20180305031357.23950-3-ming.lei@redhat.com>
In-Reply-To: <20180305031357.23950-1-ming.lei@redhat.com>
References: <20180305031357.23950-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Inside irq_create_affinity_masks(), once 'node_to_cpumask' is created,
it is accessed read-only, so mark it as const for
get_nodes_in_cpumask().

Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 4b1c4763212d..9f49d6ef0dc8 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -79,7 +79,7 @@ static void build_node_to_cpumask(cpumask_var_t *masks)
 		cpumask_set_cpu(cpu, masks[cpu_to_node(cpu)]);
 }
 
-static int get_nodes_in_cpumask(cpumask_var_t *node_to_cpumask,
+static int get_nodes_in_cpumask(const cpumask_var_t *node_to_cpumask,
 				const struct cpumask *mask, nodemask_t *nodemsk)
 {
 	int n, nodes = 0;
-- 
2.9.5
