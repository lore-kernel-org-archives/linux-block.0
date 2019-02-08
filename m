Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 897BDC282CB
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 59B5B218D4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:35:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TMgJCzez"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727970AbfBHRfI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:35:08 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:55181 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727944AbfBHRfG (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 12:35:06 -0500
Received: by mail-it1-f195.google.com with SMTP id i145so10657806ita.4
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 09:35:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=8zkyREBIrKQ0HvbZ1wj0qlZpaBpErgZ9IGppgDbR9QY=;
        b=TMgJCzez4idSxsrC8s5C4LEXrJ9jsC4a4q/C/MS9EPg46Ynua1ToGQqzL9iO7zA5Aa
         noUFGdrV0MOCn65jDGDwHp9lP+kDRWbGFNQMjI0OnIirJsS5h05gkU+nvwl4iz5u704A
         f69v9+qqFRYnn544sdcq14JwGT+b8pJHdaW5S4YCjEKfB1m+dBe5Kr3BlL0L0460kN5j
         FRjuPORQNaJQ3ge+b8LCjuxBPLyrzSSRHmXhX+9orTDc4smIC3lUJPlgvM6CkVjXA9Ky
         Aj6Z2dLM2Yzt5hjnLC6uctCDX3zJdZIxQcUQt/9LvqWWIY/ZXvL/z5nMcOOQZFnfg1YJ
         2wlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=8zkyREBIrKQ0HvbZ1wj0qlZpaBpErgZ9IGppgDbR9QY=;
        b=lCy6yB9yJ7cME1jN5vviMs0eveMngwslvxXuXbD6nsYcdv0vMvLb2mK56/QzAtcyz4
         lCiLg8+YMO3ZG07O3xoLfy5vgI1bnXTJCF8WFngpD/CU2XCRjIgcLFsCedQmLTw/I1Ck
         y8jqAd7ST7Oh4Rydewght57yzH+p+33eCVQwtC7FpWtmP7YoHWcQiIdvsgxiHjUflIbx
         Pu8S/MHjNOV+elY8dbRn17XilGxGm0/6PxNBVER6HVkHsiM3dYaPO6NKKOu3UOgILynO
         NAc5Jmi/vVRyM7S+z6VZPFq2hKCYSxmcF8plfz7o0AzboK9DLjVJ+jReXgyzT9l4LiQq
         MZsg==
X-Gm-Message-State: AHQUAuaSO6b4Jjq3BKSirzYQMNm1PyiL4hnObvWCWBnJ9sQRZMVEK1XJ
        X+kHefftN1M3pcTRnJ+DEGNCyQ==
X-Google-Smtp-Source: AHgI3Ibe8NUVbMFgNZrDH8sa0QfYhwVnElSiBoALnDeJuorCZe92zmTlZWTuKhRBfomuMBzxLKAaHw==
X-Received: by 2002:a24:4d05:: with SMTP id l5mr9381301itb.147.1549647305683;
        Fri, 08 Feb 2019 09:35:05 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f142sm1522627itc.15.2019.02.08.09.35.03
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:04 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/19] io_uring: add io_kiocb ref count
Date:   Fri,  8 Feb 2019 10:34:20 -0700
Message-Id: <20190208173423.27014-17-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190208173423.27014-1-axboe@kernel.dk>
References: <20190208173423.27014-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We'll use this for the POLL implementation. Regular requests will
NOT be using references, so initialize it to 0. Any real use of
the io_kiocb ref will initialize it to at least 2.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index e6b9cef4665d..9b28f2cd29db 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -163,6 +163,7 @@ struct io_kiocb {
 	struct io_ring_ctx	*ctx;
 	struct list_head	list;
 	unsigned int		flags;
+	refcount_t		refs;
 #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_FIXED_FILE	4	/* ctx owns file */
@@ -349,6 +350,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 
 	req->ctx = ctx;
 	req->flags = 0;
+	refcount_set(&req->refs, 0);
 	return req;
 out:
 	io_ring_drop_ctx_refs(ctx, 1);
@@ -366,8 +368,10 @@ static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
 
 static void io_free_req(struct io_kiocb *req)
 {
-	io_ring_drop_ctx_refs(req->ctx, 1);
-	kmem_cache_free(req_cachep, req);
+	if (!refcount_read(&req->refs) || refcount_dec_and_test(&req->refs)) {
+		io_ring_drop_ctx_refs(req->ctx, 1);
+		kmem_cache_free(req_cachep, req);
+	}
 }
 
 /*
-- 
2.17.1

