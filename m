Return-Path: <SRS0=IV7O=OQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,T_DKIMWL_WL_MED,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C3DE9C07E85
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 855232083D
	for <linux-block@archiver.kernel.org>; Fri,  7 Dec 2018 22:20:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="H3vt1ygN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 855232083D
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726143AbeLGWUk (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 7 Dec 2018 17:20:40 -0500
Received: from mail-pg1-f194.google.com ([209.85.215.194]:32814 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726137AbeLGWUj (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Dec 2018 17:20:39 -0500
Received: by mail-pg1-f194.google.com with SMTP id z11so2311196pgu.0
        for <linux-block@vger.kernel.org>; Fri, 07 Dec 2018 14:20:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j8zbGImEaiI6fzdEzobInCNQIlTJ46kLaRSNEoXmu1s=;
        b=H3vt1ygNmN7jAiiG/KRMk9LQKtQheMfaCpKOCYztxiaFLavZ5wjh4vbptta/7gbi5i
         4tg2qf0guLyW2xkYre0GdKRE0dTzbfu9O6CzpQ8Z2KA5pH7H8YTbwB4Xcf44HlNg71D/
         ijloX7nOSFO8qGNwgthDKqju3OWs44D28QZKHAaQ4zbtjrCilsW7kRJ0heMuG+aECpEW
         SAM/1C1Qsn1YuHg3FoYegZUhsac/QJmFuASeeofuC+RV/1fvbI8ycpNmezqcF5JDU9sm
         SQpVpOf7GrLvlXwbP1cC/aWn+uZPfiC2vVLYVVREDKa55YZOARLIeWIoVRIpeIxfNCY9
         G6ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j8zbGImEaiI6fzdEzobInCNQIlTJ46kLaRSNEoXmu1s=;
        b=LQjY3uBTU6qXHeq8PzR9xLuuQHAFDOkarLuKmMeQxj99SdwwLDibkzY7xePgYBwOTj
         Bz3tzSP3B+kZoZ91WcF9M3zGR0XmH/lDo3kEEByq2VH3aHKOP/XLyKXKVdByVKQURbgy
         I/Bx45qXLMhF3H0bdeuF5wQqc0npXeOq2yRDo3FNSrG9aWziy+wPqN1TbUlxXK/UAHMQ
         qMCS5N9gNRZaFFhyDZjvodYyWnzYs1owi09/W5XjxiJkACN20eATFN4xBlaifuXJT2c+
         YUcsK4AtDbu6A7YO8wPuHOjV+bOvkhRhQ+RX6xTaJDEITNKJqvU+Aikcfx4G7U8OR0qx
         i+mQ==
X-Gm-Message-State: AA+aEWa++8PogRhbwCyaWekZH7kDFuqHR31lT86eA+gcT61PW32cpagj
        4fpZtE7/+3KL4RtZCIKpihe1Md5Yah8=
X-Google-Smtp-Source: AFSGD/UB1/R66WvOFzl7R7V/TsvM2l/guymfbUrF/oKzdnniJcZ5of7d2lk1n08QCqYmGtpk6telfw==
X-Received: by 2002:a63:d747:: with SMTP id w7mr3451509pgi.360.1544221238149;
        Fri, 07 Dec 2018 14:20:38 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id e9sm5282511pff.5.2018.12.07.14.20.36
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 07 Dec 2018 14:20:37 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/26] aio: don't zero entire aio_kiocb aio_get_req()
Date:   Fri,  7 Dec 2018 15:19:58 -0700
Message-Id: <20181207222016.29387-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181207222016.29387-1-axboe@kernel.dk>
References: <20181207222016.29387-1-axboe@kernel.dk>
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

