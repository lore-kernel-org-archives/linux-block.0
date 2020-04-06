Return-Path: <SRS0=Ayt2=5W=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6C8F9C2BA1A
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 19:37:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 48F47206F5
	for <linux-block@archiver.kernel.org>; Mon,  6 Apr 2020 19:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725995AbgDFThH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 6 Apr 2020 15:37:07 -0400
Received: from 22.17.110.36.static.bjtelecom.net ([36.110.17.22]:26159 "HELO
        bsf02.didichuxing.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with SMTP id S1725933AbgDFThH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 6 Apr 2020 15:37:07 -0400
X-ASG-Debug-ID: 1586201825-0e410863a0378c50001-Cu09wu
Received: from mail.didiglobal.com (localhost [172.20.36.127]) by bsf02.didichuxing.com with ESMTP id Qw5jrcvJbj7UhsTG; Tue, 07 Apr 2020 03:37:05 +0800 (CST)
X-Barracuda-Envelope-From: zhangweiping@didiglobal.com
Received: from 192.168.3.9 (172.22.50.20) by BJSGEXMBX03.didichuxing.com
 (172.20.15.133) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 7 Apr
 2020 03:37:05 +0800
Date:   Tue, 7 Apr 2020 03:37:04 +0800
From:   Weiping Zhang <zhangweiping@didiglobal.com>
To:     <axboe@kernel.dk>, <bvanassche@acm.org>
CC:     <linux-block@vger.kernel.org>
Subject: [PATCH v3 5/7] block: save previous hardware queue count before
 udpate
Message-ID: <59933060f4b91d5cacd7b5ef1ac937b06c53b442.1586199103.git.zhangweiping@didiglobal.com>
X-ASG-Orig-Subj: [PATCH v3 5/7] block: save previous hardware queue count before
 udpate
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
X-Barracuda-Connect: localhost[172.20.36.127]
X-Barracuda-Start-Time: 1586201825
X-Barracuda-URL: https://bsf02.didichuxing.com:443/cgi-mod/mark.cgi
X-Virus-Scanned: by bsmtpd at didichuxing.com
X-Barracuda-Scan-Msg-Size: 814
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

blk_mq_realloc_tag_set_tags will update set->nr_hw_queues, so
save old set->nr_hw_queues before call this function.

Signed-off-by: Weiping Zhang <zhangweiping@didiglobal.com>
---
 block/blk-mq.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 406df9ce9b55..df243c19a158 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -3342,11 +3342,11 @@ static void __blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set,
 		blk_mq_sysfs_unregister(q);
 	}
 
+	prev_nr_hw_queues = set->nr_hw_queues;
 	if (blk_mq_realloc_tag_set_tags(set, set->nr_hw_queues, nr_hw_queues) <
 	    0)
 		goto reregister;
 
-	prev_nr_hw_queues = set->nr_hw_queues;
 	set->nr_hw_queues = nr_hw_queues;
 	blk_mq_update_queue_map(set);
 fallback:
-- 
2.18.1

