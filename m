Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7E90C282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 23:42:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6FC08218AF
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 23:42:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Edcf9XV6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727100AbfA3Xmp (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:42:45 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:37220 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726531AbfA3Xmo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 18:42:44 -0500
Received: by mail-io1-f65.google.com with SMTP id g8so1112298iok.4
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 15:42:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jqSMw2zGrf0FfK+YoHmxMbtx8Y1qurRdgFaaYcNZRVE=;
        b=Edcf9XV6W4aQFdOIFeawlqO8QeVr9TdtHoGa+niBwyk491qfWfLAQrV/RKsuT3x/dE
         Th5hFVHQAtOW46QPu3qcfnjHvtPnxIMxaHLfd4u6ZhAG4gJmRpvO8olA88HcleEXD85Q
         Y7aSHSKce/W5p0x2IwSRa1GxBnbaJMkWs5KdmoVHWX7a2B7M/5+LRy6Q50y9fDY85zTv
         F0/kK0els3u6siIdNDg/0abOXqgen/VeGIjihtXmfmfEYXXS/XRFv+oJ06EICDtww5zB
         KvGiTSD6ibX39DICD5T+84O22QuRnLKOBF8cfLVonOIsDPPH+vjFypjMWw9dSGhXvpXN
         4LIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jqSMw2zGrf0FfK+YoHmxMbtx8Y1qurRdgFaaYcNZRVE=;
        b=PyjdQ1e3ho7J2GO91ffzPYX8R4irC0czzt15glWF6Jxbe73bwe0pRt5NzF/gxwlsej
         rikzRDSESZJ6Jx5xG/jEsDCOqKu1zfxkUtJOnWPZHoEbf9MtPlW8cgwZ0VMsm6oo6TF4
         CIhV0/zS/DieseYS0qOLlS+bLIiAhRZHt4xVI6HUUnTcQvMPTRZ+dHP8PA2MdcKo93KC
         zq7RlHvsrWJEq6/L4FrfeRLVLov61gjeX9LInCmRd28dGQDF/QazQ6T1VHRQD8DjIjnp
         7/rimEtn4OwWAnceTumSr9OuDTgtx6OQihPIOTGFVy/wFOQ2ds5eg0vRqB8ALbfNO6hM
         Abbw==
X-Gm-Message-State: AHQUAuarq+giqztxN5dfiMTsQW2KWdN3iU4yK8dPWAIYMSiYMv2Ykx1x
        bQwpb4w0eloDcwSgzMRaRhDX6w==
X-Google-Smtp-Source: ALg8bN6FMpTJbElHloazHRVl3Usy1cMBCyNe2PNleSl2jE8DDYNXPfe/GzIiS0yIpyvOgz0pkoXhNQ==
X-Received: by 2002:a5e:de01:: with SMTP id e1mr19237565iok.137.1548885371299;
        Wed, 30 Jan 2019 13:56:11 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 189sm1805081itw.33.2019.01.30.13.56.09
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 13:56:10 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/18] io_uring: add io_kiocb ref count
Date:   Wed, 30 Jan 2019 14:55:37 -0700
Message-Id: <20190130215540.20871-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130215540.20871-1-axboe@kernel.dk>
References: <20190130215540.20871-1-axboe@kernel.dk>
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
index 64087d46a11a..34d895edeedf 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -152,6 +152,7 @@ struct io_kiocb {
 	struct io_ring_ctx	*ctx;
 	struct list_head	list;
 	unsigned int		flags;
+	refcount_t		refs;
 #define REQ_F_FORCE_NONBLOCK	1	/* inline submission attempt */
 #define REQ_F_IOPOLL_COMPLETED	2	/* polled IO has completed */
 #define REQ_F_FIXED_FILE	4	/* ctx owns file */
@@ -325,6 +326,7 @@ static struct io_kiocb *io_get_req(struct io_ring_ctx *ctx,
 
 	req->ctx = ctx;
 	req->flags = 0;
+	refcount_set(&req->refs, 0);
 	return req;
 out:
 	io_ring_drop_ctx_refs(ctx, 1);
@@ -342,8 +344,10 @@ static void io_free_req_many(struct io_ring_ctx *ctx, void **reqs, int *nr)
 
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

