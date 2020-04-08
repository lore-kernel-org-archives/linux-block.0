Return-Path: <SRS0=kJV6=5Y=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A603CC2D0EA
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 15:04:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7B0A2206F5
	for <linux-block@archiver.kernel.org>; Wed,  8 Apr 2020 15:04:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WeIoaF6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728424AbgDHPEf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:04:35 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:41873 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728157AbgDHPEe (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 8 Apr 2020 11:04:34 -0400
Received: by mail-pg1-f195.google.com with SMTP id m13so3424943pgd.8
        for <linux-block@vger.kernel.org>; Wed, 08 Apr 2020 08:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=ykBFVrZ5VqErlxdGxaznASIr1DPALx6cRNBKHC8zE+4=;
        b=WeIoaF6VGX20BswqY9TqTj+Q4BN5xdWpQNb+lBxDFRLRQmKlLnHtyLEo9szLuaaWmL
         uXpXqkrjLeFDrSpJb/pE3XsdBUYkCYg2TKiL8z75XbapAgBEJhKQqHfqot+Y6/AjHT6p
         PqyW+Y65GrBglvA1WkUvjpo7Yk5AoZ2kfXZMs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=ykBFVrZ5VqErlxdGxaznASIr1DPALx6cRNBKHC8zE+4=;
        b=glV1ar0hStsZlqHwq+jvFlumJmnhXmjOTzS/eupF7zWg3FpM24jP4Nwss1d05ZqAvM
         b4ODbqjT8XLOqOG9VaEeK5Fl9jmLitPwWz8Zt4+ooO08uTHIknEim4exo9VH5X2Q9A7M
         LgcNSfBXfLKkscBwFbxRrrAMpi/Tv0GRfn/gbt9YcaWI/Z9gRect+eohvg2hAKgtGy+q
         JbwhgYA0pPOfHXKykAUwWVs35SqbU2RWGD7IowhRJCKHro7QSTD+/KFxnxyNJRT8Z0/h
         4USujTot8fUPVZljoSpy+rJh+kBfMhF+OvqlzCgc+gIU7V7gYPZX30DbkGU0uvjp1x3h
         csnw==
X-Gm-Message-State: AGi0PuYeXCVZy1aGsl0NcvN/3RIuhPFWQJzqZEcqpUU8I98S/bQVkNht
        OLcuqWGTH2UX7U5HHs7B4rtOog==
X-Google-Smtp-Source: APiQypKEWc3MCkral5p3jzK3p9lOhhJpdLJZpPnwPUwZmxycNIYMNVYj0LsS1r4g9XYOgoQikNcQMw==
X-Received: by 2002:a63:7a07:: with SMTP id v7mr6385580pgc.302.1586358272199;
        Wed, 08 Apr 2020 08:04:32 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id d85sm1468083pfd.157.2020.04.08.08.04.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 08:04:31 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     paolo.valente@linaro.org, groeck@chromium.org,
        Gwendal Grignou <gwendal@chromium.org>,
        linux-scsi@vger.kernel.org, linux-block@vger.kernel.org,
        Ming Lei <ming.lei@redhat.com>, sqazi@google.com,
        Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/4] blk-mq: In blk_mq_dispatch_rq_list() "no budget" is a reason to kick
Date:   Wed,  8 Apr 2020 08:03:59 -0700
Message-Id: <20200408080255.v4.1.I1f95c459e51962b8d2c83e869913b6befda2255c@changeid>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200408150402.21208-1-dianders@chromium.org>
References: <20200408150402.21208-1-dianders@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In blk_mq_dispatch_rq_list(), if blk_mq_sched_needs_restart() returns
true and the driver returns BLK_STS_RESOURCE then we'll kick the
queue.  However, there's another case where we might need to kick it.
If we were unable to get budget we can be in much the same state as
when the driver returns BLK_STS_RESOURCE, so we should treat it the
same.

It should be noted that even if we add a whole bunch of extra kicking
to the queue in other patches this patch is still important.
Specifically any kicking that happened before we re-spliced leftover
requests into 'hctx->dispatch' wouldn't have found any work, so we
really need to make sure we kick ourselves after we've done the
splicing.

Signed-off-by: Douglas Anderson <dianders@chromium.org>
Reviewed-by: Ming Lei <ming.lei@redhat.com>
---

Changes in v4: None
Changes in v3:
- Note why blk_mq_dispatch_rq_list() change is needed.

Changes in v2: None

 block/blk-mq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index d92088dec6c3..2cd8d2b49ff4 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1189,6 +1189,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	bool no_tag = false;
 	int errors, queued;
 	blk_status_t ret = BLK_STS_OK;
+	bool no_budget_avail = false;
 
 	if (list_empty(list))
 		return false;
@@ -1205,8 +1206,10 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		rq = list_first_entry(list, struct request, queuelist);
 
 		hctx = rq->mq_hctx;
-		if (!got_budget && !blk_mq_get_dispatch_budget(hctx))
+		if (!got_budget && !blk_mq_get_dispatch_budget(hctx)) {
+			no_budget_avail = true;
 			break;
+		}
 
 		if (!blk_mq_get_driver_tag(rq)) {
 			/*
@@ -1311,13 +1314,15 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		 *
 		 * If driver returns BLK_STS_RESOURCE and SCHED_RESTART
 		 * bit is set, run queue after a delay to avoid IO stalls
-		 * that could otherwise occur if the queue is idle.
+		 * that could otherwise occur if the queue is idle.  We'll do
+		 * similar if we couldn't get budget and SCHED_RESTART is set.
 		 */
 		needs_restart = blk_mq_sched_needs_restart(hctx);
 		if (!needs_restart ||
 		    (no_tag && list_empty_careful(&hctx->dispatch_wait.entry)))
 			blk_mq_run_hw_queue(hctx, true);
-		else if (needs_restart && (ret == BLK_STS_RESOURCE))
+		else if (needs_restart && (ret == BLK_STS_RESOURCE ||
+					   no_budget_avail))
 			blk_mq_delay_run_hw_queue(hctx, BLK_MQ_RESOURCE_DELAY);
 
 		blk_mq_update_dispatch_busy(hctx, true);
-- 
2.26.0.292.g33ef6b2f38-goog

