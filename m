Return-Path: <SRS0=R/PO=VW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C12EEC7618B
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 07:56:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 89F62217F4
	for <linux-block@archiver.kernel.org>; Thu, 25 Jul 2019 07:56:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388664AbfGYH4Q (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 25 Jul 2019 03:56:16 -0400
Received: from mx1.redhat.com ([209.132.183.28]:51200 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388637AbfGYH4Q (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 25 Jul 2019 03:56:16 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 5E2DA3E2D7;
        Thu, 25 Jul 2019 07:56:16 +0000 (UTC)
Received: from localhost (ovpn-8-25.pek2.redhat.com [10.72.8.25])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5DE665C8A3;
        Thu, 25 Jul 2019 07:56:09 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Ming Lei <ming.lei@redhat.com>,
        Yi Zhang <yi.zhang@redhat.com>
Subject: [PATCH] blk-mq: balance mapping between CPUs and queues
Date:   Thu, 25 Jul 2019 15:56:04 +0800
Message-Id: <20190725075604.1106-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.5.16 (mx1.redhat.com [10.5.110.30]); Thu, 25 Jul 2019 07:56:16 +0000 (UTC)
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Spread queues among present CPUs first, then building the mapping
on other non-present CPUs.

So we can minimize count of dead queues which are mapped by un-present
CPUs only. Then bad IO performance can be avoided by this unbalanced
mapping between CPUs and queues.

The similar policy has been applied on Managed IRQ affinity.

Reported-by: Yi Zhang <yi.zhang@redhat.com>
Cc: Yi Zhang <yi.zhang@redhat.com>
Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-cpumap.c | 34 +++++++++++++++++++++++-----------
 1 file changed, 23 insertions(+), 11 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index f945621a0e8f..e217f3404dc7 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -15,10 +15,9 @@
 #include "blk.h"
 #include "blk-mq.h"
 
-static int cpu_to_queue_index(struct blk_mq_queue_map *qmap,
-			      unsigned int nr_queues, const int cpu)
+static int queue_index(struct blk_mq_queue_map *qmap, const int q)
 {
-	return qmap->queue_offset + (cpu % nr_queues);
+	return qmap->queue_offset + q;
 }
 
 static int get_first_sibling(unsigned int cpu)
@@ -36,23 +35,36 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 {
 	unsigned int *map = qmap->mq_map;
 	unsigned int nr_queues = qmap->nr_queues;
-	unsigned int cpu, first_sibling;
+	unsigned int cpu, first_sibling, q = 0;
+
+	for_each_possible_cpu(cpu)
+		map[cpu] = -1;
+
+	/*
+	 * Spread queues among present CPUs first for minimizing
+	 * count of dead queues which are mapped by all un-present CPUs
+	 */
+	for_each_present_cpu(cpu) {
+		if (q >= nr_queues)
+			break;
+		map[cpu] = queue_index(qmap, q++);
+	}
 
 	for_each_possible_cpu(cpu) {
+		if (map[cpu] != -1)
+			continue;
 		/*
 		 * First do sequential mapping between CPUs and queues.
 		 * In case we still have CPUs to map, and we have some number of
 		 * threads per cores then map sibling threads to the same queue
 		 * for performance optimizations.
 		 */
-		if (cpu < nr_queues) {
-			map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
+		first_sibling = get_first_sibling(cpu);
+		if (first_sibling == cpu) {
+			map[cpu] = queue_index(qmap, q);
+			q = (q + 1) % nr_queues;
 		} else {
-			first_sibling = get_first_sibling(cpu);
-			if (first_sibling == cpu)
-				map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
-			else
-				map[cpu] = map[first_sibling];
+			map[cpu] = map[first_sibling];
 		}
 	}
 
-- 
2.20.1

