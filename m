Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D828ECAAD4
	for <linux-block@archiver.kernel.org>; Mon, 29 Aug 2022 04:30:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiH2EaM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 29 Aug 2022 00:30:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiH2EaM (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 29 Aug 2022 00:30:12 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA4CD11C3A
        for <linux-block@vger.kernel.org>; Sun, 28 Aug 2022 21:30:10 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=gumi@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VNW8Wys_1661747401;
Received: from nu1m11355.sqa.nu8.tbsite.net(mailfrom:gumi@linux.alibaba.com fp:SMTPD_---0VNW8Wys_1661747401)
          by smtp.aliyun-inc.com;
          Mon, 29 Aug 2022 12:30:08 +0800
From:   Gu Mi <gumi@linux.alibaba.com>
To:     axboe@kernel.dk, bvanassche@acm.org
Cc:     linux-block@vger.kernel.org, Gu Mi <gumi@linux.alibaba.com>
Subject: [PATCH v3] block: I/O error occurs during SATA disk stress test
Date:   Mon, 29 Aug 2022 12:29:59 +0800
Message-Id: <1661747399-17831-1-git-send-email-gumi@linux.alibaba.com>
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
we will set bit 1 to the deadline at this time.

Signed-off-by: Gu Mi <gumi@linux.alibaba.com>
---
v2->v3:

the workaround is the same as v1 patch, modification in blk_add_timer() is to prevent deadline set to valid and equal to 0,
and guaranteed to check that deadline==0 in blk_mq_req_expired() is only equivalent to the invalid value 0 set by req initialization

 block/blk-mq.c      | 2 ++
 block/blk-timeout.c | 5 +++++
 2 files changed, 7 insertions(+)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index bbf5434..f36280b 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -947,6 +947,8 @@ static bool blk_mq_req_expired(struct request *rq, unsigned long *next)
 		return false;
 
 	deadline = READ_ONCE(rq->deadline);
+	if (unlikely(deadline == 0))
+		return false;
 	if (time_after_eq(jiffies, deadline))
 		return true;
 
diff --git a/block/blk-timeout.c b/block/blk-timeout.c
index 1b8de041..9e1c00c 100644
--- a/block/blk-timeout.c
+++ b/block/blk-timeout.c
@@ -140,6 +140,11 @@ void blk_add_timer(struct request *req)
 	req->rq_flags &= ~RQF_TIMED_OUT;
 
 	expiry = jiffies + req->timeout;
+#ifndef CONFIG_64BIT
+/* In case INITIAL_JIFFIES wraps on 32-bit */
+	if (expiry == 0)
+		expiry |= 1UL;
+#endif
 	WRITE_ONCE(req->deadline, expiry);
 
 	/*
-- 
1.8.3.1

