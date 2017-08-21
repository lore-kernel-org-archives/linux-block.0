Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43688 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753222AbdHUNtz (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Mon, 21 Aug 2017 09:49:55 -0400
From: Laurent Vivier <lvivier@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Tejun Heo <tj@kernel.org>, linux-block@vger.kernel.org,
        Jens Axboe <axboe@kernel.dk>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/workqueue: update list of possible CPUs
Date: Mon, 21 Aug 2017 15:49:50 +0200
Message-Id: <20170821134951.18848-1-lvivier@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

In wq_numa_init() a list of NUMA nodes with their list of possible CPUs
is built.

Unfortunately, on powerpc, the Firmware is only able to provide the
node of a CPU if the CPU is present. So, in our case (possible CPU)
CPU ids are known, but as the CPU is not present, the node id is
unknown and all the unplugged CPUs are attached to node 0.

When we hotplugged CPU, there can be an inconsistency between
the node id known by the workqueue, and the real node id of
the CPU.

This patch adds a hotplug handler to add the hotplugged CPU to
update the node entry in wq_numa_possible_cpumask array.

Signed-off-by: Laurent Vivier <lvivier@redhat.com>
---
 arch/powerpc/kernel/smp.c |  1 +
 include/linux/workqueue.h |  1 +
 kernel/workqueue.c        | 21 +++++++++++++++++++++
 3 files changed, 23 insertions(+)

diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index 8d3320562c70..abc533146514 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -964,6 +964,7 @@ void start_secondary(void *unused)
 
 	set_numa_node(numa_cpu_lookup_table[cpu]);
 	set_numa_mem(local_memory_node(numa_cpu_lookup_table[cpu]));
+	wq_numa_add_possible_cpu(cpu);
 
 	smp_wmb();
 	notify_cpu_starting(cpu);
diff --git a/include/linux/workqueue.h b/include/linux/workqueue.h
index db6dc9dc0482..4ef030dae22c 100644
--- a/include/linux/workqueue.h
+++ b/include/linux/workqueue.h
@@ -644,6 +644,7 @@ int workqueue_online_cpu(unsigned int cpu);
 int workqueue_offline_cpu(unsigned int cpu);
 #endif
 
+void wq_numa_add_possible_cpu(unsigned int cpu);
 int __init workqueue_init_early(void);
 int __init workqueue_init(void);
 
diff --git a/kernel/workqueue.c b/kernel/workqueue.c
index ca937b0c3a96..d1a99e25d5da 100644
--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c
@@ -5486,6 +5486,27 @@ static inline void wq_watchdog_init(void) { }
 
 #endif	/* CONFIG_WQ_WATCHDOG */
 
+void wq_numa_add_possible_cpu(unsigned int cpu)
+{
+	int node;
+
+	if (num_possible_nodes() <= 1)
+		return;
+
+	if (wq_disable_numa)
+		return;
+
+	if (!wq_numa_enabled)
+		return;
+
+	node = cpu_to_node(cpu);
+	if (node == NUMA_NO_NODE)
+		return;
+
+	cpumask_set_cpu(cpu, wq_numa_possible_cpumask[node]);
+}
+EXPORT_SYMBOL_GPL(wq_numa_add_possible_cpu);
+
 static void __init wq_numa_init(void)
 {
 	cpumask_var_t *tbl;
-- 
2.13.5
