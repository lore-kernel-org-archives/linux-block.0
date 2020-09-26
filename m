Return-Path: <SRS0=UEoe=DD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15481C4727C
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 02:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C48D22087D
	for <linux-block@archiver.kernel.org>; Sat, 26 Sep 2020 02:47:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726149AbgIZCrS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 25 Sep 2020 22:47:18 -0400
Received: from smtp.h3c.com ([60.191.123.50]:39869 "EHLO h3cspam02-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725208AbgIZCrS (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 25 Sep 2020 22:47:18 -0400
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam02-ex.h3c.com with ESMTPS id 08Q2kvxm021903
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Sat, 26 Sep 2020 10:46:57 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Sat, 26 Sep 2020 10:46:58 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] [v3] blk-mq: add cond_resched() in __blk_mq_alloc_rq_maps()
Date:   Sat, 26 Sep 2020 10:39:47 +0800
Message-ID: <20200926023947.1891-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP02-EX.srv.huawei-3com.com (10.63.20.133) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam02-ex.h3c.com 08Q2kvxm021903
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We found blk_mq_alloc_rq_maps() takes more time in kernel space when
testing nvme device hot-plugging. The test and anlysis as below.

Debug code,
1, blk_mq_alloc_rq_maps():
        u64 start, end;
        depth = set->queue_depth;
        start = ktime_get_ns();
        pr_err("[%d:%s switch:%ld,%ld] queue depth %d, nr_hw_queues %d\n",
                        current->pid, current->comm, current->nvcsw, current->nivcsw,
                        set->queue_depth, set->nr_hw_queues);
        do {
                err = __blk_mq_alloc_rq_maps(set);
                if (!err)
                        break;

                set->queue_depth >>= 1;
                if (set->queue_depth < set->reserved_tags + BLK_MQ_TAG_MIN) {
                        err = -ENOMEM;
                        break;
                }
        } while (set->queue_depth);
        end = ktime_get_ns();
        pr_err("[%d:%s switch:%ld,%ld] all hw queues init cost time %lld ns\n",
                        current->pid, current->comm,
                        current->nvcsw, current->nivcsw, end - start);

2, __blk_mq_alloc_rq_maps():
        u64 start, end;
        for (i = 0; i < set->nr_hw_queues; i++) {
                start = ktime_get_ns();
                if (!__blk_mq_alloc_rq_map(set, i))
                        goto out_unwind;
                end = ktime_get_ns();
                pr_err("hw queue %d init cost time %lld ns\n", i, end - start);
        }

Test nvme hot-plugging with above debug code, we found it totally cost more
than 3ms in kernel space without being scheduled out when alloc rqs for all
16 hw queues with depth 1023, each hw queue cost about 140-250us. The cost
time will be increased with hw queue number and queue depth increasing. And
in an extreme case, if __blk_mq_alloc_rq_maps() returns -ENOMEM, it will try
"queue_depth >>= 1", more time will be consumed.
	[  428.428771] nvme nvme0: pci function 10000:01:00.0
	[  428.428798] nvme 10000:01:00.0: enabling device (0000 -> 0002)
	[  428.428806] pcieport 10000:00:00.0: can't derive routing for PCI INT A
	[  428.428809] nvme 10000:01:00.0: PCI INT A: no GSI
	[  432.593374] [4688:kworker/u33:8 switch:663,2] queue depth 30, nr_hw_queues 1
	[  432.593404] hw queue 0 init cost time 22883 ns
	[  432.593408] [4688:kworker/u33:8 switch:663,2] all hw queues init cost time 35960 ns
	[  432.595953] nvme nvme0: 16/0/0 default/read/poll queues
	[  432.595958] [4688:kworker/u33:8 switch:700,2] queue depth 1023, nr_hw_queues 16
	[  432.596203] hw queue 0 init cost time 242630 ns
	[  432.596441] hw queue 1 init cost time 235913 ns
	[  432.596659] hw queue 2 init cost time 216461 ns
	[  432.596877] hw queue 3 init cost time 215851 ns
	[  432.597107] hw queue 4 init cost time 228406 ns
	[  432.597336] hw queue 5 init cost time 227298 ns
	[  432.597564] hw queue 6 init cost time 224633 ns
	[  432.597785] hw queue 7 init cost time 219954 ns
	[  432.597937] hw queue 8 init cost time 150930 ns
	[  432.598082] hw queue 9 init cost time 143496 ns
	[  432.598231] hw queue 10 init cost time 147261 ns
	[  432.598397] hw queue 11 init cost time 164522 ns
	[  432.598542] hw queue 12 init cost time 143401 ns
	[  432.598692] hw queue 13 init cost time 148934 ns
	[  432.598841] hw queue 14 init cost time 147194 ns
	[  432.598991] hw queue 15 init cost time 148942 ns
	[  432.598993] [4688:kworker/u33:8 switch:700,2] all hw queues init cost time 3035099 ns
	[  432.602611]  nvme0n1: p1

So use this patch to trigger schedule between each hw queue init, to avoid
other threads getting stuck. It is not in atomic context when executing
__blk_mq_alloc_rq_maps(), so it is safe to call cond_resched().

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 block/blk-mq.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b3d2785ee..62d152d03 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3256,9 +3256,11 @@ static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 {
 	int i;
 
-	for (i = 0; i < set->nr_hw_queues; i++)
+	for (i = 0; i < set->nr_hw_queues; i++) {
 		if (!__blk_mq_alloc_map_and_request(set, i))
 			goto out_unwind;
+		cond_resched();
+	}
 
 	return 0;
 
-- 
2.17.1

