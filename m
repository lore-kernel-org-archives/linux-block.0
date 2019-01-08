Return-Path: <SRS0=D8nw=PQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C1A60C43612
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9297B214C6
	for <linux-block@archiver.kernel.org>; Tue,  8 Jan 2019 16:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Zl+G/MTz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbfAHQ5M (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 8 Jan 2019 11:57:12 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:52745 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729179AbfAHQ5M (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 8 Jan 2019 11:57:12 -0500
Received: by mail-it1-f195.google.com with SMTP id g76so7233620itg.2
        for <linux-block@vger.kernel.org>; Tue, 08 Jan 2019 08:57:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=19AVyOAHFZ2ncTN9zzAcs34D6P7c0ZFcpuRI5Xj4k84=;
        b=Zl+G/MTzD699j6ZJuiRixezLast5YMfXBmzS4ax6gR/iAm6dEUQIDFy3VQw48XSJSP
         28k2PTy11Vsl2L1WsuV7CckBHVcqBCbadWdaHOQu56SWCNbDMTtFwA3JbFh5t3XhBT6D
         zWRAlf0gIY1qDy8Ddf0EAyhBcRPbDcGjpTVfPlLE9GoslgOjF3LG+PQD9Js4T7vXF6/X
         7iqdnUeaYD7cOA54Xz6X8p6oCQGMe9b9RpfY+wNNh5flvn7ilg1RmDC8AUJ4sTMSEamd
         fZlDhAK8JgEZMJw3fbvSL3LGDcL1t03blo8pDmnS5rwswvKDlRGUj1NlRqsYe9ctlxj7
         lKgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=19AVyOAHFZ2ncTN9zzAcs34D6P7c0ZFcpuRI5Xj4k84=;
        b=Bq/gpdp5oW0jeXP5DADfnMmW0s+Z6nG14o7p8OO//fwkZHB4KfD3Wa17wqnIRFjDsX
         7BcBDTNWMZpfVQHsvBxBTZjV6HeIXZAn8jc1NEmiTtxZaVHiJ6AN/dKxkgRnVcp4kQIY
         uqzdM0uPoaVthtY0UmOvCwO0pC2Eq4+5OG5licA561wJgjFQaS6hDi2i8PgE+PLAUBM+
         U+20eGfPYyNh/lLfPp9n7EM9w3/L75xQMbUd9X3ECXJQ0BJOnbn49cRLTl/MI+JkKZzv
         tMJBQ2/96rdL3Sn3p6WM+LA4r7+6KeCgS665mTuohWcn0EK6TPO84ahKbsPMIfaHK/9H
         EUOg==
X-Gm-Message-State: AJcUukeKZiLzbObtPw7zbWolrAti7kKViyZKeB8SU6MeL9b7QtdDBA8h
        4FfFmd925ogtykU+JxivT/US7g==
X-Google-Smtp-Source: ALg8bN5pKFwQZeZUKxcRgpnwI886d90jk2HOKrvCtq1xJrWHiXjOpgTtmzYuxIbKmpRqN8aI2dJVoQ==
X-Received: by 2002:a24:6fc4:: with SMTP id x187mr2037882itb.93.1546966631268;
        Tue, 08 Jan 2019 08:57:11 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m10sm17563442ioq.25.2019.01.08.08.57.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 08 Jan 2019 08:57:10 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/16] io_uring: split kiocb init from allocation
Date:   Tue,  8 Jan 2019 09:56:39 -0700
Message-Id: <20190108165645.19311-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190108165645.19311-1-axboe@kernel.dk>
References: <20190108165645.19311-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation from having pre-allocated requests, that we then just
need to initialize before use.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index afbaebb63012..11d045f0f799 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -202,6 +202,14 @@ static struct io_uring_event *io_peek_cqring(struct io_ring_ctx *ctx)
 	return &ring->events[tail & ctx->cq_ring.ring_mask];
 }
 
+static void io_req_init(struct io_ring_ctx *ctx, struct io_kiocb *req)
+{
+	percpu_ref_get(&ctx->refs);
+	req->ki_ctx = ctx;
+	INIT_LIST_HEAD(&req->ki_list);
+	req->ki_flags = 0;
+}
+
 static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
 {
 	struct io_kiocb *req;
@@ -210,10 +218,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx)
 	if (!req)
 		return NULL;
 
-	percpu_ref_get(&ctx->refs);
-	req->ki_ctx = ctx;
-	INIT_LIST_HEAD(&req->ki_list);
-	req->ki_flags = 0;
+	io_req_init(ctx, req);
 	return req;
 }
 
-- 
2.17.1

