Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDBBCC433F5
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 00:57:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B0DED611CE
	for <linux-block@archiver.kernel.org>; Tue, 28 Sep 2021 00:57:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238469AbhI1A6o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Sep 2021 20:58:44 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:29500 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238479AbhI1A6m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Sep 2021 20:58:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1632790623;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jEAum1p+Sq90qsNOW7FriDcJ9zjYOTdm8PupmSbR43g=;
        b=PORFgKs5NPkSR/d7JRsuJFxdTxSQ/mCe4KVNmy3ENS8H0U77SwXfVRaIfho82TbM56B0p7
        xorPXGrnWQHDswkwl9kGhe9pqswWxQW/nCQcG+3+N/pcap61wnHQYGsKFpwDPIZBIhzMAJ
        0mj87PIVN1odeITUG8+x3aR56A7XkHg=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-446-QpYr3rEsNl2bExwZkMpG6Q-1; Mon, 27 Sep 2021 20:57:02 -0400
X-MC-Unique: QpYr3rEsNl2bExwZkMpG6Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 31A1C108087A;
        Tue, 28 Sep 2021 00:57:01 +0000 (UTC)
Received: from localhost (ovpn-8-18.pek2.redhat.com [10.72.8.18])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 65E4E3AEB;
        Tue, 28 Sep 2021 00:56:57 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Thomas Gleixner <tglx@linutronix.de>, Jens Axboe <axboe@kernel.dk>
Cc:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V3 7/7] blk-mq: build default queue map via group_cpus_evenly()
Date:   Tue, 28 Sep 2021 08:55:58 +0800
Message-Id: <20210928005558.243352-8-ming.lei@redhat.com>
In-Reply-To: <20210928005558.243352-1-ming.lei@redhat.com>
References: <20210928005558.243352-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The default queue mapping builder of blk_mq_map_queues doesn't take NUMA
topo into account, so the built mapping is pretty bad, since CPUs
belonging to different NUMA node are assigned to same queue. It is
observed that IOPS drops by ~30% when running two jobs on same hctx
of null_blk from two CPUs belonging to two NUMA nodes compared with
from same NUMA node.

Address the issue by reusing group_cpus_evenly() for addressing the
issue since group_cpus_evenly() does group cpus according to CPU/NUMA
locality.

Lots of drivers may benefit from the change, such as nvme pci poll,
nvme tcp, ...

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-cpumap.c | 65 ++++++++++---------------------------------
 1 file changed, 14 insertions(+), 51 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 3db84d3197f1..b610a55eea66 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -10,67 +10,30 @@
 #include <linux/mm.h>
 #include <linux/smp.h>
 #include <linux/cpu.h>
+#include <linux/group_cpus.h>
 
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
-	unsigned int *map = qmap->mq_map;
-	unsigned int nr_queues = qmap->nr_queues;
-	unsigned int cpu, first_sibling, q = 0;
-
-	for_each_possible_cpu(cpu)
-		map[cpu] = -1;
+	const struct cpumask *masks;
+	unsigned int queue, cpu;
 
-	/*
-	 * Spread queues among present CPUs first for minimizing
-	 * count of dead queues which are mapped by all un-present CPUs
-	 */
-	for_each_present_cpu(cpu) {
-		if (q >= nr_queues)
-			break;
-		map[cpu] = queue_index(qmap, nr_queues, q++);
-	}
+	masks = group_cpus_evenly(qmap->nr_queues);
+	if (!masks)
+		goto fallback;
 
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
+	for (queue = 0; queue < qmap->nr_queues; queue++) {
+		for_each_cpu(cpu, &masks[queue])
+			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
-
+	kfree(masks);
+	return 0;
+ fallback:
+	for_each_possible_cpu(cpu)
+		qmap->mq_map[cpu] = qmap->queue_offset;
 	return 0;
 }
 EXPORT_SYMBOL_GPL(blk_mq_map_queues);
-- 
2.31.1

