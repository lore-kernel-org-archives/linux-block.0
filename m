Return-Path: <SRS0=8pZC=OW=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86197C67872
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4DC9320870
	for <linux-block@archiver.kernel.org>; Thu, 13 Dec 2018 17:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="TR9tCm3q"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4DC9320870
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-block-owner@vger.kernel.org
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729483AbeLMR5L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 13 Dec 2018 12:57:11 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:37035 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729686AbeLMR5K (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 13 Dec 2018 12:57:10 -0500
Received: by mail-it1-f195.google.com with SMTP id b5so5190584iti.2
        for <linux-block@vger.kernel.org>; Thu, 13 Dec 2018 09:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=46YCPSjyTrlcpzDW0Ukbp5ofhNBoK9a5mtdA0d9T/5Q=;
        b=TR9tCm3qtZ9avZXMryoHzIgiemEAOT6AQJdUIeXytYeS5fJV0IsnEdQHlHEr2rvz/B
         biQt+VmOkmqY4Cridh1E0I/lVMetV7kwg9Kg4ur5AcjDNXyOG1w8am0SQZWSd2lW4HBE
         t3zEi8dZ/AO/JyeSjH1d0L8MPypneZ/V77J2SZeiH3l0i6lC18LCp5TZCYMOKblZeoJo
         5mdVc6Xi4xEt5wtquXW1oIwOkoe8Qe67i37sNXSDap/JLmU1+sSseDnnR7BiTB41KiA2
         SjogNmN4Aa/2ShjIeccNix8PyGKH8vTvW3Q5/7lshxz3PISlr2oBl2woT00dtepCEOkH
         +EDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=46YCPSjyTrlcpzDW0Ukbp5ofhNBoK9a5mtdA0d9T/5Q=;
        b=M+QmNbKLurGyCUd70EhurS9onJ7yrhRKu5xdbXztO+DyQaIdsnUSXCZ+b0X+QmWBJ3
         LrpDKvy+m3OdgzmZJS5ttR7enhNlH+4bkLKFwrCAw5IO9XEoucjtoQkdUcyVtVUPRbhO
         Vv7r80cvWJR4SQak6LlZ7oHIW0/cxH4LA4zkYs51Ng0jMh+x5HqBX5LLHOvQIYGTPzbp
         VCJ0vV4v2QCCRLnKAgFIwPCCHrMHuWlz/ZKByrnBI3hLxvbCwQX0DY/mgJhY7s9XcXtW
         RWNB8/hRcbF1AplZOg9Yl4v/mEps6nVrByZgQiaViv4ulz669YtPWhFxIZyxTcpbEkPx
         2OCQ==
X-Gm-Message-State: AA+aEWY+oLSQOBTRqUnceWOc7WfxjeCIUvSIolD0MbuUcMad1VzYwsJe
        u/vKeRYaorTtQMJoEqBPslbrjXjS0gi+kg==
X-Google-Smtp-Source: AFSGD/WbZgGgxLtLVsvhgxs7NF9v+jtomC9QdA4pyT9R7xM7KXmdcQB9P68YBppJSiMiFip6jNtc/A==
X-Received: by 2002:a24:3007:: with SMTP id q7mr279761itq.57.1544723829614;
        Thu, 13 Dec 2018 09:57:09 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id k6sm1022261ios.69.2018.12.13.09.57.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Dec 2018 09:57:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-aio@kvack.org
Cc:     hch@lst.de, jmoyer@redhat.com, clm@fb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 10/26] aio: use iocb_put() instead of open coding it
Date:   Thu, 13 Dec 2018 10:56:29 -0700
Message-Id: <20181213175645.22181-11-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20181213175645.22181-1-axboe@kernel.dk>
References: <20181213175645.22181-1-axboe@kernel.dk>
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

