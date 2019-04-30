Return-Path: <SRS0=2amJ=TA=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 797D6C04AA6
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 07:35:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 41D2721670
	for <linux-block@archiver.kernel.org>; Tue, 30 Apr 2019 07:35:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gALhrWtx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbfD3HfE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 30 Apr 2019 03:35:04 -0400
Received: from mail-lf1-f66.google.com ([209.85.167.66]:40259 "EHLO
        mail-lf1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725554AbfD3HfC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 30 Apr 2019 03:35:02 -0400
Received: by mail-lf1-f66.google.com with SMTP id o16so10040046lfl.7;
        Tue, 30 Apr 2019 00:35:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=HtnRUiYbdvR5AVRauOVFfKBp7TPmzvmFc+xKArpska4=;
        b=gALhrWtxTm42YAFjHAQoNmJyyM6VIqPqDM35LxPpRh6msiZO8A9AENG/JE7I258FcL
         B7zgtK0o+dAwJG0srni8Ug0In9dmatRM0jNjJ307iLsyKhBRefOznXoSsgx2qY1JHj/r
         xLNI5WzOIwfiU6kM7qNNSlDR3o5gRy7jzYD76Lim+7cnn/DxajEVLqMiKJAasjdu2W+l
         DAFGsneyKVj/KQRi0XY85xu4iF1Jq+SUoN5jVcsO2UTJP9GlciDZLWOjFwdD/YHsETbO
         MUOfa3+w91RvettsRzazNMIvJ9qnhoSX8ORNZDB+L9E2mVAMwMAQXwshh2fURV1PC//O
         Szpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=HtnRUiYbdvR5AVRauOVFfKBp7TPmzvmFc+xKArpska4=;
        b=ALqtSr8J2AAZWmX0eF85VQAXqaR4ARIeXqBRO7nVzngfLNAvTHmxMVP1RkSBxV39LT
         WhF08k958eT97SyAnB4V73mG3J2iptYoGX3uRntY1V6GQVWbW3tLS9g8SIcOkBS/l6kz
         +EmwgxyAC4NFCJt12LJpal0Tu3/2PpGhHg6OnxgyoYeF223ntM32dzM87TPKfVhOY9k0
         d+MSX6AWZgXmLM12hZvCPy1zj71jfOdX+4vtk2gPIYF4lKuaXVOQF7nYKtidkCsqVk9x
         p6Yozr49ZopXpCVTXJBxyH/JWV8Rqnhm7Qu5KTHJBkn+xmzxVstyx/LOc7ty8tFhqYEr
         Ctkg==
X-Gm-Message-State: APjAAAWK2Y+NyJjIo/yFcosZecBU0L0OZwe0BbnH2qzCv4xZdmTttn/Q
        VuUtN5BO8rdah2YdOpJ0CUo=
X-Google-Smtp-Source: APXvYqxX4WBUaiuWGupXHmDqZxf75tc8GU/UV42ia+8uJ6iVMxobS281e9ydM/mZSZwNKesmT8NPww==
X-Received: by 2002:a19:c113:: with SMTP id r19mr34939498lff.64.1556609699788;
        Tue, 30 Apr 2019 00:34:59 -0700 (PDT)
Received: from localhost.localdomain ([109.126.133.52])
        by smtp.gmail.com with ESMTPSA id v23sm2400572ljk.14.2019.04.30.00.34.57
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 30 Apr 2019 00:34:59 -0700 (PDT)
From:   "Pavel Begunkov (Silence)" <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 3/7] blk-mq: Fix disabled hybrid polling
Date:   Tue, 30 Apr 2019 10:34:15 +0300
Message-Id: <87e3f35a44cf987cc71a8dcc38238bc61164fb11.1556609582.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1556609582.git.asml.silence@gmail.com>
References: <cover.1556609582.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Pavel Begunkov <asml.silence@gmail.com>

Commit 4bc6339a583cec650b05 ("block: move blk_stat_add() to
__blk_mq_end_request()") moved blk_stat_add(), so now it's called after
blk_update_request(), which zeroes rq->__data_len. Without length,
blk_stat_add() can't calculate stat bucket and returns error,
effectively disabling hybrid polling.

Move it back to __blk_mq_complete_request.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index fc60ed7e940e..cc3f73e4e01c 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -535,11 +535,6 @@ inline void __blk_mq_end_request(struct request *rq, blk_status_t error)
 	if (blk_mq_need_time_stamp(rq))
 		now = ktime_get_ns();
 
-	if (rq->rq_flags & RQF_STATS) {
-		blk_mq_poll_stats_start(rq->q);
-		blk_stat_add(rq, now);
-	}
-
 	if (rq->internal_tag != -1)
 		blk_mq_sched_completed_request(rq, now);
 
@@ -578,6 +573,11 @@ static void __blk_mq_complete_request(struct request *rq)
 	int cpu;
 
 	WRITE_ONCE(rq->state, MQ_RQ_COMPLETE);
+
+	if (rq->rq_flags & RQF_STATS) {
+		blk_mq_poll_stats_start(rq->q);
+		blk_stat_add(rq, ktime_get_ns());
+	}
 	/*
 	 * Most of single queue controllers, there is only one irq vector
 	 * for handling IO completion, and the only irq's affinity is set
-- 
2.21.0

