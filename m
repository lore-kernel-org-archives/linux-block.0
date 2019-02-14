Return-Path: <SRS0=Oz1R=QV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 426C2C10F04
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 21:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 116F12147C
	for <linux-block@archiver.kernel.org>; Thu, 14 Feb 2019 21:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440285AbfBNVgt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Feb 2019 16:36:49 -0500
Received: from Galois.linutronix.de ([146.0.238.70]:51354 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2440277AbfBNVgt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Feb 2019 16:36:49 -0500
Received: from localhost ([127.0.0.1] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtp (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1guOgG-0002CZ-1d; Thu, 14 Feb 2019 22:36:28 +0100
Message-Id: <20190214211759.893781190@linutronix.de>
User-Agent: quilt/0.65
Date:   Thu, 14 Feb 2019 21:48:01 +0100
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
Subject: [patch V5 6/8] PCI/MSI: Remove obsolete sanity checks for multiple
 interrupt sets
References: <20190214204755.819014197@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Multiple interrupt sets for affinity spreading are now handled in the core
code and the number of sets and their size is recalculated via a driver
supplied callback.

That avoids the requirement to invoke pci_alloc_irq_vectors_affinity() with
the arguments minvecs and maxvecs set to the same value and the callsite
handling the ENOSPC situation.

Remove the now obsolete sanity checks and the related comments.

Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

---
 drivers/pci/msi.c |   14 --------------
 1 file changed, 14 deletions(-)

--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -1035,13 +1035,6 @@ static int __pci_enable_msi_range(struct
 	if (maxvec < minvec)
 		return -ERANGE;
 
-	/*
-	 * If the caller is passing in sets, we can't support a range of
-	 * vectors. The caller needs to handle that.
-	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
-		return -EINVAL;
-
 	if (WARN_ON_ONCE(dev->msi_enabled))
 		return -EINVAL;
 
@@ -1093,13 +1086,6 @@ static int __pci_enable_msix_range(struc
 	if (maxvec < minvec)
 		return -ERANGE;
 
-	/*
-	 * If the caller is passing in sets, we can't support a range of
-	 * supported vectors. The caller needs to handle that.
-	 */
-	if (affd && affd->nr_sets && minvec != maxvec)
-		return -EINVAL;
-
 	if (WARN_ON_ONCE(dev->msix_enabled))
 		return -EINVAL;
 


