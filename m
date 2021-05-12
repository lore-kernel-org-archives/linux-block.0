Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0632C433B4
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 09:50:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCF67613A9
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 09:50:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbhELJv2 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 05:51:28 -0400
Received: from mx2.suse.de ([195.135.220.15]:41150 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230285AbhELJv1 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 05:51:27 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1620813019; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:  content-transfer-encoding:content-transfer-encoding;
        bh=RcpN7c1rBJ9sFd7YnFDTuIdD8opTCQiv0Nmy5BhXl5k=;
        b=hkPu134JYnqtV9i4cAzQdG5JD0ssAmdpZRlow6oCfo0hO60FVvqXH31kKDj08VqmRVgJD1
        h7RzqJbuuAe9+EFBuMvNPhge+rN7qn6jXiD8wrhmu/GUQmacVbvBTRzSRBVqwSh8oNVao8
        5apaXQFCH1WBXDsdJ27x2V5P6v0enKk=
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id DFD3BAC46;
        Wed, 12 May 2021 09:50:18 +0000 (UTC)
From:   Nikolay Borisov <nborisov@suse.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk
Cc:     Nikolay Borisov <nborisov@suse.com>
Subject: [PATCH] blk-mq: Use helpers to access rq->state
Date:   Wed, 12 May 2021 12:50:17 +0300
Message-Id: <20210512095017.235295-1-nborisov@suse.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Instead of having a mixed bag of opencoded usage and helper usage,
simply replace opencoded sites with the appropriate helper. No
functional changes.

Signed-off-by: Nikolay Borisov <nborisov@suse.com>
---
 block/blk-mq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d4d7c1caa439..d1cfacf2734c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -644,7 +644,7 @@ static void blk_mq_raise_softirq(struct request *rq)
 
 bool blk_mq_complete_request_remote(struct request *rq)
 {
-	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
+	blk_mq_set_request_complete(rq);
 
 	/*
 	 * For a polled request, always complete locallly, it's pointless
@@ -721,7 +721,7 @@ void blk_mq_start_request(struct request *rq)
 		rq_qos_issue(q, rq);
 	}
 
-	WARN_ON_ONCE(blk_mq_rq_state(rq) != MQ_RQ_IDLE);
+	WARN_ON_ONCE(blk_mq_request_started(rq));
 
 	blk_add_timer(rq);
 	WRITE_ONCE(rq->state, MQ_RQ_IN_FLIGHT);
@@ -3812,7 +3812,7 @@ static bool blk_mq_poll_hybrid_sleep(struct request_queue *q,
 	hrtimer_set_expires(&hs.timer, kt);
 
 	do {
-		if (blk_mq_rq_state(rq) == MQ_RQ_COMPLETE)
+		if (blk_mq_request_completed(rq))
 			break;
 		set_current_state(TASK_UNINTERRUPTIBLE);
 		hrtimer_sleeper_start_expires(&hs, mode);
-- 
2.25.1

