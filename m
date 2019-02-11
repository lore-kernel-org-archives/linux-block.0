Return-Path: <SRS0=vmzB=QS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78812C169C4
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:00:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4485D20863
	for <linux-block@archiver.kernel.org>; Mon, 11 Feb 2019 19:00:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="F9iiiQyF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732948AbfBKTA6 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 11 Feb 2019 14:00:58 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:40312 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728392AbfBKTA6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 11 Feb 2019 14:00:58 -0500
Received: by mail-it1-f195.google.com with SMTP id i2so846514ite.5
        for <linux-block@vger.kernel.org>; Mon, 11 Feb 2019 11:00:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4Bw4VTzlDlYxl2TymrzPZygZAK7hz6x9mRedpfhmojY=;
        b=F9iiiQyFBSgIMahvOkwzarpYXKjBDOuKjiRPWdQpFNB84UEk9544+1ukuvpKwnZOPk
         /Ob9vBeKV6pF2PNiw7XjdpgEzPqidHcDFCDZXljT+qPwXFCwmMfU6QkDpDI06ZocF7VE
         WJCKcCOFE6qd2VptBzg72vDm5f+rxShyguSwBfNVZXmYxFWzfyTTGufxElSg0PsPk+Rh
         ICcav5LboE97T59cXk6dkB3Tjcj+Pncte/utMRYOkyyKzQR0zxGE7Jwf7VZaaGyLLBPT
         j6T8bx8I74fA8b3gvOByJM0+SHUylINVFCm3Hmg8V0PyTHJvdcKcID263ps61b9LP4qe
         DFVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4Bw4VTzlDlYxl2TymrzPZygZAK7hz6x9mRedpfhmojY=;
        b=YAiJBAC6SR6t9tPfcDzBJGF+GDGDiH4mBwkkqd4pbO+3ZrusDeyT86h4m89mFhWcQW
         8XyL7ueOxnBzpzOiiI32FV12FZjaf4mJqjncrdcbr7w72Y72s1zDznmnLEzUDrYSIXsH
         fb5r6qBTNB9gaqkXqoGQATA1Xk5KT4cEJ7qddgoXSv6ID+iFya6n2X9JH5xplaZxerRU
         gWZI4nUUTjsAex7kMPav40uf3DKUFw5lscn8oyi43hKxC4OAeeGM4F0LjGm10iIJPcp5
         EggTP/+LhovVBoxtaudFnXqjQ89W+nlJamvdDwaBc65uoZgMBD26yOC5ysdJPjQ1tUmO
         kLFA==
X-Gm-Message-State: AHQUAuYC24OnzYL+9Z89irwif4LBTnbNU5QCqKnkaqJOPfj3RJ8CKgJf
        1Gh0DdnfhmHRCvvWZcR4sEbOrw==
X-Google-Smtp-Source: AHgI3IZh6mGaXZL8eacHZ+mohVTufoC3HCRLZZNTK/YIl+Wl2ua2TG15fInnrlYCgPVsDjDy8x5YkA==
X-Received: by 2002:a05:660c:b0b:: with SMTP id f11mr587900itk.169.1549911657300;
        Mon, 11 Feb 2019 11:00:57 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id h184sm62446ith.41.2019.02.11.11.00.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 11 Feb 2019 11:00:56 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH] io_uring: add io_uring_event cache hit information
Date:   Mon, 11 Feb 2019 12:00:31 -0700
Message-Id: <20190211190049.7888-3-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190211190049.7888-1-axboe@kernel.dk>
References: <20190211190049.7888-1-axboe@kernel.dk>
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
index 00c7c11ca699..8114723517d6 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -611,11 +611,16 @@ static void io_fput(struct io_kiocb *req)
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
index e23408692118..24906e99fdc7 100644
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

