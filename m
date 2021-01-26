Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F20BC433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 12:25:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2550D23109
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 12:25:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391617AbhAZMYn (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 07:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404524AbhAZKwr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 05:52:47 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF0AC061794
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 02:51:25 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id u14so2031511wml.4
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 02:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eDB2VePP2gLo3jktXjvGnSm3jDWHWVOh6rC8z0CbRvQ=;
        b=D7x3P3OFR2vff+Yisjrvazi8eadRJNZbJnawBZbQpfFxy4dMa/orEnq0vHCEEDJL5p
         kLf5J9b4uznLltOw5/AuQA7c4JtVJS5tWd3XV2xZCo/QMYerYkgcfBVBJ8m/gt3+9pII
         fVhlxp2QrMCtwfNZoLRG6TGUEXup8VrC6YaIUNfjVr8LmWlbg2NbS7jjmegOFbe7KmRK
         8bTtTWco0Xh45LldthuzzW8S4sL4fQ/ZdfVmAwzTguy8WBcROiEkYlEmabKewjrhpJeE
         S5iKogUo4fst39p5sS8skCcFs1ScgkFe4iJncmXTbaBjfclKz/4Cgitov9ctk+kgVtjS
         Aa5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eDB2VePP2gLo3jktXjvGnSm3jDWHWVOh6rC8z0CbRvQ=;
        b=T1yYS2k7Mh12DumlgycbIFls3NtkAENIm4+dY+g4dH1lB7YtF41Ytusy9z61+LUYKg
         2026LbMgbUYagTV6d381byGuljdCnQgZsnzabuHBDpIeLJWTQDWBey0wR29sWbjVq97w
         ERqROY/bmQREfCWzt/VoYoNDrwbm9eFx84lgCBi73NV/5qf6bI7By8Acyxve809Ltqb+
         uoOivpurWT+Od5j415XtFN31xF8JFMVz5sgaxQzL3+SF4LK5wqNGBlHdjEQ64Z4baKyr
         3HmvKf7Vk5LBriBVxoF9qwNiwm30NMINOkby4Sw1H0gDMrXKOGB8XMAcGL0198pYW7rR
         13Fg==
X-Gm-Message-State: AOAM532B65Ry5L2EbQRXyKdQXjo9+XY3is06Hatf7tR/yLWGYvCU+m5n
        V5ObU/AgdTHagUkdDEqXNeUJZQ==
X-Google-Smtp-Source: ABdhPJxt0t0zfhum4rHmKwRmfDFrxAJaGG/0X91xEqYzJx6/dtV9+zRIwoFomMvoiUeOP+B2K1NtCQ==
X-Received: by 2002:a7b:ce96:: with SMTP id q22mr4150055wmj.165.1611658283791;
        Tue, 26 Jan 2021 02:51:23 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h18sm7177879wru.65.2021.01.26.02.51.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 02:51:23 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 5/6] block, bfq: keep shared queues out of the waker mechanism
Date:   Tue, 26 Jan 2021 11:51:01 +0100
Message-Id: <20210126105102.53102-6-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210126105102.53102-1-paolo.valente@linaro.org>
References: <20210126105102.53102-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Shared queues are likely to receive I/O at a high rate. This may
deceptively let them be considered as wakers of other queues. But a
false waker will unjustly steal bandwidth to its supposedly woken
queue. So considering also shared queues in the waking mechanism may
cause more control troubles than throughput benefits. This commit
keeps shared queues out of the waker-detection mechanism.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index 0c7e203085f1..23d0dd7bd90f 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -5825,7 +5825,17 @@ static void bfq_completed_request(struct bfq_queue *bfqq, struct bfq_data *bfqd)
 			1UL<<(BFQ_RATE_SHIFT - 10))
 		bfq_update_rate_reset(bfqd, NULL);
 	bfqd->last_completion = now_ns;
-	bfqd->last_completed_rq_bfqq = bfqq;
+	/*
+	 * Shared queues are likely to receive I/O at a high
+	 * rate. This may deceptively let them be considered as wakers
+	 * of other queues. But a false waker will unjustly steal
+	 * bandwidth to its supposedly woken queue. So considering
+	 * also shared queues in the waking mechanism may cause more
+	 * control troubles than throughput benefits. Then do not set
+	 * last_completed_rq_bfqq to bfqq if bfqq is a shared queue.
+	 */
+	if (!bfq_bfqq_coop(bfqq))
+		bfqd->last_completed_rq_bfqq = bfqq;
 
 	/*
 	 * If we are waiting to discover whether the request pattern
-- 
2.20.1

