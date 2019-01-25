Return-Path: <SRS0=J6N0=QB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 182D1C282C0
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:54:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E4CAD2084A
	for <linux-block@archiver.kernel.org>; Fri, 25 Jan 2019 09:54:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728223AbfAYJyM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Jan 2019 04:54:12 -0500
Received: from mx1.redhat.com ([209.132.183.28]:47404 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727975AbfAYJyM (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Jan 2019 04:54:12 -0500
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id BCB4413268F;
        Fri, 25 Jan 2019 09:54:11 +0000 (UTC)
Received: from localhost (ovpn-8-28.pek2.redhat.com [10.72.8.28])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 299EA5B6B0;
        Fri, 25 Jan 2019 09:54:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Christoph Hellwig <hch@lst.de>, Bjorn Helgaas <helgaas@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Sagi Grimberg <sagi@grimberg.me>,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 1/5] genirq/affinity: move allocation of 'node_to_cpumask' to irq_build_affinity_masks
Date:   Fri, 25 Jan 2019 17:53:43 +0800
Message-Id: <20190125095347.17950-2-ming.lei@redhat.com>
In-Reply-To: <20190125095347.17950-1-ming.lei@redhat.com>
References: <20190125095347.17950-1-ming.lei@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.38]); Fri, 25 Jan 2019 09:54:11 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

'node_to_cpumask' is just one temparay variable for irq_build_affinity_masks(),
so move it into irq_build_affinity_masks().

No functioanl change.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 27 +++++++++++++--------------
 1 file changed, 13 insertions(+), 14 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 45b68b4ea48b..118b66d64a53 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -175,18 +175,22 @@ static int __irq_build_affinity_masks(const struct irq_affinity *affd,
  */
 static int irq_build_affinity_masks(const struct irq_affinity *affd,
 				    int startvec, int numvecs, int firstvec,
-				    cpumask_var_t *node_to_cpumask,
 				    struct irq_affinity_desc *masks)
 {
 	int curvec = startvec, nr_present, nr_others;
 	int ret = -ENOMEM;
 	cpumask_var_t nmsk, npresmsk;
+	cpumask_var_t *node_to_cpumask;
 
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
 		return ret;
 
 	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
-		goto fail;
+		goto fail_nmsk;
+
+	node_to_cpumask = alloc_node_to_cpumask();
+	if (!node_to_cpumask)
+		goto fail_npresmsk;
 
 	ret = 0;
 	/* Stabilize the cpumasks */
@@ -217,9 +221,12 @@ static int irq_build_affinity_masks(const struct irq_affinity *affd,
 	if (nr_present < numvecs)
 		WARN_ON(nr_present + nr_others < numvecs);
 
+	free_node_to_cpumask(node_to_cpumask);
+
+ fail_npresmsk:
 	free_cpumask_var(npresmsk);
 
- fail:
+ fail_nmsk:
 	free_cpumask_var(nmsk);
 	return ret;
 }
@@ -236,7 +243,6 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 {
 	int affvecs = nvecs - affd->pre_vectors - affd->post_vectors;
 	int curvec, usedvecs;
-	cpumask_var_t *node_to_cpumask;
 	struct irq_affinity_desc *masks = NULL;
 	int i, nr_sets;
 
@@ -247,13 +253,9 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	if (nvecs == affd->pre_vectors + affd->post_vectors)
 		return NULL;
 
-	node_to_cpumask = alloc_node_to_cpumask();
-	if (!node_to_cpumask)
-		return NULL;
-
 	masks = kcalloc(nvecs, sizeof(*masks), GFP_KERNEL);
 	if (!masks)
-		goto outnodemsk;
+		return NULL;
 
 	/* Fill out vectors at the beginning that don't need affinity */
 	for (curvec = 0; curvec < affd->pre_vectors; curvec++)
@@ -271,11 +273,10 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 		int ret;
 
 		ret = irq_build_affinity_masks(affd, curvec, this_vecs,
-						curvec, node_to_cpumask, masks);
+						curvec, masks);
 		if (ret) {
 			kfree(masks);
-			masks = NULL;
-			goto outnodemsk;
+			return NULL;
 		}
 		curvec += this_vecs;
 		usedvecs += this_vecs;
@@ -293,8 +294,6 @@ irq_create_affinity_masks(int nvecs, const struct irq_affinity *affd)
 	for (i = affd->pre_vectors; i < nvecs - affd->post_vectors; i++)
 		masks[i].is_managed = 1;
 
-outnodemsk:
-	free_node_to_cpumask(node_to_cpumask);
 	return masks;
 }
 
-- 
2.9.5

