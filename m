Return-Path: <SRS0=0P76=QX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0DC17C4360F
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 17:26:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D456E222E0
	for <linux-block@archiver.kernel.org>; Sat, 16 Feb 2019 17:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732010AbfBPR0K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Feb 2019 12:26:10 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:54749 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730863AbfBPR0J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Feb 2019 12:26:09 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1gv3il-0001j9-3f; Sat, 16 Feb 2019 18:25:47 +0100
Message-Id: <20190216172228.689834224@linutronix.de>
User-Agent: quilt/0.65
Date:   Sat, 16 Feb 2019 18:13:11 +0100
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
Subject: [patch v6 5/7] genirq/affinity: Remove the leftovers of the original
 set support
References: <20190216171306.403545970@linutronix.de>
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
 kernel/irq/affinity.c |   20 ++++----------------
 1 file changed, 4 insertions(+), 16 deletions(-)

Index: b/kernel/irq/affinity.c
===================================================================
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -264,20 +264,13 @@ irq_create_affinity_masks(unsigned int n
 
 	/*
 	 * Simple invocations do not provide a calc_sets() callback. Install
-	 * the generic one. The check for affd->nr_sets is a temporary
-	 * workaround and will be removed after the NVME driver is converted
-	 * over.
+	 * the generic one.
 	 */
-	if (!affd->nr_sets && !affd->calc_sets)
+	if (!affd->calc_sets)
 		affd->calc_sets = default_calc_sets;
 
-	/*
-	 * If the device driver provided a calc_sets() callback let it
-	 * recalculate the number of sets and their size. The check will go
-	 * away once the NVME driver is converted over.
-	 */
-	if (affd->calc_sets)
-		affd->calc_sets(affd, affvecs);
+	/* Recalculate the sets */
+	affd->calc_sets(affd, affvecs);
 
 	if (WARN_ON_ONCE(affd->nr_sets > IRQ_AFFINITY_MAX_SETS))
 		return NULL;
@@ -344,11 +337,6 @@ unsigned int irq_calc_affinity_vectors(u
 
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


