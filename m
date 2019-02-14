Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17B38C10F04
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 12:24:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D951D2073D
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 12:24:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2436582AbfBNMYI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:24:08 -0500
Received: from mx1.redhat.com ([209.132.183.28]:45342 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbfBNMYH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 07:24:07 -0500
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 0F45181F11;
        Thu, 14 Feb 2019 12:24:07 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id C979860C62;
        Thu, 14 Feb 2019 12:24:02 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 2/4] genirq/affinity: add new callback for caculating interrupt sets size
Date:   Thu, 14 Feb 2019 20:23:45 +0800
Message-Id: <20190214122347.17372-3-ming.lei@redhat.com>
In-Reply-To: <20190214122347.17372-1-ming.lei@redhat.com>
References: <20190214122347.17372-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.25]); Thu, 14 Feb 2019 12:24:07 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The interrupt affinity spreading mechanism supports to spread out
affinities for one or more interrupt sets. A interrupt set contains one
or more interrupts. Each set is mapped to a specific functionality of a
device, e.g. general I/O queues and read I/O queus of multiqueue block
devices.

The number of interrupts per set is defined by the driver. It depends on
the total number of available interrupts for the device, which is
determined by the PCI capabilites and the availability of underlying CPU
resources, and the number of queues which the device provides and the
driver wants to instantiate.

The driver passes initial configuration for the interrupt allocation via
a pointer to struct affinity_desc.

Right now the allocation mechanism is complex as it requires to have a
loop in the driver to determine the maximum number of interrupts which
are provided by the PCI capabilities and the underlying CPU resources.
This loop would have to be replicated in every driver which wants to
utilize this mechanism. That's unwanted code duplication and error
prone.

In order to move this into generic facilities it is required to have a
mechanism, which allows the recalculation of the interrupt sets and
their size, in the core code. As the core code does not have any
knowledge about the underlying device, a driver specific callback will
be added to struct affinity_desc, which will be invoked by the core
code. The callback will get the number of available interupts as an
argument, so the driver can calculate the corresponding number and size
of interrupt sets.

To support this, two modifications for the handling of struct
affinity_desc are required:

1) The (optional) interrupt sets size information is contained in a
   separate array of integers and struct affinity_desc contains a
   pointer to it.

   This is cumbersome and as the maximum number of interrupt sets is
   small, there is no reason to have separate storage. Moving the size
   array into struct affinity_desc avoids indirections makes the code
   simpler.

2) At the moment the struct affinity_desc pointer which is handed in from
   the driver and passed through to several core functions is marked
   'const'.

This patch adds callback to recalculate the number and size of interrupt sets,
also removes the 'const' qualifier for 'affd'.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/pci/msi.c         | 18 +++++++++---------
 include/linux/interrupt.h |  6 +++++-
 include/linux/pci.h       |  4 ++--
 kernel/irq/affinity.c     | 25 ++++++++++++-------------
 4 files changed, 28 insertions(+), 25 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 4c0b47867258..96978459e2a0 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -532,7 +532,7 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 }
 
 static struct msi_desc *
-msi_setup_entry(struct pci_dev *dev, int nvec, const struct irq_affinity *affd)
+msi_setup_entry(struct pci_dev *dev, int nvec, struct irq_affinity *affd)
 {
 	struct irq_affinity_desc *masks = NULL;
 	struct msi_desc *entry;
@@ -597,7 +597,7 @@ static int msi_verify_entries(struct pci_dev *dev)
  * which could have been allocated.
  */
 static int msi_capability_init(struct pci_dev *dev, int nvec,
-			       const struct irq_affinity *affd)
+			       struct irq_affinity *affd)
 {
 	struct msi_desc *entry;
 	int ret;
@@ -669,7 +669,7 @@ static void __iomem *msix_map_region(struct pci_dev *dev, unsigned nr_entries)
 
 static int msix_setup_entries(struct pci_dev *dev, void __iomem *base,
 			      struct msix_entry *entries, int nvec,
-			      const struct irq_affinity *affd)
+			      struct irq_affinity *affd)
 {
 	struct irq_affinity_desc *curmsk, *masks = NULL;
 	struct msi_desc *entry;
@@ -736,7 +736,7 @@ static void msix_program_entries(struct pci_dev *dev,
  * requested MSI-X entries with allocated irqs or non-zero for otherwise.
  **/
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
-				int nvec, const struct irq_affinity *affd)
+				int nvec, struct irq_affinity *affd)
 {
 	int ret;
 	u16 control;
@@ -932,7 +932,7 @@ int pci_msix_vec_count(struct pci_dev *dev)
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
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index d9dd5bd61e36..acb9c5ad6bc1 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -269,12 +269,16 @@ struct irq_affinity_notify {
  *			the MSI(-X) vector space
  * @nr_sets:		Length of passed in *sets array
  * @set_size:		Number of affinitized sets
+ * @calc_sets:		Callback for caculating interrupt sets size
+ * @priv:		Private data of @calc_sets
  */
 struct irq_affinity {
 	int	pre_vectors;
 	int	post_vectors;
 	int	nr_sets;
 	int	set_size[IRQ_AFFINITY_MAX_SETS];
+	void	(*calc_sets)(struct irq_affinity *, int nvecs);
+	void	*priv;
 };
 
 /**
@@ -334,7 +338,7 @@ extern int
 irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 
 struct irq_affinity_desc *
-irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
+irq_create_affinity_masks(int nvec, struct irq_affinity *affd);
 
 int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 40b327b814aa..4eca42cf611b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1396,7 +1396,7 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 }
 int pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 				   unsigned int max_vecs, unsigned int flags,
-				   const struct irq_affinity *affd);
+				   struct irq_affinity *affd);
 
 void pci_free_irq_vectors(struct pci_dev *dev);
 int pci_irq_vector(struct pci_dev *dev, unsigned int nr);
@@ -1422,7 +1422,7 @@ static inline int pci_enable_msix_exact(struct pci_dev *dev,
 static inline int
 pci_alloc_irq_vectors_affinity(struct pci_dev *dev, unsigned int min_vecs,
 			       unsigned int max_vecs, unsigned int flags,
-			       const struct irq_affinity *aff_desc)
+			       struct irq_affinity *aff_desc)
 {
 	if ((flags & PCI_IRQ_LEGACY) && min_vecs == 1 && dev->irq)
 		return 1;
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index a5e3e5fb3b92..3b1451a895b2 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -239,13 +239,12 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
  * Returns the irq_affinity_desc pointer or NULL if allocation failed.
  */
 struct irq_affinity_desc *
-irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
+irq_create_affinity_masks(int nvecs, struct irq_affinity *affd)
 {
 	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
 	int curvec, usedvecs;
 	struct irq_affinity_desc *masks = NULL;
-	int i, nr_sets;
-	int set_size[IRQ_AFFINITY_MAX_SETS];
+	int i;
 
 	/*
 	 * If there aren't any vectors left after applying the pre/post
@@ -268,17 +267,15 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	 * Spread on present CPUs starting from affd->pre_vectors. If we
 	 * have multiple sets, build each sets affinity mask separately.
 	 */
-	nr_sets = affd->nr_sets;
-	if (!nr_sets) {
-		nr_sets = 1;
-		set_size[0] = affvecs;
-	} else {
-		memcpy(set_size, affd->set_size,
-				IRQ_AFFINITY_MAX_SETS * sizeof(int));
+	if (affd->calc_sets) {
+		affd->calc_sets(affd, nvecs);
+	} else if (!affd->nr_sets) {
+		affd->nr_sets = 1;
+		affd->set_size[0] = affvecs;
 	}
 
-	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
-		int this_vecs = set_size[i];
+	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
+		int this_vecs = affd->set_size[i];
 		int ret;
 
 		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
@@ -321,7 +318,9 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
 	if (resv > minvec)
 		return 0;
 
-	if (affd->nr_sets) {
+	if (affd->calc_sets) {
+		set_vecs = vecs;
+	} else if (affd->nr_sets) {
 		int i;
 
 		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
-- 
2.9.5

