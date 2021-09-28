Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5262C433F5
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 00:56:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 99EDD60187
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 00:56:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238435AbhI1A6M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:58:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:20147 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238443AbhI1A6J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 20:58:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632790590;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=DXZ1UkZvOp5ivfZXdOvI0cQezxNJWCXaEdQUq/JUPyM=;
        b=OusLjvToy3pkk70egbcWyg+MqI9eSeND9OsFZZ29D8jVBOpzkC2NNMUbPSz+OHhvPEFErr
        Re829+GQZzinMju71k/duGLSvl7oWHiKSlOV1PqWWxbRgW2JeA+RISbVxjWiZ1ngkoavmm
        EwhZ5FA1pPZpExVaBuLfGs4W6G5l0Tw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-348-kiEvHUwANSmK33hNRm5JSw-1; Mon, 27 Sep 2021 20:56:29 -0400
X-MC-Unique: kiEvHUwANSmK33hNRm5JSw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6ED9D824FA7;
        Tue, 28 Sep 2021 00:56:28 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 4E1525C1D0;
        Tue, 28 Sep 2021 00:56:24 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 2/7] genirq/affinity: pass affinity managed mask array to irq_build_affinity_masks
Date:   Tue, 28 Sep 2021 08:55:53 +0800
Message-Id: <20210928005558.243352-3-ming.lei@redhat.com>
In-Reply-To: <20210928005558.243352-1-ming.lei@redhat.com>
References: <20210928005558.243352-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Pass affinity managed mask array to irq_build_affinity_masks() so that
index of the first affinity managed vector is always zero, then we can
simplify the implementation a bit.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 28 ++++++++++++----------------
 1 file changed, 12 insertions(+), 16 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 856ab6d39c05..0bc83d57cb34 100644
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
 
@@ -462,7 +458,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 		unsigned int this_vecs = affd->set_size[i];
 		int ret;
 
-		ret = irq_build_affinity_masks(curvec, this_vecs, masks);
+		ret = irq_build_affinity_masks(this_vecs, &masks[curvec]);
 		if (ret) {
 			kfree(masks);
 			return NULL;
-- 
2.31.1

