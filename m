Return-Path: <SRS0=69Bb=5X=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F77C2BB54
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 22:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D17C32074F
	for <linux-block@archiver.kernel.org>; Tue,  7 Apr 2020 22:00:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="GmjVUTgA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726508AbgDGWAk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 Apr 2020 18:00:40 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:55582 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726477AbgDGWAk (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 Apr 2020 18:00:40 -0400
Received: by mail-pj1-f67.google.com with SMTP id fh8so314042pjb.5
        for <linux-block@vger.kernel.org>; Tue, 07 Apr 2020 15:00:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xnXKID66OSSyAQqnf06AsglExR2cwtRMWmnbx6zKoBI=;
        b=GmjVUTgAUpx/envjSX4TqNkVRaWSyHW2WFhyprFYC5I5aR1kZ5yGL8K1fnGq/jh/Id
         4xWWmL+Mmqjn1uPlwRxXiFVRSzGWbCUSfwvgzbYeN8i8+KCSKqrA1oOh/0dzyVkAYh2A
         hktk/Ygzn8DBXqV33ZNi7oub2uus1hiG3AiAg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xnXKID66OSSyAQqnf06AsglExR2cwtRMWmnbx6zKoBI=;
        b=bqAyAKXlsrWyDfumQMieKxFXMOt69KcFIQDb2/XZSAS4JoooIJPoaoCDx8kUd/Z3bG
         sJsrHvDC6ZdV388zsO3yFPnL4FJEBlCgG/7f5lB+5D+nFCc3+1khe+RhJREIugn8s8bO
         MGDzV3+O61Sa6bvB6Ig1QcfusKVMyKG/D79LivIYnBWE8nP7M+R4jpnxf4YVoYNnIbv8
         i2MexUrClIG10eJ6kDYjiwseddCOHURjVNSyvWFVPQyN+dTydAQc+E+RyWwR5CIViKW5
         MrWxtk9k25QL5QKWsFHVN99m5KJP/6yyT4T3nrOOShPELHvoNgR1EDmX8/+aa4lQNNV+
         mmCg==
X-Gm-Message-State: AGi0PubfzYF8vL2eqPBdFOQzQRW6DYrRDeuhv6DvCOHPjMw/nBBmObfU
        n1VNmxP2kHHt/SZUbZ40QRb9RA==
X-Google-Smtp-Source: APiQypL5GY9tYiHTpTME8h8EpgisIlAdVi6iaupCxQLgo4LGuBLE09GyMgLM9vTrQYpw/ELJ5nXpgQ==
X-Received: by 2002:a17:902:7682:: with SMTP id m2mr4194211pll.311.1586296839137;
        Tue, 07 Apr 2020 15:00:39 -0700 (PDT)
Received: from tictac2.mtv.corp.google.com ([2620:15c:202:1:24fa:e766:52c9:e3b2])
        by smtp.gmail.com with ESMTPSA id g3sm880112pgd.64.2020.04.07.15.00.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Apr 2020 15:00:38 -0700 (PDT)
From:   Douglas Anderson <dianders@chromium.org>
To:     axboe@kernel.dk, jejb@linux.ibm.com, martin.petersen@oracle.com
Cc:     Ming Lei <ming.lei@redhat.com>, linux-scsi@vger.kernel.org,
        sqazi@google.com, Gwendal Grignou <gwendal@chromium.org>,
        groeck@chromium.org, linux-block@vger.kernel.org,
        paolo.valente@linaro.org, Douglas Anderson <dianders@chromium.org>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/4] blk-mq: In blk_mq_dispatch_rq_list() "no budget" is a reason to kick
Date:   Tue,  7 Apr 2020 15:00:02 -0700
Message-Id: <20200407145906.v3.1.I1f95c459e51962b8d2c83e869913b6befda2255c@changeid>
X-Mailer: git-send-email 2.26.0.292.g33ef6b2f38-goog
In-Reply-To: <20200407220005.119540-1-dianders@chromium.org>
References: <20200407220005.119540-1-dianders@chromium.org>
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

Changes in v3:
- Note why blk_mq_dispatch_rq_list() change is needed.

Changes in v2: None

 block/blk-mq.c | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index f6291ceedee4..7d5f388b7da9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1206,6 +1206,7 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 	bool no_tag = false;
 	int errors, queued;
 	blk_status_t ret = BLK_STS_OK;
+	bool no_budget_avail = false;
 
 	if (list_empty(list))
 		return false;
@@ -1222,8 +1223,10 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
 		rq = list_first_entry(list, struct request, queuelist);
 
 		hctx = rq->mq_hctx;
-		if (!got_budget && !blk_mq_get_dispatch_budget(hctx))
+		if (!got_budget && !blk_mq_get_dispatch_budget(hctx)) {
+			no_budget_avail = true;
 			break;
+		}
 
 		if (!blk_mq_get_driver_tag(rq)) {
 			/*
@@ -1318,13 +1321,15 @@ bool blk_mq_dispatch_rq_list(struct request_queue *q, struct list_head *list,
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

