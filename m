Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD6E7C433EF
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 23:27:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A531360F6F
	for <linux-block@archiver.kernel.org>; Thu, 23 Sep 2021 23:27:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243381AbhIWX2i (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Sep 2021 19:28:38 -0400
Received: from mail-pj1-f53.google.com ([209.85.216.53]:52737 "EHLO
        mail-pj1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235628AbhIWX2i (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Sep 2021 19:28:38 -0400
Received: by mail-pj1-f53.google.com with SMTP id v19so5525914pjh.2
        for <linux-block@vger.kernel.org>; Thu, 23 Sep 2021 16:27:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W1+ihNENtaOKfFRhllTtY8Ka3bwanKzRizQI2gu09y0=;
        b=6WYzglPi5VmKp6RPCiM6BUVwOmkGRV81QKxzSAE3iyqBNMN6RyoYO6iRMSdHuN4HD0
         f7qRM4F8OgWMg1MDQ27Er1jlL/oJ9kw+FRSEgi5lRb3xmqo1rCRwH1qewTicY5DsPwJG
         w0J7kdPjPvP/5JFx3f3eoKnU8x//lcQl46BWzf0mX6bwOkCCuoiQCJVLbyyaxjOwWyt6
         lib4RPZDuhntBP/OLQZ+rE6Eo3jdLGaXumDuaw2emlHyQsqdlwBMuKI6uAYSurPcbOir
         lov0v/BpvvPiPS0mMRW6bpv1DvOUrqhPc3roLqH8ZX8Ffp03/K9T9+6t0q2ZbWrCryTH
         77cQ==
X-Gm-Message-State: AOAM531sTUbI1uPCY4DG9gLMEPxFoVmLtXVLBin81AIXtA2nuDpGH45k
        fkYN3frGU/akmtRMCkgCL14=
X-Google-Smtp-Source: ABdhPJwWR0HsU7YQPJjOZMTbVZU1El7Z815Ccl970rJjQmVieOwcBx8SFBmTpDB8OZRhCDJ+7JjiRw==
X-Received: by 2002:a17:90a:352:: with SMTP id 18mr8278194pjf.116.1632439625825;
        Thu, 23 Sep 2021 16:27:05 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:bf91:ebe7:eabf:7473])
        by smtp.gmail.com with ESMTPSA id o14sm6969807pfh.84.2021.09.23.16.27.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Sep 2021 16:27:05 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Niklas Cassel <Niklas.Cassel@wdc.com>,
        Hannes Reinecke <hare@suse.de>
Subject: [PATCH 1/4] block/mq-deadline: Improve request accounting further
Date:   Thu, 23 Sep 2021 16:26:52 -0700
Message-Id: <20210923232655.3907383-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.33.0.685.g46640cef36-goog
In-Reply-To: <20210923232358.3907118-1-bvanassche@acm.org>
References: <20210923232358.3907118-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

The scheduler .insert_requests() callback is called when a request is
queued for the first time and also when it is requeued. Only count a
request the first time it is queued. Additionally, since the mq-deadline
scheduler only performs zone locking for requests that have been
inserted, skip the zone unlock code for requests that have not been
inserted into the mq-deadline scheduler.

Fixes: 38ba64d12d4c ("block/mq-deadline: Track I/O statistics")
Cc: Damien Le Moal <damien.lemoal@wdc.com>
Cc: Niklas Cassel <Niklas.Cassel@wdc.com>
Cc: Hannes Reinecke <hare@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 block/mq-deadline.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/block/mq-deadline.c b/block/mq-deadline.c
index 7f3c3932b723..b1175e4560ad 100644
--- a/block/mq-deadline.c
+++ b/block/mq-deadline.c
@@ -677,8 +677,10 @@ static void dd_insert_request(struct blk_mq_hw_ctx *hctx, struct request *rq,
 	blk_req_zone_write_unlock(rq);
 
 	prio = ioprio_class_to_prio[ioprio_class];
-	dd_count(dd, inserted, prio);
-	rq->elv.priv[0] = (void *)(uintptr_t)1;
+	if (!rq->elv.priv[0]) {
+		dd_count(dd, inserted, prio);
+		rq->elv.priv[0] = (void *)(uintptr_t)1;
+	}
 
 	if (blk_mq_sched_try_insert_merge(q, rq, &free)) {
 		blk_mq_free_requests(&free);
@@ -759,12 +761,13 @@ static void dd_finish_request(struct request *rq)
 
 	/*
 	 * The block layer core may call dd_finish_request() without having
-	 * called dd_insert_requests(). Hence only update statistics for
-	 * requests for which dd_insert_requests() has been called. See also
-	 * blk_mq_request_bypass_insert().
+	 * called dd_insert_requests(). Skip requests that bypassed I/O
+	 * scheduling. See also blk_mq_request_bypass_insert().
 	 */
-	if (rq->elv.priv[0])
-		dd_count(dd, completed, prio);
+	if (!rq->elv.priv[0])
+		return;
+
+	dd_count(dd, completed, prio);
 
 	if (blk_queue_is_zoned(q)) {
 		unsigned long flags;
