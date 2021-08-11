Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56C57C41537
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 19:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2596105A
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 19:35:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231655AbhHKTgH (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:36:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231403AbhHKTgF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 15:36:05 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A280C061765
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 12:35:41 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id e15so4030187plh.8
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 12:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3qJ0cLXPwzuYEK5Ou0Wuu6u7LZDeLGYslbPHi5c/pHk=;
        b=SfbYM3OkBemATUFedu3RcmN2KNt+PrN56St6aEdv1p2MLCaQbOwLIQA7l9X3Fp3/PL
         VNbtizRGhOpevgv9CFl9hmXh+McvLeafA3DvzphN/LRlEOuLOYpEDVxxfj4fqwICpaWL
         mFur6X+dISuCkMsVCvHSDO5q7U7nqlJUxDmjs9G068CVZJYIL9c3qvXeRsvt1FYvfm/t
         OQO43sqweqGWLQD8/M930uAPaGl3xd0fetGWLU9KJcDIxmizS6CWGqaoqkLYUl4Ch6LJ
         jTGMfGbY2Tn4zdnYOe28+MnGtHSvSDZx/4MseKVbTNkYJ0enGK37QbxyC2ZupUwzx/dZ
         /tNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3qJ0cLXPwzuYEK5Ou0Wuu6u7LZDeLGYslbPHi5c/pHk=;
        b=N09TIt8yThpMIVX86BdV7B1LK9kIFWS65t6wR/cqKVY4bh/j4Rzuaajr8GyNxTLV1E
         EYQVEhUkqu+C/hhGBhn13lPpd8ugU6CPLRfT60Wve5Fu4KOc+31Z/inOPow18oI80ioM
         1DXb4RLvh3+6IzIChvcPX0LsgI7HQXrB4B+ZA76gypYDUz7qz52wHn5WmUntcgSF00F2
         orWEkntNXVIXb6VWZLAJuOjq9dimQLWbsYuYuZ9y6ZaAk7R2g6B5XHV9tYE29sLXMhpr
         /8KspA+XwzDMmZBDykgSZrd3Vpna0agUvmhsf+bI3GGNq6K4AGcBvMi2ehNqMS0Bh0OH
         Omlg==
X-Gm-Message-State: AOAM532muSzLrXfVVdbRaopGLmtdGoWvoMS+Gjk+p3c19JrtIpgA69Bl
        vfe6J0xIN/b7nxo6lY5cBBsmPA==
X-Google-Smtp-Source: ABdhPJw+pjLBfJhRyRCDOoT+oXV+bgpnlxCfXS+YcKGx6KPwhG3u9kPWOt3xTeufIVtCKF26mC90rg==
X-Received: by 2002:a17:90b:f10:: with SMTP id br16mr3171552pjb.65.1628710540759;
        Wed, 11 Aug 2021 12:35:40 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id u20sm286487pgm.4.2021.08.11.12.35.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:35:40 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, hch@infradead.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 2/6] fs: add kiocb alloc cache flag
Date:   Wed, 11 Aug 2021 13:35:29 -0600
Message-Id: <20210811193533.766613-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811193533.766613-1-axboe@kernel.dk>
References: <20210811193533.766613-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If this kiocb can safely use the polled bio allocation cache, then this
flag must be set.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 include/linux/fs.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/include/linux/fs.h b/include/linux/fs.h
index 640574294216..0dcc5de779c9 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -319,6 +319,8 @@ enum rw_hint {
 /* iocb->ki_waitq is valid */
 #define IOCB_WAITQ		(1 << 19)
 #define IOCB_NOIO		(1 << 20)
+/* can use bio alloc cache */
+#define IOCB_ALLOC_CACHE	(1 << 21)
 
 struct kiocb {
 	struct file		*ki_filp;
-- 
2.32.0

