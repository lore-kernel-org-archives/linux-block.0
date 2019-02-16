Return-Path: <SRS0=0P76=QX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6C0AC4360F
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 17:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BC17222D0
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 17:26:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732083AbfBPR0R (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Feb 2019 12:26:17 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54756 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732063AbfBPR0P (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Feb 2019 12:26:15 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gv3ii-0001il-V7; Sat, 16 Feb 2019 18:25:45 +0100
Message-Id: <20190216172228.512444498@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 16 Feb 2019 18:13:09 +0100
From:   Thomas Gleixner <tglx@linutronix.de>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        Keith Busch <keith.busch@intel.com>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Sumit Saxena <sumit.saxena@broadcom.com>,
        Kashyap Desai <kashyap.desai@broadcom.com>,
        Shivasharan Srikanteshwara 
        <shivasharan.srikanteshwara@broadcom.com>
Subject: [patch v6 3/7] genirq/affinity: Add new callback for (re)calculating
 interrupt sets
References: <20190216171306.403545970@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

The interrupt affinity spreading mechanism supports to spread out
affinities for one or more interrupt sets. A interrupt set contains one or
more interrupts. Each set is mapped to a specific functionality of a
device, e.g. general I/O queues and read I/O queus of multiqueue block
devices.

The number of interrupts per set is defined by the driver. It depends on
the total number of available interrupts for the device, which is
determined by the PCI capabilites and the availability of underlying CPU
resources, and the number of queues which the device provides and the
driver wants to instantiate.

The driver passes initial configuration for the interrupt allocation via a
pointer to struct irq_affinity.

Right now the allocation mechanism is complex as it requires to have a loop
in the driver to determine the maximum number of interrupts which are
provided by the PCI capabilities and the underlying CPU resources.  This
loop would have to be replicated in every driver which wants to utilize
this mechanism. That's unwanted code duplication and error prone.

In order to move this into generic facilities it is required to have a
mechanism, which allows the recalculation of the interrupt sets and their
size, in the core code. As the core code does not have any knowledge about the
underlying device, a driver specific callback is required in struct
irq_affinity, which can be invoked by the core code. The callback gets the
number of available interupts as an argument, so the driver can calculate the
corresponding number and size of interrupt sets.

At the moment the struct irq_affinity pointer which is handed in from the
driver and passed through to several core functions is marked 'const', but for
the callback to be able to modify the data in the struct it's required to
remove the 'const' qualifier.

Add the optional callback to struct irq_affinity, which allows drivers to
recalculate the number and size of interrupt sets and remove the 'const'
qualifier.

For simple invocations, which do not supply a callback, a default callback
is installed, which just sets nr_sets to 1 and transfers the number of
spreadable vectors to the set_size array at index 0.

This is for now guarded by a check for nr_sets != 0 to keep the NVME driver
working until it is converted to the callback mechanism.

To make sure that the driver configuration is correct under all circumstances
the callback is invoked even when there are no interrupts for queues left,
i.e. the pre/post requirements already exhaust the numner of available
interrupts.

At the PCI layer irq_create_affinity_masks() has to be invoked even for the
case where the legacy interrupt is used. That ensures that the callback is
invoked and the device driver can adjust to that situation.

[ tglx: Fixed the simple case (no sets required). Moved the sanity check
  	for nr_sets after the invocation of the callback so it catches
  	broken drivers. Fixed the kernel doc comments for struct
  	irq_affinity and de-'This patch'-ed the changelog ]

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/pci/msi.c               |   25 ++++++++++------
 drivers/scsi/be2iscsi/be_main.c |    2 -
 include/linux/interrupt.h       |   10 +++++-
 include/linux/pci.h             |    4 +-
 kernel/irq/affinity.c           |   62 ++++++++++++++++++++++++++++------------
 5 files changed, 71 insertions(+), 32 deletions(-)

Index: b/drivers/pci/msi.c
===================================================================
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -532,7 +532,7 @@ static int populate_msi_sysfs(struct pci
 }
 
 static struct msi_desc *
-msi_setup_entry(struct pci_dev *dev, int nvec, const struct irq_affinity *affd)
+msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
 {
 	struct irq_affinity_desc *masks = NULL;
 	struct msi_desc *entry;
@@ -597,7 +597,7 @@ static int msi_verify_entries(struct pci
  * which could have been allocated.
  */
 static int msi_capability_init(struct pci_dev *dev, int nvec,
-			       const struct irq_affinity *affd)
+			       struct irq_affinity *affd)
 {
 	struct msi_desc *entry;
 	int ret;
@@ -669,7 +669,7 @@ static void __iomem *msix_map_region(str
 
 static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 			      struct msix_entry *entries, int nvec,
-			      const struct irq_affinity *affd)
+			      struct irq_affinity *affd)
 {
 	struct irq_affinity_desc *curmsk, *masks = NULL;
 	struct msi_desc *entry;
@@ -736,7 +736,7 @@ static void msix_program_entries(struct
  * requested MSI-X entries with allocated irqs or non-zero for otherwise.
  **/
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
-				int nvec, const struct irq_affinity *affd)
+				int nvec, struct irq_affinity *affd)
 {
 	int ret;
 	u16 control;
@@ -932,7 +932,7 @@ int pci_msix_vec_count(struct pci_dev *d
 EXPORT_SYMBOL(pci_msix_vec_count);
 
 static int __pci_enable_msix(struct pci_dev *dev, struct msix_entry *entries,
-			     int nvec, const struct irq_affinity *affd)
+			     int nvec, struct irq_affinity *affd)
 {
 	int nr_entries;
 	int i, j;
@@ -1018,7 +1018,7 @@ int pci_msi_enabled(void)
 EXPORT_SYMBOL(pci_msi_enabled);
 
 static int __pci_enable_msi_range(struct pci_dev *dev, int minvec, int maxvec,
-				  const struct irq_affinity *affd)
+				  struct irq_affinity *affd)
 {
 	int nvec;
 	int rc;
@@ -1086,7 +1086,7 @@ EXPORT_SYMBOL(pci_enable_msi);
 
 static int __pci_enable_msix_range(struct pci_dev *dev,
 				   struct msix_entry *entries, int minvec,
-				   int maxvec, const struct irq_affinity *affd)
+				   int maxvec, struct irq_affinity *affd)
 {
 	int rc, nvec = maxvec;
 
@@ -1165,9 +1165,9 @@ EXPORT_SYMBOL(pci_enable_msix_range);
  */
 int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   unsigned int max_vecs, unsigned int flags,
-				   const struct irq_affinity *affd)
+				   struct irq_affinity *affd)
 {
-	static const struct irq_affinity msi_default_affd;
+	struct irq_affinity msi_default_affd = {0};
 	int msix_vecs = -ENOSPC;
 	int msi_vecs = -ENOSPC;
 
@@ -1196,6 +1196,13 @@ int pci_alloc_irq_vectors_affinity(struc
 	/* use legacy irq if allowed */
 	if (flags & PCI_IRQ_LEGACY) {
 		if (min_vecs == 1 && dev->irq) {
+			/*
+			 * Invoke the affinity spreading logic to ensure that
+			 * the device driver can adjust queue configuration
+			 * for the single interrupt case.
+			 */
+			if (affd)
+				irq_create_affinity_masks(1, affd);
 			pci_intx(dev, 1);
 			return 1;
 		}
Index: b/drivers/scsi/be2iscsi/be_main.c
===================================================================
--- a/drivers/scsi/be2iscsi/be_main.c
+++ b/drivers/scsi/be2iscsi/be_main.c
@@ -3566,7 +3566,7 @@ static void be2iscsi_enable_msix(struct
 
 	/* if eqid_count == 1 fall back to INTX */
 	if (enable_msix && nvec > 1) {
-		const struct irq_affinity desc = { .post_vectors = 1 };
+		struct irq_affinity desc = { .post_vectors = 1 };
 
 		if (pci_alloc_irq_vectors_affinity(phba->pcidev, 2, nvec,
 				PCI_IRQ_MSIX | PCI_IRQ_AFFINITY, &desc) < 0) {
Index: b/include/linux/interrupt.h
===================================================================
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -252,12 +252,18 @@ struct irq_affinity_notify {
  * @nr_sets:		The number of interrupt sets for which affinity
  *			spreading is required
  * @set_size:		Array holding the size of each interrupt set
+ * @calc_sets:		Callback for calculating the number and size
+ *			of interrupt sets
+ * @priv:		Private data for usage by @calc_sets, usually a
+ *			pointer to driver/device specific data.
  */
 struct irq_affinity {
 	unsigned int	pre_vectors;
 	unsigned int	post_vectors;
 	unsigned int	nr_sets;
 	unsigned int	set_size[IRQ_AFFINITY_MAX_SETS];
+	void		(*calc_sets)(struct irq_affinity *, unsigned int nvecs);
+	void		*priv;
 };
 
 /**
@@ -317,7 +323,7 @@ extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 
 struct irq_affinity_desc *
-irq_create_affinity_masks(unsigned int nvec, const struct irq_affinity *affd);
+irq_create_affinity_masks(unsigned int nvec, struct irq_affinity *affd);
 
 unsigned int irq_calc_affinity_vectors(unsigned int minvec, unsigned int maxvec,
 				       const struct irq_affinity *affd);
@@ -354,7 +360,7 @@ irq_set_affinity_notifier(unsigned int i
 }
 
 static inline struct irq_affinity_desc *
-irq_create_affinity_masks(unsigned int nvec, const struct irq_affinity *affd)
+irq_create_affinity_masks(unsigned int nvec, struct irq_affinity *affd)
 {
 	return NULL;
 }
Index: b/include/linux/pci.h
===================================================================
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1393,7 +1393,7 @@ static inline int pci_enable_msix_exact(
 }
 int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   unsigned int max_vecs, unsigned int flags,
-				   const struct irq_affinity *affd);
+				   struct irq_affinity *affd);
 
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
@@ -1419,7 +1419,7 @@ static inline int pci_enable_msix_exact(
 static inline int
 pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 			       unsigned int max_vecs, unsigned int flags,
-			       const struct irq_affinity *aff_desc)
+			       struct irq_affinity *aff_desc)
 {
 	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1 && dev->irq)
 		return 1;
Index: b/kernel/irq/affinity.c
===================================================================
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -230,6 +230,12 @@ static int irq_build_affinity_masks(cons
 	return ret;
 }
 
+static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
+{
+	affd->nr_sets = 1;
+	affd->set_size[0] = affvecs;
+}
+
 /**
  * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
  * @nvecs:	The total number of vectors
@@ -240,20 +246,46 @@ static int irq_build_affinity_masks(cons
 struct irq_affinity_desc *
 irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 {
-	unsigned int affvecs, curvec, usedvecs, nr_sets, i;
-	unsigned int set_size[IRQ_AFFINITY_MAX_SETS];
+	unsigned int affvecs, curvec, usedvecs, i;
 	struct irq_affinity_desc *masks = NULL;
 
 	/*
-	 * If there aren't any vectors left after applying the pre/post
-	 * vectors don't bother with assigning affinity.
+	 * Determine the number of vectors which need interrupt affinities
+	 * assigned. If the pre/post request exhausts the available vectors
+	 * then nothing to do here except for invoking the calc_sets()
+	 * callback so the device driver can adjust to the situation. If there
+	 * is only a single vector, then managing the queue is pointless as
+	 * well.
 	 */
-	if (nvecs == affd->pre_vectors + affd->post_vectors)
-		return NULL;
+	if (nvecs > 1 && nvecs > affd->pre_vectors + affd->post_vectors)
+		affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
+	else
+		affvecs = 0;
+
+	/*
+	 * Simple invocations do not provide a calc_sets() callback. Install
+	 * the generic one. The check for affd->nr_sets is a temporary
+	 * workaround and will be removed after the NVME driver is converted
+	 * over.
+	 */
+	if (!affd->nr_sets && !affd->calc_sets)
+		affd->calc_sets = default_calc_sets;
+
+	/*
+	 * If the device driver provided a calc_sets() callback let it
+	 * recalculate the number of sets and their size. The check will go
+	 * away once the NVME driver is converted over.
+	 */
+	if (affd->calc_sets)
+		affd->calc_sets(affd, affvecs);
 
 	if (WARN_ON_ONCE(affd->nr_sets > IRQ_AFFINITY_MAX_SETS))
 		return NULL;
 
+	/* Nothing to assign? */
+	if (!affvecs)
+		return NULL;
+
 	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
 	if (!masks)
 		return NULL;
@@ -261,21 +293,13 @@ irq_create_affinity_masks(unsigned int n
 	/* Fill out vectors at the beginning that don't need affinity */
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
 		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
+
 	/*
 	 * Spread on present CPUs starting from affd->pre_vectors. If we
 	 * have multiple sets, build each sets affinity mask separately.
 	 */
-	affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
-	nr_sets = affd->nr_sets;
-	if (!nr_sets) {
-		nr_sets = 1;
-		set_size[0] = affvecs;
-	} else {
-		memcpy(set_size, affd->set_size, nr_sets * sizeof(unsigned int));
-	}
-
-	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
-		unsigned int this_vecs = set_size[i];
+	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
+		unsigned int this_vecs = affd->set_size[i];
 		int ret;
 
 		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
@@ -318,7 +342,9 @@ unsigned int irq_calc_affinity_vectors(u
 	if (resv > minvec)
 		return 0;
 
-	if (affd->nr_sets) {
+	if (affd->calc_sets) {
+		set_vecs = maxvec - resv;
+	} else if (affd->nr_sets) {
 		unsigned int i;
 
 		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)


