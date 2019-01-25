Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63664C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F9652084A
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:54:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729174AbfAYJyV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:54:21 -0500
Received: from mx1.redhat.com ([209.132.183.28]:44418 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbfAYJyV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 04:54:21 -0500
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCC61C057E22;
        Fri, 25 Jan 2019 09:54:20 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E5F654A4;
        Fri, 25 Jan 2019 09:54:16 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 2/5] genirq/affinity: allow driver to setup managed IRQ's affinity
Date:   Fri, 25 Jan 2019 17:53:44 +0800
Message-Id: <20190125095347.17950-3-ming.lei@redhat.com>
In-Reply-To: <20190125095347.17950-1-ming.lei@redhat.com>
References: <20190125095347.17950-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.31]); Fri, 25 Jan 2019 09:54:20 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This patch introduces callback of .setup_affinity into 'struct
irq_affinity', so that:

1) allow drivers to customize the affinity for managed IRQ, for
example, now NVMe has special requirement for read queues & poll
queues

2) 6da4b3ab9a6e9 ("genirq/affinity: Add support for allocating interrupt sets")
makes pci_alloc_irq_vectors_affinity() a bit difficult to use for
allocating interrupt sets: 'max_vecs' is required to same with 'min_vecs'.

With this patch, driver can implement their own .setup_affinity to
customize the affinity, then the above thing can be solved easily.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/interrupt.h | 26 +++++++++++++++++---------
 kernel/irq/affinity.c     |  6 ++++++
 2 files changed, 23 insertions(+), 9 deletions(-)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index c672f34235e7..f6cea778cf50 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -242,30 +242,38 @@ struct irq_affinity_notify {
 };
 
 /**
+ * struct irq_affinity_desc - Interrupt affinity descriptor
+ * @mask:	cpumask to hold the affinity assignment
+ */
+struct irq_affinity_desc {
+	struct cpumask	mask;
+	unsigned int	is_managed : 1;
+};
+
+/**
  * struct irq_affinity - Description for automatic irq affinity assignements
  * @pre_vectors:	Don't apply affinity to @pre_vectors at beginning of
  *			the MSI(-X) vector space
  * @post_vectors:	Don't apply affinity to @post_vectors at end of
  *			the MSI(-X) vector space
+ * @setup_affinity:	Use driver's method to setup irq vectors affinity,
+ * 			and driver has to handle pre_vectors & post_vectors
+ * 			correctly, set 'is_managed' flag correct too
+ * @priv:		Private data of @setup_affinity
  * @nr_sets:		Length of passed in *sets array
  * @sets:		Number of affinitized sets
  */
 struct irq_affinity {
 	int	pre_vectors;
 	int	post_vectors;
+	int	(*setup_affinity)(const struct irq_affinity *,
+				  struct irq_affinity_desc *,
+				  unsigned int);
+	void    *priv;
 	int	nr_sets;
 	int	*sets;
 };
 
-/**
- * struct irq_affinity_desc - Interrupt affinity descriptor
- * @mask:	cpumask to hold the affinity assignment
- */
-struct irq_affinity_desc {
-	struct cpumask	mask;
-	unsigned int	is_managed : 1;
-};
-
 #if defined(CONFIG_SMP)
 
 extern cpumask_var_t irq_default_affinity;
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 118b66d64a53..7b77cbdf739c 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -257,6 +257,12 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	if (!masks)
 		return NULL;
 
+	if (affd->setup_affinity) {
+		if (affd->setup_affinity(affd, masks, nvecs))
+			return NULL;
+		return masks;
+	}
+
 	/* Fill out vectors at the beginning that don't need affinity */
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
 		cpumask_copy(&masks[curvec].mask, irq_default_affinity);
-- 
2.9.5

