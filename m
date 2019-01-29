Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01F86C169C4
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C935420989
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="nDwHkkX3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729282AbfA2T1g (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:27:36 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:50813 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbfA2T1g (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 14:27:36 -0500
Received: by mail-it1-f196.google.com with SMTP id z7so6449760iti.0
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 11:27:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=frLBRiOju0LOdg0T3UhLSLpfaK/ko5ZXXY+JIT4DKJ4=;
        b=nDwHkkX35CjRSPlj9ouYS4MWwJe/1e0jQXU9lkwPjUx1HrGCYE2O2LS2jFw/l9tldk
         sRUGtxiQf2DzRAomJcsVhTGpq5ByGwrei4tYvK4ySVmfjpTJTlqdnW5C5RUws+PrUwWU
         gnt3xZ/AmplgdjnBbdeTCkhPEwa66bNqlFw4gavFtiQgTxE+Lxzd6Dyx0sRZgUKzqUdj
         J0DGF1x/1F8liZ4L0cbecFubr3U+qjspK5L0Z7BJXXUSUi4oePgz9KhWOdPX5pP0N2b7
         tC4mqBMJ+6Mg5fSxJZCUHkhdGwDg//Yngjzx+zlRg8t60czwlAJubXlG0TgAi5fZhK5b
         sH3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=frLBRiOju0LOdg0T3UhLSLpfaK/ko5ZXXY+JIT4DKJ4=;
        b=cp3Dx1nBUBoZcjEgcgwsFYd8NRP5ry6t7YpTJ3/ZP9gqWjIMc16qucf71/fIkaRp++
         cI2gb7iiV6DLn1otA7rAF4lVCsRhC4+HR41i96oWYYzWKqBQKKqUFFQ/jm8iM0COKE0H
         0Y7nHN7W8PTu+BB7mgSl4T012/GlYG8KHp0ef/cDYZGqoE0uaRW+gCtAVf5TTaQy6+Tk
         m5Vy2VLEfEDhn7cn/WRtKRvoH74+6oLhZWBYZ3f10LrTLdc4+RuMouS8Pj6tKeVHxISW
         4gn98VWMvsT8D6xRR6nU09FPw+az5vDayDb2DAreXfoi7qlne88SLW1mj117Ob+vDtZ+
         p32A==
X-Gm-Message-State: AJcUukdafWCWjzQUEmB1XfFvWVfpcFSIQuaVd6EF/l4aGQsNlu95bhjp
        4ILY+1cO48JVYnNEdZnt2pU92w==
X-Google-Smtp-Source: ALg8bN4N/apQ7RXzWBwMkFRjRB/dXHyCgCm2bX0I5z4NvoysPnr7e7FltpnvzhZt0Bnq2qMEyCAnTQ==
X-Received: by 2002:a24:7687:: with SMTP id z129mr14448256itb.29.1548790055152;
        Tue, 29 Jan 2019 11:27:35 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y3sm15223203iol.55.2019.01.29.11.27.33
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 11:27:34 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/18] io_uring: add io_kiocb ref count
Date:   Tue, 29 Jan 2019 12:26:59 -0700
Message-Id: <20190129192702.3605-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190129192702.3605-1-axboe@kernel.dk>
References: <20190129192702.3605-1-axboe@kernel.dk>
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
index 328fb35b4df7..bb215fe494f7 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -145,6 +145,7 @@ struct io_kiocb {
 	struct io_ring_ctx	*ctx;
 	struct list_head	list;
 	unsigned int		flags;
+	refcount_t		refs;
 #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_FIXED_FILE	4	/* ctx owns file */
@@ -318,6 +319,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 
 	req->ctx = ctx;
 	req->flags = 0;
+	refcount_set(&req->refs, 0);
 	return req;
 out:
 	io_ring_drop_ctx_refs(ctx, 1);
@@ -335,8 +337,10 @@ static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
 
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

