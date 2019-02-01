Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C42EC282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFF4D218AC
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="gf7aUSjc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730032AbfBAPY4 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:24:56 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:54946 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729860AbfBAPYz (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 10:24:55 -0500
Received: by mail-it1-f193.google.com with SMTP id i145so9600815ita.4
        for <linux-block@vger.kernel.org>; Fri, 01 Feb 2019 07:24:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=heCO4PqIPeaG7qS6KODVXQgGniVV6HXd/0gzeRZcYhY=;
        b=gf7aUSjcVHIUbxSfa9eg6Nan++SJuYKNl4SFffTUk1LyEGVJ49qcPc97cR5hGjZtDt
         UmdK3NxuuxZ5Mu1QfCD+ptp5tVAcCqeoJ3ptKSzXmIjdGexCNlyAW3KRg5sPutAfe5DW
         xwTzD+XOcLh+dZWCOqXs7IzfUtaxuKMIkxTJbI9Ag3Sqzt70FAFY/TuL+ALDfwZIKsQv
         SHJ6zz2RFtWYS6O5qGO5ubMLBXaOCUBEp06CmSPrZIvKWHroaOIdWoHzqW9Te02IEKvK
         iRge9ldnodvgpI0CtdtrHyB3McUP1ZylSnTS8k2UROScf9Sj/mRVJ/rR6moYvTDhtdNz
         QPyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=heCO4PqIPeaG7qS6KODVXQgGniVV6HXd/0gzeRZcYhY=;
        b=eOvX91eg/7jxO4W1N10YfnfO4FcwSgMDbwpH8lq/GZtzz9SYc6oM6PGUTRKlhwPbj7
         tJiaYhbX4vXkI47juBSCT7M87wU6yFrWRMBdrLCtcAY7iLV7SgDXj3xM1FhnkO9ghzDB
         ssX/WtHzX8R3WPS/V0Vex07lsF8BezjsqmhEfXeCGNbaEQ55Sv6+GNnHe28LP/kyolYp
         o1R/ixsWHVkkTXqjjtxkyFyRivXnFbli6WP4xEmfGNX2/09fWaODZmXqtHbZWCftt7EF
         u8weXegJEPuJglOGNXs0dFX76+tpns94v1Omxl/FeWvOXlVv3jlYMAUJG67wMdJRUwMV
         n9iw==
X-Gm-Message-State: AJcUukfxKfdeOtWpRHQjEjCz/5hrivTmeQluYPdfaxYxKbwNfaLRlbFB
        +E4BafUuHxKcgfrO03Vy4KDs4Q==
X-Google-Smtp-Source: ALg8bN7BB6JiR+8z3pXRfnzxjXZh9P0lwUeFl4cOiQIKgFZcHq3pFXC/mdOJFBfcBCdPmCxvvcMZBA==
X-Received: by 2002:a02:ac8c:: with SMTP id x12mr22675098jan.72.1549034694214;
        Fri, 01 Feb 2019 07:24:54 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t6sm3388898ioc.87.2019.02.01.07.24.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:24:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 18/18] io_uring: add io_uring_event cache hit information
Date:   Fri,  1 Feb 2019 08:24:14 -0700
Message-Id: <20190201152414.23296-19-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201152414.23296-1-axboe@kernel.dk>
References: <20190201152414.23296-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add hint on whether a read was served out of the page cache, or if it
hit media. This is useful for buffered async IO, O_DIRECT reads would
never have this set (for obvious reasons).

If the read hit page cache, cqe->flags will have IOCQE_FLAG_CACHEHIT
set.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c                 | 7 ++++++-
 include/uapi/linux/io_uring.h | 5 +++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 0e700e81ac43..48234304ef02 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -560,11 +560,16 @@ static void io_fput(struct io_kiocb *req)
 static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
+	unsigned ev_flags = 0;
 
 	kiocb_end_write(kiocb);
 
 	io_fput(req);
-	io_cqring_add_event(req->ctx, req->user_data, res, 0);
+
+	if (res > 0 && (req->flags & REQ_F_FORCE_NONBLOCK))
+		ev_flags = IOCQE_FLAG_CACHEHIT;
+
+	io_cqring_add_event(req->ctx, req->user_data, res, ev_flags);
 	io_free_req(req);
 }
 
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index d319b2cd6319..6782e4e0464b 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -69,6 +69,11 @@ struct io_uring_cqe {
 	__u32	flags;
 };
 
+/*
+ * io_uring_event->flags
+ */
+#define IOCQE_FLAG_CACHEHIT	(1U << 0)	/* IO did not hit media */
+
 /*
  * Magic offsets for the application to mmap the data it needs
  */
-- 
2.17.1

