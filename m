Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CD6BC67839
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3D192087F
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jKc/oV4X"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D3D192087F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729714AbeLMR50 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:26 -0500
Received: from mail-io1-f66.google.com ([209.85.166.66]:37965 "EHLO
        mail-io1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728042AbeLMR50 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:26 -0500
Received: by mail-io1-f66.google.com with SMTP id l14so2317898ioj.5
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:57:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=5UZD3rlbMpzki33VvR6rIT0nzMnP5TNa+2FvOR+SAL8=;
        b=jKc/oV4XKSrA58shJi75dwcx/fPya0GX9L5Bi9IJ8k+NeqzZdKPKkZjO/iiqeeWmLf
         uAxo0ltYr0pR3XNnk4x6FqeOkeNfBQxkPqDouV5oJijky1kye2nVLHFlwMJnv6iLZhuF
         DEWfZscTV3C48bT2H3ZeA/plNPp/tEJa6EMluzu2tAapt4af44xYtmXjsUkP82/jJbwA
         nIWShlLE2icmn7mOJDcAXjrTm7H9qQqCQrQ1ysS4JrvLxCUH+cPDol6EDJLYTJywwlwJ
         EcJ+JrOLG0QDLyrCOFmTrtPopzp/hkbw7OH11fTUMCxcx2frYMXgY0tVwBLg6FoaYNyo
         2ZhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=5UZD3rlbMpzki33VvR6rIT0nzMnP5TNa+2FvOR+SAL8=;
        b=hDtW4grIrd4VAyH7Ujr7P1D9tmAlm1/bOksxya5U34Y0/gKZPzWFOVGZN0FBKFdtIz
         E2iex6y2l8+6ES36mW9/a6MGpmoBcVKcKkcKMsM0IflbU07MqyyvfyY6Sdqbgeh8Lra9
         c+W3TrezT/IJ5fN2srXp7VRoLNbTkLaNLA7w7oTuJvEer0ikd+PqCB+EwMbiCdlvvA7z
         eBuWPco4PyQzibgbCy2JEGTZal+gYwZio41pH7RMmtXbSC+ZJev9jdrEMIi2JsdZRMEA
         IknfxbkbUhK+RO+J5riEB0IHE5G1s2C6miHdoZjTcd/g48KzK4bem8SPz8ZMiU3t70zs
         gtlg==
X-Gm-Message-State: AA+aEWapFQrCn15QiVMNHOUEGjdIBum1q+rmqo6Ve5+F5qQKZTbTwtAK
        L+12xnQwplwsdO5ZgE5U8MmB7BNtZ+3mUQ==
X-Google-Smtp-Source: AFSGD/WLqkn3SiBeBIo6dpsmhlUnT/o1tMWjNrpZ5R5yk0PI+8FAbC4pksgJ7/PiBtodLH38WnSpQg==
X-Received: by 2002:a6b:1414:: with SMTP id 20mr20910546iou.140.1544723844865;
        Thu, 13 Dec 2018 09:57:24 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.57.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:57:23 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 18/26] aio: split iocb init from allocation
Date:   Thu, 13 Dec 2018 10:56:37 -0700
Message-Id: <20181213175645.22181-19-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation from having pre-allocated requests, that we then just
need to initialize before use.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 29336c6e8b40..b6dfc4e9af47 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1097,6 +1097,16 @@ static bool get_reqs_available(struct kioctx *ctx)
 	return __get_reqs_available(ctx);
 }
 
+static void aio_iocb_init(struct kioctx *ctx, struct aio_kiocb *req)
+{
+	percpu_ref_get(&ctx->reqs);
+	req->ki_ctx = ctx;
+	INIT_LIST_HEAD(&req->ki_list);
+	req->ki_flags = 0;
+	refcount_set(&req->ki_refcnt, 0);
+	req->ki_eventfd = NULL;
+}
+
 /* aio_get_req
  *	Allocate a slot for an aio request.
  * Returns NULL if no requests are free.
@@ -1109,12 +1119,7 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 	if (unlikely(!req))
 		return NULL;
 
-	percpu_ref_get(&ctx->reqs);
-	req->ki_ctx = ctx;
-	INIT_LIST_HEAD(&req->ki_list);
-	req->ki_flags = 0;
-	refcount_set(&req->ki_refcnt, 0);
-	req->ki_eventfd = NULL;
+	aio_iocb_init(ctx, req);
 	return req;
 }
 
-- 
2.17.1

