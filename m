Return-Path: <SRS0=tdSH=PS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A7C1C43387
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6723920665
	for <linux-block@archiver.kernel.org>; Thu, 10 Jan 2019 02:44:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mjbJtvrf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727153AbfAJCot (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 9 Jan 2019 21:44:49 -0500
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36587 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727176AbfAJCos (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 9 Jan 2019 21:44:48 -0500
Received: by mail-pg1-f196.google.com with SMTP id n2so4178806pgm.3
        for <linux-block@vger.kernel.org>; Wed, 09 Jan 2019 18:44:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=NA7bxp3FsqdCNDD3mLzXDoV5LzMApWnvX0Tn1Xg1AHs=;
        b=mjbJtvrf70R1VXZEXb5lfZMvLIy7Esqml9CkARVFQEJX3Q3U84rUlbQqLQreaXMzfj
         VNhpHP6qwqxzLVB9oUnDRycDUNDSybEzsZWFevhaGh4/jUahmTLa2EuREKgk4PNHmc8M
         F9lcYfcf0s+xBlqfcl12Jw1+C1/fEAm5PuNB8GRLu1/ty+6+D3k74ucUJfXvSa/50dwm
         kgwuhvSsojfE31F/IlpgP2t5gw+ea+EhQvDyRu8sCqtzOBsWzoHBfsjdNxqzihC+9V3v
         642fk7p+xp2ADY0vBf5mkwFsm0C0rr6uP2RSpMOMfm+nYtfalxZ9IGo0ZkdJsFZr3uHu
         p7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=NA7bxp3FsqdCNDD3mLzXDoV5LzMApWnvX0Tn1Xg1AHs=;
        b=fwPtmCGu2MoTy7mj1RGwOv5jcKQlB+XNQ4N3RgRSiXyHXZcL7v/68pOg7prrtroOyT
         sPrnyxnp9QmF/W7TMxWwcbd/XjgYAg1J+X5zl8Gy2McU8Xg9EGG+csHysnNTUaTvrYyP
         2MwaQkzE1TTloNX1dNFPFrJcPgbhUyXnTQsuONOx0ljj4Wx5daRMmpC3Vvk2CqmBS8bo
         5b1+gjJrfECsmxMsIizfmifCDprbP5nv9eQwMYtopIWhERU1+m9cyn5XBCd/bWwAywxW
         kYjKxsF+5jiQ7L7C8matr3sNhVq8cIm9GvQiiTlTYSrRrZt5Sbg+nBcennkD34jd24sS
         8pYA==
X-Gm-Message-State: AJcUukeZ9CrYDieEYLGg2mrTxmVslHk/eZHcE2/VNZ/TGP1yDyEWqDQ5
        sjSgAm0/gme9pOTLHQUqlhooZA==
X-Google-Smtp-Source: ALg8bN6UBaTSzG4vSHOJFEwqJkNmGUkFXzeP9UV+qoqmAkpoxyExfL8X8/yVHySLhsODbBAlAXs4Lg==
X-Received: by 2002:a65:4904:: with SMTP id p4mr7812461pgs.384.1547088287516;
        Wed, 09 Jan 2019 18:44:47 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id v15sm105799631pfn.94.2019.01.09.18.44.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jan 2019 18:44:46 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 15/15] io_uring: add io_uring_event cache hit information
Date:   Wed,  9 Jan 2019 19:44:04 -0700
Message-Id: <20190110024404.25372-16-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190110024404.25372-1-axboe@kernel.dk>
References: <20190110024404.25372-1-axboe@kernel.dk>
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
index 6c62329b00ec..f2a603c447ba 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -511,11 +511,16 @@ static void io_fill_cq_error(struct io_ring_ctx *ctx, struct sqe_submit *s,
 static void io_complete_scqring_rw(struct kiocb *kiocb, long res, long res2)
 {
 	struct io_kiocb *iocb = container_of(kiocb, struct io_kiocb, rw);
+	unsigned ev_flags = 0;
 
 	kiocb_end_write(kiocb);
 
 	fput(kiocb->ki_filp);
-	io_cqring_fill_event(iocb->ki_ctx, iocb->ki_index, res, 0);
+
+	if (res > 0 && test_bit(KIOCB_F_FORCE_NONBLOCK, &iocb->ki_flags))
+		ev_flags = IOCQE_FLAG_CACHEHIT;
+
+	io_cqring_fill_event(iocb->ki_ctx, iocb->ki_index, res, ev_flags);
 	io_free_kiocb(iocb);
 }
 
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 9321eb97479d..20e4c22e040d 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -55,6 +55,11 @@ struct io_uring_cqe {
 	__u32	flags;
 };
 
+/*
+ * io_uring_event->flags
+ */
+#define IOCQE_FLAG_CACHEHIT	(1 << 0)	/* IO did not hit media */
+
 /*
  * Magic offsets for the application to mmap the data it needs
  */
-- 
2.17.1

