Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A212C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:54:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E7E68218FE
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:54:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729054AbfAYJyb (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:54:31 -0500
Received: from mx1.redhat.com ([209.132.183.28]:51504 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726888AbfAYJyb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 04:54:31 -0500
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id A13F6A7FDE;
        Fri, 25 Jan 2019 09:54:30 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9350F1834E;
        Fri, 25 Jan 2019 09:54:24 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 3/5] genirq/affinity: introduce irq_build_affinity()
Date:   Fri, 25 Jan 2019 17:53:45 +0800
Message-Id: <20190125095347.17950-4-ming.lei@redhat.com>
In-Reply-To: <20190125095347.17950-1-ming.lei@redhat.com>
References: <20190125095347.17950-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.28]); Fri, 25 Jan 2019 09:54:30 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Drivers may use this API to build customized irq affinity, one example
is NVMe, which needs to build multiple irq sets, on each of which all
CPUs are spread.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 include/linux/interrupt.h | 12 ++++++++++++
 kernel/irq/affinity.c     | 27 +++++++++++++++++++++++++++
 2 files changed, 39 insertions(+)

diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
index f6cea778cf50..b820b07f3b55 100644
--- a/include/linux/interrupt.h
+++ b/include/linux/interrupt.h
@@ -323,6 +323,10 @@ irq_set_affinity_notifier(unsigned int irq, struct irq_affinity_notify *notify);
 struct irq_affinity_desc *
 irq_create_affinity_masks(int nvec, const struct irq_affinity *affd);
 
+int irq_build_affinity(const struct irq_affinity *affd, int startvec,
+                      int numvecs, int firstvec,
+                      struct irq_affinity_desc *masks, int nmasks);
+
 int irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *affd);
 
 #else /* CONFIG_SMP */
@@ -368,6 +372,14 @@ irq_calc_affinity_vectors(int minvec, int maxvec, const struct irq_affinity *aff
 	return maxvec;
 }
 
+static inline int
+irq_build_affinity(const struct irq_affinity *affd, int startvec,
+		   int numvecs, int firstvec,
+		   struct irq_affinity_desc *masks, int nmasks)
+{
+	return 0;
+}
+
 #endif /* CONFIG_SMP */
 
 /*
diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 7b77cbdf739c..524fdcda9f85 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -232,6 +232,33 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 }
 
 /**
+ * irq_build_affinity - build affinity masks for multiqueue spreading
+ * @affd:	Description of the affinity requirements
+ * @startvec:	The start vector for building affinity masks
+ * @numvec:	The number of vectors is needed for building affinity
+ * @firstvec:	It is the IRQ vector which we jump to for continue spread
+ * 		after the last vector(@startvec + @numvec - 1) is built.
+ * @masks:	The mask array for storing the affinity masks
+ * @nmasks:	The total number of @masks
+ *
+ * Both @startvec and @firstvec are relative to the 1st irq vectorc
+ * allocated to the device.
+ *
+ * Returns 0 if affinty masks is built successfully.
+ */
+int irq_build_affinity(const struct irq_affinity *affd, int startvec,
+		       int numvecs, int firstvec,
+		       struct irq_affinity_desc *masks, int nmasks)
+{
+	if (startvec >= nmasks || firstvec >= nmasks || numvecs > nmasks)
+		return -EINVAL;
+
+	return irq_build_affinity_masks(affd, startvec, numvecs, firstvec,
+					masks);
+}
+EXPORT_SYMBOL_GPL(irq_build_affinity);
+
+/**
  * irq_create_affinity_masks - Create affinity masks for multiqueue spreading
  * @nvecs:	The total number of vectors
  * @affd:	Description of the affinity requirements
-- 
2.9.5

