Return-Path: <SRS0=AbZH=R4=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DECFC43381
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 15:27:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9AF6208E4
	for <linux-block@archiver.kernel.org>; Mon, 25 Mar 2019 15:27:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alibaba-inc.com header.i=@alibaba-inc.com header.b="XfDEhfGU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726214AbfCYP1X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 25 Mar 2019 11:27:23 -0400
Received: from out0-155.mail.aliyun.com ([140.205.0.155]:35438 "EHLO
        out0-155.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726203AbfCYP1W (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 25 Mar 2019 11:27:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alibaba-inc.com; s=default;
        t=1553527630; h=From:To:Subject:Date:Message-Id;
        bh=jiJapBog30szdJZwNcqicqXvLmGj0FCkcBHUcQiZPUQ=;
        b=XfDEhfGUO2kvpJt2MWEyrs9yVRdWGJdCxab+Xc5HiopirkeIGa2/EsDORpWKRCZmQqDNkbkEiW3sWYxsZJMCfoqQhVJRib/gzgNDdjlHAlk1m+lA3cxASsa5HHNB2HuLV3YwKAg8L0TI3xNxvfCsR+EYvovIfL1b3LlUK8XC3fk=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01a16368;MF=xuyun.xy@alibaba-inc.com;NM=1;PH=DS;RN=7;SR=0;TI=SMTPD_---.ECVXSGc_1553527622;
Received: from localhost(mailfrom:xuyun.xy@alibaba-inc.com fp:SMTPD_---.ECVXSGc_1553527622)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 25 Mar 2019 23:27:08 +0800
From:   luferry <luferry@163.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dongli Zhang <dongli.zhang@oracle.com>,
        Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        xuyun <luferry@163.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] make blk_mq_map_queues more friendly for cpu topology
Date:   Mon, 25 Mar 2019 23:26:40 +0800
Message-Id: <20190325152640.48120-1-luferry@163.com>
X-Mailer: git-send-email 2.14.1.40.g8e62ba1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

under virtual machine environment, cpu topology may differ
from normal physical server.

for example (machine with 4 cores, 2 threads per core):

normal physical server:
core-id   thread-0-id  thread-1-id
0         0            4
1         1            5
2         2            6
3         3            7

virtual machine:
core-id   thread-0-id  thread-1-id
0         0            1
1         2            3
2         4            5
3         6            7

If we attach disk with multi queues to virtual machine,
blk_mq_map_queues can cause serious imbalance.this will lead to
performance impact on system IO.

Here is the qemu cmdline:
"-smp 8,sockets=1,cores=8,threads=2"
"-device virtio-blk-pci,drive=drive0,id=device0,num-queues=4,vectors=2"

when vectors less than num-queues, virtio-blk will fallback to
blk_mq_map_queues

Before this patch:
[root@blk-mq ~]# cat /sys/block/vd*/mq/*/cpu_list
0, 4, 5, 8, 9, 12, 13
1
2, 6, 7, 10, 11, 14, 15
3

After this patch:
[root@blk-mq ~]# cat /sys/block/vd*/mq/*/cpu_list
0, 1, 8, 9
2, 3, 10, 11
4, 5, 12, 13
6, 7, 14, 15

Signed-off-by: luferry <luferry@163.com>
---
 block/blk-mq-cpumap.c | 31 +++++++++++++++++++++++--------
 1 file changed, 23 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 03a534820271..2eb78ad4a49b 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -35,22 +35,37 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 {
 	unsigned int *map = qmap->mq_map;
 	unsigned int nr_queues = qmap->nr_queues;
-	unsigned int cpu, first_sibling;
+	unsigned int cpu, first_sibling, core = 0;
+	bool core_map = false;
 
+	/*
+	 * If core num is euqal or over nr_queues,
+	 * there be sure at least per core per queue
+	 */
+	for_each_possible_cpu(cpu) {
+		if (get_first_sibling(cpu) == cpu)
+			core++;
+	}
+	if (core >= nr_queues)
+		core_map = true;
+
+	core = 0;
 	for_each_possible_cpu(cpu) {
 		/*
-		 * First do sequential mapping between CPUs and queues.
-		 * In case we still have CPUs to map, and we have some number of
-		 * threads per cores then map sibling threads to the same queue for
+		 * If cores is enough, just do map between cores and queues
+		 * else will do sequential mapping between CPUs and queues first.
+		 * For other cpus, we have some number of threads per cores
+		 * then map sibling threads to the same queue for
 		 * performace optimizations.
 		 */
-		if (cpu < nr_queues) {
+		if (!core_map && cpu < nr_queues) {
 			map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
 		} else {
 			first_sibling = get_first_sibling(cpu);
-			if (first_sibling == cpu)
-				map[cpu] = cpu_to_queue_index(qmap, nr_queues, cpu);
-			else
+			if (first_sibling == cpu) {
+				map[cpu] = cpu_to_queue_index(qmap, nr_queues, core);
+				core++;
+			} else
 				map[cpu] = map[first_sibling];
 		}
 	}
-- 
2.14.1.40.g8e62ba1

