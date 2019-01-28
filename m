Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB188C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:36:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 854AC2177E
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:36:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ytrEhMjn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728357AbfA1VgM (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:36:12 -0500
Received: from mail-it1-f194.google.com ([209.85.166.194]:52441 "EHLO
        mail-it1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728332AbfA1VgL (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 16:36:11 -0500
Received: by mail-it1-f194.google.com with SMTP id d11so935961itf.2
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 13:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=SyN4FVJHSbniTFclb7EwO9EKb7bx5qQceMJrgjYtwI4=;
        b=ytrEhMjnedgUQ4r39gRu8mcnn1yXOTAl691b0XYjHcf+0GPtd2pqysYYa6wQW/Bojl
         q2dOPRfkMLEFK539mHpmB/lPglgXSkedo5vCV3sMaOchGJa3Hkm4WcB9IDxCcLnaXq8X
         j38INjLmLBR11JhIlFRZxwHTVSxPWcD8zVuzbEP34oWyF+MTwOMHIo9SJtfW+nlpOne5
         JVsJT95AfQcqeCNdFXiSZq/R8D+vytGDmN+yyh9f2cubUmkAx4PkkeLZMpCCZh2d4Brj
         L2mbMajHSBtcs9LH9zFuyxdB6jzpFj33g+PL/SmmpDEX4P4NN5oLCwQloz9ktU1Sp64t
         ixNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=SyN4FVJHSbniTFclb7EwO9EKb7bx5qQceMJrgjYtwI4=;
        b=IaIjH4J1RXU9Bmy9s6ZSWyCYu3tjilqs+V6ITHq8Sd44GZmRDINtQI+bKyR2uDb6Fa
         L9M95E9+lBiQqeyuTATDfmEGP8Z6/MN9n4ZiEA/beQcTdbhypeIp7eE0SmzXf4F/j91y
         wrOqiK6GVK2O4+HcxjHCdqXWTDj7uVi8RU3fKm9e6JuzW/MeTzoKz2jGi2/u9oFsgxsY
         tYs0eV+Jdt0BWq//EDMUpx1EJLkO0nQ3iKBScOM40YOsdaqZ54E1FVWQHONDTMREN6e7
         gXZEM3k7S1JYj/hw3qBrFfOQYEcsgdXQ0Go8Rl0754x1tFW4RC+Kf4HH947aZzNJUgFs
         997g==
X-Gm-Message-State: AJcUukcfzfh8PmzcyB0i8vQ8NdQVI/vzxHfUfZm/+yJv3BvOQzaOyyvW
        3X4WIks3ji3ul2kF3vaLmNRkoA==
X-Google-Smtp-Source: ALg8bN6gslaE0Bixl/KsFJ1/Eq/MD6/fgjyIeYnXhE/sieU9Zh9rsLuloGkg6WH6vKl9fcc+5mYmxg==
X-Received: by 2002:a24:c8d7:: with SMTP id w206mr11765338itf.56.1548711370992;
        Mon, 28 Jan 2019 13:36:10 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u25sm13782077iob.23.2019.01.28.13.36.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:36:09 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/18] io_uring: add io_kiocb ref count
Date:   Mon, 28 Jan 2019 14:35:35 -0700
Message-Id: <20190128213538.13486-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128213538.13486-1-axboe@kernel.dk>
References: <20190128213538.13486-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We'll use this for the POLL implementation. Regular requests will
NOT be using references, so initialize it to 0. Any real use of
the io_kiocb ref will initialize it to at least 2.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 34e786eb2e2d..71bf890e25f2 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -139,6 +139,7 @@ struct io_kiocb {
 	struct io_ring_ctx	*ctx;
 	struct list_head	list;
 	unsigned int		flags;
+	refcount_t		refs;
 #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_IOPOLL_EAGAIN	4	/* submission got EAGAIN */
@@ -319,6 +320,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	if (req) {
 		req->ctx = ctx;
 		req->flags = 0;
+		refcount_set(&req->refs, 0);
 		return req;
 	}
 
@@ -338,8 +340,10 @@ static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
 
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

