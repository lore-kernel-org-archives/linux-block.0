Return-Path: <SRS0=Ayt2=5W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA2C9C2BA1A
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 19:37:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B0C11206F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 19:37:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726130AbgDFThT (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:37:19 -0400
Received: from mx1.didichuxing.com ([111.202.154.82]:3758 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1725933AbgDFThT (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Apr 2020 15:37:19 -0400
X-ASG-Debug-ID: 1586201837-0e40885f62217390001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.207]) by bsf01.didichuxing.com with ESMTP id ag6EdPLxB70Eo9KJ; Tue, 07 Apr 2020 03:37:17 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 7 Apr
 2020 03:37:16 +0800
Date:   Tue, 7 Apr 2020 03:37:15 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH v3 6/7] block: refactor __blk_mq_alloc_rq_map_and_requests
Message-ID: <eb995b7a9c5a942c596eb21856043c4a1b2135f1.1586199103.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v3 6/7] block: refactor __blk_mq_alloc_rq_map_and_requests
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
X-Barracuda-Connect: localhost[172.20.36.207]
X-Barracuda-Start-Time: 1586201837
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 3555
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

This patch add a new member nr_allocated_map_rqs to the
struct blk_mq_tag_set to record the number of maps and requests have
been allocated for this tagset.

Now there is a problem when we increase hardware queue count, we do not
allocate maps and request for the new allocated hardware queue, it will
be fixed in the next patch.

Since request needs lots of memory, it's not easy alloc so many memory
dynamically, espeicially when system is under memory pressure.

This patch allow nr_hw_queues does not equal to the nr_allocated_map_rqs,
to avoid alloc/free memory when change hardware queue count.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-mq.c         | 28 +++++++++++++++++++++-------
 include/linux/blk-mq.h |  1 +
 2 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index df243c19a158..15f6a811122a 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2479,8 +2479,10 @@ static bool __blk_mq_alloc_rq_map_and_request(struct blk_mq_tag_set *set, int hc
 
 	ret = blk_mq_alloc_rqs(set, set->tags[hctx_idx], hctx_idx,
 				set->queue_depth);
-	if (!ret)
+	if (!ret) {
+		set->nr_allocated_map_rqs++;
 		return true;
+	}
 
 	blk_mq_free_rq_map(set->tags[hctx_idx]);
 	set->tags[hctx_idx] = NULL;
@@ -2494,6 +2496,7 @@ static void blk_mq_free_map_and_requests(struct blk_mq_tag_set *set,
 		blk_mq_free_rqs(set, set->tags[hctx_idx], hctx_idx);
 		blk_mq_free_rq_map(set->tags[hctx_idx]);
 		set->tags[hctx_idx] = NULL;
+		set->nr_allocated_map_rqs--;
 	}
 }
 
@@ -2978,18 +2981,28 @@ void blk_mq_exit_queue(struct request_queue *q)
 	blk_mq_exit_hw_queues(q, set, set->nr_hw_queues);
 }
 
-static int __blk_mq_alloc_rq_map_and_requests(struct blk_mq_tag_set *set)
+/*
+ * Only append new map and requests, if new > now, all of these maps and
+ * request will be released when cleanup whole tag set. Because requests
+ * will cost lots memory, if system's memory is under a pressure, it's not
+ * easy to allocate too much memory.
+ */
+static int blk_mq_realloc_rq_map_and_requests(struct blk_mq_tag_set *set,
+						int new)
 {
-	int i;
+	int i, now = set->nr_allocated_map_rqs;
+
+	if (new <= now)
+		return 0;
 
-	for (i = 0; i < set->nr_hw_queues; i++)
+	for (i = now; i < new; i++)
 		if (!__blk_mq_alloc_rq_map_and_request(set, i))
 			goto out_unwind;
 
 	return 0;
 
 out_unwind:
-	while (--i >= 0)
+	while (--i >= now)
 		blk_mq_free_map_and_requests(set, i);
 
 	return -ENOMEM;
@@ -3007,7 +3020,8 @@ static int blk_mq_alloc_rq_map_and_requests(struct blk_mq_tag_set *set)
 
 	depth = set->queue_depth;
 	do {
-		err = __blk_mq_alloc_rq_map_and_requests(set);
+		err = blk_mq_realloc_rq_map_and_requests(set,
+						set->nr_hw_queues);
 		if (!err)
 			break;
 
@@ -3184,7 +3198,7 @@ void blk_mq_free_tag_set(struct blk_mq_tag_set *set)
 {
 	int i, j;
 
-	for (i = 0; i < set->nr_hw_queues; i++)
+	for (i = 0; i < set->nr_allocated_map_rqs; i++)
 		blk_mq_free_map_and_requests(set, i);
 
 	for (j = 0; j < set->nr_maps; j++) {
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index f389d7c724bd..d950435cd3c6 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -240,6 +240,7 @@ struct blk_mq_tag_set {
 	unsigned int		nr_maps;
 	const struct blk_mq_ops	*ops;
 	unsigned int		nr_hw_queues;
+	unsigned int		nr_allocated_map_rqs;
 	unsigned int		queue_depth;
 	unsigned int		reserved_tags;
 	unsigned int		cmd_size;
-- 
2.18.1

