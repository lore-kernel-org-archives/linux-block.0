Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de,
	axboe@fb.com
Subject: [PATCH 06/13] irq: add a helper spread an affinity mask for MSI/MSI-X
 vectors
Date: Tue, 14 Jun 2016 21:58:59 +0200
Message-Id: <1465934346-20648-7-git-send-email-hch@lst.de>
In-Reply-To: <1465934346-20648-1-git-send-email-hch@lst.de>
References: <1465934346-20648-1-git-send-email-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

This is lifted from the blk-mq code and adopted to use the affinity mask
concept just intruced in the irq handling code.

Signed-off-by: Christoph Hellwig <hch@lst.de>
---
 include/linux/interrupt.h | 11 +++++++++
 kernel/irq/Makefile       |  1 +
 kernel/irq/affinity.c     | 60 +++++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 72 insertions(+)
 create mode 100644 kernel/irq/affinity.c

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 9fcabeb..12003c0 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -278,6 +278,9 @@ extern int irq_set_affinity_hint(unsigned int irq, const struct cpumask *m);
 extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 
+int irq_create_affinity_mask(struct cpumask **affinity_mask,
+		unsigned int *nr_vecs);
+
 #else /* CONFIG_SMP */
 
 static inline int irq_set_affinity(unsigned int irq, const struct cpumask *m)
@@ -308,6 +311,14 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify)
 {
 	return 0;
 }
+
+static inline int irq_create_affinity_mask(struct cpumask **affinity_mask,
+		unsigned int *nr_vecs)
+{
+	*affinity_mask = NULL;
+	*nr_vecs = 1;
+	return 0;
+}
 #endif /* CONFIG_SMP */
 
 /*
diff --git a/kernel/irq/Makefile b/kernel/irq/Makefile
index 2ee42e9..1d3ee31 100644
--- a/kernel/irq/Makefile
+++ b/kernel/irq/Makefile
@@ -9,3 +9,4 @@ obj-$(CONFIG_GENERIC_IRQ_MIGRATION) += cpuhotplug.o
 obj-$(CONFIG_PM_SLEEP) += pm.o
 obj-$(CONFIG_GENERIC_MSI_IRQ) += msi.o
 obj-$(CONFIG_GENERIC_IRQ_IPI) += ipi.o
+obj-$(CONFIG_SMP) += affinity.o
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
new file mode 100644
index 0000000..1daf8fb
--- /dev/null
+++ b/kernel/irq/affinity.c
@@ -0,0 +1,60 @@
+
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/slab.h>
+#include <linux/cpu.h>
+
+static int get_first_sibling(unsigned int cpu)
+{
+	unsigned int ret;
+
+	ret = cpumask_first(topology_sibling_cpumask(cpu));
+	if (ret < nr_cpu_ids)
+		return ret;
+	return cpu;
+}
+
+/*
+ * Take a map of online CPUs and the number of available interrupt vectors
+ * and generate an output cpumask suitable for spreading MSI/MSI-X vectors
+ * so that they are distributed as good as possible around the CPUs.  If
+ * more vectors than CPUs are available we'll map one to each CPU,
+ * otherwise we map one to the first sibling of each socket.
+ *
+ * If there are more vectors than CPUs we will still only have one bit
+ * set per CPU, but interrupt code will keep on assining the vectors from
+ * the start of the bitmap until we run out of vectors.
+ */
+int irq_create_affinity_mask(struct cpumask **affinity_mask,
+		unsigned int *nr_vecs)
+{
+	unsigned int vecs = 0;
+
+	if (*nr_vecs == 1) {
+		*affinity_mask = NULL;
+		return 0;
+	}
+
+	*affinity_mask = kzalloc(cpumask_size(), GFP_KERNEL);
+	if (!*affinity_mask)
+		return -ENOMEM;
+
+	if (*nr_vecs >= num_online_cpus()) {
+		cpumask_copy(*affinity_mask, cpu_online_mask);
+	} else {
+		unsigned int cpu;
+
+		for_each_online_cpu(cpu) {
+			if (cpu == get_first_sibling(cpu)) {
+				cpumask_set_cpu(cpu, *affinity_mask);
+				vecs++;
+			}
+
+			if (--(*nr_vecs) == 0)
+				break;
+		}
+	}
+
+	*nr_vecs = vecs;
+	return 0;
+}
-- 
2.1.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
