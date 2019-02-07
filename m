Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C278C282C4
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9ECD21904
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="LM9YC2+M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727338AbfBGT41 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:56:27 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36079 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfBGT40 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 14:56:26 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so2971331itj.1
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 11:56:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=z7+GZ4iwB5WgeWIzeaDqvBYowst7B51aZXoDPY3tw1Q=;
        b=LM9YC2+MSS6B3vPkkCRZ+oodjoUITfC+Tm30atZkbmJZtI9A7YeCMjrwsgBr2Rvt2O
         wSC5s2Affwx/O3+vH+EofslfUSdLGlUb5Mq0gZTdglFEfRTVFbMiUPWBBsjSn/2Z8e4c
         jPiYNUkZCOcysNtctZ3iuzieMLGRROTGMKsw4rn85/ku6Q3fa0VV2/qLBFyOSUoetXOD
         TzyR89C/sfQ1DEzMHc0ugDtUySQ+mp5z5pBc0+AzZyAG238PBscXrmG8/JZ0eNu+WFxV
         VoyWSN8JJo52+W6ypponMkP9QUAJ+kd/FGlDQ6j6vTLTCzW+Ke2ZZbaH1g32MlavTEvo
         KDWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=z7+GZ4iwB5WgeWIzeaDqvBYowst7B51aZXoDPY3tw1Q=;
        b=N9G/MzLbvs20aZWaL1bbMw8Tu++Ab30oWFB7kV/mW+7AeCuEvdp3G98rol4sZZRgj3
         ysHTEdyEAq61Yy8MRAHe5WHSf2YaGfd332AFZS4McCjVl1kc7Fzh9miSrXKomc80n/9i
         JrgbolKcA7PoyODsXwRQsWYhBDLnb1zymwwQyjdaDasNjMHTyENOOBKNCQMUlS4fkUzu
         0R8Q5lkE04zPs8Esjs9noWlS3d+SRC4Lv3FW4g0Z5/PtwXGFqtLe/j2sKmWlg2dq73wE
         zUQBXPlfuAqkutxW5NfblfMpNyA+45ZUprZe4Syd1U/LK5DT6jW9DBw4Xc954UbRurXF
         SbRg==
X-Gm-Message-State: AHQUAubd6i2ty4ZkLcxZZuXAX7Hjg07VG9Ej1uokMUU4c6cqzsZL5DIY
        tjn0YolIVZPcDTQJSRf/6D+8qoVn619vww==
X-Google-Smtp-Source: AHgI3IZLrhKX8uUVFbm6/FwzvrVXFqToS3FvNhaI8qh0rOmYZAAJP0qeIZ9a6u6AN26TlVFyz/Jsrg==
X-Received: by 2002:a6b:bc83:: with SMTP id m125mr9059505iof.83.1549569385806;
        Thu, 07 Feb 2019 11:56:25 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y26sm5092782iob.16.2019.02.07.11.56.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 11:56:24 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/18] io_uring: add io_kiocb ref count
Date:   Thu,  7 Feb 2019 12:55:49 -0700
Message-Id: <20190207195552.22770-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207195552.22770-1-axboe@kernel.dk>
References: <20190207195552.22770-1-axboe@kernel.dk>
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
index 200631cf3955..b54c70f8f8af 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -160,6 +160,7 @@ struct io_kiocb {
 	struct io_ring_ctx	*ctx;
 	struct list_head	list;
 	unsigned int		flags;
+	refcount_t		refs;
 #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_FIXED_FILE	4	/* ctx owns file */
@@ -345,6 +346,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 
 	req->ctx = ctx;
 	req->flags = 0;
+	refcount_set(&req->refs, 0);
 	return req;
 out:
 	io_ring_drop_ctx_refs(ctx, 1);
@@ -362,8 +364,10 @@ static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
 
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

