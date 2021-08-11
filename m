Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73AB1C00144
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 19:35:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BB4C61102
	for <linux-block@archiver.kernel.org>; Wed, 11 Aug 2021 19:35:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbhHKTgJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 11 Aug 2021 15:36:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231636AbhHKTgH (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 11 Aug 2021 15:36:07 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 08265C061765
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 12:35:44 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id nt11so5223230pjb.2
        for <linux-block@vger.kernel.org>; Wed, 11 Aug 2021 12:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oEanWYqex9JuH3iGdmfjQ00rfPxW60wGQ1NzD9wjGSo=;
        b=o2n0uXw2A1dkovhZfrRJwk7J04SXPUMV78vc0FOMnSsnuVtqCj2WcPC/Iqmc7x5FwX
         oann7w01bIooqFyKR1mliZ2wecJ5eTq9TTgSZtiz9Q7oiyIqPG99Hwfl96nNiaONwI4G
         A+7KOq2RIGqH3RNu30ppI/lDnVw/TQW6olt0IclIfRXmgnVa1xiESGUfpjTBIhjasuLi
         wS9nLuibcY/fgmtX3wTgsJ0pwhgHwHqU12cySJgucpQkYJzCIsGyCvwbUtr+ipid3t2t
         DI0GoM/p4Xh9FibPXdpBn0UIYejaoBS+SFQ7OF2Yzdf01y1fGKM/tlkaQXCB/i2bLI5U
         XxiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oEanWYqex9JuH3iGdmfjQ00rfPxW60wGQ1NzD9wjGSo=;
        b=HbUgbfOoaGSwn+R7CUKHcVWJ8edMNf05RI8tkoIKA+O4J5IZm2wSgARuGPIDca1aKJ
         aOeVIIuleNFZIkTFbfSIFbalb7xs+LzG+tO+P/DeYjBeLurvEIJeGe6luYYghRYHsNPW
         IcBX9oaYdP78kv7nBhnyg11a50hJVoaOmFkgbqv9NQjesW5kvR3VqRR60LQx8hknn3YS
         evRZ210xPe4sIDVpfEWcJ7oR8A0J8zdW7O68QDVuW13rcugNm79CcTzV1haojiayy2jc
         Y+8R7xX749clvNOE0bf2E55g/esDJLTrUvqACuiLZ9G6kVJkZXuzubGz8FDIWfTm9x8F
         ajKA==
X-Gm-Message-State: AOAM5306yfYfSlxgundEHXEK3Lgplcyog6t6jBPtC7sjfOK7ZM39n0hK
        DkS6b8B1eKyCUR9O70c8r4ZGBQ==
X-Google-Smtp-Source: ABdhPJwNzpEpb02gfUBt/Jh6uj4oiG5Hz4tPIqqmCtxgyRm82dQwWXlf5CU0LGyPf3PYJFQf4b8e8w==
X-Received: by 2002:a05:6a00:1596:b029:3c7:998a:709 with SMTP id u22-20020a056a001596b02903c7998a0709mr399865pfk.68.1628710543569;
        Wed, 11 Aug 2021 12:35:43 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id u20sm286487pgm.4.2021.08.11.12.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Aug 2021 12:35:43 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     io-uring@vger.kernel.org
Cc:     linux-block@vger.kernel.org, hch@infradead.org,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/6] io_uring: enable use of bio alloc cache
Date:   Wed, 11 Aug 2021 13:35:32 -0600
Message-Id: <20210811193533.766613-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.32.0
In-Reply-To: <20210811193533.766613-1-axboe@kernel.dk>
References: <20210811193533.766613-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Mark polled IO as being safe for dipping into the bio allocation
cache, in case the targeted bio_set has it enabled.

This brings an IOPOLL gen2 Optane QD=128 workload from ~3.0M IOPS to
~3.3M IOPS.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index bd3f8529fe6f..00da7bdd2b53 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2667,7 +2667,7 @@ static int io_prep_rw(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		    !kiocb->ki_filp->f_op->iopoll)
 			return -EOPNOTSUPP;
 
-		kiocb->ki_flags |= IOCB_HIPRI;
+		kiocb->ki_flags |= IOCB_HIPRI | IOCB_ALLOC_CACHE;
 		kiocb->ki_complete = io_complete_rw_iopoll;
 		req->iopoll_completed = 0;
 	} else {
-- 
2.32.0

