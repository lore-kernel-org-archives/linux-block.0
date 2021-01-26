Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 011E1C433E0
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 10:53:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B6FBE23109
	for <linux-block@archiver.kernel.org>; Tue, 26 Jan 2021 10:53:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404532AbhAZKwz (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 26 Jan 2021 05:52:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404523AbhAZKwr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 26 Jan 2021 05:52:47 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8B65C061793
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 02:51:23 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id j18so2037187wmi.3
        for <linux-block@vger.kernel.org>; Tue, 26 Jan 2021 02:51:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=g0MXCokkbnaIDoDqUI9Wq5P/6nCekdb4/ZayF5jaU44=;
        b=vj1b6NidgsO3AAvLOcErxLumqmJkTgHblZ2YHQzhzjKBenORxnL05KJV+vzV+/H4M1
         qD6TVraUtAGqfx+BhiM51UH0O0bGE8/UfsSJZnn5kKjpc5/sATZAj7MKszmX3BfeSGaL
         39KVXY5Igy9YDb4tUpgwnvpqoBk/6P7U1l5wAsmey3oYSlYUM6wELOk9KKELCJhtF4Yc
         hIQU5oavrd7La/YTBNrrkM61cRzuzJvruQS8Po/Zl4YyakHcj19xuU4V79xaFl2bf1I+
         9Xo4QuJu7tg4OS/Rco/9Y/OQQS3ntIOFkCISszXN+onU2Mb7mnabTUXTUvfUZ3Sqhm52
         hD6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=g0MXCokkbnaIDoDqUI9Wq5P/6nCekdb4/ZayF5jaU44=;
        b=fRT9wAE+BOfbcizLHhqkFWTtfLBh0RKhtQgZBxj2phJOJbE+5AdYAP6Nwg3SGCB4cE
         jt/C/5Xw8g6eYsHaY5aN/+yjk888i0v9f6zuDXgHAZB5Q68a/t4uo2gMYrC1w3TohaNR
         6tVCN+3UdgBzPAlqZmaMm1vPTjgQTiUQBlPVlEVO6YP233Ja1sagw3CZJ5TnsED1k346
         JaBkV1zXLNYXS7jhX27dtuKeL1xv+VHiHOeTIobiFa2nURhnuUvBC28RfAVtsdNNXu7P
         Oqi/G8QSXdui0JZMrU320hoMBJjg07ozpkvCE9U6vGbqd2qd4D4EiMlOgM9eVC3mkUyR
         7Cuw==
X-Gm-Message-State: AOAM530IY/BsbvzE3lPHziXf1X41o/AqJGQpWOzAf2pP8+q/ALB3vLQp
        Q7Nlcgl98F6ef9pDWgYLE12rAvlowkJcoQ==
X-Google-Smtp-Source: ABdhPJzK8Zs6frbsR2txsRD/xENvh79/znuNQXhGsBjUQ+py4BQ16PPJQWOtSdFqV0GvmIo8IjaV+g==
X-Received: by 2002:a1c:e0d4:: with SMTP id x203mr4071206wmg.160.1611658282468;
        Tue, 26 Jan 2021 02:51:22 -0800 (PST)
Received: from localhost.localdomain ([83.216.184.132])
        by smtp.gmail.com with ESMTPSA id h18sm7177879wru.65.2021.01.26.02.51.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 26 Jan 2021 02:51:22 -0800 (PST)
From:   Paolo Valente <paolo.valente@linaro.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paolo Valente <paolo.valente@linaro.org>,
        Jan Kara <jack@suse.cz>
Subject: [PATCH BUGFIX/IMPROVEMENT 4/6] block, bfq: fix weight-raising resume with !low_latency
Date:   Tue, 26 Jan 2021 11:51:00 +0100
Message-Id: <20210126105102.53102-5-paolo.valente@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210126105102.53102-1-paolo.valente@linaro.org>
References: <20210126105102.53102-1-paolo.valente@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When the io_latency heuristic is off, bfq_queues must not start to be
weight-raised. Unfortunately, by mistake, this may happen when the
state of a previously weight-raised bfq_queue is resumed after a queue
split. This commit fixes this error.

Tested-by: Jan Kara <jack@suse.cz>
Signed-off-by: Paolo Valente <paolo.valente@linaro.org>
---
 block/bfq-iosched.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/block/bfq-iosched.c b/block/bfq-iosched.c
index c5bda33c0923..0c7e203085f1 100644
--- a/block/bfq-iosched.c
+++ b/block/bfq-iosched.c
@@ -1010,7 +1010,7 @@ static void
 bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 		      struct bfq_io_cq *bic, bool bfq_already_existing)
 {
-	unsigned int old_wr_coeff = bfqq->wr_coeff;
+	unsigned int old_wr_coeff = 1;
 	bool busy = bfq_already_existing && bfq_bfqq_busy(bfqq);
 
 	if (bic->saved_has_short_ttime)
@@ -1031,7 +1031,13 @@ bfq_bfqq_resume_state(struct bfq_queue *bfqq, struct bfq_data *bfqd,
 	bfqq->ttime = bic->saved_ttime;
 	bfqq->io_start_time = bic->saved_io_start_time;
 	bfqq->tot_idle_time = bic->saved_tot_idle_time;
-	bfqq->wr_coeff = bic->saved_wr_coeff;
+	/*
+	 * Restore weight coefficient only if low_latency is on
+	 */
+	if (bfqd->low_latency) {
+		old_wr_coeff = bfqq->wr_coeff;
+		bfqq->wr_coeff = bic->saved_wr_coeff;
+	}
 	bfqq->service_from_wr = bic->saved_service_from_wr;
 	bfqq->wr_start_at_switch_to_srt = bic->saved_wr_start_at_switch_to_srt;
 	bfqq->last_wr_start_finish = bic->saved_last_wr_start_finish;
-- 
2.20.1

