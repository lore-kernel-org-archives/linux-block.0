Return-Path: <SRS0=S1TO=6M=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEF75C83000
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 13:30:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA1DE206D6
	for <linux-block@archiver.kernel.org>; Tue, 28 Apr 2020 13:30:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726868AbgD1Nad (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 28 Apr 2020 09:30:33 -0400
Received: from mx2.didiglobal.com ([111.202.154.82]:23232 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1726825AbgD1Nad (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 28 Apr 2020 09:30:33 -0400
X-ASG-Debug-ID: 1588080630-0e4108595b572ca0001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.245]) by bsf02.didichuxing.com with ESMTP id OGXHxdrwYCbmI81w; Tue, 28 Apr 2020 21:30:30 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 28 Apr
 2020 21:30:30 +0800
Date:   Tue, 28 Apr 2020 21:30:28 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tom.leiming@gmail.com>, <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>
Subject: [RESEND v4 6/6] block: rename blk_mq_alloc_rq_maps
Message-ID: <35b2fc8a9648ed16c9a465fd43c928d4393d1c4a.1588080449.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [RESEND v4 6/6] block: rename blk_mq_alloc_rq_maps
Mail-Followup-To: axboe@kernel.dk, tom.leiming@gmail.com,
        bvanassche@acm.org, linux-block@vger.kernel.org
References: <cover.1588080449.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1588080449.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.245]
X-Barracuda-Start-Time: 1588080630
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1085
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81478
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

rename blk_mq_alloc_rq_maps to blk_mq_alloc_map_and_requests,
this function allocs both map and request, make function name align
with funtion.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b6c907dbbb30..8ae9e375fe53 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3017,7 +3017,7 @@ static int blk_mq_realloc_map_and_requests(struct blk_mq_tag_set *set, int new)
  * may reduce the depth asked for, if memory is tight. set->queue_depth
  * will be updated to reflect the allocated depth.
  */
-static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
+static int blk_mq_alloc_map_and_requests(struct blk_mq_tag_set *set)
 {
 	unsigned int depth;
 	int err;
@@ -3177,7 +3177,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (ret)
 		goto out_free_mq_map;
 
-	ret = blk_mq_alloc_rq_maps(set);
+	ret = blk_mq_alloc_map_and_requests(set);
 	if (ret)
 		goto out_free_mq_map;
 
-- 
2.18.1

