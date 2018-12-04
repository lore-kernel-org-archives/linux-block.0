Return-Path: <SRS0=ovnK=ON=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C7A5C04EBF
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 505FC206B6
	for <linux-block@archiver.kernel.org>; Tue,  4 Dec 2018 23:37:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Set3dj9n"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 505FC206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725925AbeLDXh4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Dec 2018 18:37:56 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:33798 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726624AbeLDXhz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Dec 2018 18:37:55 -0500
Received: by mail-pg1-f195.google.com with SMTP id 17so8110784pgg.1
        for <linux-block@vger.kernel.org>; Tue, 04 Dec 2018 15:37:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j8zbGImEaiI6fzdEzobInCNQIlTJ46kLaRSNEoXmu1s=;
        b=Set3dj9nxVQrkupYh/+vPbi3t2uxo7+EjNlGSkIkQl0JTq/vhMHP5SQ1GKLG4UJsYT
         goH8r45Ukjn6fzROvOFzgYeEPTIiPAEdjbGoePumQiVPTenDrVMpLERic2Ya4PaX98Vj
         cDEcGXe4RzCUcqW/NqCXzh6ms2KpAyqwa/KLSPt0h80HBZMNJPgcLW0L4Xwli6Ck4mkw
         JICDXjN3tL19OSIrQZWglTy/qsTHmiObvAg/i6w+uGIC/Y2FhQ2cz1ICi3dyKx9QI/AJ
         aSCwW5ZibvSpME6fTPqLStYRoIT3mAWAX6ECgkwdc/QC1UXgab6+cJAutkIPXJ/vjbHo
         Z24g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j8zbGImEaiI6fzdEzobInCNQIlTJ46kLaRSNEoXmu1s=;
        b=sV4QUi5PdMxTf4sCZF3Fzt8zvinkQR58+QhUpMKsnWepilQLN7ptwFm4+HLWPAA3dV
         +Bk3EydFo/X6s92kdmtXI/cq79rMtQ05Zq5mk6HoXo9B98LVbyssktBl+hQ06825t5WQ
         NIjpD9LtVhy5Z9JdyvzE6/QiRm93uEYqC22JztXEjuW1VmpOGqfh/mWKKZUhwFj5AtJ3
         dxggnX5S4i/aSiF8wZ5aho1pgXAYp3xQhbidMgmlSmwL3Knz46YcZY4cpaHd0OllGPGN
         pScS3jeaYREpGTo6wcFF1E1KO9Z48E1Oiq7eCRkF9CdmSTI8Ko7Rwlt8jE+gSfreFKsg
         nu/A==
X-Gm-Message-State: AA+aEWagfqjacJ8Z1FDc/1XDPjbvRaYCWF5fweaDCaXqK3DKgD08yrFW
        P11/CJdGW3GA5ts8G02yeYegTJ6o9/E=
X-Google-Smtp-Source: AFSGD/VBmQMykE9KxJcCOsVQ6mWUMkR59I46LJ+UNutZ8v/nWJqEjOW8gCHKkFpPqJwdy7OZl8zLpQ==
X-Received: by 2002:a62:7dcb:: with SMTP id y194mr22258894pfc.113.1543966674877;
        Tue, 04 Dec 2018 15:37:54 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id t13sm22527635pgr.42.2018.12.04.15.37.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 04 Dec 2018 15:37:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 08/26] aio: don't zero entire aio_kiocb aio_get_req()
Date:   Tue,  4 Dec 2018 16:37:11 -0700
Message-Id: <20181204233729.26776-9-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181204233729.26776-1-axboe@kernel.dk>
References: <20181204233729.26776-1-axboe@kernel.dk>
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

