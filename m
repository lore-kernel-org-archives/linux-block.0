Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70C4EC38A24
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 13:04:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 51B5F20870
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 13:04:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726638AbgEGNEt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 09:04:49 -0400
Received: from mx2.didiglobal.com ([111.202.154.82]:22210 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1725914AbgEGNEt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 May 2020 09:04:49 -0400
X-ASG-Debug-ID: 1588856683-0e408819ec78960001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.175]) by bsf01.didichuxing.com with ESMTP id IaBfkJSaE9POZBtk; Thu, 07 May 2020 21:04:43 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 7 May
 2020 21:04:43 +0800
Date:   Thu, 7 May 2020 21:04:42 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tom.leiming@gmail.com>, <bvanassche@acm.org>,
        <hch@infradead.org>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH v6 5/5] block: rename blk_mq_alloc_rq_maps
Message-ID: <db1712c57633b1cf63bc704a3c47456a0dda5ed8.1588856361.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v6 5/5] block: rename blk_mq_alloc_rq_maps
Mail-Followup-To: axboe@kernel.dk, tom.leiming@gmail.com,
        bvanassche@acm.org, hch@infradead.org, linux-block@vger.kernel.org
References: <cover.1588856361.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1588856361.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS02.didichuxing.com (172.20.36.211) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.175]
X-Barracuda-Start-Time: 1588856683
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1157
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81679
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

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-mq.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 0a4f7fdd2248..649a8abdd742 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3006,7 +3006,7 @@ static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
  * may reduce the depth asked for, if memory is tight. set->queue_depth
  * will be updated to reflect the allocated depth.
  */
-static int blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
+static int blk_mq_alloc_map_and_requests(struct blk_mq_tag_set *set)
 {
 	unsigned int depth;
 	int err;
@@ -3166,7 +3166,7 @@ int blk_mq_alloc_tag_set(struct blk_mq_tag_set *set)
 	if (ret)
 		goto out_free_mq_map;
 
-	ret = blk_mq_alloc_rq_maps(set);
+	ret = blk_mq_alloc_map_and_requests(set);
 	if (ret)
 		goto out_free_mq_map;
 
-- 
2.18.2

