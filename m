Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDAA2C282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E166218EA
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="aChFEgfl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729959AbfBAPYu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:24:50 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55950 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729860AbfBAPYt (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 10:24:49 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so9593017ith.5
        for <linux-block@vger.kernel.org>; Fri, 01 Feb 2019 07:24:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=CU9RuQlGNjt6599i3rjRfgOEgyHxaUBCJJkBrgEZ49g=;
        b=aChFEgfl2a13oJo7T9k2d59alEtwGmJTZYQL6RIgEmL/ph1lTQSKYEHW2p0XrnUwsL
         OjsVIl1oNmmo80URJUMv8EL/MmiwUCQi2+5vDwVmLBYPHOV2x3SywYC6EzFw6xnm3MLz
         hQ0nSfB+3fVschi7S3Xh9WD1Ey/gm4ifE89otQdDOr58CSqumBqXoqZdhsDKsJRP1m0F
         zy4D70HuJxwqbE75ahqI52IhSE8pCp+jFduIUf0rPCofyghvolQJO2oDn4aJfRcy7HDd
         +pInZoxZYt/tNcFVa1HxpRNNuMBnWL/yofYHJeUzQ4DZ15YPcey1ZOWUsi1wzvo04dpn
         k1cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=CU9RuQlGNjt6599i3rjRfgOEgyHxaUBCJJkBrgEZ49g=;
        b=jWnoIglCT4QZXUgWFivlExS4h+UWC8ZAvcZZTiAxvyxsEpdTXJfpEOG6+QDeI9esGG
         cEUO5Hwly6rjQVTscDUpqrpPt2VqCphfBE+TIVarDkjrvbCR40TkmSzEqKGZ2CANeFjA
         v4v2xlzZG8WI4rKdOZbFU+nlm/8b50Q8pBszpuOur0ISWaFkBaj5zXjlzb2O8ImCCTOs
         CK26WxvuuuzDeIZq52HLDQEWy+d/kyPZ4DKGXkDGOvbB/7qZCQLGKaR9NRaED6ho1cgF
         selBfw6idhsG4ZnrHt8AvveDB2fu3rXXnPHylCyCQRy5P6OXUYKScOdZpek6Y/TyyNs5
         QxhQ==
X-Gm-Message-State: AHQUAubiLzuT2bvaQC05q0wgQppZ0Z8LqOlqe4fM0tm9iUSQ/GKWfkSb
        uQ41wrGiZHh1Ckd6mlrPJNZ21Q==
X-Google-Smtp-Source: AHgI3IbV5WKPUg7FtnJW4QBTs7pRY3In/s/kBTX2x+MJ2oTqWtp37w5cKJqrSJXm9GzEPU+HZeNjHw==
X-Received: by 2002:a24:ac02:: with SMTP id s2mr1819222ite.94.1549034688440;
        Fri, 01 Feb 2019 07:24:48 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t6sm3388898ioc.87.2019.02.01.07.24.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:24:46 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/18] io_uring: add io_kiocb ref count
Date:   Fri,  1 Feb 2019 08:24:11 -0700
Message-Id: <20190201152414.23296-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201152414.23296-1-axboe@kernel.dk>
References: <20190201152414.23296-1-axboe@kernel.dk>
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
index 8f8cde20bb6c..97ec812b10b3 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -153,6 +153,7 @@ struct io_kiocb {
 	struct io_ring_ctx	*ctx;
 	struct list_head	list;
 	unsigned int		flags;
+	refcount_t		refs;
 #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_FIXED_FILE	4	/* ctx owns file */
@@ -326,6 +327,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 
 	req->ctx = ctx;
 	req->flags = 0;
+	refcount_set(&req->refs, 0);
 	return req;
 out:
 	io_ring_drop_ctx_refs(ctx, 1);
@@ -343,8 +345,10 @@ static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
 
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

