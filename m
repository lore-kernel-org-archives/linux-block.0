Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B534C64E90
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 01:40:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1D7420757
	for <linux-block@archiver.kernel.org>; Mon, 30 Nov 2020 01:40:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cEI9Xgw5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727084AbgK3Bkf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 29 Nov 2020 20:40:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbgK3Bke (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 29 Nov 2020 20:40:34 -0500
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0638C0613D3
        for <linux-block@vger.kernel.org>; Sun, 29 Nov 2020 17:39:53 -0800 (PST)
Received: by mail-wm1-x342.google.com with SMTP id h21so20839118wmb.2
        for <linux-block@vger.kernel.org>; Sun, 29 Nov 2020 17:39:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=US5yRushGVKjXXXhnDbhPM2UlXqQN3YfBLJdnKDGXgU=;
        b=cEI9Xgw56KYfx/SV2lbfyvMII9OHUhr73oi1UIv2atH4AyXEb2lEeUDaOtrRqyrmIg
         PV1QtMgDFhT5sxai+bqKexh09gMu/YZ5yA/G2ml20qq0TBuaMlkOLnnwpAZHIcvdf0L8
         4a0HhPVATI9XyNY5VxjdOiIlLyI65NUVCFBE3j7xeSu0zDGCeTbSDG+VbBxLKmelYiU/
         y2pVbUfwCO1zYGPAfHQLOwWUnWfWfrKRLml4JHRGfmhwyCqWJk/CREoujBtEsbLxj/xs
         VZlcsfKiMC7y0tznF+iMtV4/oP7hq9Uc0YubN6xAMUt0Ujp0gxByX/xDg26myUGBZphc
         ycgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=US5yRushGVKjXXXhnDbhPM2UlXqQN3YfBLJdnKDGXgU=;
        b=dwEo7SpnTf0yDfgvz5GvbRpyOkhFh0K5DzTe2H/MzEiPaTaYpdzhooS8RS1ow7JteD
         VwuuIlptGtQRvb9pt6P01jbFjRdv+J62XcZPR6XRfEt122wl9sge+Ow1rJsC5fckY2r8
         EJPGwdyIwrxhm7jypuNGezdIyJo4YOdhXtaHQfn3t5yLTbYt9TXhhjU9eXftKXaGh8QN
         OkSs5rqbpZ1/J58U21rcY+5Z8/fUxgY4BRIDGKqscGfgVojMwwZ1k4r/O/RqieimctfK
         JazJGPXMgtTRB1ktpl2m5lWrYRKuY9IzGq/Dr+o47DeiYjilAliM2HqCJfWmWnXoXHd0
         W3qg==
X-Gm-Message-State: AOAM533RSqonJprj90gvHbjBCe3N0mwU7bYlBKIGqCTBy7LO2Agfh9dz
        9U59ITT6nKmcQgZEwiHGo57Cr+Xki3Q=
X-Google-Smtp-Source: ABdhPJxmd+q8Wf0u74V8QGVePtjC6MoELVEnF/W1yEgJ9hmWJSfiXEEFi7r/Ikxj38j6xLfEdpIuTw==
X-Received: by 2002:a1c:5f8a:: with SMTP id t132mr14169336wmb.121.1606700392592;
        Sun, 29 Nov 2020 17:39:52 -0800 (PST)
Received: from localhost.localdomain (host109-152-100-135.range109-152.btcentralplus.com. [109.152.100.135])
        by smtp.gmail.com with ESMTPSA id k1sm24573414wrp.23.2020.11.29.17.39.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Nov 2020 17:39:52 -0800 (PST)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org
Subject: [PATCH 2/3] blk-mq: deduplicate blk_mq_get_tag() bits
Date:   Mon, 30 Nov 2020 01:36:26 +0000
Message-Id: <15662b9565f5d372e5a2fd568f1fccc083198e90.1606699505.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <cover.1606699505.git.asml.silence@gmail.com>
References: <cover.1606699505.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Deduplicate bt_wait_ptr() call in blk_mq_get_tag(), condition-less while
and absence of loop controls in-between former and current call location
makes the change functionally identical.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/blk-mq-tag.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq-tag.c b/block/blk-mq-tag.c
index dbbf11edf9a6..98f6ea219bb4 100644
--- a/block/blk-mq-tag.c
+++ b/block/blk-mq-tag.c
@@ -112,10 +112,11 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 	if (data->flags & BLK_MQ_REQ_NOWAIT)
 		return BLK_MQ_NO_TAG;
 
-	ws = bt_wait_ptr(bt, data->hctx);
 	do {
 		struct sbitmap_queue *bt_prev;
 
+		ws = bt_wait_ptr(bt, data->hctx);
+
 		/*
 		 * We're out of tags on this hardware queue, kick any
 		 * pending IO submits before going to sleep waiting for
@@ -158,8 +159,6 @@ unsigned int blk_mq_get_tag(struct blk_mq_alloc_data *data)
 		 */
 		if (bt != bt_prev)
 			sbitmap_queue_wake_up(bt_prev);
-
-		ws = bt_wait_ptr(bt, data->hctx);
 	} while (1);
 
 	sbitmap_finish_wait(bt, ws, &wait);
-- 
2.24.0

