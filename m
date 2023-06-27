Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F4202EB64D9
	for <linux-block@archiver.kernel.org>; Tue, 27 Jun 2023 12:09:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230356AbjF0MJa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Jun 2023 08:09:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35190 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230310AbjF0MJ3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Jun 2023 08:09:29 -0400
X-Greylist: delayed 2198 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 27 Jun 2023 05:09:27 PDT
Received: from out-25.mta1.migadu.com (out-25.mta1.migadu.com [95.215.58.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6C92198D
        for <linux-block@vger.kernel.org>; Tue, 27 Jun 2023 05:09:27 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1687867766;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=jXwoOICLOShdX7GdT4p+4NbQyy/5jY0pTAO6DGHq6Ek=;
        b=deQwbwKzKSR21OXpf2PePuZ4sU+KKmFuah4oWQXe3F+ZpELyCJ15iLXDG6blxyzBfiIHs2
        2ywkmlUzuZIIgj1T6XEFXzPV3TvaD9FoHjGU2qNcBejs35N3PYWmVHzpMWJDxgoOgFwTAY
        M1eU9Wx8l5DBTCFFlNalCZjGl91D878=
From:   chengming.zhou@linux.dev
To:     axboe@kernel.dk, tj@kernel.org, hch@lst.de, ming.lei@redhat.com
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        zhouchengming@bytedance.com
Subject: [PATCH 1/4] blk-mq: use percpu csd to remote complete instead of per-rq csd
Date:   Tue, 27 Jun 2023 20:08:51 +0800
Message-Id: <20230627120854.971475-2-chengming.zhou@linux.dev>
In-Reply-To: <20230627120854.971475-1-chengming.zhou@linux.dev>
References: <20230627120854.971475-1-chengming.zhou@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Chengming Zhou <zhouchengming@bytedance.com>

If request need to be completed remotely, we insert it into percpu llist,
and smp_call_function_single_async() if llist is empty previously.

We don't need to use per-rq csd, percpu csd is enough. And the size of
struct request is decreased by 24 bytes.

Signed-off-by: Chengming Zhou <zhouchengming@bytedance.com>
---
 block/blk-mq.c         | 12 ++++++++----
 include/linux/blk-mq.h |  5 +----
 2 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index decb6ab2d508..a36822479b94 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -43,6 +43,7 @@
 #include "blk-ioprio.h"
 
 static DEFINE_PER_CPU(struct llist_head, blk_cpu_done);
+static DEFINE_PER_CPU(struct __call_single_data, blk_cpu_csd);
 
 static void blk_mq_insert_request(struct request *rq, blk_insert_t flags);
 static void blk_mq_request_bypass_insert(struct request *rq,
@@ -1156,13 +1157,13 @@ static void blk_mq_complete_send_ipi(struct request *rq)
 {
 	struct llist_head *list;
 	unsigned int cpu;
+	struct __call_single_data *csd;
 
 	cpu = rq->mq_ctx->cpu;
 	list = &per_cpu(blk_cpu_done, cpu);
-	if (llist_add(&rq->ipi_list, list)) {
-		INIT_CSD(&rq->csd, __blk_mq_complete_request_remote, rq);
-		smp_call_function_single_async(cpu, &rq->csd);
-	}
+	csd = &per_cpu(blk_cpu_csd, cpu);
+	if (llist_add(&rq->ipi_list, list))
+		smp_call_function_single_async(cpu, csd);
 }
 
 static void blk_mq_raise_softirq(struct request *rq)
@@ -4796,6 +4797,9 @@ static int __init blk_mq_init(void)
 
 	for_each_possible_cpu(i)
 		init_llist_head(&per_cpu(blk_cpu_done, i));
+	for_each_possible_cpu(i)
+		INIT_CSD(&per_cpu(blk_cpu_csd, i),
+			 __blk_mq_complete_request_remote, NULL);
 	open_softirq(BLOCK_SOFTIRQ, blk_done_softirq);
 
 	cpuhp_setup_state_nocalls(CPUHP_BLOCK_SOFTIRQ_DEAD,
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f401067ac03a..070551197c0e 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -182,10 +182,7 @@ struct request {
 		rq_end_io_fn		*saved_end_io;
 	} flush;
 
-	union {
-		struct __call_single_data csd;
-		u64 fifo_time;
-	};
+	u64 fifo_time;
 
 	/*
 	 * completion callback.
-- 
2.39.2

