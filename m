Return-Path: <SRS0=Cb6v=6V=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F74FC38A2A
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 13:03:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C5AB2070B
	for <linux-block@archiver.kernel.org>; Thu,  7 May 2020 13:03:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725857AbgEGNDs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 May 2020 09:03:48 -0400
Received: from mx2.didiglobal.com ([111.202.154.82]:6274 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1726267AbgEGNDs (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 May 2020 09:03:48 -0400
X-ASG-Debug-ID: 1588856620-0e408819ee78880001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.236]) by bsf01.didichuxing.com with ESMTP id 6Vp6GOhI5XSgY67h; Thu, 07 May 2020 21:03:40 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 7 May
 2020 21:03:40 +0800
Date:   Thu, 7 May 2020 21:03:39 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <tom.leiming@gmail.com>, <bvanassche@acm.org>,
        <hch@infradead.org>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH v6 1/5] block: free both rq_map and request
Message-ID: <e26c4cfa43d586ef83743908ce1c33cc69bb9a2f.1588856361.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v6 1/5] block: free both rq_map and request
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
X-Barracuda-Connect: localhost[172.20.36.236]
X-Barracuda-Start-Time: 1588856620
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 1257
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: 1.08
X-Barracuda-Spam-Status: No, SCORE=1.08 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=BSF_SC0_MV0249, MARKETING_SUBJECT
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.81679
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
        0.60 MARKETING_SUBJECT      Subject contains popular marketing words
        2.50 BSF_SC0_MV0249         Custom rule MV0249
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Allocation:

__blk_mq_alloc_rq_map
	blk_mq_alloc_rq_map
		blk_mq_alloc_rq_map
			tags = blk_mq_init_tags : kzalloc_node:
			tags->rqs = kcalloc_node
			tags->static_rqs = kcalloc_node
	blk_mq_alloc_rqs
		p = alloc_pages_node
		tags->static_rqs[i] = p + offset;

Free:

blk_mq_free_rq_map
	kfree(tags->rqs);
	kfree(tags->static_rqs);
	blk_mq_free_tags
		kfree(tags);

The page allocated in blk_mq_alloc_rqs cannot be released,
so we should use blk_mq_free_map_and_requests here.

blk_mq_free_map_and_requests
	blk_mq_free_rqs
		__free_pages : cleanup for blk_mq_alloc_rqs
	blk_mq_free_rq_map : cleanup for blk_mq_alloc_rq_map

Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index a7785df2c944..f789b3e1b3ab 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2995,7 +2995,7 @@ static int __blk_mq_alloc_rq_maps(struct blk_mq_tag_set *set)
 
 out_unwind:
 	while (--i >= 0)
-		blk_mq_free_rq_map(set->tags[i]);
+		blk_mq_free_map_and_requests(set, i);
 
 	return -ENOMEM;
 }
-- 
2.18.2

