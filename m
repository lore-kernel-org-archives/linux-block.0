Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9082FC636C9
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 09:58:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D10261175
	for <linux-block@archiver.kernel.org>; Mon, 19 Jul 2021 09:58:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236099AbhGSJRX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 19 Jul 2021 05:17:23 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37610 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236141AbhGSJRW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 19 Jul 2021 05:17:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626688681;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=JaaLSZZcYBkVwNwp6ibcAolkUL10+1ObvBKOoa79GDo=;
        b=VTXv+I7RPsLZSV8bYLCN5kaF7oMW3dthURCNNLLluhFCMceEUicWbmCOo4qu/NoVWAOTb5
        M6HC6xNwZM7LyDzQTk4NEPdvNU8Dt19xXclccALJDfPRyH4nBwwAt4Whird2S0R4BrBfsS
        cd1qSKg70D8RH6fgXfdzeiVfhJUAxnk=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-479-onV5UmV-Ph2kwv7lA1xfsw-1; Mon, 19 Jul 2021 05:57:58 -0400
X-MC-Unique: onV5UmV-Ph2kwv7lA1xfsw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDE2F100C611;
        Mon, 19 Jul 2021 09:57:56 +0000 (UTC)
Received: from localhost (ovpn-12-118.pek2.redhat.com [10.72.12.118])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 481F95C1C5;
        Mon, 19 Jul 2021 09:57:51 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [RFC PATCH 2/7] genirq/affinity: pass affinity managed mask array to irq_build_affinity_masks
Date:   Mon, 19 Jul 2021 17:57:24 +0800
Message-Id: <20210719095729.834332-3-ming.lei@redhat.com>
In-Reply-To: <20210719095729.834332-1-ming.lei@redhat.com>
References: <20210719095729.834332-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass affinity managed mask array to irq_build_affinity_masks() so that
index of the first affinity managed vector is always zero, then we can
simplify the implementation a bit.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 0c535591f2f2..c8da750f393b 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -246,14 +246,13 @@ static void alloc_nodes_vectors(unsigned int numvecs,
 
 static int __irq_build_affinity_masks(unsigned int startvec,
 				      unsigned int numvecs,
-				      unsigned int firstvec,
 				      cpumask_var_t *node_to_cpumask,
 				      const struct cpumask *cpu_mask,
 				      struct cpumask *nmsk,
 				      struct irq_affinity_desc *masks)
 {
 	unsigned int i, n, nodes, cpus_per_vec, extra_vecs, done = 0;
-	unsigned int last_affv = firstvec + numvecs;
+	unsigned int last_affv = numvecs;
 	unsigned int curvec = startvec;
 	nodemask_t nodemsk = NODE_MASK_NONE;
 	struct node_vectors *node_vectors;
@@ -272,7 +271,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 			cpumask_or(&masks[curvec].mask, &masks[curvec].mask,
 				   node_to_cpumask[n]);
 			if (++curvec == last_affv)
-				curvec = firstvec;
+				curvec = 0;
 		}
 		return numvecs;
 	}
@@ -320,7 +319,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 			 * may start anywhere
 			 */
 			if (curvec >= last_affv)
-				curvec = firstvec;
+				curvec = 0;
 			irq_spread_init_one(&masks[curvec].mask, nmsk,
 						cpus_per_vec);
 		}
@@ -335,11 +334,10 @@ static int __irq_build_affinity_masks(unsigned int startvec,
  *	1) spread present CPU on these vectors
  *	2) spread other possible CPUs on these vectors
  */
-static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
+static int irq_build_affinity_masks(unsigned int numvecs,
 				    struct irq_affinity_desc *masks)
 {
-	unsigned int curvec = startvec, nr_present = 0, nr_others = 0;
-	unsigned int firstvec = startvec;
+	unsigned int curvec = 0, nr_present = 0, nr_others = 0;
 	cpumask_var_t *node_to_cpumask;
 	cpumask_var_t nmsk, npresmsk;
 	int ret = -ENOMEM;
@@ -359,9 +357,8 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 	build_node_to_cpumask(node_to_cpumask);
 
 	/* Spread on present CPUs starting from affd->pre_vectors */
-	ret = __irq_build_affinity_masks(curvec, numvecs, firstvec,
-					 node_to_cpumask, cpu_present_mask,
-					 nmsk, masks);
+	ret = __irq_build_affinity_masks(curvec, numvecs, node_to_cpumask,
+					 cpu_present_mask, nmsk, masks);
 	if (ret < 0)
 		goto fail_build_affinity;
 	nr_present = ret;
@@ -373,13 +370,12 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
 	 * out vectors.
 	 */
 	if (nr_present >= numvecs)
-		curvec = firstvec;
+		curvec = 0;
 	else
-		curvec = firstvec + nr_present;
+		curvec = nr_present;
 	cpumask_andnot(npresmsk, cpu_possible_mask, cpu_present_mask);
-	ret = __irq_build_affinity_masks(curvec, numvecs, firstvec,
-					 node_to_cpumask, npresmsk, nmsk,
-					 masks);
+	ret = __irq_build_affinity_masks(curvec, numvecs, node_to_cpumask,
+					 npresmsk, nmsk, masks);
 	if (ret >= 0)
 		nr_others = ret;
 
@@ -469,7 +465,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 		unsigned int this_vecs = affd->set_size[i];
 		int ret;
 
-		ret = irq_build_affinity_masks(curvec, this_vecs, masks);
+		ret = irq_build_affinity_masks(this_vecs, &masks[curvec]);
 		if (ret) {
 			kfree(masks);
 			return NULL;
-- 
2.31.1

