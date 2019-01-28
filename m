Return-Path: <SRS0=89dG=QE=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C103C282C8
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:36:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DF0C821738
	for <linux-block@archiver.kernel.org>; Mon, 28 Jan 2019 21:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="x0mmEuhY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728365AbfA1VgS (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 28 Jan 2019 16:36:18 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:36478 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728366AbfA1VgS (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 28 Jan 2019 16:36:18 -0500
Received: by mail-it1-f193.google.com with SMTP id c9so885979itj.1
        for <linux-block@vger.kernel.org>; Mon, 28 Jan 2019 13:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=fDtRNQpVuq2Zsp4hKnSkKBNwM9rEDomCiPa8xu6Rn4M=;
        b=x0mmEuhYS59nU8QoVtFDcV2og53ko+FnKJPHXub/Y3EjWM358lotTci4e/jSH6Xnv9
         Dr2jq+zU7RX798ChIQdfRefRluA/c7MHX2GE2iJImyliSMHYhf4SYt7JvV8IA0eSzSEf
         8S5mAbZEU3ZGOUTWlWmiB3CqzCIqT/qMP4AyzAZqwJhIs3U0OC7xz9XWAkIQJNWnbwNJ
         bMqq2bcHEPh1f3Xux14qQ3kjqI3jugC0sL8yFMCjS3SJ9vCCgrrqqbCkMoLRYePXSAu/
         wcxEKmTQovOtYu5Q9UUL+pP/pjn5oBz7MdH9PYwvhecXr1b3/Xgg+fbXY4inGznkXGd7
         UHyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=fDtRNQpVuq2Zsp4hKnSkKBNwM9rEDomCiPa8xu6Rn4M=;
        b=rviQUURVccK1QckehKXuImvWtINRSd3mRHhTuZtJ/EOz15a9vicUdNP9Qdv/cV9MmW
         gXRIxttwuK2rCJfMJZk8+u8SAQIPymybXILZMBJoFeu4i/uYbFig59Wf9DBTaAmQahy1
         iVeGD1EdYMwzwcRWe2xiarUXFLRX0qoVjLtIwECiQPDK1X0jX8XMcqz6TqI3X9793m+7
         85qqEujTPYiQ64WCVjLFw6xqUY0gKBANDIzLH5fK9v54fh3HdhYAmv08/R4hepojedug
         wUCE9g0WFpG13MMmWZgn5qxYZ4K5JC5z8sxADfmx3bNwvR3RAvggrgh+gBfQ5uP6HDXc
         REqg==
X-Gm-Message-State: AJcUukc2AxKo5AkImGmcRmFz8bUiX1HW+EY1tigdm70QOpHM1CxVu5fF
        2BtZwcSHW3WsJqrnnzrHzbd8zA==
X-Google-Smtp-Source: ALg8bN6M+kVQuOxgTlII9hKrQMXRkU2b0Y9KUlD/Is4lT7XcIJgiWDitFpVlhPFxR2eR5STecwab7Q==
X-Received: by 2002:a24:9e87:: with SMTP id p129mr10750861itd.148.1548711376818;
        Mon, 28 Jan 2019 13:36:16 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id u25sm13782077iob.23.2019.01.28.13.36.15
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 28 Jan 2019 13:36:16 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-man@vger.kernel.org, linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 18/18] io_uring: add io_uring_event cache hit information
Date:   Mon, 28 Jan 2019 14:35:38 -0700
Message-Id: <20190128213538.13486-19-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190128213538.13486-1-axboe@kernel.dk>
References: <20190128213538.13486-1-axboe@kernel.dk>
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
index 0240e0a04f6a..9b4b4f9d06a5 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -558,11 +558,16 @@ static void io_fput(struct io_kiocb *req)
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
index 39d3d3336dce..589b6402081d 100644
--- a/include/uapi/linux/io_uring.h
+++ b/include/uapi/linux/io_uring.h
@@ -71,6 +71,11 @@ struct io_uring_cqe {
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

