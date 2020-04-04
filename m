Return-Path: <SRS0=MH8N=5U=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA0BC2BA19
	for <linux-block@archiver.kernel.org>; Sat,  4 Apr 2020 13:36:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 01157206F5
	for <linux-block@archiver.kernel.org>; Sat,  4 Apr 2020 13:36:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726005AbgDDNgG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 4 Apr 2020 09:36:06 -0400
Received: from mx2.didichuxing.com ([36.110.17.22]:25327 "HELO
        bsf01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with SMTP id S1725837AbgDDNgG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 4 Apr 2020 09:36:06 -0400
X-ASG-Debug-ID: 1586007357-0e4088570a57b0b0001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.235]) by bsf01.didichuxing.com with ESMTP id ZBnBj5e3WIKgPayl; Sat, 04 Apr 2020 21:35:57 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 4 Apr
 2020 21:35:57 +0800
Date:   Sat, 4 Apr 2020 21:35:56 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH v2 1/2] block: save previous hardware queue count before
 udpate
Message-ID: <a0230ed5731a2c9183e1929611755579f20616ff.1586006904.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v2 1/2] block: save previous hardware queue count before
 udpate
Mail-Followup-To: axboe@kernel.dk, linux-block@vger.kernel.org
References: <cover.1586006904.git.zhangweiping@didiglobal.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <cover.1586006904.git.zhangweiping@didiglobal.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Originating-IP: [172.22.50.20]
X-ClientProxiedBy: BJEXCAS03.didichuxing.com (172.20.36.245) To
 BJSGEXMBX03.didichuxing.com (172.20.15.133)
X-Barracuda-Connect: localhost[172.20.36.235]
X-Barracuda-Start-Time: 1586007357
X-Barracuda-URL: https://bsf01.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 973
X-Barracuda-BRTS-Status: 1
X-Barracuda-Bayes: INNOCENT GLOBAL 0.0000 1.0000 -2.0210
X-Barracuda-Spam-Score: -2.02
X-Barracuda-Spam-Status: No, SCORE=-2.02 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=1000.0 KILL_LEVEL=1000.0 tests=
X-Barracuda-Spam-Report: Code version 3.2, rules version 3.2.3.80990
        Rule breakdown below
         pts rule name              description
        ---- ---------------------- --------------------------------------------------
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

blk_mq_realloc_tag_set_tags will update set->nr_hw_queues, so
save old set->nr_hw_queues before call this function.

Since set->nr_hw_queues has been updated in blk_mq_realloc_tag_set_tags,
no need set it again.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-mq.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6291ceedee4..c86d1c81d3d6 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3342,12 +3342,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_sysfs_unregister(q);
 	}
 
+	prev_nr_hw_queues = set->nr_hw_queues;
 	if (blk_mq_realloc_tag_set_tags(set, set->nr_hw_queues, nr_hw_queues) <
 	    0)
 		goto reregister;
 
-	prev_nr_hw_queues = set->nr_hw_queues;
-	set->nr_hw_queues = nr_hw_queues;
 	blk_mq_update_queue_map(set);
 fallback:
 	list_for_each_entry(q, &set->tag_list, tag_set_list) {
-- 
2.18.1

