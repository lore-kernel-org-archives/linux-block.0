Return-Path: <SRS0=iCYb=RZ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,UNPARSEABLE_RELAY,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3B53C43381
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 10:10:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 618A7218B0
	for <linux-block@archiver.kernel.org>; Fri, 22 Mar 2019 10:10:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alibaba-inc.com header.i=@alibaba-inc.com header.b="bpqjAucu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727932AbfCVKKJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 22 Mar 2019 06:10:09 -0400
Received: from out0-147.mail.aliyun.com ([140.205.0.147]:53569 "EHLO
        out0-147.mail.aliyun.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727919AbfCVKKJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 22 Mar 2019 06:10:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=alibaba-inc.com; s=default;
        t=1553249405; h=From:To:Subject:Date:Message-Id;
        bh=CESTLGwAfcQfHJ2H49WSr6BzPB3M2SoBVB9y8nCwm+Y=;
        b=bpqjAucuZ3VIB7kQvQ+pteYLMwbGi/hVZamdTdM/wxS5mMmIpJZLLF6M+KmWUCcr6q2/5NjPS4Aizc3eqq8CZ5mUia29xO8d+O0+ViLWmcmVoO9MB8uIHSdhdvwEH6wJX7O5hv1GLKWgJNAPVdWrfgarpLQOPB0tHfsUai2vAt8=
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e02c03299;MF=xuyun.xy@alibaba-inc.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---.EBGcyQx_1553249398;
Received: from localhost(mailfrom:xuyun.xy@alibaba-inc.com fp:SMTPD_---.EBGcyQx_1553249398)
          by smtp.aliyun-inc.com(127.0.0.1);
          Fri, 22 Mar 2019 18:10:04 +0800
From:   luferry <luferry@163.com>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Ming Lei <ming.lei@redhat.com>, Christoph Hellwig <hch@lst.de>,
        xuyun <luferry@163.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] block/mq: blk map queues by core id
Date:   Fri, 22 Mar 2019 18:09:49 +0800
Message-Id: <20190322100949.5555-1-luferry@163.com>
X-Mailer: git-send-email 2.14.1.40.g8e62ba1
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

under virtual machine environment, cpu topology may differ from normal
physical server.
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

When attach disk with two queues, all the even numbered cpus will be
mapped to queue 0. Under virtual machine, all the cpus is followed by
its sibling cpu.Before this patch, all the odd numbered cpus will also
be mapped to queue 0, can cause serious imbalance.this will lead to
performance impact on system IO

So suggest to allocate cpu map by core id, this can be more currency

Signed-off-by: luferry <luferry@163.com>
---
 block/blk-mq-cpumap.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 03a534820271..4125e8e77679 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -35,7 +35,7 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
 {
 	unsigned int *map = qmap->mq_map;
 	unsigned int nr_queues = qmap->nr_queues;
-	unsigned int cpu, first_sibling;
+	unsigned int cpu, first_sibling, core = 0;
 
 	for_each_possible_cpu(cpu) {
 		/*
@@ -48,9 +48,10 @@ int blk_mq_map_queues(struct blk_mq_queue_map *qmap)
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

