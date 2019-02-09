Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8047C282C4
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:14:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A780D21934
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:14:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="xejsy1hG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbfBIVOZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 16:14:25 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40428 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727123AbfBIVOY (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Feb 2019 16:14:24 -0500
Received: by mail-pf1-f196.google.com with SMTP id h1so515645pfo.7
        for <linux-block@vger.kernel.org>; Sat, 09 Feb 2019 13:14:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QI6By8wA+81DOgTbJ9bfEfiV+Q9Uf/NGeZ9aKzg06YA=;
        b=xejsy1hGYNR8/13wrAnMzrxXx8kbXRHDOBBd5cxKmja4kojInxGyM1p6pBYHaGdCyP
         fp+jniWUYiNvbgUhKYwDkOJ6ei57m5TE49okR5YV7mErg8RlbZiQBBkrQgImq8vTfFuO
         ubV5tvghsxctC3zPlAAs+LxCVQmBnDBiGhfNxvshZ0iR2teq0DCAH9XKOFErKT9VL8SS
         RgXsQ9xfOEVrfCmpZfT6Bo2DomQ4uL0PRox2Tu8sk4g6t4Vd4C9jAL133RkbQDB3k6eH
         ISRhJYRuY5ekHQjOTh04CZ0g4Hi0e64HsymDwGl0KFbVKlr4YS4bL0qjasCBvNeJ1PLq
         MMlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QI6By8wA+81DOgTbJ9bfEfiV+Q9Uf/NGeZ9aKzg06YA=;
        b=iKOA4TQiL099Uo7tbO9+SW88xbBWBgQZuPUlWulokh8MJG7eeqwnNCrmskYFM++ahJ
         O8XB0Nzos0KGt/4uuwQ9/F5AffQmo8EvAyFbTMfO6xxG22dD5mmEmOez8e+jYoik6hWh
         EuzAkPBq2aUYzG34l/unlkR31SCqC75EVswkyNgzDA1GXmgNCD7qdzCzEKvhC27z9vqT
         nYvgxmmfvSeMwzxXpSr5CGjhZ5wuLp6q31Bux5HgvPM5C4esQr34wpkFjcxMHi7RObax
         qylRKoolPSHgHBsxd9N7c975yS/te0vQL/OJ+3aHg5muLfB2o/JCRR1J7NyL9Ro2lpto
         hNcA==
X-Gm-Message-State: AHQUAua1zXqxGsn4yvtlb4OjwScWNeBgdwPAX9LJWJLg4GVnyrhAn+7g
        i++iV0wjNEtPw2f/lc58THJICw==
X-Google-Smtp-Source: AHgI3IbnEok1tUpbo8JF4Mj4Jjwoe0ylJIg4IbvIFSin6IO6yxvP2101MUrhQIDSGQuveEy1yexI+Q==
X-Received: by 2002:a63:65c7:: with SMTP id z190mr22251181pgb.249.1549746863829;
        Sat, 09 Feb 2019 13:14:23 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a17sm7004942pgm.26.2019.02.09.13.14.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 13:14:22 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/19] io_uring: add io_kiocb ref count
Date:   Sat,  9 Feb 2019 14:13:43 -0700
Message-Id: <20190209211346.26060-17-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209211346.26060-1-axboe@kernel.dk>
References: <20190209211346.26060-1-axboe@kernel.dk>
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
index cd7ff2643292..dc5667c53c55 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -164,6 +164,7 @@ struct io_kiocb {
 	struct io_ring_ctx	*ctx;
 	struct list_head	list;
 	unsigned int		flags;
+	refcount_t		refs;
 #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_FIXED_FILE	4	/* ctx owns file */
@@ -353,6 +354,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 
 	req->ctx = ctx;
 	req->flags = 0;
+	refcount_set(&req->refs, 0);
 	return req;
 out:
 	io_ring_drop_ctx_refs(ctx, 1);
@@ -370,8 +372,10 @@ static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
 
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

