Return-Path: <SRS0=jhC6=X5=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72F82C4360C
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 16:22:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4B0E9222C0
	for <linux-block@archiver.kernel.org>; Fri,  4 Oct 2019 16:22:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="S/ontCGa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729000AbfJDQWc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 4 Oct 2019 12:22:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:42574 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725932AbfJDQWc (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 4 Oct 2019 12:22:32 -0400
Received: by mail-pg1-f196.google.com with SMTP id z12so4014005pgp.9
        for <linux-block@vger.kernel.org>; Fri, 04 Oct 2019 09:22:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=h4yYOigTYDZ45NkeHLdjj91h7KRosbmms/4jLThgxYc=;
        b=S/ontCGarJN2K+2JTCO6AvkKBIpwSsIi25wNBvUKGzyXG2y3Mn9sNx72p6Oyu5M6dN
         nX/Vve/XTdXCYxHW2Dky6aNY7zZs5hhHoJesOIqF3jXggtSKkRy3aLC9hyCvc4cCrCss
         qTzzuTM5YNPmvsz5NwoNi302mZNNR5fPCdhdYh55ZNP+//egkZUCLnm7QQGMRA72vz+D
         9RAnR1Nril7/YrwL6Ago/1xl7PChYMq61GWOm+esn1DLjgc/39PNELvVR41KKJ9gUMGQ
         s+TjIwECXR7rXBC0tYVraBJ9JlrA6x/JsBCgir+BWvQAC7C1rp5+2SPRcmfZmseAz6R0
         vMxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=h4yYOigTYDZ45NkeHLdjj91h7KRosbmms/4jLThgxYc=;
        b=FY39Ff4TGbwJWuUrerVGEG4THkiH1CB7ctNvi5tx9FvYgDXC6GQqebRGsw7LpLsOPr
         ZvtdsS1H0kSEeqzkcveqHoyxjt/E3Ii0QLNv4pQKERIwf2rFNxJ+w8cnPo24p+4ClSEu
         +y4sMqZe4au0diBTtmbQ8IP0ZQ5nMaD3KaTVu9/xif3358r7NghNudjXJ/AjhoZQnKkr
         9/yh0+kzcIYYBfvRvx7ZsmQIBldzuFVWklUAwY4yi/vx4Au6ks578t6vobqTkM9Y4cQc
         z2V5EGCamY8ysUzK6QcNhn9xnXEv4cho8C4YwRIDBLsp8IMjbKk54r7JF1LKx0c9MQs+
         ZYIA==
X-Gm-Message-State: APjAAAUJjwyeOBUIbcm/tNVC3HOMHnKWSm7gbs4C74zWwfojYuyOXVk7
        WRFJ/yhNcE8ZVvQhZ7Zs9WADDSfhwzY6qg==
X-Google-Smtp-Source: APXvYqz7cE5+dcxxNLIQ442baZTwoZcdl39yhFcNv5vtJ9NC+6pCqNKYINoILBODjGA5WM0ACkNhww==
X-Received: by 2002:a62:62c6:: with SMTP id w189mr18097163pfb.235.1570206151474;
        Fri, 04 Oct 2019 09:22:31 -0700 (PDT)
Received: from localhost.localdomain ([2600:380:7548:69cb:e476:ab55:1c76:9921])
        by smtp.gmail.com with ESMTPSA id v20sm994054pgh.89.2019.10.04.09.22.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Oct 2019 09:22:30 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     jmoyer@redhat.com, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] io_uring: allow sparse fixed file sets
Date:   Fri,  4 Oct 2019 10:22:21 -0600
Message-Id: <20191004162222.10390-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20191004162222.10390-1-axboe@kernel.dk>
References: <20191004162222.10390-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

This is in preparation for allowing updates to fixed file sets without
requiring a full unregister+register.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c | 44 ++++++++++++++++++++++++++++++--------------
 1 file changed, 30 insertions(+), 14 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 83a07a47683d..6d4f1394cfca 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -2319,6 +2319,8 @@ static int io_req_set_file(struct io_ring_ctx *ctx, const struct sqe_submit *s,
 		if (unlikely(!ctx->user_files ||
 		    (unsigned) fd >= ctx->nr_user_files))
 			return -EBADF;
+		if (!ctx->user_files[fd])
+			return -EBADF;
 		req->file = ctx->user_files[fd];
 		req->flags |= REQ_F_FIXED_FILE;
 	} else {
@@ -2937,7 +2939,8 @@ static void __io_sqe_files_unregister(struct io_ring_ctx *ctx)
 	int i;
 
 	for (i = 0; i < ctx->nr_user_files; i++)
-		fput(ctx->user_files[i]);
+		if (ctx->user_files[i])
+			fput(ctx->user_files[i]);
 #endif
 }
 
@@ -3001,7 +3004,7 @@ static int __io_sqe_files_scm(struct io_ring_ctx *ctx, int nr, int offset)
 	struct sock *sk = ctx->ring_sock->sk;
 	struct scm_fp_list *fpl;
 	struct sk_buff *skb;
-	int i;
+	int i, nr_files;
 
 	if (!capable(CAP_SYS_RESOURCE) && !capable(CAP_SYS_ADMIN)) {
 		unsigned long inflight = ctx->user->unix_inflight + nr;
@@ -3023,19 +3026,26 @@ static int __io_sqe_files_scm(struct io_ring_ctx *ctx, int nr, int offset)
 	skb->sk = sk;
 	skb->destructor = io_destruct_skb;
 
+	nr_files = 0;
 	fpl->user = get_uid(ctx->user);
 	for (i = 0; i < nr; i++) {
-		fpl->fp[i] = get_file(ctx->user_files[i + offset]);
-		unix_inflight(fpl->user, fpl->fp[i]);
+		if (!ctx->user_files[i + offset])
+			continue;
+		fpl->fp[nr_files] = get_file(ctx->user_files[i + offset]);
+		unix_inflight(fpl->user, fpl->fp[nr_files]);
+		nr_files++;
 	}
 
-	fpl->max = fpl->count = nr;
-	UNIXCB(skb).fp = fpl;
-	refcount_add(skb->truesize, &sk->sk_wmem_alloc);
-	skb_queue_head(&sk->sk_receive_queue, skb);
+	if (nr_files) {
+		fpl->max = fpl->count = nr_files;
+		UNIXCB(skb).fp = fpl;
+		refcount_add(skb->truesize, &sk->sk_wmem_alloc);
+		skb_queue_head(&sk->sk_receive_queue, skb);
 
-	for (i = 0; i < nr; i++)
-		fput(fpl->fp[i]);
+		for (i = 0; i < nr_files; i++)
+			fput(fpl->fp[i]);
+	} else
+		kfree_skb(skb);
 
 	return 0;
 }
@@ -3066,7 +3076,8 @@ static int io_sqe_files_scm(struct io_ring_ctx *ctx)
 		return 0;
 
 	while (total < ctx->nr_user_files) {
-		fput(ctx->user_files[total]);
+		if (ctx->user_files[total])
+			fput(ctx->user_files[total]);
 		total++;
 	}
 
@@ -3097,10 +3108,15 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 	if (!ctx->user_files)
 		return -ENOMEM;
 
-	for (i = 0; i < nr_args; i++) {
+	for (i = 0; i < nr_args; i++, ctx->nr_user_files++) {
 		ret = -EFAULT;
 		if (copy_from_user(&fd, &fds[i], sizeof(fd)))
 			break;
+		/* allow sparse sets */
+		if (fd == -1) {
+			ret = 0;
+			continue;
+		}
 
 		ctx->user_files[i] = fget(fd);
 
@@ -3118,13 +3134,13 @@ static int io_sqe_files_register(struct io_ring_ctx *ctx, void __user *arg,
 			fput(ctx->user_files[i]);
 			break;
 		}
-		ctx->nr_user_files++;
 		ret = 0;
 	}
 
 	if (ret) {
 		for (i = 0; i < ctx->nr_user_files; i++)
-			fput(ctx->user_files[i]);
+			if (ctx->user_files[i])
+				fput(ctx->user_files[i]);
 
 		kfree(ctx->user_files);
 		ctx->user_files = NULL;
-- 
2.17.1

