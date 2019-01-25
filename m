Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6465C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:54:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8FF1A218E2
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:54:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728354AbfAYJyn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:54:43 -0500
Received: from mx1.redhat.com ([209.132.183.28]:40812 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728459AbfAYJyn (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 04:54:43 -0500
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 515E2C05FFE0;
        Fri, 25 Jan 2019 09:54:43 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3A26F608C3;
        Fri, 25 Jan 2019 09:54:33 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 4/5] nvme-pci: simplify nvme_setup_irqs() via .setup_affinity callback
Date:   Fri, 25 Jan 2019 17:53:46 +0800
Message-Id: <20190125095347.17950-5-ming.lei@redhat.com>
In-Reply-To: <20190125095347.17950-1-ming.lei@redhat.com>
References: <20190125095347.17950-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.32]); Fri, 25 Jan 2019 09:54:43 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Use the callback of .setup_affinity() to re-caculate number
of queues, and build irqs affinity with help of irq_build_affinity().

Then nvme_setup_irqs() gets simplified a lot.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 drivers/nvme/host/pci.c | 97 ++++++++++++++++++++++++-------------------------
 1 file changed, 48 insertions(+), 49 deletions(-)

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 9bc585415d9b..24496de0a29b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -2078,17 +2078,58 @@ static void nvme_calc_io_queues(struct nvme_dev *dev, unsigned int irq_queues)
 	}
 }
 
+static int nvme_setup_affinity(const struct irq_affinity *affd,
+			       struct irq_affinity_desc *masks,
+			       unsigned int nmasks)
+{
+	struct nvme_dev *dev = affd->priv;
+	int affvecs = nmasks - affd->pre_vectors - affd->post_vectors;
+	int curvec, usedvecs;
+	int i;
+
+	nvme_calc_io_queues(dev, nmasks);
+
+	/* Fill out vectors at the beginning that don't need affinity */
+	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
+		cpumask_copy(&masks[curvec].mask, cpu_possible_mask);
+
+	for (i = 0, usedvecs = 0; i < HCTX_TYPE_POLL; i++) {
+		int this_vecs = dev->io_queues[i];
+		int ret;
+
+		if (!this_vecs)
+			break;
+
+		ret = irq_build_affinity(affd, curvec, this_vecs, curvec,
+					 masks, nmasks);
+		if (ret)
+			return ret;
+
+		curvec += this_vecs;
+		usedvecs += this_vecs;
+	}
+
+	/* Fill out vectors at the end that don't need affinity */
+	curvec = affd->pre_vectors + min(usedvecs, affvecs);
+	for (; curvec < nmasks; curvec++)
+		cpumask_copy(&masks[curvec].mask, cpu_possible_mask);
+
+	/* Mark the managed interrupts */
+	for (i = affd->pre_vectors; i < nmasks - affd->post_vectors; i++)
+		masks[i].is_managed = 1;
+
+	return 0;
+}
+
 static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
-	int irq_sets[2];
 	struct irq_affinity affd = {
 		.pre_vectors = 1,
-		.nr_sets = ARRAY_SIZE(irq_sets),
-		.sets = irq_sets,
+		.setup_affinity = nvme_setup_affinity,
+		.priv = dev,
 	};
-	int result = 0;
-	unsigned int irq_queues, this_p_queues;
+	int result, irq_queues, this_p_queues;
 
 	/*
 	 * Poll queues don't need interrupts, but we need at least one IO
@@ -2103,50 +2144,8 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 	}
 	dev->io_queues[HCTX_TYPE_POLL] = this_p_queues;
 
-	/*
-	 * For irq sets, we have to ask for minvec == maxvec. This passes
-	 * any reduction back to us, so we can adjust our queue counts and
-	 * IRQ vector needs.
-	 */
-	do {
-		nvme_calc_io_queues(dev, irq_queues);
-		irq_sets[0] = dev->io_queues[HCTX_TYPE_DEFAULT];
-		irq_sets[1] = dev->io_queues[HCTX_TYPE_READ];
-		if (!irq_sets[1])
-			affd.nr_sets = 1;
-
-		/*
-		 * If we got a failure and we're down to asking for just
-		 * 1 + 1 queues, just ask for a single vector. We'll share
-		 * that between the single IO queue and the admin queue.
-		 * Otherwise, we assign one independent vector to admin queue.
-		 */
-		if (irq_queues > 1)
-			irq_queues = irq_sets[0] + irq_sets[1] + 1;
-
-		result = pci_alloc_irq_vectors_affinity(pdev, irq_queues,
-				irq_queues,
-				PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
-
-		/*
-		 * Need to reduce our vec counts. If we get ENOSPC, the
-		 * platform should support mulitple vecs, we just need
-		 * to decrease our ask. If we get EINVAL, the platform
-		 * likely does not. Back down to ask for just one vector.
-		 */
-		if (result == -ENOSPC) {
-			irq_queues--;
-			if (!irq_queues)
-				return result;
-			continue;
-		} else if (result == -EINVAL) {
-			irq_queues = 1;
-			continue;
-		} else if (result <= 0)
-			return -EIO;
-		break;
-	} while (1);
-
+	result = pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
+			PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
 	return result;
 }
 
-- 
2.9.5

