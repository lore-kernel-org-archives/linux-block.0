Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 957AEC43381
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 21:37:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6D84C2147C
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 21:37:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2395092AbfBNVhV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:37:21 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51355 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440278AbfBNVgt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 16:36:49 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1guOgG-0002Ce-Q7; Thu, 14 Feb 2019 22:36:29 +0100
Message-Id: <20190214211759.981965829@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 14 Feb 2019 21:48:02 +0100
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
Subject: [patch V5 7/8] genirq/affinity: Set is_managed in the spreading
 function
References: <20190214204755.819014197@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some drivers need an extra set of interrupts which are not marked managed,
but should get initial interrupt spreading.

To achieve this it is simpler to set the is_managed bit of the affinity
descriptor in the spreading function instead of having yet another loop and
tons of conditionals.

No functional change.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
---
 kernel/irq/affinity.c |   18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -98,6 +98,7 @@ static int __irq_build_affinity_masks(co
 				      unsigned int startvec,
 				      unsigned int numvecs,
 				      unsigned int firstvec,
+				      bool managed,
 				      cpumask_var_t *node_to_cpumask,
 				      const struct cpumask *cpu_mask,
 				      struct cpumask *nmsk,
@@ -154,6 +155,7 @@ static int __irq_build_affinity_masks(co
 			}
 			irq_spread_init_one(&masks[curvec].mask, nmsk,
 						cpus_per_vec);
+			masks[curvec].is_managed = managed;
 		}
 
 		done += v;
@@ -173,7 +175,7 @@ static int __irq_build_affinity_masks(co
  */
 static int irq_build_affinity_masks(const struct irq_affinity *affd,
 				    unsigned int startvec, unsigned int numvecs,
-				    unsigned int firstvec,
+				    unsigned int firstvec, bool managed,
 				    struct irq_affinity_desc *masks)
 {
 	unsigned int curvec = startvec, nr_present, nr_others;
@@ -197,8 +199,8 @@ static int irq_build_affinity_masks(cons
 	build_node_to_cpumask(node_to_cpumask);
 
 	/* Spread on present CPUs starting from affd->pre_vectors */
-	nr_present = __irq_build_affinity_masks(affd, curvec, numvecs,
-						firstvec, node_to_cpumask,
+	nr_present = __irq_build_affinity_masks(affd, curvec, numvecs, firstvec,
+						managed, node_to_cpumask,
 						cpu_present_mask, nmsk, masks);
 
 	/*
@@ -212,8 +214,8 @@ static int irq_build_affinity_masks(cons
 	else
 		curvec = firstvec + nr_present;
 	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
-	nr_others = __irq_build_affinity_masks(affd, curvec, numvecs,
-					       firstvec, node_to_cpumask,
+	nr_others = __irq_build_affinity_masks(affd, curvec, numvecs, firstvec,
+					       managed, node_to_cpumask,
 					       npresmsk, nmsk, masks);
 	put_online_cpus();
 
@@ -290,7 +292,7 @@ irq_create_affinity_masks(unsigned int n
 		int ret;
 
 		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
-					       curvec, masks);
+					       true, curvec, masks);
 		if (ret) {
 			kfree(masks);
 			return NULL;
@@ -307,10 +309,6 @@ irq_create_affinity_masks(unsigned int n
 	for (; curvec < nvecs; curvec++)
 		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
 
-	/* Mark the managed interrupts */
-	for (i = affd->pre_vectors; i < nvecs - affd->post_vectors; i++)
-		masks[i].is_managed = 1;
-
 	return masks;
 }
 


