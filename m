Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D705EC00140
	for <linux-block@archiver.kernel.org>; Wed, 24 Aug 2022 11:37:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234831AbiHXLhH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Aug 2022 07:37:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229542AbiHXLhH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Aug 2022 07:37:07 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7042082779
        for <linux-block@vger.kernel.org>; Wed, 24 Aug 2022 04:37:01 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=gumi@linux.alibaba.com;NM=1;PH=DS;RN=3;SR=0;TI=SMTPD_---0VN7OdNk_1661341013;
Received: from nu1m11355.sqa.nu8.tbsite.net(mailfrom:gumi@linux.alibaba.com fp:SMTPD_---0VN7OdNk_1661341013)
          by smtp.aliyun-inc.com;
          Wed, 24 Aug 2022 19:36:59 +0800
From:   Gu Mi <gumi@linux.alibaba.com>
To:     axboe@kernel.dk
Cc:     linux-block@vger.kernel.org, Gu Mi <gumi@linux.alibaba.com>
Subject: [PATCH] block: I/O error occurs during SATA disk stress test
Date:   Wed, 24 Aug 2022 19:36:50 +0800
Message-Id: <1661341010-80107-1-git-send-email-gumi@linux.alibaba.com>
X-Mailer: git-send-email 1.8.3.1
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The problem occurs in two async processes, One is when a new IO
calls the blk_mq_start_request() interface to start sending,The other
is that the block layer timer process calls the blk_mq_req_expired
interface to check whether there is an IO timeout.

When an instruction out of sequence occurs between blk_add_timer
and WRITE_ONCE(rq->state,MQ_RQ_IN_FLIGHT) in the interface
blk_mq_start_request,at this time, the block timer is checking the
new IO timeout, Since the req status has been set to MQ_RQ_IN_FLIGHT
and req->deadline is 0 at this time, the new IO will be misjudged as
a timeout.

Our repair plan is for the deadline to be 0, and we do not think
that a timeout occurs. At the same time, because the jiffies of the
32-bit system will be reversed shortly after the system is turned on,
we will add 1 jiffies to the deadline at this time.

Signed-off-by: Gu Mi <gumi@linux.alibaba.com>
---
 block/blk-mq.c      | 2 ++
 block/blk-timeout.c | 4 ++++
 2 files changed, 6 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 4b90d2d..6defaa1 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1451,6 +1451,8 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
 		return false;
 
 	deadline = READ_ONCE(rq->deadline);
+	if (unlikely(deadline == 0))
+		return false;
 	if (time_after_eq(jiffies, deadline))
 		return true;
 
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 1b8de041..6fc5088 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -140,6 +140,10 @@ void blk_add_timer(struct request *req)
 	req->rq_flags &= ~RQF_TIMED_OUT;
 
 	expiry = jiffies + req->timeout;
+#ifndef CONFIG_64BIT
+/* In case INITIAL_JIFFIES wraps on 32-bit */
+	expiry |= 1UL;
+#endif
 	WRITE_ONCE(req->deadline, expiry);
 
 	/*
-- 
1.8.3.1

