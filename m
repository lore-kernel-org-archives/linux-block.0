Return-Path: <SRS0=E5Vf=CF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30A01C433DF
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 08:08:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0EAE420786
	for <linux-block@archiver.kernel.org>; Thu, 27 Aug 2020 08:08:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgH0II2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 27 Aug 2020 04:08:28 -0400
Received: from smtp.h3c.com ([60.191.123.56]:54406 "EHLO h3cspam01-ex.h3c.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726851AbgH0II0 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 27 Aug 2020 04:08:26 -0400
Received: from h3cspam01-ex.h3c.com (localhost [127.0.0.2] (may be forged))
        by h3cspam01-ex.h3c.com with ESMTP id 07R6fTEB043927;
        Thu, 27 Aug 2020 14:41:29 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from DAG2EX03-BASE.srv.huawei-3com.com ([10.8.0.66])
        by h3cspam01-ex.h3c.com with ESMTPS id 07R6f3mf042483
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Aug 2020 14:41:03 +0800 (GMT-8)
        (envelope-from tian.xianting@h3c.com)
Received: from localhost.localdomain (10.99.212.201) by
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Aug 2020 14:41:05 +0800
From:   Xianting Tian <tian.xianting@h3c.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Xianting Tian <tian.xianting@h3c.com>
Subject: [PATCH] [v3] blk-mq: use BLK_MQ_NO_TAG for no tag
Date:   Thu, 27 Aug 2020 14:34:17 +0800
Message-ID: <20200827063417.35851-1-tian.xianting@h3c.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.99.212.201]
X-ClientProxiedBy: BJSMTP01-EX.srv.huawei-3com.com (10.63.20.132) To
 DAG2EX03-BASE.srv.huawei-3com.com (10.8.0.66)
X-DNSRBL: 
X-MAIL: h3cspam01-ex.h3c.com 07R6f3mf042483
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace various magic -1 constants for tags with BLK_MQ_NO_TAG.

Signed-off-by: Xianting Tian <tian.xianting@h3c.com>
---
 block/blk-core.c     | 4 ++--
 block/blk-mq-sched.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index d9d632639..c7eaf7504 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -116,8 +116,8 @@ void blk_rq_init(struct request_queue *q, struct request *rq)
 	rq->__sector = (sector_t) -1;
 	INIT_HLIST_NODE(&rq->hash);
 	RB_CLEAR_NODE(&rq->rb_node);
-	rq->tag = -1;
-	rq->internal_tag = -1;
+	rq->tag = BLK_MQ_NO_TAG;
+	rq->internal_tag = BLK_MQ_NO_TAG;
 	rq->start_time_ns = ktime_get_ns();
 	rq->part = NULL;
 	refcount_set(&rq->ref, 1);
diff --git a/block/blk-mq-sched.c b/block/blk-mq-sched.c
index a19cdf159..439481f59 100644
--- a/block/blk-mq-sched.c
+++ b/block/blk-mq-sched.c
@@ -522,7 +522,7 @@ void blk_mq_sched_insert_request(struct request *rq, bool at_head,
 		goto run;
 	}
 
-	WARN_ON(e && (rq->tag != -1));
+	WARN_ON(e && (rq->tag != BLK_MQ_NO_TAG));
 
 	if (blk_mq_sched_bypass_insert(hctx, !!e, rq)) {
 		/*
-- 
2.17.1

