Return-Path: <SRS0=mhrr=QI=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 947DFC282D8
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6302921872
	for <linux-block@archiver.kernel.org>; Fri,  1 Feb 2019 15:24:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="E36jjarm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729444AbfBAPYZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 1 Feb 2019 10:24:25 -0500
Received: from mail-io1-f65.google.com ([209.85.166.65]:38769 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbfBAPYZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 1 Feb 2019 10:24:25 -0500
Received: by mail-io1-f65.google.com with SMTP id l14so5977697ioj.5
        for <linux-block@vger.kernel.org>; Fri, 01 Feb 2019 07:24:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=FBZUThjVgqlafR/VslkU6xBWVbQBqldD6jr0wVQhMXM=;
        b=E36jjarmT4PZJgUW4HrovIIbWM5f/tryQ00WxC4qH+Q6O7L71VQ6YYcCKFK6Yo2Oqg
         zOKtC4IHGD7sKUzMBp5kOyWxxfDKFrH/GtguVISv4ActbKUJdDDm/Td3GdKoQhCKY4/a
         8lgC4tqYr6wPLPEi3xWZUakRk0bnnCc3HqoSwq/f3VTTng9nDV3lIXCIkWaaJBKOd3lo
         WmQTq/7JPDIcUdZ3hBjoi62R9yxwpj6k3fFBXvt2hUkxxZIUc+gioie6dg08GHTd8AXu
         llSuMbhktWDKGLFlJ8BDbsKm6ntEgmzqj5BuhSkzdykr6JSDcql1fAJzCuQvjbSdE4cJ
         De4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=FBZUThjVgqlafR/VslkU6xBWVbQBqldD6jr0wVQhMXM=;
        b=WsM7k8yu5fQNl+uEb3Pp8bLokTw3NngU0NXWzGEmmcz7/sj2ZkMtL8sciw9NY7rUG1
         U0vl6alV5YhjnT3cCzi123Pgud3IFxcFEp6+kvYst7X56L12RlIHTtwf2BKcawNVJkDk
         9dK+rKQpb8sAOcyP8y1+qCKpbcrdNoELl2beqn5cK/n2WkNJCIl4juFERboEZ+asMlWZ
         MRXPodkc71wSPs+TCMD+MhGJuxW9pGCT3sdXQSsuoiM3iY8gu1F9hacclMVverqAGIel
         jlPCN6GjSHmeBoRj7B7A5mv6Ow/CPjU6q79FIYkg2tOziHUFj4Lt6EKre2pXaadZKwVD
         V8Rg==
X-Gm-Message-State: AJcUukfkF+V8FoB5ekCB44BP1tTBFlOuDPF471XRq5IphLfgzx0RXBbk
        GDpmnoIeCteDBUS89Z+bQ+0cAg==
X-Google-Smtp-Source: AHgI3IaG0PXiOVoH6816ZghQm6rlNQr6eYJvHX0E29rnhr+VwbQGmGkPl7qY0/gnAAj1SXPikQOEPw==
X-Received: by 2002:a6b:5902:: with SMTP id n2mr22735307iob.16.1549034664765;
        Fri, 01 Feb 2019 07:24:24 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id t6sm3388898ioc.87.2019.02.01.07.24.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 Feb 2019 07:24:23 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 03/18] block: add bio_set_polled() helper
Date:   Fri,  1 Feb 2019 08:23:59 -0700
Message-Id: <20190201152414.23296-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190201152414.23296-1-axboe@kernel.dk>
References: <20190201152414.23296-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For the upcoming async polled IO, we can't sleep allocating requests.
If we do, then we introduce a deadlock where the submitter already
has async polled IO in-flight, but can't wait for them to complete
since polled requests must be active found and reaped.

Utilize the helper in the blockdev DIRECT_IO code.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/block_dev.c      |  4 ++--
 include/linux/bio.h | 14 ++++++++++++++
 2 files changed, 16 insertions(+), 2 deletions(-)

diff --git a/fs/block_dev.c b/fs/block_dev.c
index f18d076a2596..392e2bfb636f 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -247,7 +247,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 		task_io_account_write(ret);
 	}
 	if (iocb->ki_flags & IOCB_HIPRI)
-		bio.bi_opf |= REQ_HIPRI;
+		bio_set_polled(&bio, iocb);
 
 	qc = submit_bio(&bio);
 	for (;;) {
@@ -415,7 +415,7 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		nr_pages = iov_iter_npages(iter, BIO_MAX_PAGES);
 		if (!nr_pages) {
 			if (iocb->ki_flags & IOCB_HIPRI)
-				bio->bi_opf |= REQ_HIPRI;
+				bio_set_polled(bio, iocb);
 
 			qc = submit_bio(bio);
 			WRITE_ONCE(iocb->ki_cookie, qc);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 7380b094dcca..f6f0a2b3cbc8 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -823,5 +823,19 @@ static inline int bio_integrity_add_page(struct bio *bio, struct page *page,
 
 #endif /* CONFIG_BLK_DEV_INTEGRITY */
 
+/*
+ * Mark a bio as polled. Note that for async polled IO, the caller must
+ * expect -EWOULDBLOCK if we cannot allocate a request (or other resources).
+ * We cannot block waiting for requests on polled IO, as those completions
+ * must be found by the caller. This is different than IRQ driven IO, where
+ * it's safe to wait for IO to complete.
+ */
+static inline void bio_set_polled(struct bio *bio, struct kiocb *kiocb)
+{
+	bio->bi_opf |= REQ_HIPRI;
+	if (!is_sync_kiocb(kiocb))
+		bio->bi_opf |= REQ_NOWAIT;
+}
+
 #endif /* CONFIG_BLOCK */
 #endif /* __LINUX_BIO_H */
-- 
2.17.1

