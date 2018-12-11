Return-Path: <SRS0=ptgV=OU=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2D8FC5CFFE
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B66320870
	for <linux-block@archiver.kernel.org>; Tue, 11 Dec 2018 00:16:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="z5G8mLTg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8B66320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729177AbeLKAQS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 10 Dec 2018 19:16:18 -0500
Received: from mail-pl1-f195.google.com ([209.85.214.195]:37892 "EHLO
        mail-pl1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728609AbeLKAQS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 10 Dec 2018 19:16:18 -0500
Received: by mail-pl1-f195.google.com with SMTP id e5so6034193plb.5
        for <linux-block@vger.kernel.org>; Mon, 10 Dec 2018 16:16:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=46YCPSjyTrlcpzDW0Ukbp5ofhNBoK9a5mtdA0d9T/5Q=;
        b=z5G8mLTgAuvpYLegi+S5fGTYJMXodCmeX47ulRAotdeqmI1MI/cnHV1gbAJ+WwDKg+
         WqFwtnWTb83Er1j2Edy9IFjPyMiD0wgIqcYZ7Tz3LxdUgRAFUlYscdteiXlv1JV6Wxiq
         6fctt2XXKWVnn72wbxasAKA1UCS6syzquWWT6HoUs35nHVvXYh+NhIhsyDvfjciJCK5O
         hmwdgaZqsZBmfGkkqauP6aai9kWJQdLExA6UBkB/H/r37/9R4ygZSRjUR3lEvaijGoNu
         3/I2E91pKubNVi8d1lSUUloSN/xfKCmLzH3U2N8WQgoK1aOGAog6dT4ggNp3m6t+qzDF
         jJ7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=46YCPSjyTrlcpzDW0Ukbp5ofhNBoK9a5mtdA0d9T/5Q=;
        b=sukP4nKGYiP0GwtmC+squZ13OISWT8JhJK88Tn0FmY4sESbuS6b7orxkbuHKzCzrKt
         +G9avbrW9YMHrt993z4uZbh/lXh/5u9tdbLwXHKVzvBhtjiue+U8hLJGPLPaZGnleeoq
         NDbdqIsdRKszjDVwy5OMXcMMEEFqxnuEgE7qDYS025NWbemr1o6k6lpDkEaNE16ZueJo
         aWNsAMO0fIzZqVLXNYR0gIDbVXX/F7HiZvNuwvF/dUkx49PrYJ7ASKd8n8MbIEaDaL0l
         HVfnrQreqrUeTpVaXUQr2Mt4sLduewTbXngO3ptsxJHV+PeGkiDkAKTDB/AbuZrsTj0o
         Q6gQ==
X-Gm-Message-State: AA+aEWYpi5gQWG4SjspfabR5So+tdh6vvn/yhtthutEpE5FWvqsRrZbM
        lhjd9XK+LfN6mH+4CV704ZO0a/iNVT46pw==
X-Google-Smtp-Source: AFSGD/WueLnrroTicqXzhpk8YxL3bnKO2H1XJvAFXHVH+RDI6IXD4XhAF2DbEAe4Taasoli0mcIBaw==
X-Received: by 2002:a17:902:8541:: with SMTP id d1mr14291577plo.205.1544487377374;
        Mon, 10 Dec 2018 16:16:17 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm16872856pfl.16.2018.12.10.16.16.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 10 Dec 2018 16:16:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/27] aio: use iocb_put() instead of open coding it
Date:   Mon, 10 Dec 2018 17:15:32 -0700
Message-Id: <20181211001549.30085-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181211001549.30085-1-axboe@kernel.dk>
References: <20181211001549.30085-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Replace the percpu_ref_put() + kmem_cache_free() with a call to
iocb_put() instead.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index ed6c3914477a..cf93b92bfb1e 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1884,10 +1884,9 @@ static int io_submit_one(struct kioctx *ctx, struct iocb __user *user_iocb,
 		goto out_put_req;
 	return 0;
 out_put_req:
-	percpu_ref_put(&ctx->reqs);
 	if (req->ki_eventfd)
 		eventfd_ctx_put(req->ki_eventfd);
-	kmem_cache_free(kiocb_cachep, req);
+	iocb_put(req);
 out_put_reqs_available:
 	put_reqs_available(ctx, 1);
 	return ret;
-- 
2.17.1

