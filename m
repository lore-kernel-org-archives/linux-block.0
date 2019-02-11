Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F000C282D7
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:01:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0098F20863
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:01:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="C84gSm0r"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387473AbfBKTB0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:01:26 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:53414 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1733289AbfBKTB0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 14:01:26 -0500
Received: by mail-it1-f196.google.com with SMTP id g85so883278ita.3
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 11:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Q8VhM/to/dzC4LkTSiVPV4UGBDV+ReSxEMSKO3PuRJ8=;
        b=C84gSm0rqjMc4waInNUluvmDHqiqqP+cjSKkajFJGoKTGmqN2WqDX/sX/48lbOmwni
         DUC07OBg60eowKk7WXG2AjK7fMaJvDOeiiigGfr68PzkKClGCEFFMZBndnKgHMbttPmn
         sss8k7/01EQBAOHMzvCJ/QwMnuBUv+Erfb/CdPRqah5WhbHENKHMsxWheQz2BWSeZMZA
         18KKlTXk0Nxv/UMJkM9SXYp+nHQAY5YRF2yNNDak7u2SWNbScyApB1f+H6A7JDmoTFq6
         K6jKlcKsDLYDgAWCBSf3m4LjCl1ewFylHxKw9wDajk4prmsYEYNthauDTbzsY2KUZ9Z/
         I87A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Q8VhM/to/dzC4LkTSiVPV4UGBDV+ReSxEMSKO3PuRJ8=;
        b=Mwu16wvj9y8d/ApIHKHD34rEUpWOeX/IzFxPYjeWRR9J65CMhL5paZ/wdtPNyNp/Ox
         qqtLaBPEwR9/GN+VqYNuI/vtxXUgnychkk9Ugp6YPvjOIMYMclTMusn0cG0ENT5RoL6w
         wJaancFIPww4uTBhDPyNFCcEpKF5rtZO5Q1gdkOq8VG0V2qMkFPcPeb5397AubH5TkHd
         U+C9yvwL7ZA1CE9alUp3NjCgv8FAUs9JyK8NIXgR/WxNlWbRThEO7zIcxTLgQhDZhum/
         u0ktJsBd5yJtm4xBBdnNWJu8OCUmHgJEgxbQk8jbDv2RnT2m4PI4rrAK60yMBOIBt/7M
         GlhA==
X-Gm-Message-State: AHQUAuasENCXgPEKHphoLg7KrNHi+BHqQ8EYpq0P15ubmHK4i2+zUvfo
        s2UK6/b/tXOtRG7K32b5jI3YrQ==
X-Google-Smtp-Source: AHgI3IY4E4w3zs5oLhDi547VPCXja2o/P81PRWJwIsJRv9MT4oFuik3Slo+zTKsRIfHIvswvZtJIKA==
X-Received: by 2002:a24:7c58:: with SMTP id a85mr611580itd.9.1549911685165;
        Mon, 11 Feb 2019 11:01:25 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h184sm62446ith.41.2019.02.11.11.01.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:01:24 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/19] io_uring: add io_kiocb ref count
Date:   Mon, 11 Feb 2019 12:00:46 -0700
Message-Id: <20190211190049.7888-18-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211190049.7888-1-axboe@kernel.dk>
References: <20190211190049.7888-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

We'll use this for the POLL implementation. Regular requests will
NOT be using references, so initialize it to 0. Any real use of
the io_kiocb ref will initialize it to at least 2.

Reviewed-by: Hannes Reinecke <hare@suse.com>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 24c280076e81..33b6c6167595 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -184,6 +184,7 @@ struct io_kiocb {
 	struct io_ring_ctx	*ctx;
 	struct list_head	list;
 	unsigned int		flags;
+	refcount_t		refs;
 #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_FIXED_FILE	4	/* ctx owns file */
@@ -377,6 +378,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 
 	req->ctx = ctx;
 	req->flags = 0;
+	refcount_set(&req->refs, 0);
 	return req;
 out:
 	io_ring_drop_ctx_refs(ctx, 1);
@@ -394,8 +396,10 @@ static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
 
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

