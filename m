Return-Path: <SRS0=tXSx=YT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CFB2ECA9EB9
	for <linux-block@archiver.kernel.org>; Sat, 26 Oct 2019 13:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A2467206DD
	for <linux-block@archiver.kernel.org>; Sat, 26 Oct 2019 13:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="IxsVaY+I"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726363AbfJZNvS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 26 Oct 2019 09:51:18 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:40905 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726173AbfJZNvS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 26 Oct 2019 09:51:18 -0400
Received: by mail-pg1-f194.google.com with SMTP id 15so3514883pgt.7
        for <linux-block@vger.kernel.org>; Sat, 26 Oct 2019 06:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=t2VsE09bKgfcr0wEIK8n7/K1gkQXaesJ1C1YKXtPVyk=;
        b=IxsVaY+I1lyEPoHQs7xnbkFE29uY5izxCT33u1SFIzCE+D1j4Ztli9u2TystKsTVzD
         fkRB6NnRSsfZs5uMS6gavsIgwpBeixtqHyeofYACE2E4sBmhny4ne70DnLWwOGzEnojI
         18OXl7EXyYaCQAA7zT9yfyAhoJafnt6jMm5150ZQMYlLVPr4P/XbbXTwssC/YSNnyv+2
         /IciEz9BaA78X8FrNtrsbZgj0x5g9JrRQ9i4FtWMvzoqSwRYDm2VDTvOAn6M9qebuZeE
         5jjSyJn8mdw1m0KjvquBLvdI5FKRvLJslGeL1nbMCsdxdje0SFw84PwOa5hEZK3PINFc
         FUCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=t2VsE09bKgfcr0wEIK8n7/K1gkQXaesJ1C1YKXtPVyk=;
        b=GbWLPBcmoE8q5QZs6Uo/8hQKLBmt9XIn2SoGZnGVs+XlinXO8PGwkEDg7Q1AhrPnHs
         snWs3N4dFwaEMb3LonI0q0PgsX+8bXsI0PRZOodyZWpdM4uR9I6xaVcajtzpzqv6XC+L
         qzbxR8Y+0o0wP2+b5xs+DwxJsHxa5iq6Tl5yiL63gBwwBSmfaG+qXvMiSRXUuNcxZYuo
         5wqVTcGm/mu725xl+IcgbIYAyTBxzHxzraZjiDyUQ1o3lJ2qTH4qsAgMjISXcokDirqb
         QkxAZflZiWlKtXe0eQnI/6cotPwVvvRgQsBXyOr9md3aUh5HzfRHTDHfZA7h54unK8fI
         /mMA==
X-Gm-Message-State: APjAAAVM/ydQ3G9rCBS+bwguStiPziT+6bIGeyvii+9lh5nE01ccMqOq
        izj5K9N7o5q7NMXxr7xA1w0D9g==
X-Google-Smtp-Source: APXvYqzWMJb/ygmufL4GUFz+KnEytbGQ6OkL0BdANWWfUYl+HvbziPsVrJB+8HJYfdiQ1eNXw7Wd8w==
X-Received: by 2002:a63:7358:: with SMTP id d24mr2288134pgn.407.1572097877770;
        Sat, 26 Oct 2019 06:51:17 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.79])
        by smtp.gmail.com with ESMTPSA id o15sm4706041pjs.14.2019.10.26.06.51.16
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 26 Oct 2019 06:51:17 -0700 (PDT)
To:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Cc:     Jann Horn <jannh@google.com>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: protect fixed file indexing with
 array_index_nospec()
Message-ID: <be03c863-4415-6fcb-2139-86efd680ea50@kernel.dk>
Date:   Sat, 26 Oct 2019 07:51:15 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org


We index the file tables with a user given value. After we check
it's within our limits, use array_index_nospec() to prevent any
spectre attacks here.

Suggested-by: Jann Horn <jannh@google.com>
Signed-off-by: Jens Axboe <axboe@kernel.dk>

---

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 4402485f0879..769a8c7eee37 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2320,6 +2320,7 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 		if (unlikely(!ctx->user_files ||
 		    (unsigned) fd >= ctx->nr_user_files))
 			return -EBADF;
+		fd = array_index_nospec(fd, ctx->nr_user_files);
 		if (!ctx->user_files[fd])
 			return -EBADF;
 		req->file = ctx->user_files[fd];

-- 
Jens Axboe
