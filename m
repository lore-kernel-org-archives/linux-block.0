Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE998C2B9F4
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 14:10:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A8A761154
	for <linux-block@archiver.kernel.org>; Sat, 19 Jun 2021 14:10:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233984AbhFSOMW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 19 Jun 2021 10:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234201AbhFSOMT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 19 Jun 2021 10:12:19 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74290C061574
        for <linux-block@vger.kernel.org>; Sat, 19 Jun 2021 07:10:08 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id a11so14124369wrt.13
        for <linux-block@vger.kernel.org>; Sat, 19 Jun 2021 07:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hC9BFTBWcTXijFEq33PLLX9kxhkfj/7LaHyPw7jQ58s=;
        b=o8TzPa/l1bjhf7QJVAWLMR7BvlUNSL2urpFZoxSIhTmfqBGcnsBJw7OA6e3Rt4C8OV
         QqWe4sjJN01SsrIwPExwmMqiyupkYW2MDoPs8amz1eO11np7bkZVz9DfPlgXhdzyKTwX
         M1NuodJ+rSZBRbpYU/BuSXrx7RSnNoT+GuBDA8UlYGoNivTeTHEScEVIGEdtziwVXFnu
         IFbIEMmAp4WQo0tuGRO+9ueJEY0rSMZnZHf1vo89ELIOgyH05SSXiZ9vgkZSHm6TVAiZ
         Nbsm8KKhpBWJZrpTUH/WwvFMFpmfp/W+uM8p/rVXvfN+QrU2/Mxi1+1fx0KuyzEL6tla
         so9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hC9BFTBWcTXijFEq33PLLX9kxhkfj/7LaHyPw7jQ58s=;
        b=IWrk+XtmK9DPEXgVxrhxh+z6xdDMkcAZ9o4riF+3jksowJGTHOFKqlEYHdKI0SE6Lx
         GHs1bOwOOw9dA+PXhq5G+KZl4lHjPPE+tR0yQVmsO55XCZNKAK6VOvWjpQJPS0uwTM3Z
         VDyzZBbAsk50DtRAQ3mrCztWZpw3LO1Rf4phd6LE1qv+i+1M85CxbYHCf0eku752U3Xg
         ROoCi6oCBRVAjqp6FKN4tuFxv5EnzAIem0OG/x5PpwgBs78e1IbLt6s4/PivFvwXACNN
         0NDLBLEvqN6Prksx24GDsnj7ODTPZAut3bma915sQ6hpO18lpw4iloexzVyAtV2lNhv4
         rOGA==
X-Gm-Message-State: AOAM530u/037IKBQ0gLzwjXBQZyegLx8y9lMk4sZGRQuGMNu36Z+eeEO
        n5fgQEBBOFFnEdhAHOJAuwBJuQ==
X-Google-Smtp-Source: ABdhPJw9VMfy19IWy4r4JaRGj+svzFwY0ZUiywgiyFidMcYz1RGQ9K//Rs9Lj8yf8hpJ1JrLCDVicw==
X-Received: by 2002:a5d:558e:: with SMTP id i14mr17953487wrv.16.1624111806981;
        Sat, 19 Jun 2021 07:10:06 -0700 (PDT)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id y16sm8379350wrp.51.2021.06.19.07.10.05
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 19 Jun 2021 07:10:05 -0700 (PDT)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        mariottiluca1@hotmail.it, holger@applied-asynchrony.com,
        pedroni.pietro.96@gmail.com,
        Paolo Valente <paolo.valente@unimore.it>
Subject: [PATCH FIXES/IMPROVEMENTS 2/7] block, bfq: fix delayed stable merge check
Date:   Sat, 19 Jun 2021 16:09:43 +0200
Message-Id: <20210619140948.98712-3-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210619140948.98712-1-paolo.valente@linaro.org>
References: <20210619140948.98712-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Luca Mariotti <mariottiluca1@hotmail.it>

When attempting to schedule a merge of a given bfq_queue with the currently
in-service bfq_queue or with a cooperating bfq_queue among the scheduled
bfq_queues, delayed stable merge is checked for rotational or non-queueing
devs. For this stable merge to be performed, some conditions must be met.
If the current bfq_queue underwent some split from some merged bfq_queue,
one of these conditions is that two hundred milliseconds must elapse from
split, otherwise this condition is always met.

Unfortunately, by mistake, time_is_after_jiffies() was written instead of
time_is_before_jiffies() for this check, verifying that less than two
hundred milliseconds have elapsed instead of verifying that at least two
hundred milliseconds have elapsed.

Fix this issue by replacing time_is_after_jiffies() with
time_is_before_jiffies().

Signed-off-by: Luca Mariotti <mariottiluca1@hotmail.it>
Signed-off-by: Paolo Valente <paolo.valente@unimore.it>
Signed-off-by: Pietro Pedroni <pedroni.pietro.96@gmail.com>
---
 block/bfq-iosched.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index da2363f12e53..c5c0e74977d4 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -2710,7 +2710,7 @@ bfq_setup_cooperator(struct bfq_data *bfqd, struct bfq_queue *bfqq,
 	if (unlikely(!bfqd->nonrot_with_queueing)) {
 		if (bic->stable_merge_bfqq &&
 		    !bfq_bfqq_just_created(bfqq) &&
-		    time_is_after_jiffies(bfqq->split_time +
+		    time_is_before_jiffies(bfqq->split_time +
 					  msecs_to_jiffies(200))) {
 			struct bfq_queue *stable_merge_bfqq =
 				bic->stable_merge_bfqq;
-- 
2.20.1

