Return-Path: <SRS0=0P76=QX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92A68C10F00
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 17:26:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6582B222E0
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 17:26:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731888AbfBPRZ5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Feb 2019 12:25:57 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54734 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731690AbfBPRZ4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Feb 2019 12:25:56 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gv3ii-0001ii-5S; Sat, 16 Feb 2019 18:25:44 +0100
Message-Id: <20190216172228.423723127@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 16 Feb 2019 18:13:08 +0100
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
Subject: [patch v6 2/7] genirq/affinity: Store interrupt sets size in struct
 irq_affinity
References: <20190216171306.403545970@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Ming Lei <ming.lei@redhat.com>

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
a pointer to struct irq_affinity.

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

To support this, two modifications for the handling of struct irq_affinity
are required:

1) The (optional) interrupt sets size information is contained in a
   separate array of integers and struct irq_affinity contains a
   pointer to it.

   This is cumbersome and as the maximum number of interrupt sets is small,
   there is no reason to have separate storage. Moving the size array into
   struct affinity_desc avoids indirections and makes the code simpler.

2) At the moment the struct irq_affinity pointer which is handed in from
   the driver and passed through to several core functions is marked
   'const'.

   With the upcoming callback to recalculate the number and size of
   interrupt sets, it's necessary to remove the 'const'
   qualifier. Otherwise the callback would not be able to update the data.

Implement #1 and store the interrupt sets size in 'struct irq_affinity'.

No functional change.

[ tglx: Fixed the memcpy() size so it won't copy beyond the size of the
  	source. Fixed the kernel doc comments for struct irq_affinity and
  	de-'This patch'-ed the changelog ]

Signed-off-by: Ming Lei <ming.lei@redhat.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/nvme/host/pci.c   |    7 +++----
 include/linux/interrupt.h |    9 ++++++---
 kernel/irq/affinity.c     |   16 ++++++++++++----
 3 files changed, 21 insertions(+), 11 deletions(-)

--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2081,12 +2081,11 @@ static void nvme_calc_io_queues(struct n
 static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	int irq_sets[2];
 	struct irq_affinity affd = {
-		.pre_vectors = 1,
-		.nr_sets = ARRAY_SIZE(irq_sets),
-		.sets = irq_sets,
+		.pre_vectors	= 1,
+		.nr_sets	= 2,
 	};
+	unsigned int *irq_sets = affd.set_size;
 	int result = 0;
 	unsigned int irq_queues, this_p_queues;
 
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -241,20 +241,23 @@ struct irq_affinity_notify {
 	void (*release)(struct kref *ref);
 };
 
+#define	IRQ_AFFINITY_MAX_SETS  4
+
 /**
  * struct irq_affinity - Description for automatic irq affinity assignements
  * @pre_vectors:	Don't apply affinity to @pre_vectors at beginning of
  *			the MSI(-X) vector space
  * @post_vectors:	Don't apply affinity to @post_vectors at end of
  *			the MSI(-X) vector space
- * @nr_sets:		Length of passed in *sets array
- * @sets:		Number of affinitized sets
+ * @nr_sets:		The number of interrupt sets for which affinity
+ *			spreading is required
+ * @set_size:		Array holding the size of each interrupt set
  */
 struct irq_affinity {
 	unsigned int	pre_vectors;
 	unsigned int	post_vectors;
 	unsigned int	nr_sets;
-	unsigned int	*sets;
+	unsigned int	set_size[IRQ_AFFINITY_MAX_SETS];
 };
 
 /**
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -238,9 +238,10 @@ static int irq_build_affinity_masks(cons
  * Returns the irq_affinity_desc pointer or NULL if allocation failed.
  */
 struct irq_affinity_desc *
-irq_create_affinity_masks(unsigned int nvecs, const struct irq_affinity *affd)
+irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 {
 	unsigned int affvecs, curvec, usedvecs, nr_sets, i;
+	unsigned int set_size[IRQ_AFFINITY_MAX_SETS];
 	struct irq_affinity_desc *masks = NULL;
 
 	/*
@@ -250,6 +251,9 @@ irq_create_affinity_masks(unsigned int n
 	if (nvecs == affd->pre_vectors + affd->post_vectors)
 		return NULL;
 
+	if (WARN_ON_ONCE(affd->nr_sets > IRQ_AFFINITY_MAX_SETS))
+		return NULL;
+
 	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
 	if (!masks)
 		return NULL;
@@ -263,11 +267,15 @@ irq_create_affinity_masks(unsigned int n
 	 */
 	affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
 	nr_sets = affd->nr_sets;
-	if (!nr_sets)
+	if (!nr_sets) {
 		nr_sets = 1;
+		set_size[0] = affvecs;
+	} else {
+		memcpy(set_size, affd->set_size, nr_sets * sizeof(unsigned int));
+	}
 
 	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
-		unsigned int this_vecs = affd->sets ? affd->sets[i] : affvecs;
+		unsigned int this_vecs = set_size[i];
 		int ret;
 
 		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
@@ -314,7 +322,7 @@ unsigned int irq_calc_affinity_vectors(u
 		unsigned int i;
 
 		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
-			set_vecs += affd->sets[i];
+			set_vecs += affd->set_size[i];
 	} else {
 		get_online_cpus();
 		set_vecs = cpumask_weight(cpu_possible_mask);


