Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Christoph Hellwig <hch@lst.de>
To: tglx@linutronix.de,
	axboe@fb.com
Subject: [PATCH 05/13] irq/msi: Make use of affinity aware allocations
Date: Mon,  4 Jul 2016 17:39:26 +0900
Message-Id: <1467621574-8277-6-git-send-email-hch@lst.de>
In-Reply-To: <1467621574-8277-1-git-send-email-hch@lst.de>
References: <1467621574-8277-1-git-send-email-hch@lst.de>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: linux-block@vger.kernel.org, linux-pci@vger.kernel.org, agordeev@redhat.com,
 linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

From: Thomas Gleixner <tglx@linutronix.de>

Allow the MSI code to provide affinity hints per MSI descriptor.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/msi.h | 2 ++
 kernel/irq/msi.c    | 2 +-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/include/linux/msi.h b/include/linux/msi.h
index c33abfa..4f0bfe5 100644
--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -47,6 +47,7 @@ struct fsl_mc_msi_desc {
  * @nvec_used:	The number of vectors used
  * @dev:	Pointer to the device which uses this descriptor
  * @msg:	The last set MSI message cached for reuse
+ * @affinity:	Optional pointer to a cpu affinity mask for this descriptor
  *
  * @masked:	[PCI MSI/X] Mask bits
  * @is_msix:	[PCI MSI/X] True if MSI-X
@@ -67,6 +68,7 @@ struct msi_desc {
 	unsigned int			nvec_used;
 	struct device			*dev;
 	struct msi_msg			msg;
+	const struct cpumask		*affinity;
 
 	union {
 		/* PCI MSI/X specific data */
diff --git a/kernel/irq/msi.c b/kernel/irq/msi.c
index 58dbbac..0e2a736 100644
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -335,7 +335,7 @@ int msi_domain_alloc_irqs(struct irq_domain *domain, struct device *dev,
 
 		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
 					       dev_to_node(dev), &arg, false,
-					       NULL);
+					       desc->affinity);
 		if (virq < 0) {
 			ret = -ENOSPC;
 			if (ops->handle_error)
-- 
2.1.4


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
