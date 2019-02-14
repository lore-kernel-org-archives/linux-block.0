Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54622C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 12:24:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 209562073D
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 12:24:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403907AbfBNMYB (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 07:24:01 -0500
Received: from mx1.redhat.com ([209.132.183.28]:43550 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726485AbfBNMYB (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 07:24:01 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 36A6889ACD;
        Thu, 14 Feb 2019 12:24:00 +0000 (UTC)
Received: from localhost (ovpn-8-24.pek2.redhat.com [10.72.8.24])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 210ED608D1;
        Thu, 14 Feb 2019 12:23:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Keith Busch <keith.busch@intel.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 1/4] genirq/affinity: store interrupt sets size in 'struct irq_affinity'
Date:   Thu, 14 Feb 2019 20:23:44 +0800
Message-Id: <20190214122347.17372-2-ming.lei@redhat.com>
In-Reply-To: <20190214122347.17372-1-ming.lei@redhat.com>
References: <20190214122347.17372-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.26]); Thu, 14 Feb 2019 12:24:00 +0000 (UTC)
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

With the upcoming callback to recalculate the number and size of
interrupt sets, it's necessary to remove the 'const' qualifier. Otherwise
the callback would not be able to update the data.

This patch does the 1st thing and stores interrupt sets size in
'struct irq_affinity'.

Reviewed-by: Jens Axboe <axboe@kernel.dk>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c   |  5 ++---
 include/linux/interrupt.h |  6 ++++--
 kernel/irq/affinity.c     | 15 ++++++++++++---
 3 files changed, 18 insertions(+), 8 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 022ea1ee63f8..193d94caf457 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2081,12 +2081,11 @@ static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
 static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	int irq_sets[2];
 	struct irq_affinity affd = {
 		.pre_vectors = 1,
-		.nr_sets = ARRAY_SIZE(irq_sets),
-		.sets = irq_sets,
+		.nr_sets = 2,
 	};
+	int *irq_sets = affd.set_size;
 	int result = 0;
 	unsigned int irq_queues, this_p_queues;
 
diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index 7c9434652f36..d9dd5bd61e36 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -259,6 +259,8 @@ struct irq_affinity_notify {
 	void (*release)(struct kref *ref);
 };
 
+#define	IRQ_AFFINITY_MAX_SETS  4
+
 /**
  * struct irq_affinity - Description for automatic irq affinity assignements
  * @pre_vectors:	Don't apply affinity to @pre_vectors at beginning of
@@ -266,13 +268,13 @@ struct irq_affinity_notify {
  * @post_vectors:	Don't apply affinity to @post_vectors at end of
  *			the MSI(-X) vector space
  * @nr_sets:		Length of passed in *sets array
- * @sets:		Number of affinitized sets
+ * @set_size:		Number of affinitized sets
  */
 struct irq_affinity {
 	int	pre_vectors;
 	int	post_vectors;
 	int	nr_sets;
-	int	*sets;
+	int	set_size[IRQ_AFFINITY_MAX_SETS];
 };
 
 /**
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 118b66d64a53..a5e3e5fb3b92 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -245,6 +245,7 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	int curvec, usedvecs;
 	struct irq_affinity_desc *masks = NULL;
 	int i, nr_sets;
+	int set_size[IRQ_AFFINITY_MAX_SETS];
 
 	/*
 	 * If there aren't any vectors left after applying the pre/post
@@ -253,6 +254,9 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	if (nvecs == affd->pre_vectors + affd->post_vectors)
 		return NULL;
 
+	if (WARN_ON_ONCE(affd->nr_sets > IRQ_AFFINITY_MAX_SETS))
+		return NULL;
+
 	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
 	if (!masks)
 		return NULL;
@@ -265,11 +269,16 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	 * have multiple sets, build each sets affinity mask separately.
 	 */
 	nr_sets = affd->nr_sets;
-	if (!nr_sets)
+	if (!nr_sets) {
 		nr_sets = 1;
+		set_size[0] = affvecs;
+	} else {
+		memcpy(set_size, affd->set_size,
+				IRQ_AFFINITY_MAX_SETS * sizeof(int));
+	}
 
 	for (i = 0, usedvecs = 0; i < nr_sets; i++) {
-		int this_vecs = affd->sets ? affd->sets[i] : affvecs;
+		int this_vecs = set_size[i];
 		int ret;
 
 		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
@@ -316,7 +325,7 @@ int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity
 		int i;
 
 		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
-			set_vecs += affd->sets[i];
+			set_vecs += affd->set_size[i];
 	} else {
 		get_online_cpus();
 		set_vecs = cpumask_weight(cpu_possible_mask);
-- 
2.9.5

