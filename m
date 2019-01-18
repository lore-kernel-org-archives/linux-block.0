Return-Path: <SRS0=kGct=P2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CE85C43387
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:13:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2812086D
	for <linux-block@archiver.kernel.org>; Fri, 18 Jan 2019 16:13:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="BJoh+Sq2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728121AbfARQNN (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Jan 2019 11:13:13 -0500
Received: from mail-pf1-f195.google.com ([209.85.210.195]:45572 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727587AbfARQNN (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Jan 2019 11:13:13 -0500
Received: by mail-pf1-f195.google.com with SMTP id g62so6801656pfd.12
        for <linux-block@vger.kernel.org>; Fri, 18 Jan 2019 08:13:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4mAP7BjReU2H349vfmTmNTZ8t+6jtk7ue9ku7Z8AMWw=;
        b=BJoh+Sq2eVxX+RxLeR1YbB0Keb04Sf7iBOJeliQOgTgCY5LexdwJMAlejNztIHatbD
         PokEL6M9WMOY7XzDj/2uBXpONCL6ok0RS9a70fhaEyNEKsNqdFwqijGA3Gqa6TQ9i/Yr
         uzZNns7agei5nBMubVCot/DOp1eGKCGHAYD71wfV4J2aRYFbNoXmYPfY2dmCzz2FwuHg
         znNG3ND8xq2q7XTAXXl1+xSabSK/x6smynNPwd/whinAO9hDzq07KzedfcDJ+p+HOQGV
         HS5vsF86xSGnJqfMptCljmFcH1Jt9mt9Phi6lYqEUxKH/n3KBFHD0DS84gNJhbdYnd4O
         OWKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=4mAP7BjReU2H349vfmTmNTZ8t+6jtk7ue9ku7Z8AMWw=;
        b=kUvKsVj+guFnlqcjDsCfoZVDDOkum5PNYnbq1FTTNZtsNr0M3w0hWTJ1/+6TC/5/2i
         tOHlol8bWOyYiptBe7G2tTTOWtBS0u0lYT8yX9nza4b6W0j/rGBoIY5oR+IGP0dB5jO5
         Dv3wTQKxlpJlM0EBc5MeAWErj7KjDMP8tbRRVojEppUF6G/zUMMxDbbqV9HIrSwNo9o5
         J1rpz7axP5NOdcbUV89FOZ7GLA2GcTZXWhS19auhmF/jM2OdR3j1EAPn+epaCIMnPMPJ
         W1rZ8kpgNlWduTRpra5hdq0OmWh5YDnjSbO4xhNbD8Z4wEaMjMmahQIkBBAUVF6wyGA4
         R8EA==
X-Gm-Message-State: AJcUukdQvJoYQ6Fa7MZooclGPxQkWfifhmDT6EJv8fKyPC4XcGuvI73Z
        Km8ukdSKWciKvW+Coghweb3W7g==
X-Google-Smtp-Source: ALg8bN6uAhcqjM0ABX796h1VzJRXLWlQz8K/+nldjaDzGOCRhRUomMFhyjgD9OXjn/IAu2y9BV8cNg==
X-Received: by 2002:a63:6506:: with SMTP id z6mr18299912pgb.334.1547827992178;
        Fri, 18 Jan 2019 08:13:12 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id m20sm5317804pgv.93.2019.01.18.08.13.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 18 Jan 2019 08:13:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 17/17] io_uring: add io_uring_event cache hit information
Date:   Fri, 18 Jan 2019 09:12:25 -0700
Message-Id: <20190118161225.4545-18-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190118161225.4545-1-axboe@kernel.dk>
References: <20190118161225.4545-1-axboe@kernel.dk>
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
index 4709a19d692b..aec7c3db32c5 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -542,11 +542,16 @@ static void io_fput(struct io_kiocb *req)
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
index 60b52c551c87..3b8d623031ad 100644
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

