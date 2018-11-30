Return-Path: <SRS0=+5f8=OJ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0765AC64EB4
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BFD8A2145D
	for <linux-block@archiver.kernel.org>; Fri, 30 Nov 2018 16:57:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sq6DFq35"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BFD8A2145D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727203AbeLAEHE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 30 Nov 2018 23:07:04 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:56290 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbeLAEHD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Nov 2018 23:07:03 -0500
Received: by mail-it1-f195.google.com with SMTP id o19so10088451itg.5
        for <linux-block@vger.kernel.org>; Fri, 30 Nov 2018 08:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8/1Nol3a3uaTr8sM9gFlQE0kinP2KU2cED85d/G/25k=;
        b=sq6DFq35bVoDp8yMVd4wxPxeB8WZxYMT8MrxJpIMsjZTcUC+cuzrHaib4c2h+cUWHG
         SPFt6/IM5SlxytyM7VaRwZJGxCVuWiTt+KVUDZ/adXoMwgVp5OERMgsbUDg2T084vID7
         Y3koQryj0o11LyctjsTQhcjhUtC+udH6LMa+T47rVrF7ylZvpS+BgDB0MTNyxUf8hRwE
         UjS5PIpt1+bkk6fWt1vfk2t3CoMcj5+SIQua01wzJW1RvlU6ZGDbAKiF3dtC43BHoEGE
         BVXbxpc7KHuKh0MSsaoLwKPac57p3ojDSW3Kcxyd2OsyDoFB+CYlQfP+WdJ7GT9FyXAV
         paPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8/1Nol3a3uaTr8sM9gFlQE0kinP2KU2cED85d/G/25k=;
        b=cahWSoVOQoCwnI5cQgoe/ni4ec77mfogRbckG/+VE30Aly9eb34gVawZV9Yp0NFcKe
         JhmspdmmkNkjyW7E6P471b6S/UtXMq5TCp45Wk9rFt10sqF9yDVWc4Nx2n173ZfgWhsn
         0qVDFrdnzZHkV8gtOw8CHGJMoBlVsgPOK7DcZMepbVQjJVqMDE/zopZRSKy1u1uVAKNq
         OWua6HvSgXjd6BLYtAiJTN4pBjlVSlt9ZaxhGpL1JABnjeijZQVW1c1bsuZyNr0zgo4Z
         Tf19slAWyEGGt/YmTC7Pa5OQhvb0fHrgxY4oK+fNwvsdJbYqVYZ5M0PrqKjCACeZpsOi
         rQ7A==
X-Gm-Message-State: AA+aEWZDabzd1tnQkBKjkg1dnu/nJY++QZu99Z3w6Ot3UB5crkQqmohO
        N/50ks10LNM8GDni0fi17Pvmh5dMETI=
X-Google-Smtp-Source: AFSGD/UgQEX8ECP7m2g6PGBOyb8hL2FU1DTaFUDFfNacktD29Gyaf8QZxq/WPkzeZurYJbhxzTNmdQ==
X-Received: by 2002:a02:242b:: with SMTP id f43mr5640161jaa.144.1543597027331;
        Fri, 30 Nov 2018 08:57:07 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id j133sm2979447itj.16.2018.11.30.08.57.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Nov 2018 08:57:06 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 11/27] aio: only use blk plugs for > 2 depth submissions
Date:   Fri, 30 Nov 2018 09:56:30 -0700
Message-Id: <20181130165646.27341-12-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181130165646.27341-1-axboe@kernel.dk>
References: <20181130165646.27341-1-axboe@kernel.dk>
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

