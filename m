Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE618C43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 21:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C5B3D2147C
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 21:37:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2503285AbfBNVhL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:37:11 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51360 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2502507AbfBNVgw (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 16:36:52 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1guOgI-0002Cv-I7; Thu, 14 Feb 2019 22:36:30 +0100
Message-Id: <20190214211800.077804233@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 14 Feb 2019 21:48:03 +0100
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
Subject: [patch V5 8/8] genirq/affinity: Add support for non-managed affinity
 sets
References: <20190214204755.819014197@linutronix.de>
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
 kernel/irq/affinity.c     |    5 ++++-
 2 files changed, 6 insertions(+), 1 deletion(-)

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
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -251,6 +251,8 @@ irq_create_affinity_masks(unsigned int n
 	unsigned int affvecs, curvec, usedvecs, i;
 	struct irq_affinity_desc *masks = NULL;
 
+	BUILD_BUG_ON(IRQ_AFFINITY_MAX_SETS > sizeof(affd->unmanaged_sets) * 8);
+
 	/*
 	 * If there aren't any vectors left after applying the pre/post
 	 * vectors don't bother with assigning affinity.
@@ -288,11 +290,12 @@ irq_create_affinity_masks(unsigned int n
 	 * have multiple sets, build each sets affinity mask separately.
 	 */
 	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
+		bool managed = affd->unmanaged_sets & (1U << i) ? true : false;
 		unsigned int this_vecs = affd->set_size[i];
 		int ret;
 
 		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
-					       true, curvec, masks);
+					       managed, curvec, masks);
 		if (ret) {
 			kfree(masks);
 			return NULL;


