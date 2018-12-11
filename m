Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0CD6C04EB8
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 86EA72086D
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mobL/sgX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 86EA72086D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729164AbeLKAQO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:14 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45380 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729177AbeLKAQO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:14 -0500
Received: by mail-pl1-f193.google.com with SMTP id a14so6020425plm.12
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j8zbGImEaiI6fzdEzobInCNQIlTJ46kLaRSNEoXmu1s=;
        b=mobL/sgXqqCnQNBG8A1SuXTWeUbV+ofMZxhvx1FLlC6QcW+sMYvEsGzjJeNt37/GVf
         bu3aUbbIo8k77wc2T6b2vYP1CXwmc/ZIBdjYtMnUDxlhrJPiaRP9EQzoy0HRWK49PRCX
         vurIwT/wnro9DlFiegGdET84bJdCCK5mLT0XHfKmOmFGqNRsW8De75iV8C47EJYlFQQl
         CmztOL59uQd3rXGQMt+7RxwD04pXTWE2VdIR1ZymjNjdc8w6A4eIn7MAlWPxbLB1+z44
         XtQT60+rUYNjzr5ihIeRfmEmT52cvW/a6Oj7iSN+bCN75AS1ufHGhYEoY1+xeOUDVhrN
         0s8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j8zbGImEaiI6fzdEzobInCNQIlTJ46kLaRSNEoXmu1s=;
        b=bZPfWiRtmcRw+4+dBVM4GrY98qxI+pbahntZxaTdULYPuh+/Qzj4RNzjSLLobz6P8U
         woPiOMc7BvXLhPoOchSHf/7v7tzBET9siY7jAurDchWyViwKuBKEqqiNlRioYzYXj/Fe
         3xRbt/ixIKhRu7w0+FWvq66XMpAj0QCMxVg19Js9J0eluNajjBqLRFDy6F6uV8UQp6tt
         Xyt0C7UN7vaZ6RgE95MvU2Sf8Sh32mxBYqoNlDxDx5+C/xhJhi6pWg0JRREcI8xEomMc
         WR0AlimJzxKAQHkkyvIpdFhAIXQRaTEFsChW5Nc1Og/eIQJ4xOb7Lemw7nP0QgSbb8NE
         D9hw==
X-Gm-Message-State: AA+aEWb1HRxLd65EOrk+5QirptWDuPA0hfpUOJ1D3RpFVE5ZDlYWk0Gz
        86Q/FdZ32hzf8uRFskQFgAeqiBpwFOFa6Q==
X-Google-Smtp-Source: AFSGD/Uhx09gfBxAVsQBf/gfo9USeD/Xs5h/cTDX9ehOEsncld6HdPpMRU54NvEOb4MRhJ46Meq4OA==
X-Received: by 2002:a17:902:a83:: with SMTP id 3mr13132906plp.276.1544487373090;
        Mon, 10 Dec 2018 16:16:13 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.11
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/27] aio: don't zero entire aio_kiocb aio_get_req()
Date:   Mon, 10 Dec 2018 17:15:30 -0700
Message-Id: <20181211001549.30085-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It's 192 bytes, fairly substantial. Most items don't need to be cleared,
especially not upfront. Clear the ones we do need to clear, and leave
the other ones for setup when the iocb is prepared and submitted.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index eaceb40e6cf5..522c04864d82 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1009,14 +1009,15 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 {
 	struct aio_kiocb *req;
 
-	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL|__GFP_ZERO);
+	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
 	if (unlikely(!req))
 		return NULL;
 
 	percpu_ref_get(&ctx->reqs);
+	req->ki_ctx = ctx;
 	INIT_LIST_HEAD(&req->ki_list);
 	refcount_set(&req->ki_refcnt, 0);
-	req->ki_ctx = ctx;
+	req->ki_eventfd = NULL;
 	return req;
 }
 
@@ -1730,6 +1731,10 @@ static ssize_t aio_poll(struct aio_kiocb *aiocb, struct iocb *iocb)
 	if (unlikely(!req->file))
 		return -EBADF;
 
+	req->head = NULL;
+	req->woken = false;
+	req->cancelled = false;
+
 	apt.pt._qproc = aio_poll_queue_proc;
 	apt.pt._key = req->events;
 	apt.iocb = aiocb;
-- 
2.17.1

