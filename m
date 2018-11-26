Return-Path: <SRS0=/l1b=OF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47FD7C04EB8
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1156B20659
	for <linux-block@archiver.kernel.org>; Mon, 26 Nov 2018 16:46:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="ZI/Nj0KW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1156B20659
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727104AbeK0Dkr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 26 Nov 2018 22:40:47 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:54576 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727100AbeK0Dkq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 26 Nov 2018 22:40:46 -0500
Received: by mail-it1-f195.google.com with SMTP id m123-v6so5069964ita.4
        for <linux-block@vger.kernel.org>; Mon, 26 Nov 2018 08:46:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=mh+baagw6TRyG7ZRVJ1uWljPK7oJpHidng0AtT9sC8g=;
        b=ZI/Nj0KWRWNNOzDBr+AA6s1u+beQA0V+xoTW/OIX0kXbANq3qRThh3xyTyZakAX35n
         VBjMeULPcxYgS6Gp5wq3P1DvPmyFJ8vt3WeJtsZCPAGyFkrDzJR7LA5gtl7iN+a4y7Q8
         SwONi7qLWdYZmF7uPfIrrVBb4tSUQqCCcRFzVCVsxJWcPHCzHtEKL8LU059ci/Glur7G
         XL4Kk384BfccHtj61hgZtmPiAP2hMYaYCk2uvMCOxZEEp+IPp+dpjSerXpddY8RukvqI
         M9/bnez19KCGlyR7Ip2bnPhO+hpv4tUKRJfYKNCUWbpSMgrsRMfjf6a9axR6zp8bE0C/
         fPBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=mh+baagw6TRyG7ZRVJ1uWljPK7oJpHidng0AtT9sC8g=;
        b=ZfY34FIPm3wdtffQfiiP3BCLbx+m8WI8j6CJxclHPLWAvMhtweycEgpFXr10zC3k/y
         22a5TUG+0TJlMsKYDNPW+8iR6HfrKEI/WoFa9YZalnFabhBmpVcWORTD8cFB/viuElqJ
         n/8vdXr77j9bGNQiQe5cRlfey8G0H0K50wNdba+rXAge9vrKNKuFJy/C7375d/xtWlVN
         6mn48S1jhLLb4jgc65/PJ8Gfee0wGTFJKhp1DXxLpW/G9azPax7OYitNDExL7BU/mN61
         PMER48XRbzbfy2EJIuBP7ogr19TFcznTHin02vZq/p5XshVSV4Tx60D3+DnmuLcTV8Ai
         BkSA==
X-Gm-Message-State: AGRZ1gJCZ1Dwd62aLyhNarXUA+YdxMnLzkXPptXBBmWobkeUU/SCLOed
        91gJUuS3631dnn6xDlGWyFcPsPDI8WM=
X-Google-Smtp-Source: AJdET5eqjJTja24x3SvUDZJy4+CPO+TjcaJpqgrtOzRfwrmRMc+NKBxBHBXGEV19gsrKeQn6F4vFXw==
X-Received: by 2002:a24:458c:: with SMTP id c12mr23420072itd.27.1543250767096;
        Mon, 26 Nov 2018 08:46:07 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t65-v6sm486801ita.9.2018.11.26.08.46.05
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 26 Nov 2018 08:46:05 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-aio@kvack.org,
        linux-fsdevel@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/20] aio: don't zero entire aio_kiocb aio_get_req()
Date:   Mon, 26 Nov 2018 09:45:34 -0700
Message-Id: <20181126164544.5699-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181126164544.5699-1-axboe@kernel.dk>
References: <20181126164544.5699-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

It's 192 bytes, fairly substantial. Most items don't need to be cleared,
especially not upfront. Clear the ones we do need to clear, and leave
the other ones for setup when the iocb is prepared and submitted.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/aio.c | 19 ++++++++++++-------
 1 file changed, 12 insertions(+), 7 deletions(-)

diff --git a/fs/aio.c b/fs/aio.c
index eaceb40e6cf5..681f2072f81b 100644
--- a/fs/aio.c
+++ b/fs/aio.c
@@ -1009,14 +1009,15 @@ static inline struct aio_kiocb *aio_get_req(struct kioctx *ctx)
 {
 	struct aio_kiocb *req;
 
-	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL|__GFP_ZERO);
-	if (unlikely(!req))
-		return NULL;
+	req = kmem_cache_alloc(kiocb_cachep, GFP_KERNEL);
+	if (req) {
+		percpu_ref_get(&ctx->reqs);
+		req->ki_ctx = ctx;
+		INIT_LIST_HEAD(&req->ki_list);
+		refcount_set(&req->ki_refcnt, 0);
+		req->ki_eventfd = NULL;
+	}
 
-	percpu_ref_get(&ctx->reqs);
-	INIT_LIST_HEAD(&req->ki_list);
-	refcount_set(&req->ki_refcnt, 0);
-	req->ki_ctx = ctx;
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

