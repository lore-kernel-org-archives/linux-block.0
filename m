Return-Path: <SRS0=hu+R=VT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DA21C76194
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 13:10:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 16CF521921
	for <linux-block@archiver.kernel.org>; Mon, 22 Jul 2019 13:10:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="sTWhn9Px"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728493AbfGVNKL (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 22 Jul 2019 09:10:11 -0400
Received: from mail-pg1-f195.google.com ([209.85.215.195]:44974 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729631AbfGVNKK (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 22 Jul 2019 09:10:10 -0400
Received: by mail-pg1-f195.google.com with SMTP id i18so17645150pgl.11
        for <linux-block@vger.kernel.org>; Mon, 22 Jul 2019 06:10:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=UrNlslrN8liHzMkSr61dS9Vo6ULE756aXr3wsWluV9g=;
        b=sTWhn9PxWbhK839hc00cr7mXR3PAg7IJBOZdEQ3yWz0jcnV2L5DSAZTRCNfZ3R3d54
         S6lUKT9NOdU/eoqkabViw9sqI3eKK1TunpvowbjZMkQ3m+4my1dYN/MpifvTFguoJKxA
         JWD1MkHiP2Gh2FQF05boPObIjc3o18u4gzsxPaui+37HoJXU1rTum2aNvjhprkGHnddC
         rsELA6KESDEcSm345tA941PvgOu8ntB+1Jh/H37feV61ct7+ygRTTHnvsRyljp7q/PAq
         nv9TB8HPiWJupf7g4msnq+RXVaqFOKrcw7bYzwMzA6z3HUvhO4RP/Lt+5eWDsO075gW6
         uWwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=UrNlslrN8liHzMkSr61dS9Vo6ULE756aXr3wsWluV9g=;
        b=dC0JWaFyNGVK6n9H1TGrG7LFZiBJYI/2Akek/WthNhuJbckXAIqKFJE/LBJdJn5XGS
         9zaxGxqh4x1QbN2/cFWZqqqFIPxXS1QfR1wR5P883nqyw0aXMIxpX6l+tD5QqQ9ldclF
         OG47RE/amx6jPjhc3oOb4JvStT2gDE6xpWAjN1KhPMV0pM2znPemq/q3uJRZ4RNCTf6D
         IwqBYVzN4YLID6XdprJua7Cnlo9sEG4yF8+ZzxT9avhmGe16w0tEjfU9Ed5fSIgqx5KV
         /nLldQlM1vwf88QF2LJk6AK/tTYJ3+bas9gZ/mvh9zn0AtHaZZMfjIm5EiA1TTJOxC5M
         voGw==
X-Gm-Message-State: APjAAAX2zdTvu7D/cx1RFlReNMmk7vdDxc1lbrTPzoejnG0XYJ0MjFx2
        PDGii7cEfyklTys5BJjDXbaU8A==
X-Google-Smtp-Source: APXvYqzRcxWpErvDH9emY38XtTGLIfJLxdrGbWv/jZZGNuzN2nNOtcSfgjzeFVKvDTcKg0wIuHMY2Q==
X-Received: by 2002:a17:90a:8985:: with SMTP id v5mr76073955pjn.136.1563801009693;
        Mon, 22 Jul 2019 06:10:09 -0700 (PDT)
Received: from baolinwangubtpc.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id p19sm47013192pfn.99.2019.07.22.06.10.06
        (version=TLS1 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 22 Jul 2019 06:10:09 -0700 (PDT)
From:   Baolin Wang <baolin.wang@linaro.org>
To:     axboe@kernel.dk, adrian.hunter@intel.com, ulf.hansson@linaro.org
Cc:     zhang.lyra@gmail.com, orsonzhai@gmail.com, arnd@arndb.de,
        linus.walleij@linaro.org, baolin.wang@linaro.org,
        vincent.guittot@linaro.org, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-block@vger.kernel.org
Subject: [RFC PATCH 1/7] blk-mq: Export blk_mq_hctx_has_pending() function
Date:   Mon, 22 Jul 2019 21:09:36 +0800
Message-Id: <94a0d20e6304b909391abd9a425c71c376cad964.1563782844.git.baolin.wang@linaro.org>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
In-Reply-To: <cover.1563782844.git.baolin.wang@linaro.org>
References: <cover.1563782844.git.baolin.wang@linaro.org>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Some SD/MMC host controllers can support packed command or packed request,
that means we can package several requests to host controller at one time
to improve performence. And this patch set will introduce MMC packed function
to support this feature by following patches.

To support MMC packed function, the MMC layer need to know if there are
requests are pending now in hardware queue to help to combine requests
as much as possible. If we know there are requests pending in hardware
queue, then we should not package requests to host controller immediately,
instead we should collect more requests into MMC packed queue to be packed
to host controller with packed condition.

Thus export this function for MMC packed function.

Signed-off-by: Baolin Wang <baolin.wang@linaro.org>
---
 block/blk-mq.c         |    3 ++-
 include/linux/blk-mq.h |    1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index b038ec6..5bd4ef9 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -63,12 +63,13 @@ static int blk_mq_poll_stats_bkt(const struct request *rq)
  * Check if any of the ctx, dispatch list or elevator
  * have pending work in this hardware queue.
  */
-static bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
+bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx)
 {
 	return !list_empty_careful(&hctx->dispatch) ||
 		sbitmap_any_bit_set(&hctx->ctx_map) ||
 			blk_mq_sched_has_work(hctx);
 }
+EXPORT_SYMBOL_GPL(blk_mq_hctx_has_pending);
 
 /*
  * Mark this ctx as having pending work in this hardware queue
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 3fa1fa5..15a2b7b 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -334,6 +334,7 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
 
 unsigned int blk_mq_rq_cpu(struct request *rq);
+bool blk_mq_hctx_has_pending(struct blk_mq_hw_ctx *hctx);
 
 /*
  * Driver command data is immediately after the request. So subtract request
-- 
1.7.9.5

