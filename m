Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail.linuxfoundation.org ([140.211.169.12]:52476 "EHLO
        mail.linuxfoundation.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S935642AbcIEQtq (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 5 Sep 2016 12:49:46 -0400
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
        Bart Van Assche <bart.vanassche@sandisk.com>,
        Christoph Hellwig <hch@lst.de>, linux-block@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org,
        axboe@fb.com, agordeev@redhat.com
Subject: [PATCH 4.7 022/143] genirq/msi: Remove unused MSI_FLAG_IDENTITY_MAP
Date: Mon,  5 Sep 2016 18:43:18 +0200
Message-Id: <20160905164431.560979069@linuxfoundation.org>
In-Reply-To: <20160905164430.593075551@linuxfoundation.org>
References: <20160905164430.593075551@linuxfoundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

4.7-stable review patch.  If anyone has any objections, please let me know.

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
@@ -264,12 +264,10 @@ enum {
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
@@ -324,7 +324,7 @@ int msi_domain_alloc_irqs(struct irq_dom
 	struct msi_domain_ops *ops = info->ops;
 	msi_alloc_info_t arg;
 	struct msi_desc *desc;
-	int i, ret, virq = -1;
+	int i, ret, virq;
 
 	ret = msi_domain_prepare_irqs(domain, dev, nvec, &arg);
 	if (ret)
@@ -332,12 +332,8 @@ int msi_domain_alloc_irqs(struct irq_dom
 
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


