Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 747CBC67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F62420851
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="axA/QSsM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3F62420851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729654AbeLMR5K (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:10 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:35971 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729483AbeLMR5J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:09 -0500
Received: by mail-io1-f67.google.com with SMTP id m19so2326517ioh.3
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fw/O4zwzIPzN/w4BqDNf+gyUsaBSdiYM1Ss+7FBryao=;
        b=axA/QSsM99YaA9/9NCbIjs/ZXRLwt6850ruelQU6q6PDTFa7NMx54n9spJYe0Y3aD2
         NSS7xeo9clYe07YEBwu0eCqvP9jCtJ/axeQDyJ4pzBigT7obPmDmFzuPSmFTaX0XNFFA
         2LKk3rty9cgGDbgx4bymYPFNUvCa9BK95yYVaAsaQ9/rmDu4QNGCIrW8dh4hxRx+ggbP
         emXCSQrDNjKdSj8Gb21H9sFIgiIHsCXiG5X5Mjo6b3Uopua6yCdYmDvLvyoyoZQxirH5
         y9rLfgcjaZGNsieCIAta6xn01ec/ZzYXGzz6pCKCvJQoJht4vbtPMAs7hHRBDEOR/NMI
         L4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fw/O4zwzIPzN/w4BqDNf+gyUsaBSdiYM1Ss+7FBryao=;
        b=ot0wxWYNvAPTcdZajaJXqeOiK7nCkbPwOkf7VodqKqikU7a4DEvnbpBv3XGKDvsLA+
         BV2oPhYF2V4qGvYUmuM+RdRkA6CXQ+dC0G9TgzMBaVoqA0MA6w9WpxYzKDMf6J72EKfn
         YZ9tCnH8ZKqTN77Taqis1IATISC/7zpuYL+g9aaVuI1cu5EagaAi/jIBLm/iM6oWPqP8
         YvEVa55K+Q4/jFBtQEGtFRSs127fA7tDsn6V91iuZcdgaW0LHRGk+t7dBaohl0Jpew43
         8c4g5hPOj/teIWRi35APNpZZPyU6LkwaiLh+WXzEm2q+gJS82jH6KNGjoZ74Lc2VWUmD
         A7yA==
X-Gm-Message-State: AA+aEWZSlpmGnOM4NLN2SdnA9oCy/9I9DsiZfjgAFDrKecEnXFqudC5z
        76KsvmGyVzquY/FcM0HAJelnNNfAqdpc/g==
X-Google-Smtp-Source: AFSGD/XTZeSKdeoq0YmMSuXnnql/o3ffi05htmGMUlxqlQtoTwQHR/KSbbpq/gGETftC38ZghVQ+Kw==
X-Received: by 2002:a5d:9913:: with SMTP id x19mr7748823iol.99.1544723827625;
        Thu, 13 Dec 2018 09:57:07 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:57:06 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 09/26] aio: only use blk plugs for > 2 depth submissions
Date:   Thu, 13 Dec 2018 10:56:28 -0700
Message-Id: <20181213175645.22181-10-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Plugging is meant to optimize submission of a string of IOs, if we don't
have more than 2 being submitted, don't bother setting up a plug.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 18 ++++++++++++++----
 1 file changed, 14 insertions(+), 4 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 522c04864d82..ed6c3914477a 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -69,6 +69,12 @@ struct aio_ring {
 	struct io_event		io_events[0];
 }; /* 128 bytes + ring size */
 
+/*
+ * Plugging is meant to work with larger batches of IOs. If we don't
+ * have more than the below, then don't bother setting up a plug.
+ */
+#define AIO_PLUG_THRESHOLD	2
+
 #define AIO_RING_PAGES	8
 
 struct kioctx_table {
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

