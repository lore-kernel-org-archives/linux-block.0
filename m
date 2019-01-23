Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5815EC282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:36:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 272D72184C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="U1wUTZwa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726256AbfAWPgI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:36:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:38216 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726144AbfAWPgH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 10:36:07 -0500
Received: by mail-pf1-f193.google.com with SMTP id q1so1352567pfi.5
        for <linux-block@vger.kernel.org>; Wed, 23 Jan 2019 07:36:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xuCT6eBYZtmluqgZSIP7z54GOK7JK42Z5rDnSlWKERE=;
        b=U1wUTZwaRtIZRdk1VT/3tLjLiqjg26G0o06pj1r/SNMSfiY9V9ovzFoLsaTXdtLgTz
         Z0/31oCbEQEDa/dMwz284qrVsqVAO5LAA0zeqTbKZPx1PlhGPGQTG04+HBOct0DOCmfr
         wp65FH5upJ8ZkbdUsJBrPjDtiSjr0LCTlxnwEV3QfxF2uoVwPR981VHPKo9RWjOsKoMs
         xP/Q4fc4LAQK3EbvYvdaB3zcXm3pQ1Ir19gnsgsOpV40mAn4gMldxsJRtwtNKxyzaFOI
         pYJH96AeCVqBTJJapboFRi6emyyyvKd4Pb8xPonFjWbPMezlOxsmvHcY3HEZ3Q0GDn1E
         bx4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xuCT6eBYZtmluqgZSIP7z54GOK7JK42Z5rDnSlWKERE=;
        b=FglXuxaTcott+GFBBUDyRuyb36kzURVcp+KOtcDkwRQ6Ct0tEceyPwMwF9XvuhpXsI
         P8D6I7DA4RKsTfjjAu5YywBcbcl3dlkfGQefYPUe7XGNxKGHBmtiT4KRkEzFFm+YcdYg
         aS/eW7/pMHapkSz86vYgtfIx1ds2niKsTkijpBxwFFOqV4Mbn49RdScusanlhm6qUYH7
         ZpyTDLpPKCw8J7QggdKdbW0LItvA2ZRomhDty1FBmgFUjsjfmtyHIw5SwvWXJF5hZe4k
         WNxnhZCEbWuxh8fhE8sYk9L6Fec1/yI6mppCUxp4icu9car+8VGr+zh2e6qVp8gXpJ1p
         XfTQ==
X-Gm-Message-State: AJcUukc8L6P6ykO+hUxDU0Qmg24L+nnmypxWWl685gNF/b1GW39xnUrW
        oZRgisB1SPLpGc8ZyEJ7BG2meJzWP5QYTg==
X-Google-Smtp-Source: ALg8bN6ZdDm1+KmWjKh0xgKk90lub9Ij7IrqpVaZOBkEMG2qJj4Fc04oWpoaI5lxqFb28GCsVMUOmQ==
X-Received: by 2002:a63:e247:: with SMTP id y7mr2265364pgj.84.1548257767152;
        Wed, 23 Jan 2019 07:36:07 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm30731715pfl.16.2019.01.23.07.36.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 07:36:06 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/13] io_uring: add io_kiocb ref count
Date:   Wed, 23 Jan 2019 08:35:24 -0700
Message-Id: <20190123153536.7081-14-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123153536.7081-1-axboe@kernel.dk>
References: <20190123153536.7081-1-axboe@kernel.dk>
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
index 2deda7b1b3dd..c10653be39c0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -141,6 +141,7 @@ struct io_kiocb {
 	struct io_ring_ctx	*ctx;
 	struct list_head	list;
 	unsigned int		flags;
+	refcount_t		refs;
 #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_IOPOLL_EAGAIN	4	/* submission got EAGAIN */
@@ -322,6 +323,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 	if (req) {
 		req->ctx = ctx;
 		req->flags = 0;
+		refcount_set(&req->refs, 0);
 		return req;
 	}
 
@@ -341,8 +343,10 @@ static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
 
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

