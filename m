Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9D9C433EF
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 02:06:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6947C60F8F
	for <linux-block@archiver.kernel.org>; Sun, 17 Oct 2021 02:06:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231439AbhJQCIk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 16 Oct 2021 22:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230102AbhJQCIj (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 16 Oct 2021 22:08:39 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA151C061765
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 19:06:30 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id g2so11312851ild.1
        for <linux-block@vger.kernel.org>; Sat, 16 Oct 2021 19:06:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=p09U8SXDT+RFFWHkiHhCOYbDlZKSVrwgbC8CojRQ8/8=;
        b=V9IxN8qdvxZNlG/DrbaUeEWB2sfoj8AJWpKlo6x+l0rBscF8Wl7bshyiRrBtoPxsUa
         tOTFyJ3sd7X8PrkEqvhqZ0LhbdslTwIjLvIAFqL5hfg603HyjLo40f/UhjWEA9N+RdGm
         zRaC609QuHmFgERiBYG2tp5GC4QlYumSEpQYLwlATvkXxe0/CslhCGvp7zYE08Rr4IzH
         wCOlP/LhMjhkN3rsG9guRDk7kAHppKLb/zENnLyTfWr3m/Zb/B7ddm2IWklaNg8U4B/i
         1DbtMvTz1Lw8LsMko4SxJG2XpOkvHfvkNQ1ZxG3O8KeeFBpMF57AeEedT4kU2Sao8eGm
         P+Nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=p09U8SXDT+RFFWHkiHhCOYbDlZKSVrwgbC8CojRQ8/8=;
        b=cz8l2I56fqA9kBdVPcmXSqplOMNjXGWkEAiHzca7PsMbNGDWfOAbJW7YcD4bAd+YFa
         E1hQ5aTPUSHTPDLUECnHFHgCYzor4V/wZJdEsOVLxYEyAqFWtKWXI5aZlghriC9UqmzX
         6CFafQVLwq1qg5ZhI5ulsmaqElbHiqNMQFAPx4JlY/ojiTe1NQxsbhB7Xr7JY534dBvj
         ayg/ObkkXi7obPggA9Xwx1kXOkiYufaWvp4J/7sXhZAgaDG+btrFQM+jCxOZcu5LLUXt
         Q3SAHy6QEPGeNGocYqTeJAPhZXlPWI5C2TAh2y0lvDToDYW97GD1AZ/5nC/UxcHIPjNf
         P4UQ==
X-Gm-Message-State: AOAM532n80RcD3WlP9z7mQmVEkp4+hVNBTTrorhjjW2VSUhWST/PERcl
        kU0uYJhf7I9EILWlv5srcJe0CGm5Bl2dxw==
X-Google-Smtp-Source: ABdhPJyuhwppiCT+soDGubV2nPElOMOhDCKWlWJ8ocKkTJEv0f37EsluMUt1g0R+BhEz+cN8UMLItg==
X-Received: by 2002:a05:6e02:1e03:: with SMTP id g3mr9309981ila.86.1634436390087;
        Sat, 16 Oct 2021 19:06:30 -0700 (PDT)
Received: from localhost.localdomain ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id n25sm5072127ioz.51.2021.10.16.19.06.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Oct 2021 19:06:29 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 5/6] io_uring: utilize the io batching infrastructure for more efficient polled IO
Date:   Sat, 16 Oct 2021 20:06:22 -0600
Message-Id: <20211017020623.77815-6-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211017020623.77815-1-axboe@kernel.dk>
References: <20211017020623.77815-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Wire up using an io_comp_batch for f_op->iopoll(). If the lower stack
supports it, we can handle high rates of polled IO more efficiently.

This raises the single core efficiency on my system from ~6.1M IOPS to
~6.6M IOPS running a random read workload at depth 128 on two gen2
Optane drives.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index fed8ec12a36d..57fb6f13b50b 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2428,6 +2428,7 @@ static int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin)
 {
 	struct io_wq_work_node *pos, *start, *prev;
 	unsigned int poll_flags = BLK_POLL_NOSLEEP;
+	DEFINE_IO_COMP_BATCH(iob);
 	int nr_events = 0;
 
 	/*
@@ -2450,18 +2451,21 @@ static int io_do_iopoll(struct io_ring_ctx *ctx, bool force_nonspin)
 		if (READ_ONCE(req->iopoll_completed))
 			break;
 
-		ret = kiocb->ki_filp->f_op->iopoll(kiocb, NULL, poll_flags);
+		ret = kiocb->ki_filp->f_op->iopoll(kiocb, &iob, poll_flags);
 		if (unlikely(ret < 0))
 			return ret;
 		else if (ret)
 			poll_flags |= BLK_POLL_ONESHOT;
 
 		/* iopoll may have completed current req */
-		if (READ_ONCE(req->iopoll_completed))
+		if (!rq_list_empty(iob.req_list) ||
+		    READ_ONCE(req->iopoll_completed))
 			break;
 	}
 
-	if (!pos)
+	if (iob.req_list)
+		iob.complete(&iob);
+	else if (!pos)
 		return 0;
 
 	prev = start;
-- 
2.33.1

