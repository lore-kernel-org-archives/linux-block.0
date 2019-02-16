Return-Path: <SRS0=0P76=QX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B688C4360F
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 17:26:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 552FB222E0
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 17:26:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732184AbfBPR0V (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Feb 2019 12:26:21 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54761 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732151AbfBPR0U (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Feb 2019 12:26:20 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gv3im-0001jU-Qv; Sat, 16 Feb 2019 18:25:48 +0100
Message-Id: <20190216172228.869750763@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 16 Feb 2019 18:13:13 +0100
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
Subject: [patch v6 7/7] genirq/affinity: Add support for non-managed affinity
 sets
References: <20190216171306.403545970@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some drivers need an extra set of interrupts which should not be marked
managed, but should get initial interrupt spreading.

Add a bitmap to struct irq_affinity which allows the driver to mark a
particular set of interrupts as non managed. Check the bitmap during
spreading and use the result to mark the interrupts in the sets
accordingly.

The unmanaged interrupts get initial spreading, but user space can change
their affinity later on. For the managed sets, i.e. the corresponding bit
in the mask is not set, there is no change in behaviour.

Usage example:

	struct irq_affinity affd = {
		.pre_vectors	= 2,
		.unmanaged_sets	= 0x02,
		.calc_sets	= drv_calc_sets,
	};
	....

For both interrupt sets the interrupts are properly spread out, but the
second set is not marked managed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 include/linux/interrupt.h |    2 ++
 kernel/irq/affinity.c     |   16 +++++++++++-----
 2 files changed, 13 insertions(+), 5 deletions(-)

Index: b/include/linux/interrupt.h
===================================================================
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -251,6 +251,7 @@ struct irq_affinity_notify {
  *			the MSI(-X) vector space
  * @nr_sets:		The number of interrupt sets for which affinity
  *			spreading is required
+ * @unmanaged_sets:	Bitmap to mark entries in the @set_size array unmanaged
  * @set_size:		Array holding the size of each interrupt set
  * @calc_sets:		Callback for calculating the number and size
  *			of interrupt sets
@@ -261,6 +262,7 @@ struct irq_affinity {
 	unsigned int	pre_vectors;
 	unsigned int	post_vectors;
 	unsigned int	nr_sets;
+	unsigned int	unmanaged_sets;
 	unsigned int	set_size[IRQ_AFFINITY_MAX_SETS];
 	void		(*calc_sets)(struct irq_affinity *, unsigned int nvecs);
 	void		*priv;
Index: b/kernel/irq/affinity.c
===================================================================
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -249,6 +249,8 @@ irq_create_affinity_masks(unsigned int n
 	unsigned int affvecs, curvec, usedvecs, i;
 	struct irq_affinity_desc *masks = NULL;
 
+	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS > sizeof(affd->unmanaged_sets) * 8);
+
 	/*
 	 * Determine the number of vectors which need interrupt affinities
 	 * assigned. If the pre/post request exhausts the available vectors
@@ -292,7 +294,8 @@ irq_create_affinity_masks(unsigned int n
 	 * have multiple sets, build each sets affinity mask separately.
 	 */
 	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
-		unsigned int this_vecs = affd->set_size[i];
+		bool managed = affd->unmanaged_sets & (1U << i) ? true : false;
+		unsigned int idx, this_vecs = affd->set_size[i];
 		int ret;
 
 		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
@@ -301,8 +304,15 @@ irq_create_affinity_masks(unsigned int n
 			kfree(masks);
 			return NULL;
 		}
+
+		idx = curvec;
 		curvec += this_vecs;
 		usedvecs += this_vecs;
+		if (managed) {
+			/* Mark the managed interrupts */
+			for (; idx < curvec; idx++)
+				masks[idx].is_managed = 1;
+		}
 	}
 
 	/* Fill out vectors at the end that don't need affinity */
@@ -313,10 +323,6 @@ irq_create_affinity_masks(unsigned int n
 	for (; curvec < nvecs; curvec++)
 		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
 
-	/* Mark the managed interrupts */
-	for (i = affd->pre_vectors; i < nvecs - affd->post_vectors; i++)
-		masks[i].is_managed = 1;
-
 	return masks;
 }
 


