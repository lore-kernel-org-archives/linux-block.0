Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AA9CC4360F
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 21:37:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE3DA21B68
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 21:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440281AbfBNVgt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:36:49 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51353 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2436452AbfBNVgq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 16:36:46 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1guOgF-0002CU-3N; Thu, 14 Feb 2019 22:36:27 +0100
Message-Id: <20190214211759.803557905@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 14 Feb 2019 21:48:00 +0100
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
Subject: [patch V5 5/8] genirq/affinity: Remove the leftovers of the original
 set support
References: <20190214204755.819014197@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Now that the NVME driver is converted over to the calc_set() callback, the
workarounds of the original set support can be removed.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/affinity.c |   17 ++++-------------
 1 file changed, 4 insertions(+), 13 deletions(-)

--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -258,21 +258,17 @@ irq_create_affinity_masks(unsigned int n
 
 	/*
 	 * Simple invocations do not provide a calc_sets()
-	 * callback. Install the generic one. The check for affd->nr_sets
-	 * is a temporary workaround and will be removed after the NVME
-	 * driver is converted over.
+	 * callback. Install the generic one.
 	 */
-	if (!affd->nr_sets && !affd->calc_sets)
+	if (!affd->calc_sets)
 		affd->calc_sets = default_calc_sets;
 
 	/*
 	 * If the device driver provided a calc_sets() callback let it
-	 * recalculate the number of sets and their size. The check will go
-	 * away once the NVME driver is converted over.
+	 * recalculate the number of sets and their size.
 	 */
 	affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
-	if (affd->calc_sets)
-		affd->calc_sets(affd, affvecs);
+	affd->calc_sets(affd, affvecs);
 
 	if (WARN_ON_ONCE(affd->nr_sets > IRQ_AFFINITY_MAX_SETS))
 		return NULL;
@@ -335,11 +331,6 @@ unsigned int irq_calc_affinity_vectors(u
 
 	if (affd->calc_sets) {
 		set_vecs = maxvec - resv;
-	} else if (affd->nr_sets) {
-		unsigned int i;
-
-		for (i = 0, set_vecs = 0;  i < affd->nr_sets; i++)
-			set_vecs += affd->set_size[i];
 	} else {
 		get_online_cpus();
 		set_vecs = cpumask_weight(cpu_possible_mask);


