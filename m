Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75AA8C49361
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 14:10:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DF1161168
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 14:10:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234210AbhFSOMU (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jun 2021 10:12:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234100AbhFSOMT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jun 2021 10:12:19 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75805C061756
        for <linux-block@vger.kernel.org>; Sat, 19 Jun 2021 07:10:06 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id c5so14115504wrq.9
        for <linux-block@vger.kernel.org>; Sat, 19 Jun 2021 07:10:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=6g7vlVbhoRZSF7+EmrRdxzOP/EHGvFfqkkjwETya/KE=;
        b=kjMBUY3h3UMTyLQUbc28lJ70mF0Ggl/Z+C4o5tHPUcVFtGPII28NP36weIPnVxdIw3
         sWpCjcYZVo4izzyMLTgvzAaJCod4JxphZYTUjdwkBnBFMkp5iiO92vxK0lJmiuQmjjGU
         uyJdIGWuKnkQBGFb7Ts12IHJLjx7g2xC3rxUPdgWLMr0JFAWQn2lD35IBq17SmtBLUio
         DQx3TGmzOId64bieow58imzwYQ8fPTgcwSyR41v0tYXK6A/RbVUOXBIVYozdZt/wZRYD
         Lfn0W0VOyEKeeXhKFrO9wYGp8N0t74qgDWdqWM5as8c1jxeJTW2+AhTRHih6Rl/7KdGm
         MJ7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=6g7vlVbhoRZSF7+EmrRdxzOP/EHGvFfqkkjwETya/KE=;
        b=ksvaHXTzlwh0zAaUHPKK/nlh3KV6i4uF+0FpS7uURvrDqjRhkG4Lrtr3rhbNOhpZAj
         yyv3t4CPEJirsHt4+qJUDeSZvubQ0kCn6ocyXj+ADZEQvTQLTdWRfhvGKabwoLaWXJsR
         7vWxUz/1REQznKiXeP9pwGkhjQQlCwkaAEdtZzzKF5pbgEcpko3VSU1zTEZ8H2l5J9PA
         qJNOQwy2wVWQ2Iu/rlZn+9XXAA+OsfeImmY/hb4AfSm/rokZE9Bx8avo0d3McwWej+Wp
         0sVaA9yMtfHcN5Ejfy+lEuo4LuXUK/2d8ZFWdcwQSjtUWrPIoE3M35XXzRaWbnagCsX7
         LqPg==
X-Gm-Message-State: AOAM530lpWyN/pwlOYBrIBOuOswFVfiFvC/1tcQk16EZI7dQkMFwS45B
        s/e7nvhDH/DNn8Bo3M2U0hupCw==
X-Google-Smtp-Source: ABdhPJwJHJqgwj+z7ObRlMdOuqA4Jx8jhBKQRQmNXinJqXxj94gI8wVZ5HhsevkGxDk8YxEoIqWRig==
X-Received: by 2002:adf:a34e:: with SMTP id d14mr18045203wrb.325.1624111804985;
        Sat, 19 Jun 2021 07:10:04 -0700 (PDT)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id y16sm8379350wrp.51.2021.06.19.07.10.03
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jun 2021 07:10:04 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mariottiluca1@hotmail.it, holger@applied-asynchrony.com,
        pedroni.pietro.96@gmail.com,
        Paolo Valente <paolo.valente@linaro.org>
Subject: [PATCH FIXES/IMPROVEMENTS 1/7] block, bfq: let also stably merged queues enjoy weight raising
Date:   Sat, 19 Jun 2021 16:09:42 +0200
Message-Id: <20210619140948.98712-2-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210619140948.98712-1-paolo.valente@linaro.org>
References: <20210619140948.98712-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Merged bfq_queues are kept out of weight-raising (low-latency)
mechanisms. The reason is that these queues are usually created for
non-interactive and non-soft-real-time tasks. Yet this is not the case
for stably-merged queues. These queues are merged just because they
are created shortly after each other. So they may easily serve the I/O
of an interactive or soft-real time application, if the application
happens to spawn multiple processes.

To address this issue, this commits lets also stably-merged queued
enjoy weight raising.

Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index acd1f881273e..da2363f12e53 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1729,10 +1729,23 @@ static void bfq_bfqq_handle_idle_busy_switch(struct bfq_data *bfqd,
 		bfqq->entity.new_weight == 40;
 	*interactive = !in_burst && idle_for_long_time &&
 		bfqq->entity.new_weight == 40;
+	/*
+	 * Merged bfq_queues are kept out of weight-raising
+	 * (low-latency) mechanisms. The reason is that these queues
+	 * are usually created for non-interactive and
+	 * non-soft-real-time tasks. Yet this is not the case for
+	 * stably-merged queues. These queues are merged just because
+	 * they are created shortly after each other. So they may
+	 * easily serve the I/O of an interactive or soft-real time
+	 * application, if the application happens to spawn multiple
+	 * processes. So let also stably-merged queued enjoy weight
+	 * raising.
+	 */
 	wr_or_deserves_wr = bfqd->low_latency &&
 		(bfqq->wr_coeff > 1 ||
 		 (bfq_bfqq_sync(bfqq) &&
-		  bfqq->bic && (*interactive || soft_rt)));
+		  (bfqq->bic || RQ_BIC(rq)->stably_merged) &&
+		   (*interactive || soft_rt)));
 
 	/*
 	 * Using the last flag, update budget and check whether bfqq
-- 
2.20.1

