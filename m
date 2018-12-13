Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDB53C65BAE
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9E51620879
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="wyVRCenG"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E51620879
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729589AbeLMR5H (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:07 -0500
Received: from mail-io1-f68.google.com ([209.85.166.68]:39763 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbeLMR5H (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:07 -0500
Received: by mail-io1-f68.google.com with SMTP id k7so2302872iob.6
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:57:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j8zbGImEaiI6fzdEzobInCNQIlTJ46kLaRSNEoXmu1s=;
        b=wyVRCenGpJ7Utd3thODL9gLn/0Um/RLk+cC32Z8bg8uPkqdCKKPF+y/OmgbxHALv+D
         HgJm7LsD5066SLdHBMEB5LtRu83wx7DzAO2m91Ktxfuj1iFUJLu7pmq6f0oCYHNOGg5S
         zesTlVyin4C34Q0K/B9T6uLcYo725WW1Zt5cTzcgUQ63f6D2I7ji3gSV3oPP+kJdaduo
         M06OuF8QENdFkfDV5oWtp1SVBgMenPN1LRAotaqKQ4npOQydl704/bmvkOqYCe8KSfBy
         V030HuGHFvZ1miYapW0ZbEn/2STeGa/bmdJgeuv640sg8FiDBwe9gE99schsbaJ9c5cS
         YFYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j8zbGImEaiI6fzdEzobInCNQIlTJ46kLaRSNEoXmu1s=;
        b=Dqu8WDUcp/3hI+7wC5JcYVRelSkBomncBb4noHXkaGx8IBvYfJleLfzPMagEbU1Gw3
         bfYatJOwI7GejOke0luE5Df5Rx69JWHNtzEIGYLadFG6iloOY4A48TjDDIKKoBNOviq5
         FYvlxLbWJbMzJsueSd4y+7EClG0qXM8/3OT+GXLDhEn5hUhkOBAg4iytEUmTDCLDUTt2
         DgvegeCrlrL1IuJfRve10JJzxdTAC18GZGzHo+l/lvTWVuA2BfSEzbYJmI5d9pAfMODD
         Tzfhr2euvtrFUzVvOeSsOYl7Goj2ubgR0HO00hUTM3AnX6wddYNvge3DovhmFtUzeNas
         a6VQ==
X-Gm-Message-State: AA+aEWY8df0lk3qMsBW947wLe1BpXAOlZF+wGjbTD0u9ceMaX2fYIdKp
        e1kOeeOmQ+kjPG2E6iGX70wnROmoLTlHpw==
X-Google-Smtp-Source: AFSGD/UZuMcpdXV9ceBYr4vyy/sE99WT1EGbVIyhWSUEsc7jJlo6Agstzty9h2WNv6XBn/eCGnEGtA==
X-Received: by 2002:a6b:919:: with SMTP id t25mr20293537ioi.207.1544723825932;
        Thu, 13 Dec 2018 09:57:05 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.57.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:57:04 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/26] aio: don't zero entire aio_kiocb aio_get_req()
Date:   Thu, 13 Dec 2018 10:56:27 -0700
Message-Id: <20181213175645.22181-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
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

