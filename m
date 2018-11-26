Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2EADEC43441
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB15920865
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="SpG2ITlT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB15920865
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbeK0Dkt (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:40:49 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:41208 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726484AbeK0Dkt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:40:49 -0500
Received: by mail-io1-f68.google.com with SMTP id s22so14461692ioc.8
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:46:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8/1Nol3a3uaTr8sM9gFlQE0kinP2KU2cED85d/G/25k=;
        b=SpG2ITlTENkBMGZK/kJkn/8cxIwNnkar1M8O94LTHwrAlqMcDehZ+x4SX0yv8fyWBk
         CGnm8gTrSEI6GZJ7+iahYvmKqdqKnwb1byicIDFkgxY+J1i8rpGmQUL7PoEjaEShAJd9
         V+8+qCFxWFRrZJCMIm+rD2YLu1cu58mNG0GiWbpU/THKsvzkp3/I0Zvyh7rFLoGqOHag
         abklHSYlwiWYuV272zC/4aHE8kzp0cdnnZgy7+Cchl+W5Nl5RRTpgGqJHzBlvv2ZX5BM
         HezJzM365+6tacTIdKEXYJCXN2iEO5aoFZ0p3lsb0KqfXBYu5h9Mo5JOst0NQJBDS/pZ
         gbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8/1Nol3a3uaTr8sM9gFlQE0kinP2KU2cED85d/G/25k=;
        b=dyM9Py2Tc0JM/3YK5Fa1JzROPgGjOVV9/cVkSyWXZZoCEHuM642ZVPkkLQW8SKuUlc
         skOnkoxkdzww06WwFYQvAfGPJqcxvPeaJwrjLE32GpIcaNiLSjPIEUvwuJuMjMmThT11
         5dQeDx5dJhKZsnBySDiHy2+1g9ixPVPBkLe+JUf9N+O4O/Y7S9SES3SdyXFR0JIBpesv
         TkwWETdYQ3TdfqlxIldPf124fjlq6Zp6sMC9y6Jg9DiqzFCRyvhekBoTvsG8oKk2Z47G
         NqFC2MO4E49KVVX7VUxFaqTjsm3KpK/S+r1dsYv+ABsWdRVsK66496fj6fSGKHvDQ7vL
         Q6sA==
X-Gm-Message-State: AA+aEWYAvScWSPAgVt3ziZ367vGgPlS8mkmLb6FuN5lfbqtPO7p6rVnU
        LPMPEFa9ZKB1depr3t4DLGLiDQynqJc=
X-Google-Smtp-Source: AFSGD/XMTYi6/A14h4AbBuZrWT5os/7E/avzDu65ty7TuN1Eo8U7jb6gqgbAg39BcxVTBUjmlcnM5A==
X-Received: by 2002:a5d:87cd:: with SMTP id q13mr5186661ios.92.1543250769114;
        Mon, 26 Nov 2018 08:46:09 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t65-v6sm486801ita.9.2018.11.26.08.46.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:46:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/20] aio: only use blk plugs for > 2 depth submissions
Date:   Mon, 26 Nov 2018 09:45:35 -0700
Message-Id: <20181126164544.5699-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126164544.5699-1-axboe@kernel.dk>
References: <20181126164544.5699-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Plugging is meant to optimize submission of a string of IOs, if we don't
have more than 2 being submitted, don't bother setting up a plug.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 681f2072f81b..533cb7b1112f 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1887,6 +1887,12 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 	return ret;
 }
 
+/*
+ * Plugging is meant to work with larger batches of IOs. If we don't
+ * have more than the below, then don't bother setting up a plug.
+ */
+#define AIO_PLUG_THRESHOLD	2
+
 /* sys_io_submit:
  *	Queue the nr iocbs pointed to by iocbpp for processing.  Returns
  *	the number of iocbs queued.  May return -EINVAL if the aio_context
@@ -1919,7 +1925,8 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 	if (nr > ctx->nr_events)
 		nr = ctx->nr_events;
 
-	blk_start_plug(&plug);
+	if (nr > AIO_PLUG_THRESHOLD)
+		blk_start_plug(&plug);
 	for (i = 0; i < nr; i++) {
 		struct iocb __user *user_iocb;
 
@@ -1932,7 +1939,8 @@ SYSCALL_DEFINE3(io_submit, aio_context_t, ctx_id, long, nr,
 		if (ret)
 			break;
 	}
-	blk_finish_plug(&plug);
+	if (nr > AIO_PLUG_THRESHOLD)
+		blk_finish_plug(&plug);
 
 	percpu_ref_put(&ctx->users);
 	return i ? i : ret;
@@ -1959,7 +1967,8 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 	if (nr > ctx->nr_events)
 		nr = ctx->nr_events;
 
-	blk_start_plug(&plug);
+	if (nr > AIO_PLUG_THRESHOLD)
+		blk_start_plug(&plug);
 	for (i = 0; i < nr; i++) {
 		compat_uptr_t user_iocb;
 
@@ -1972,7 +1981,8 @@ COMPAT_SYSCALL_DEFINE3(io_submit, compat_aio_context_t, ctx_id,
 		if (ret)
 			break;
 	}
-	blk_finish_plug(&plug);
+	if (nr > AIO_PLUG_THRESHOLD)
+		blk_finish_plug(&plug);
 
 	percpu_ref_put(&ctx->users);
 	return i ? i : ret;
-- 
2.17.1

