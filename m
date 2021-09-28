Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FA15C433F5
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 00:56:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 80C0361205
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 00:56:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238434AbhI1A6S (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:58:18 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60237 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238451AbhI1A6Q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 20:58:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632790597;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yx3CKjzfifLZuvsmKfKPxJm45kH1LWGVrXCZ9eoFqpc=;
        b=BxlsK/oFm3REocGOpCL4L9mZSsqlpSt8uNbKqdCudEbLs6TvmNQibP0TRtaWIhn0SXN7pf
        pTRUJZHfPcXSiuuBQGJt5WmgZYJ5g9/G1B6Mr9OZbDR7CQ5AzZ2zcHUYC5lVBKvCAhwM8v
        P9yU9v913XYpwT/koiljeHHVTgaZ4gQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-332-I1dQv5aFN-SvGAP7mZY8tQ-1; Mon, 27 Sep 2021 20:56:35 -0400
X-MC-Unique: I1dQv5aFN-SvGAP7mZY8tQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA6E8824FA6;
        Tue, 28 Sep 2021 00:56:34 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74758669F3;
        Tue, 28 Sep 2021 00:56:31 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 3/7] genirq/affinity: don't pass irq_affinity_desc array to irq_build_affinity_masks
Date:   Tue, 28 Sep 2021 08:55:54 +0800
Message-Id: <20210928005558.243352-4-ming.lei@redhat.com>
In-Reply-To: <20210928005558.243352-1-ming.lei@redhat.com>
References: <20210928005558.243352-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Prepare for abstracting irq_build_affinity_masks() into one public helper
for assigning all CPUs evenly into several groups. Don't pass
irq_affinity_desc array to irq_build_affinity_masks, instead return
a cpumask array by storing each assigned group into one element of
the array.

This way helps us to provide generic interface for grouping all CPUs
evenly from NUMA and CPU locality viewpoint, and the cost is one extra
allocation in irq_build_affinity_masks(), which should be fine since
it is done via GFP_KERNEL and irq_build_affinity_masks() is called very
less.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 kernel/irq/affinity.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/kernel/irq/affinity.c b/kernel/irq/affinity.c
index 0bc83d57cb34..aef12ec05dcf 100644
--- a/kernel/irq/affinity.c
+++ b/kernel/irq/affinity.c
@@ -249,7 +249,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 				      cpumask_var_t *node_to_cpumask,
 				      const struct cpumask *cpu_mask,
 				      struct cpumask *nmsk,
-				      struct irq_affinity_desc *masks)
+				      struct cpumask *masks)
 {
 	unsigned int i, n, nodes, cpus_per_vec, extra_vecs, done = 0;
 	unsigned int last_affv = numvecs;
@@ -268,7 +268,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 	 */
 	if (numvecs <= nodes) {
 		for_each_node_mask(n, nodemsk) {
-			cpumask_or(&masks[curvec].mask, &masks[curvec].mask,
+			cpumask_or(&masks[curvec], &masks[curvec],
 				   node_to_cpumask[n]);
 			if (++curvec == last_affv)
 				curvec = 0;
@@ -320,7 +320,7 @@ static int __irq_build_affinity_masks(unsigned int startvec,
 			 */
 			if (curvec >= last_affv)
 				curvec = 0;
-			irq_spread_init_one(&masks[curvec].mask, nmsk,
+			irq_spread_init_one(&masks[curvec], nmsk,
 						cpus_per_vec);
 		}
 		done += nv->nvectors;
@@ -334,16 +334,16 @@ static int __irq_build_affinity_masks(unsigned int startvec,
  *	1) spread present CPU on these vectors
  *	2) spread other possible CPUs on these vectors
  */
-static int irq_build_affinity_masks(unsigned int numvecs,
-				    struct irq_affinity_desc *masks)
+static struct cpumask *irq_build_affinity_masks(unsigned int numvecs)
 {
 	unsigned int curvec = 0, nr_present = 0, nr_others = 0;
 	cpumask_var_t *node_to_cpumask;
 	cpumask_var_t nmsk, npresmsk;
 	int ret = -ENOMEM;
+	struct cpumask *masks = NULL;
 
 	if (!zalloc_cpumask_var(&nmsk, GFP_KERNEL))
-		return ret;
+		return NULL;
 
 	if (!zalloc_cpumask_var(&npresmsk, GFP_KERNEL))
 		goto fail_nmsk;
@@ -352,6 +352,10 @@ static int irq_build_affinity_masks(unsigned int numvecs,
 	if (!node_to_cpumask)
 		goto fail_npresmsk;
 
+	masks = kcalloc(numvecs, sizeof(*masks), GFP_KERNEL);
+	if (!masks)
+		goto fail_node_to_cpumask;
+
 	/* Stabilize the cpumasks */
 	cpus_read_lock();
 	build_node_to_cpumask(node_to_cpumask);
@@ -385,6 +389,7 @@ static int irq_build_affinity_masks(unsigned int numvecs,
 	if (ret >= 0)
 		WARN_ON(nr_present + nr_others < numvecs);
 
+ fail_node_to_cpumask:
 	free_node_to_cpumask(node_to_cpumask);
 
  fail_npresmsk:
@@ -392,7 +397,11 @@ static int irq_build_affinity_masks(unsigned int numvecs,
 
  fail_nmsk:
 	free_cpumask_var(nmsk);
-	return ret < 0 ? ret : 0;
+	if (ret < 0) {
+		kfree(masks);
+		return NULL;
+	}
+	return masks;
 }
 
 static void default_calc_sets(struct irq_affinity *affd, unsigned int affvecs)
@@ -456,13 +465,18 @@ irq_create_affinity_masks(unsigned int nvecs, struct irq_affinity *affd)
 	 */
 	for (i = 0, usedvecs = 0; i < affd->nr_sets; i++) {
 		unsigned int this_vecs = affd->set_size[i];
-		int ret;
+		int j;
+		struct cpumask *result = irq_build_affinity_masks(this_vecs);
 
-		ret = irq_build_affinity_masks(this_vecs, &masks[curvec]);
-		if (ret) {
+		if (!result) {
 			kfree(masks);
 			return NULL;
 		}
+
+		for (j = 0; j < this_vecs; j++)
+			cpumask_copy(&masks[curvec + j].mask, &result[j]);
+		kfree(result);
+
 		curvec += this_vecs;
 		usedvecs += this_vecs;
 	}
-- 
2.31.1

