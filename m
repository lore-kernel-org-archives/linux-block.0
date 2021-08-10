Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08E5FC432BE
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 16:37:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3B4D60724
	for <linux-block@archiver.kernel.org>; Tue, 10 Aug 2021 16:37:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236202AbhHJQiE (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 10 Aug 2021 12:38:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236100AbhHJQiA (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 10 Aug 2021 12:38:00 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3385C061798
        for <linux-block@vger.kernel.org>; Tue, 10 Aug 2021 09:37:37 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id cp15-20020a17090afb8fb029017891959dcbso5124005pjb.2
        for <linux-block@vger.kernel.org>; Tue, 10 Aug 2021 09:37:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=EOUkUjkApB+u9s/YlxR3KEiPACxa20TSw4f2NjsBDFs=;
        b=Ot4LUM9vennjOsDScG+3pnXhAVWQ+7ozD6mExFiU/aVRNFuzm8PMzBcMa4XZsEwso3
         i9z5RAna0gYQtTFNd61o9jeiOH6tWKu5LajdsFaXhMLrd25cJuPf1ojBIyeL1Yv4ZoPD
         7MOdpeqh+HQ2uXmWsVIyXBZARr/xXmTikyFle987FhGhVW+m35RITgGN7HQ6DXm1p3eK
         zUlgyuHNjDHxjLaMGmmvhd+EivglTjKNTR9hkOcueDk1lZvwuW5+Y8//8B7YgQFqIxWm
         T5LzRUZ+P0bsZA0elYv2i3Xz0aZ+92cIbrFLg1iqcEcrT2GOxRD3g3RJ9ktYVZLwtfqF
         CQ8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=EOUkUjkApB+u9s/YlxR3KEiPACxa20TSw4f2NjsBDFs=;
        b=Krbg1IXg1hceNn9wWthF0qtojmrXteaC0OHC8r0Z3u24D7hY+x8w9Bx1ugTfj2wlsC
         SMdktg0boJCb2bZpJ5Frp7AqBYL7q6Qs7gQe+tNpDTxyE4YLAnYtTE0T/F5vL4s3JFdG
         msQZs+hNuMsKZzIOSY9yLOJF2aFGNAXS0wS1cHNbByJ8yKYLeBmQyQRGvECpW4uWmNJc
         bNLSWbFuFKtLomDhURD5imCDFgvPYT2kp2drI/k+MXP6h1kgUGv7YdR2ITZRsIGduHKA
         OY3b9BpeKPayCvq0la3P0CqGAIOz746xkQ8sSnC+QAWHnDPhZ+5SvmO8wFFaL7N0jmV8
         svBg==
X-Gm-Message-State: AOAM532LZB3B5k6BdfcSU2Cg3e/F43v47gFjIpa/+dQ5CVqTiqXeUF4B
        zehwRNWBYM0wAlO+BCeKaK/r3Q==
X-Google-Smtp-Source: ABdhPJwbB4i6KbTtSHoL8+GibG3II0wrltUkyNqSuMSNeJPHqSJinHnylmT6nDOpvLO+YEKUOjamcQ==
X-Received: by 2002:a63:f011:: with SMTP id k17mr193635pgh.391.1628613457217;
        Tue, 10 Aug 2021 09:37:37 -0700 (PDT)
Received: from localhost.localdomain ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id pi14sm3517744pjb.38.2021.08.10.09.37.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Aug 2021 09:37:36 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/5] fs: add ki_bio_cache pointer to struct kiocb
Date:   Tue, 10 Aug 2021 10:37:26 -0600
Message-Id: <20210810163728.265939-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210810163728.265939-1-axboe@kernel.dk>
References: <20210810163728.265939-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This allows an issuer (and owner of a kiocb) to pass in a bio allocation
cache that can be used to improve the efficiency of the churn of repeated
bio allocations and frees.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 640574294216..5f17d10ddc2d 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -291,6 +291,7 @@ struct page;
 struct address_space;
 struct writeback_control;
 struct readahead_control;
+struct bio_alloc_cache;
 
 /*
  * Write life time hint values.
@@ -319,6 +320,8 @@ enum rw_hint {
 /* iocb->ki_waitq is valid */
 #define IOCB_WAITQ		(1 << 19)
 #define IOCB_NOIO		(1 << 20)
+/* iocb->ki_bio_cache is valid */
+#define IOCB_ALLOC_CACHE	(1 << 21)
 
 struct kiocb {
 	struct file		*ki_filp;
@@ -337,6 +340,14 @@ struct kiocb {
 		struct wait_page_queue	*ki_waitq; /* for async buffered IO */
 	};
 
+	/*
+	 * If set, owner of iov_iter can pass in a fast-cache for bio
+	 * allocations.
+	 */
+#ifdef CONFIG_BLOCK
+	struct bio_alloc_cache	*ki_bio_cache;
+#endif
+
 	randomized_struct_fields_end
 };
 
-- 
2.32.0

