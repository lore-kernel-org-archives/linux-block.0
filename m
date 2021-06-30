Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E74BDC11F65
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 03:52:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF0561D18
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 03:52:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232840AbhF3Dyh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jun 2021 23:54:37 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:60719 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232327AbhF3Dyg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jun 2021 23:54:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625025128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=T1dl9D9ApMIKd4R/7HXKlSNn2WJcXfZn9zlOzx5EGbc=;
        b=U/eALJf9nzU3TVhq3eaA56rwKL8mHCGX/1usaSfVMgRPceL7svIBKtKtRfVRxO6WMgWOYG
        jTii4DJB6mxSu/SOIqo2gbrVrnLWbOh+uin3B9MFAvQw4L3jgdcuMiwI7+mZEXaMsmjLfV
        JNSH8hVVSVhmdtidVDnSGVvWhmAY0YQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-526-4YXc7vW7NmW54rG3Isdl-w-1; Tue, 29 Jun 2021 23:52:06 -0400
X-MC-Unique: 4YXc7vW7NmW54rG3Isdl-w-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id AA943106B7E6;
        Wed, 30 Jun 2021 03:52:05 +0000 (UTC)
Received: from localhost (ovpn-12-77.pek2.redhat.com [10.72.12.77])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 84B6068D95;
        Wed, 30 Jun 2021 03:51:58 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH] block: build default queue map via irq_create_affinity_masks
Date:   Wed, 30 Jun 2021 11:51:53 +0800
Message-Id: <20210630035153.2099975-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The default queue mapping builder of blk_mq_map_queues doesn't take NUMA
topo into account, so the built mapping is pretty bad, since CPUs
belonging to different NUMA node are assigned to same queue. It is
observed that IOPS drops by ~30% when running two jobs on same hctx
of null_blk from two CPUs belonging to two NUMA nodes compared with
from same NUMA node.

Address the issue by reusing irq_create_affinity_masks() for building
the default queue mapping, so that we can re-use the mapping created
for managed irq.

Lots of drivers may benefit from the change, such as nvme pci poll,
nvme tcp, ...

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-cpumap.c | 60 +++++++++----------------------------------
 1 file changed, 12 insertions(+), 48 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 3db84d3197f1..946e373296a3 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -10,67 +10,31 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/cpu.h>
+#include <linux/interrupt.h>
 
 #include <linux/blk-mq.h>
 #include "blk.h"
 #include "blk-mq.h"
 
-static int queue_index(struct blk_mq_queue_map *qmap,
-		       unsigned int nr_queues, const int q)
-{
-	return qmap->queue_offset + (q % nr_queues);
-}
-
-static int get_first_sibling(unsigned int cpu)
-{
-	unsigned int ret;
-
-	ret = cpumask_first(topology_sibling_cpumask(cpu));
-	if (ret < nr_cpu_ids)
-		return ret;
-
-	return cpu;
-}
-
 int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 {
+	struct irq_affinity_desc *masks = NULL;
+	struct irq_affinity affd = {0};
 	unsigned int *map = qmap->mq_map;
 	unsigned int nr_queues = qmap->nr_queues;
-	unsigned int cpu, first_sibling, q = 0;
+	unsigned int q;
 
-	for_each_possible_cpu(cpu)
-		map[cpu] = -1;
+	masks = irq_create_affinity_masks(nr_queues, &affd);
+	if (!masks)
+		return -ENOMEM;
 
-	/*
-	 * Spread queues among present CPUs first for minimizing
-	 * count of dead queues which are mapped by all un-present CPUs
-	 */
-	for_each_present_cpu(cpu) {
-		if (q >= nr_queues)
-			break;
-		map[cpu] = queue_index(qmap, nr_queues, q++);
-	}
+	for (q = 0; q < nr_queues; q++) {
+		unsigned int cpu;
 
-	for_each_possible_cpu(cpu) {
-		if (map[cpu] != -1)
-			continue;
-		/*
-		 * First do sequential mapping between CPUs and queues.
-		 * In case we still have CPUs to map, and we have some number of
-		 * threads per cores then map sibling threads to the same queue
-		 * for performance optimizations.
-		 */
-		if (q < nr_queues) {
-			map[cpu] = queue_index(qmap, nr_queues, q++);
-		} else {
-			first_sibling = get_first_sibling(cpu);
-			if (first_sibling == cpu)
-				map[cpu] = queue_index(qmap, nr_queues, q++);
-			else
-				map[cpu] = map[first_sibling];
-		}
+		for_each_cpu(cpu, &masks[q].mask)
+			map[cpu] = q;
 	}
-
+	kfree(masks);
 	return 0;
 }
 EXPORT_SYMBOL_GPL(blk_mq_map_queues);
-- 
2.31.1

