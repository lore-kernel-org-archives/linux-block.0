Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA4DAC433B4
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 09:42:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B03D7613AA
	for <linux-block@archiver.kernel.org>; Wed, 12 May 2021 09:42:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhELJnM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 12 May 2021 05:43:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230176AbhELJnL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 12 May 2021 05:43:11 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84003C06175F
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 02:42:03 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id j10so6985938ejb.3
        for <linux-block@vger.kernel.org>; Wed, 12 May 2021 02:42:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=J5ilOFgohDPowmInai3EYFncza98UL+il5HL3oO9vVE=;
        b=P1O9HrOSfZr0fdZnh9cx07Q3tIkAsfdOggSGcISUJ47Em9U+qMku0KDscLgHJswPb/
         VToYR/Yi42SMNo3Lk8RrUJNeEeNct4jSIQRXdbui0zTvO+dd5A9tJXZQnkjqSDinKHRt
         FZi7FTiEhYU5nCNmXQgyrusQQdlxTl07Iku0oUSEiCSBtT9CTngKsOfP2dlsKGnuQfXl
         BOxmebktZozSxzyE5IxfLd+Cw2xHZl/xbi07EdN4hzlRv+fdOTxa8gU50MwukvrZZCUf
         1VykBN9ABHxUhync1Vcp6iQdGv9p1qHJBnFrkyBBeTIXmMEB+mswsL1HbMDpFhC84aU1
         CgGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=J5ilOFgohDPowmInai3EYFncza98UL+il5HL3oO9vVE=;
        b=TP2f99GhJVvBYR7Ghs8nepWUbj3pVlYCvsO31CEcmUq2LTYHjc8YN3iEU4qtvHOWVx
         qx/il0iTGeLkoRZ3ikjhBO/8ZURZqyELm7DD8WWeMQpyFPg7iDWI+5cWurZVIrb5XfJI
         m3zPJUAvORZE1oCV8mLNRqwv3KKykWjsFdDS3bQchhP+nNjYMazWDZzI5fWrIb8Vqud7
         PR60hR9iQIbIPwt2o6I23rqxHCFhFCOaMFCKBZgSaNCkYUscSi4YHY19QCdzzFR64PB5
         SrJRMSK8IMYFPvAzPli1oKJLENfr52kt78B9S20MstNPL84jRRcZqdN3jcgEhbNx85cU
         ALoQ==
X-Gm-Message-State: AOAM530SrYwpi6yG2D0RuT135r15ns3Hpr5YvApl1QQj2jKa6f3fbJ9x
        pgiEp+vkEsmBqP+jPodmOFzmXw==
X-Google-Smtp-Source: ABdhPJzRu72gJjn0WIjo+2j/Y6e4RQU7/05oZiXpUIngV0qidNDYedy94Ac5BQGj8E054nxxwzLMBA==
X-Received: by 2002:a17:907:3da4:: with SMTP id he36mr35931348ejc.308.1620812522246;
        Wed, 12 May 2021 02:42:02 -0700 (PDT)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id p22sm17068261edr.4.2021.05.12.02.42.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 12 May 2021 02:42:01 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        yi.zhang@redhat.com, Paolo Valente <paolo.valente@linaro.org>,
        Pietro Pedroni <pedroni.pietro.96@gmail.com>
Subject: [PATCH BUGFIX 1/1] block, bfq: avoid circular stable merges
Date:   Wed, 12 May 2021 11:43:52 +0200
Message-Id: <20210512094352.85545-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210512094352.85545-1-paolo.valente@linaro.org>
References: <20210512094352.85545-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

BFQ may merge a new bfq_queue, stably, with the last bfq_queue
created. In particular, BFQ first waits a little bit for some I/O to
flow inside the new queue, say Q2, if this is needed to understand
whether it is better or worse to merge Q2 with the last queue created,
say Q1. This delayed stable merge is performed by assigning
bic->stable_merge_bfqq = Q1, for the bic associated with Q1.

Yet, while waiting for some I/O to flow in Q2, a non-stable queue
merge of Q2 with Q1 may happen, causing the bic previously associated
with Q2 to be associated with exactly Q1 (bic->bfqq = Q1). After that,
Q2 and Q1 may happen to be split, and, in the split, Q1 may happen to
be recycled as a non-shared bfq_queue. In that case, Q1 may then
happen to undergo a stable merge with the bfq_queue pointed by
bic->stable_merge_bfqq. Yet bic->stable_merge_bfqq still points to
Q1. So Q1 would be merged with itself.

This commit fixes this error by intercepting this situation, and
canceling the schedule of the stable merge.

Fixes: 430a67f9d616 ("block, bfq: merge bursts of newly-created queues")
Signed-off-by: Pietro Pedroni <pedroni.pietro.96@gmail.com>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 31 +++++++++++++++++++++++++++++--
 1 file changed, 29 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0270cd7ca165..4c3dcf43b0e2 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -372,9 +372,38 @@ struct bfq_queue *bic_to_bfqq(struct bfq_io_cq *bic, bool is_sync)
 	return bic->bfqq[is_sync];
 }
 
+static void bfq_put_stable_ref(struct bfq_queue *bfqq);
+
 void bic_set_bfqq(struct bfq_io_cq *bic, struct bfq_queue *bfqq, bool is_sync)
 {
+	/*
+	 * If bfqq != NULL, then a non-stable queue merge between
+	 * bic->bfqq and bfqq is happening here. This causes troubles
+	 * in the following case: bic->bfqq has also been scheduled
+	 * for a possible stable merge with bic->stable_merge_bfqq,
+	 * and bic->stable_merge_bfqq == bfqq happens to
+	 * hold. Troubles occur because bfqq may then undergo a split,
+	 * thereby becoming eligible for a stable merge. Yet, if
+	 * bic->stable_merge_bfqq points exactly to bfqq, then bfqq
+	 * would be stably merged with itself. To avoid this anomaly,
+	 * we cancel the stable merge if
+	 * bic->stable_merge_bfqq == bfqq.
+	 */
 	bic->bfqq[is_sync] = bfqq;
+
+	if (bfqq && bic->stable_merge_bfqq == bfqq) {
+		/*
+		 * Actually, these same instructions are executed also
+		 * in bfq_setup_cooperator, in case of abort or actual
+		 * execution of a stable merge. We could avoid
+		 * repeating these instructions there too, but if we
+		 * did so, we would nest even more complexity in this
+		 * function.
+		 */
+		bfq_put_stable_ref(bic->stable_merge_bfqq);
+
+		bic->stable_merge_bfqq = NULL;
+	}
 }
 
 struct bfq_data *bic_to_bfqd(struct bfq_io_cq *bic)
@@ -2631,8 +2660,6 @@ static bool bfq_may_be_close_cooperator(struct bfq_queue *bfqq,
 static bool idling_boosts_thr_without_issues(struct bfq_data *bfqd,
 					     struct bfq_queue *bfqq);
 
-static void bfq_put_stable_ref(struct bfq_queue *bfqq);
-
 /*
  * Attempt to schedule a merge of bfqq with the currently in-service
  * queue or with a close queue among the scheduled queues.  Return
-- 
2.20.1

