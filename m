Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFA22C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:13:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7FE022086D
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:13:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Vpd+bVRI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728100AbfARQNI (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:13:08 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:44116 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728078AbfARQNI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 11:13:08 -0500
Received: by mail-pf1-f193.google.com with SMTP id u6so6805015pfh.11
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 08:13:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DTlkF97vGefqpS0bMWv746R15dMGRBYhpLm7YzqPk8E=;
        b=Vpd+bVRIeZu+98XKdNR5oAaJQdU3jBp1Sxi8qU7IQAPY7TIokkpLgrKpmwc3uy6iH1
         x0Jp9e4lWBwqXdfCf7jN5xUAsGyrun3Gq22lre5vaDMoZJArjgAumCFZFsqGyfwSb07g
         4ka/VZsFLjPMC1D7gLtbOwUdQTCFmGUs5Zle63XTJz4VIKJOUmL1QLBB34B3+APp4L2+
         yvwx+4WJvK3Wm+vrk/vExHJmxauzzv+RJ26U/7jIWMCqgH/fR6kFRMDOT3/bUTC0eSZv
         l4vL6W4VtqjhBSM3clzku2i3Z/5K1aDnMdZWSpvRtCKcfHQckH38Qt/7Do3PAvxpIdg9
         issA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DTlkF97vGefqpS0bMWv746R15dMGRBYhpLm7YzqPk8E=;
        b=VyZXf7HFgp7MFdGJRzCU7AQQLNeZbK+zXSjA2nR4SvwUGpGNJKfczC4E+ga276oGlZ
         8gmIMSD5D+OMupVfNM/uGL2j8a2lZXbwgxjl5dO01QQFeVqqAqbK7k9otKU2eD3hboZ6
         aE3SlOpkGWf2rw1u+QKn+1xc5wRKp0QsdvouTkvisz1zfPd+HkqEdeHUQchXVKiffD1Q
         wOouMapnxxok9VOJsPXIcJEssFPNmzgyYMjYBsVV/gbmWN3pZNq8pD28+1V3uDKG9Ssq
         S9IqT+S1l9owSxvyj/uvrFnJVjQbyemi0FOGp0JgQmgCernVnv4MQsxXnz+LnGGLkIkI
         k8eQ==
X-Gm-Message-State: AJcUukc7nX2XRdCf048vT6wMpLRXaEi9kSAyfdi1ycmHt/e0VeIbRa9k
        Kp5yS/yCpLufwhM9Z3OPIOSF6A==
X-Google-Smtp-Source: ALg8bN51A4DrcA9djqPZFWlvZUqpGWUCbey9g5sJ1DeJWqt4np/zgv/BqeGZ92uOU3ipTg3fYR2zXw==
X-Received: by 2002:a63:5ec6:: with SMTP id s189mr17528226pgb.357.1547827987643;
        Fri, 18 Jan 2019 08:13:07 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m20sm5317804pgv.93.2019.01.18.08.13.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:13:06 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/17] io_uring: add io_kiocb ref count
Date:   Fri, 18 Jan 2019 09:12:23 -0700
Message-Id: <20190118161225.4545-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190118161225.4545-1-axboe@kernel.dk>
References: <20190118161225.4545-1-axboe@kernel.dk>
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
index cdd9873edfe3..4f13b3371156 100644
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

