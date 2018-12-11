Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE41C04EB8
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 63B452084E
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="FILp/J8+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 63B452084E
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729368AbeLKAQf (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:35 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:42186 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729385AbeLKAQf (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:35 -0500
Received: by mail-pl1-f193.google.com with SMTP id y1so6022804plp.9
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qHDLuoPuT2zJbNlsgPDVv0H8LQBSdMIFml14oahFVS4=;
        b=FILp/J8+QutgOiP2YSsBf52ECS8kvrINIxuFPprXHObFxAMcqvIroJwwUlZDeIVkG+
         Tpbg//zxDEC8PUfzRz5Q1Z9LTYWg/7ud/2ognBD7j393jNhZTe1wLCh94lX5mNyhEFZR
         GbJf8CU6k+4/mUa0dme4wOsy/PdHVltphMYNO1FnSWH6wpBdFExyM4qD4h7KhZmoA1or
         c/jq5jCwecaiDuV/CC9sx5KsT6bybyQhOssrQZ7l/IIvqL9O5WJnY3Br368xcN+gloUO
         VVtYqINMI/ptUdSWZxmwY9cUl+gdS5VCkh0Hux27igN1ow7CXYvUiRUX774u0GEJx1bE
         HmmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qHDLuoPuT2zJbNlsgPDVv0H8LQBSdMIFml14oahFVS4=;
        b=kOjaXgM8+vXaz41FPE0Gd/zuFEGO/3sbabWsWl/gdSIM5TZx4pw/SuSVi0upark+OD
         hLY8ov7moZRC2sJmRq7w5++vJxdl7Uwkp64iFpyom4siDzzxPRqwe5zgLMf1UtgrAoPT
         e5ayHS4I+xmAjxzPIXo1P+NHfsK/ZaZK/Nf92RxWz93wC65Xn+uuHuBfWS02q50EwPAf
         +bgqtbr50rxCxRaimElgfdsUot8Z1d1cRrQGgQmg+ja/auagfUv2qztOxOSjpoi4sDAJ
         qlXA1ebpOf0895yl0spEcQltSnTXqsk7D6VYkIKe1D4D5499Bp/FSy7N5MXO734tKpM/
         SC8w==
X-Gm-Message-State: AA+aEWYJP4LYDu2BxML2y2zKPWlGE4+Qk2nI7OMyK+Bc28Az1drztZNQ
        3EyFGMB7seTcCdjWkywN06m44fhMFJ9gNA==
X-Google-Smtp-Source: AFSGD/X4LwREfRiY5kWKwdQO1+oFl8jkakjrN6XDV6UWcqVRy3rct/R8YXaJrY03Y6n1Yqu33DrqKg==
X-Received: by 2002:a17:902:503:: with SMTP id 3mr14193312plf.233.1544487394350;
        Mon, 10 Dec 2018 16:16:34 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.32
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:33 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 19/27] aio: split iocb init from allocation
Date:   Mon, 10 Dec 2018 17:15:41 -0700
Message-Id: <20181211001549.30085-20-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In preparation from having pre-allocated requests, that we then just
need to initialize before use.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 17 +++++++++++------
 1 file changed, 11 insertions(+), 6 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index 6cbfe9905637..e9dbaedda7ae 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1099,6 +1099,16 @@ static bool get_reqs_available(struct kioctx *ctx)
 	return __get_reqs_available(ctx);
 }
 
+static void aio_iocb_init(struct kioctx *ctx, struct aio_kiocb *req)
+{
+	percpu_ref_get(&ctx->reqs);
+	req->ki_ctx = ctx;
+	INIT_LIST_HEAD(&req->ki_list);
+	req->ki_flags = 0;
+	refcount_set(&req->ki_refcnt, 0);
+	req->ki_eventfd = NULL;
+}
+
 /* aio_get_req
  *	Allocate a slot for an aio request.
  * Returns NULL if no requests are free.
@@ -1111,12 +1121,7 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 	if (unlikely(!req))
 		return NULL;
 
-	percpu_ref_get(&ctx->reqs);
-	req->ki_ctx = ctx;
-	INIT_LIST_HEAD(&req->ki_list);
-	req->ki_flags = 0;
-	refcount_set(&req->ki_refcnt, 0);
-	req->ki_eventfd = NULL;
+	aio_iocb_init(ctx, req);
 	return req;
 }
 
-- 
2.17.1

