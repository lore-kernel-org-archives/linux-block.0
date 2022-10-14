Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78969C4332F
	for <linux-block@archiver.kernel.org>; Fri, 14 Oct 2022 10:01:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbiJNKBh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 14 Oct 2022 06:01:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230064AbiJNKBc (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 14 Oct 2022 06:01:32 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8CAE1C711A
        for <linux-block@vger.kernel.org>; Fri, 14 Oct 2022 03:01:25 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id e129so3884684pgc.9
        for <linux-block@vger.kernel.org>; Fri, 14 Oct 2022 03:01:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T5QWdWbstBgp2pYAiaYjcKEsDSFrUBS6egywEqSQuoo=;
        b=A27aDlZbs9NSj4m7qw6txksQVYzDJiVoj8ML+HrOjRCRmnW5tWDSMAdNbc7LhSAR8R
         WmArMei/J06lNVp/dqLvB8Hxzf8zIwfd5WGVM37VlHRC1d6dW3PDg7e5FryO7oC0z8US
         36F+PxeLuFUdeKtUgXvg64NL/L+N0uniILvQLoLy+3PTh/hJDXg4ZXQsuKPy0WdsOn94
         4WjsVXEtFslIakNFMhbogGur6jeuHsfVGoNeLQV1OsVFJyMLaArbyboMGJVWJxUtMokI
         AKHGHp6RFcIthAg9gQuRW89xdGmoqgNalGgIF16uvB8lYD6EQmv4uaKhddAmU7or/7Ah
         YZiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T5QWdWbstBgp2pYAiaYjcKEsDSFrUBS6egywEqSQuoo=;
        b=4WHdxr+Xo5li9NhYDwET4kdI+hOQFgz79hVx2y7tR5RFy5RKXm8Fd/ho12e1aCJYlT
         /Wrx5XOG4E924bXot+OCHhQL2WpbbSxcemtz8DEmR8cpSZZH2lcs3KBTJPcnqqE5Pl13
         XLREAWCwrswChWxsdu4F/SUoDDF4mxNGNIaVgy9hsxGn6JkNv1JXtMIfM+GdcOMP8GUP
         AWZW6izNZb9bX/C7e72HkfLgMhP8jj0tvl49xJGxJH78aBLR6e+n7dmw8pRSElM88fFf
         NbU5nhgRIwBTsbxuXw6o2Fhz4y/oJrPWJhgARc9AKb566g82ot4AZqkcCqluc8vzZBbL
         69rQ==
X-Gm-Message-State: ACrzQf3LkftnJwQgHl0NORDQ1LWp3+s4diUiKPCe2kpGVFkzUG/YEctz
        bRWJPSGxA2x8Dg0scfTT+u9hT3NqLp0=
X-Google-Smtp-Source: AMsMyM6hefei0xTR66Mrbw0sJ9Sefb+X1c9MimCmah438bXDi6ZC4/Unaah4MAO3NLZQuQZo+98rSg==
X-Received: by 2002:a05:6a00:2449:b0:528:3a29:e79d with SMTP id d9-20020a056a00244900b005283a29e79dmr4322452pfj.39.1665741684779;
        Fri, 14 Oct 2022 03:01:24 -0700 (PDT)
Received: from localhost.localdomain ([119.28.83.143])
        by smtp.gmail.com with ESMTPSA id a19-20020aa794b3000000b0053e42167a33sm1288905pfl.53.2022.10.14.03.01.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Oct 2022 03:01:24 -0700 (PDT)
From:   Hengqi Chen <hengqi.chen@gmail.com>
To:     linux-block@vger.kernel.org, axboe@kernel.dk, rostedt@goodmis.org
Cc:     hengqi.chen@gmail.com, flaniel@linux.microsoft.com
Subject: [PATCH] block: introduce block_io_start/block_io_done tracepoints
Date:   Fri, 14 Oct 2022 18:01:11 +0800
Message-Id: <20221014100111.1706363-1-hengqi.chen@gmail.com>
X-Mailer: git-send-email 2.25.1
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
  [0]: https://github.com/iovisor/bcc/issues/3954
  [1]: https://github.com/iovisor/bcc/issues/4261

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

