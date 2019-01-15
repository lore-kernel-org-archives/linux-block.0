Return-Path: <SRS0=gCKl=PX=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F8DC43387
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:56:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2D0B2070B
	for <linux-block@archiver.kernel.org>; Tue, 15 Jan 2019 02:56:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="d2A7qeDu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727988AbfAOC4L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 14 Jan 2019 21:56:11 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:44433 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727981AbfAOC4J (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 14 Jan 2019 21:56:09 -0500
Received: by mail-pl1-f193.google.com with SMTP id e11so562499plt.11
        for <linux-block@vger.kernel.org>; Mon, 14 Jan 2019 18:56:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=oEF+pnA/FRpVwgmNK0tM84y/kmrmPYkGmk6f6LS/rXc=;
        b=d2A7qeDud021+2iozRx0N/q/8ReDymLRkWQzsPs2hy/QXoid3tkzeKpeDJd4VQVRZj
         rNIdGYOeq2RNCxbS2mHxQwOQ+fR4PfEHY7/2tgbXuMq9fXS7IRzUykmBAWv6xsFOzkpf
         obz9jUK9LAsb4Qu5AAG+G+VySPVW0/OIuDHDXH753oQ2nSzBmInZOE6/zi2W66VuP3TC
         1eetFGAEr1lmklToXas/Do1GmlCtKI/2+o0E2AAySd/HdCzUj1LvxLIUznhv/82nMtJ4
         AE4vKclHCOes9VCLosyOYYRaCFcReNkeltmi7pGXxgjs8dQAyEtLuRVWhatLzpBVJeEg
         qOCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=oEF+pnA/FRpVwgmNK0tM84y/kmrmPYkGmk6f6LS/rXc=;
        b=VhkAH+tp9e0Fgesmn/TKAf9mIIWTEskbtKXFbBXxr+jwEG3xeiymvGQuB3E9mzGGUM
         1Gjk8x/LaaEkH2tzAU7qyQ9/JSV96v5/liPWt2lundDCLH3f8Dp+5BoIdyi0p3ksRZFi
         m+FNUhZZTPKmc6I9EdyHWT5LI8SylRabTptng6sWoeFKhc4QbAaH1mDGWU7AnIrKWPBu
         BZdFuuZDHchFKwW5Q/cvI7pPAB0oRRx2/GJ5q0Lz3z5PHUOVjIP/rFcHAzGen9/iGgLX
         4VtVpQpv1ij9sNnA6VDuecvV6YQBqftlHM+hcevmPGSUNzkdr1kRjJWzYs5ALc6ipC7I
         mpQg==
X-Gm-Message-State: AJcUukebwtO+eGhirqsuzUTPJ3kydBgwzsZ5LNLRb5Hs76G/U9YJKVC9
        /vck57X7zdE/l/MvrNI3pNkmCo68WNx+vQ==
X-Google-Smtp-Source: ALg8bN6p06+HK1G/4eb6IS4ewUxvAznbrnqaLgr7X2e6Z7gocVAB+s6lDpe7GoAFgGozNwEHO0Tdrw==
X-Received: by 2002:a17:902:59c8:: with SMTP id d8mr1788296plj.116.1547520968966;
        Mon, 14 Jan 2019 18:56:08 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id c23sm2415544pfi.83.2019.01.14.18.56.07
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 14 Jan 2019 18:56:08 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org, linux-arch@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 16/16] io_uring: add io_uring_event cache hit information
Date:   Mon, 14 Jan 2019 19:55:31 -0700
Message-Id: <20190115025531.13985-17-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190115025531.13985-1-axboe@kernel.dk>
References: <20190115025531.13985-1-axboe@kernel.dk>
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
index fd89fcecd8e2..4a74a40cd134 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -546,11 +546,16 @@ static void io_fput(struct io_kiocb *req)
 static void io_complete_rw(struct kiocb *kiocb, long res, long res2)
 {
 	struct io_kiocb *req = container_of(kiocb, struct io_kiocb, rw);
+	unsigned ev_flags = 0;
 
 	kiocb_end_write(kiocb);
 
 	io_fput(req);
-	io_cqring_fill_event(req->ctx, req->user_data, res, 0);
+
+	if (res > 0 && (req->flags & REQ_F_FORCE_NONBLOCK))
+		ev_flags = IOCQE_FLAG_CACHEHIT;
+
+	io_cqring_fill_event(req->ctx, req->user_data, res, ev_flags);
 	io_free_req(req);
 }
 
diff --git a/include/uapi/linux/io_uring.h b/include/uapi/linux/io_uring.h
index 3f367be56a9e..71e92026d26c 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -69,6 +69,11 @@ struct io_uring_cqe {
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

