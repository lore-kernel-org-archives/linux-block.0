Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D16E7C2BB3F
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 15:22:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A270422C9C
	for <linux-block@archiver.kernel.org>; Fri,  4 Dec 2020 15:22:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730518AbgLDPWH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Dec 2020 10:22:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730493AbgLDPWH (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Dec 2020 10:22:07 -0500
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E920C061A53;
        Fri,  4 Dec 2020 07:21:27 -0800 (PST)
Received: by mail-pg1-x541.google.com with SMTP id n7so3708761pgg.2;
        Fri, 04 Dec 2020 07:21:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zSiFncf9bc1IksnnHanoKbYxCLnTdwlPlYIeXCQuzAo=;
        b=NUKe7m154RACyFxE/BsYVTHsM+7z19YuU1au+5V0prlFmNfBtv35ChQeOuXhYQOYCj
         3CI6C3YYYH+MGvrU4CJQoxjLKPPuYRH83yoXKkUz5TngBc6ExqMocojFL9lNfe6EtCb4
         NQXG2ESRU+N6+MRDUKE738qzQyf48T+vksFsfbo6qmp8etFfjSUlM0lk2MQdIyza5T66
         HCje7fK+NkTwTzSR8XM2FO+NO2PoEkYObT21FdKUCVpxGxSIXhwSzQ7EwedFlomQ/qe2
         hKgPU0y26HfWMJdo6D4SMQCwRVP2J3t88rzwzFaxca2EBYIIFyfvCriCbNDWSHq0ZPoJ
         MSpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zSiFncf9bc1IksnnHanoKbYxCLnTdwlPlYIeXCQuzAo=;
        b=l3Zkla0h1iHZHUgZqYP1zkeYw6TqnHRuDH8ESBOSh+PqXUsENAUM+kHvF4nXbjwnqd
         48sGYAQXCVVKlrVJiSgGeKexHnk9V2y7r39U+ULG8EbGl7ZsBi8DL0TvjgrBceq5AE7u
         BVBVW6uj3roEHtO6u3ZT8pjbLEhyogrP4ML4v16GpZzUK6C7MAjbZ0abD3Fd7ZFqt1wr
         j6FReZWg+x8ddh3anpkIwwNa0eQPYtfN3NoznxGfos5kAW5b9lcsMHVk0uvrNh5sYlQT
         87ngPrATIsWmFPPrNLYRArohDgD1KiCUa+8+LYU9PRQr1c8IT1OVTfsdWbb7O+J4q1+u
         unkg==
X-Gm-Message-State: AOAM530u5CDU7qqD6gv7q5Q9tl5EQRDMnD4JhwbP2ly1inkICeeh5kwj
        ZYp+tYN2Y2nO8WRQ5OiMndKJukyyMKSMRQ==
X-Google-Smtp-Source: ABdhPJypSxXb5nWWg6zFc4F311ljR6V39mAg0gur2Z3gKt7vFFgkNKvnCs1Fp44NFAGk3rNiuZKADQ==
X-Received: by 2002:a63:1b42:: with SMTP id b2mr2745121pgm.401.1607095286645;
        Fri, 04 Dec 2020 07:21:26 -0800 (PST)
Received: from localhost.localdomain ([211.108.35.36])
        by smtp.gmail.com with ESMTPSA id d20sm2407286pjz.3.2020.12.04.07.21.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Dec 2020 07:21:26 -0800 (PST)
From:   Minwoo Im <minwoo.im.dev@gmail.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>, Minwoo Im <minwoo.im.dev@gmail.com>
Subject: [PATCH 3/3] blk-mq: fix msec comment from micro to milli seconds
Date:   Sat,  5 Dec 2020 00:20:55 +0900
Message-Id: <20201204152055.31605-4-minwoo.im.dev@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20201204152055.31605-1-minwoo.im.dev@gmail.com>
References: <20201204152055.31605-1-minwoo.im.dev@gmail.com>
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Delay to wait for queue running is milli second unit which is passed to
delayed work via msecs_to_jiffies() which is to convert milliseconds to
jiffies.

Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>
---
 block/blk-mq.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index 69771ba18f1f..284d103bd0e7 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -1594,7 +1594,7 @@ static int blk_mq_hctx_next_cpu(struct blk_mq_hw_ctx *hctx)
  * __blk_mq_delay_run_hw_queue - Run (or schedule to run) a hardware queue.
  * @hctx: Pointer to the hardware queue to run.
  * @async: If we want to run the queue asynchronously.
- * @msecs: Microseconds of delay to wait before running the queue.
+ * @msecs: Milliseconds of delay to wait before running the queue.
  *
  * If !@async, try to run the queue now. Else, run the queue asynchronously and
  * with a delay of @msecs.
@@ -1623,7 +1623,7 @@ static void __blk_mq_delay_run_hw_queue(struct blk_mq_hw_ctx *hctx, bool async,
 /**
  * blk_mq_delay_run_hw_queue - Run a hardware queue asynchronously.
  * @hctx: Pointer to the hardware queue to run.
- * @msecs: Microseconds of delay to wait before running the queue.
+ * @msecs: Milliseconds of delay to wait before running the queue.
  *
  * Run a hardware queue asynchronously with a delay of @msecs.
  */
@@ -1687,7 +1687,7 @@ EXPORT_SYMBOL(blk_mq_run_hw_queues);
 /**
  * blk_mq_delay_run_hw_queues - Run all hardware queues asynchronously.
  * @q: Pointer to the request queue to run.
- * @msecs: Microseconds of delay to wait before running the queues.
+ * @msecs: Milliseconds of delay to wait before running the queues.
  */
 void blk_mq_delay_run_hw_queues(struct request_queue *q, unsigned long msecs)
 {
-- 
2.17.1

