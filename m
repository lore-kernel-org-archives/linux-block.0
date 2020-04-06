Return-Path: <SRS0=Ayt2=5W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22A8BC2BA2B
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 19:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04F05206F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 19:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726084AbgDFTgT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:36:19 -0400
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:24910 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with SMTP id S1725933AbgDFTgT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Apr 2020 15:36:19 -0400
X-ASG-Debug-ID: 1586201776-0e40885f622171f0001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.175]) by bsf01.didichuxing.com with ESMTP id AzZvsZhxY5VUrhTI; Tue, 07 Apr 2020 03:36:16 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 7 Apr
 2020 03:36:16 +0800
Date:   Tue, 7 Apr 2020 03:36:15 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH v3 1/7] block: rename __blk_mq_alloc_rq_map
Message-ID: <9e542bceca1c467c99f114be7ab958066b8c7bf5.1586199103.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v3 1/7] block: rename __blk_mq_alloc_rq_map
Mail-Followup-To: axboe@kernel.dk, bvanassche@acm.org,
        linux-block@vger.kernel.org
References: <cover.1586199103.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1586199103.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS02.didichuxing.com (172.20.36.211) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.175]
X-Barracuda-Start-Time: 1586201776
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1453
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81033
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

rename __blk_mq_alloc_rq_map to __blk_mq_alloc_rq_map_and_request,
actually it alloc both map and request, make function name
align with function.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-mq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6291ceedee4..3a482ce7ed28 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2468,7 +2468,7 @@ static void blk_mq_init_cpu_queues(struct request_queue *q,
 	}
 }
 
-static bool __blk_mq_alloc_rq_map(struct blk_mq_tag_set *set, int hctx_idx)
+static bool __blk_mq_alloc_rq_map_and_request(struct blk_mq_tag_set *set, int hctx_idx)
 {
 	int ret = 0;
 
@@ -2519,7 +2519,7 @@ static void blk_mq_map_swqueue(struct request_queue *q)
 		hctx_idx = set->map[HCTX_TYPE_DEFAULT].mq_map[i];
 		/* unmapped hw queue can be remapped after CPU topo changed */
 		if (!set->tags[hctx_idx] &&
-		    !__blk_mq_alloc_rq_map(set, hctx_idx)) {
+		    !__blk_mq_alloc_rq_map_and_request(set, hctx_idx)) {
 			/*
 			 * If tags initialization fail for some hctx,
 			 * that hctx won't be brought online.  In this
@@ -2983,7 +2983,7 @@ static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 	int i;
 
 	for (i = 0; i < set->nr_hw_queues; i++)
-		if (!__blk_mq_alloc_rq_map(set, i))
+		if (!__blk_mq_alloc_rq_map_and_request(set, i))
 			goto out_unwind;
 
 	return 0;
-- 
2.18.1

