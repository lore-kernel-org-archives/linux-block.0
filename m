Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8822C3DA79
	for <linux-block@archiver.kernel.org>; Tue, 27 Dec 2022 02:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232598AbiL0CaM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Dec 2022 21:30:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbiL0CaH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Dec 2022 21:30:07 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9065FA3
        for <linux-block@vger.kernel.org>; Mon, 26 Dec 2022 18:29:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1672108168;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8s9N4odoxU9TLcs2ylQzubyo1NqVpZprjNLrRaHWiXo=;
        b=BgQ6KngzUD8oxyHgXrZHw5f6uUPvlKfEGbP0fmeB4v31hxcLQsq79JU6doOF+iiq/LDLmw
        xb5vQlNeKv/tR9SNIGyk8CvKg2Ks9ZPPhlhw7Pk2raaxLvRxNsWBZFHVhA4Bcy1K3EK+ru
        LczZT1xXaAejP27Rkg+kl7zLccR1tB8=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-541-oY-z5lflOfCpSRNfuXqwcQ-1; Mon, 26 Dec 2022 21:29:22 -0500
X-MC-Unique: oY-z5lflOfCpSRNfuXqwcQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.rdu2.redhat.com [10.11.54.4])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3DD2F811E6E;
        Tue, 27 Dec 2022 02:29:22 +0000 (UTC)
Received: from localhost (ovpn-8-22.pek2.redhat.com [10.72.8.22])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 413732026D4B;
        Tue, 27 Dec 2022 02:29:20 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>,
        John Garry <john.garry@huawei.com>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 2/6] genirq/affinity: Pass affinity managed mask array to irq_build_affinity_masks
Date:   Tue, 27 Dec 2022 10:29:01 +0800
Message-Id: <20221227022905.352674-3-ming.lei@redhat.com>
In-Reply-To: <20221227022905.352674-1-ming.lei@redhat.com>
References: <20221227022905.352674-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.4
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
index 3361e36ebaa1..da6379cd27fd 100644
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
@@ -273,7 +272,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 			cpumask_and(nmsk, cpu_mask, node_to_cpumask[n]);
 			cpumask_or(&masks[curvec].mask, &masks[curvec].mask, nmsk);
 			if (++curvec == last_affv)
-				curvec = firstvec;
+				curvec = 0;
 		}
 		return numvecs;
 	}
@@ -321,7 +320,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 			 * may start anywhere
 			 */
 			if (curvec >= last_affv)
-				curvec = firstvec;
+				curvec = 0;
 			irq_spread_init_one(&masks[curvec].mask, nmsk,
 						cpus_per_vec);
 		}
@@ -336,11 +335,10 @@ static int __irq_build_affinity_masks(unsigned int startvec,
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
@@ -360,9 +358,8 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
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
@@ -374,13 +371,12 @@ static int irq_build_affinity_masks(unsigned int startvec, unsigned int numvecs,
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
 
@@ -463,7 +459,7 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 		unsigned int this_vecs = affd->set_size[i];
 		int ret;
 
-		ret = irq_build_affinity_masks(curvec, this_vecs, masks);
+		ret = irq_build_affinity_masks(this_vecs, &masks[curvec]);
 		if (ret) {
 			kfree(masks);
 			return NULL;
-- 
2.31.1

