Return-Path: <linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org>
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4.4 027/113] genirq/msi: Remove unused MSI_FLAG_IDENTITY_MAP
Date: Mon,  5 Sep 2016 18:43:50 +0200
Message-Id: <20160905164350.396981651@linuxfoundation.org>
In-Reply-To: <20160905164349.217621339@linuxfoundation.org>
References: <20160905164349.217621339@linuxfoundation.org>
MIME-Version: 1.0
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: axboe@fb.com, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 stable@vger.kernel.org, linux-block@vger.kernel.org, agordeev@redhat.com,
 linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
 Bart Van Assche <bart.vanassche@sandisk.com>,
 Thomas Gleixner <tglx@linutronix.de>, Christoph Hellwig <hch@lst.de>
Content-Type: text/plain; charset="us-ascii"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+axboe=kernel.dk@lists.infradead.org
List-ID: <linux-block@vger.kernel.org>

4.4-stable review patch.  If anyone has any objections, please let me know.

------------------

From: Thomas Gleixner <tglx@linutronix.de>

commit b6140914fd079e43ea75a53429b47128584f033a upstream.

No user and we definitely don't want to grow one.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Reviewed-by: Bart Van Assche <bart.vanassche@sandisk.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: linux-block@vger.kernel.org
Cc: linux-pci@vger.kernel.org
Cc: linux-nvme@lists.infradead.org
Cc: axboe@fb.com
Cc: agordeev@redhat.com
Link: http://lkml.kernel.org/r/1467621574-8277-2-git-send-email-hch@lst.de
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
 include/linux/msi.h |    6 ++----
 kernel/irq/msi.c    |    8 ++------
 2 files changed, 4 insertions(+), 10 deletions(-)

--- a/include/linux/msi.h
+++ b/include/linux/msi.h
@@ -254,12 +254,10 @@ enum {
 	 * callbacks.
 	 */
 	MSI_FLAG_USE_DEF_CHIP_OPS	= (1 << 1),
-	/* Build identity map between hwirq and irq */
-	MSI_FLAG_IDENTITY_MAP		= (1 << 2),
 	/* Support multiple PCI MSI interrupts */
-	MSI_FLAG_MULTI_PCI_MSI		= (1 << 3),
+	MSI_FLAG_MULTI_PCI_MSI		= (1 << 2),
 	/* Support PCI MSIX interrupts */
-	MSI_FLAG_PCI_MSIX		= (1 << 4),
+	MSI_FLAG_PCI_MSIX		= (1 << 3),
 };
 
 int msi_domain_set_affinity(struct irq_data *data, const struct cpumask *mask,
--- a/kernel/irq/msi.c
+++ b/kernel/irq/msi.c
@@ -268,7 +268,7 @@ int msi_domain_alloc_irqs(struct irq_dom
 	struct msi_domain_ops *ops = info->ops;
 	msi_alloc_info_t arg;
 	struct msi_desc *desc;
-	int i, ret, virq = -1;
+	int i, ret, virq;
 
 	ret = ops->msi_check(domain, info, dev);
 	if (ret == 0)
@@ -278,12 +278,8 @@ int msi_domain_alloc_irqs(struct irq_dom
 
 	for_each_msi_entry(desc, dev) {
 		ops->set_desc(&arg, desc);
-		if (info->flags & MSI_FLAG_IDENTITY_MAP)
-			virq = (int)ops->get_hwirq(info, &arg);
-		else
-			virq = -1;
 
-		virq = __irq_domain_alloc_irqs(domain, virq, desc->nvec_used,
+		virq = __irq_domain_alloc_irqs(domain, -1, desc->nvec_used,
 					       dev_to_node(dev), &arg, false);
 		if (virq < 0) {
 			ret = -ENOSPC;



_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
