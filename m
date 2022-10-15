Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ACC7C4332F
	for <linux-block@archiver.kernel.org>; Sat, 15 Oct 2022 09:46:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229525AbiJOJqH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 15 Oct 2022 05:46:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJOJqG (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 15 Oct 2022 05:46:06 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFA0B4E622
        for <linux-block@vger.kernel.org>; Sat, 15 Oct 2022 02:46:01 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d10so7012313pfh.6
        for <linux-block@vger.kernel.org>; Sat, 15 Oct 2022 02:46:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yevS77zqlIo70RbwIB38gWjJeXMW2kI24HEwrpBEZG8=;
        b=SFoKswY9s54XXWOEd/FWf2SlXif50vG5yxUi23GsWnNyV2q33yzYVrfJxyIBiWEji0
         TARW8DrGamXjI7MQUU+JZiHjo6JbDji/qq9ndKVbfvQNU3cNTS6qx9Bd5tt1o3ukXr8n
         EqR0zAgySpmFrV0a9euuOUEiErTvDzj2CG7CjuU5UjuY98BQ37O51shatzHHqzQuZxjK
         JGm/ItirV4CZmjSMZoOmmOI0ICywWM3zwWaoZgcBEUMhJIVSiQyTCHIVGgPvTNR7ZQKf
         dPPELCE7n5vqgSzlDlMuoV4YUkfcnbhYdBrleGTtFsHtycuYW7nUhXISwGWdHpDD7Qpl
         ZBZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yevS77zqlIo70RbwIB38gWjJeXMW2kI24HEwrpBEZG8=;
        b=gbxO1H9ghvCzvYG4OvewCUk91qGD/Z+V8g3VPAPWUdgbC6pGxeWPRkikVk200NsjnV
         nHc/oaDC3VhAl/xanzYxutBfdhQfi9RWWXZQ/RcEo+ZVp2Bzeg+wIspk6YdHDkWUh2Bd
         YTLUKy+iLiRHhPQi68bq3+cnKKk02tVdHFsv10y/X3HTjBLyFsI2jX9giRZZoNyeWdCu
         0ST3TaTsqMQMkpVIo+6IJUK0PO3bKp/4vAtY5lqYwhil75rKodXSk43SDti62AGq/FGt
         OKRkKN8a1YXLyEnP/oE6MfzRvqmQpMGtVOsl6gKNLhV50xAXEFweq2kHE2mlxpxRMqsz
         XhTw==
X-Gm-Message-State: ACrzQf2TLYAot5UPqpXTai05EFdmAAKlYDrl0zGYNw+cX4VHJ5PeMm20
        0THd8ukzN/I4fxqZTB68IZQMrXXci7tKrw==
X-Google-Smtp-Source: AMsMyM4K5x0SHvIUNgyqnoU7lpN4WVx5LBnga8z66aBx9rHdKtTgb7+qNhk4LsPL+rsPwmxVlSuYNA==
X-Received: by 2002:a62:5a86:0:b0:563:553d:878e with SMTP id o128-20020a625a86000000b00563553d878emr2253302pfb.73.1665827160936;
        Sat, 15 Oct 2022 02:46:00 -0700 (PDT)
Received: from VM-32-4-ubuntu.. ([43.134.203.53])
        by smtp.gmail.com with ESMTPSA id e23-20020a17090a119700b0020a8ed65df3sm2738465pja.45.2022.10.15.02.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Oct 2022 02:46:00 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk, rostedt@goodmis.org
Cc:     hengqi.chen@gmail.com, flaniel@linux.microsoft.com
Subject: [PATCH v2] block: introduce block_io_start/block_io_done tracepoints
Date:   Sat, 15 Oct 2022 09:45:37 +0000
Message-Id: <20221015094537.383808-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Currently, several BCC ([0]) tools (biosnoop/biostacks/biotop) use
kprobes to blk_account_io_start/blk_account_io_done to implement
their functionalities. This is fragile because the target kernel
functions may be renamed ([1]) or inlined ([2]). So introduces two
new tracepoints for such use cases.

  [0]: https://github.com/iovisor/bcc
  [1]: https://github.com/iovisor/bcc/issues/3954
  [2]: https://github.com/iovisor/bcc/issues/4261

Tested-by: Francis Laniel <flaniel@linux.microsoft.com>
Signed-off-by: Hengqi Chen <hengqi.chen@gmail.com>
---
 block/blk-mq.c               |  4 ++++
 include/trace/events/block.h | 27 ++++++++++++++++++++++++++-
 2 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq.c b/block/blk-mq.c
index c96c8c4f751b..3777f486a365 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -887,6 +887,8 @@ static void __blk_account_io_done(struct request *req, u64 now)
 
 static inline void blk_account_io_done(struct request *req, u64 now)
 {
+	trace_block_io_done(req);
+
 	/*
 	 * Account IO completion.  flush_rq isn't accounted as a
 	 * normal IO on queueing nor completion.  Accounting the
@@ -917,6 +919,8 @@ static void __blk_account_io_start(struct request *rq)
 
 static inline void blk_account_io_start(struct request *req)
 {
+	trace_block_io_start(req);
+
 	if (blk_do_io_stat(req))
 		__blk_account_io_start(req);
 }
diff --git a/include/trace/events/block.h b/include/trace/events/block.h
index 7f4dfbdf12a6..65c4cb224736 100644
--- a/include/trace/events/block.h
+++ b/include/trace/events/block.h
@@ -245,6 +245,32 @@ DEFINE_EVENT(block_rq, block_rq_merge,
 	TP_ARGS(rq)
 );
 
+/**
+ * block_io_start - insert a request for execution
+ * @rq: block IO operation request
+ *
+ * Called when block operation request @rq is queued for execution
+ */
+DEFINE_EVENT(block_rq, block_io_start,
+
+	TP_PROTO(struct request *rq),
+
+	TP_ARGS(rq)
+);
+
+/**
+ * block_io_done - block IO operation request completed
+ * @rq: block IO operation request
+ *
+ * Called when block operation request @rq is completed
+ */
+DEFINE_EVENT(block_rq, block_io_done,
+
+	TP_PROTO(struct request *rq),
+
+	TP_ARGS(rq)
+);
+
 /**
  * block_bio_complete - completed all work on the block operation
  * @q: queue holding the block operation
@@ -556,4 +582,3 @@ TRACE_EVENT(block_rq_remap,
 
 /* This part must be outside protection */
 #include <trace/define_trace.h>
-
-- 
2.34.1

