Return-Path: <SRS0=HTWS=QP=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29A74C169C4
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEBE2217D8
	for <linux-block@archiver.kernel.org>; Fri,  8 Feb 2019 17:38:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sJN6o3mJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727859AbfBHRii (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 8 Feb 2019 12:38:38 -0500
Received: from mail-it1-f196.google.com ([209.85.166.196]:39786 "EHLO
        mail-it1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728008AbfBHRfN (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 8 Feb 2019 12:35:13 -0500
Received: by mail-it1-f196.google.com with SMTP id a6so10790568itl.4
        for <linux-block@vger.kernel.org>; Fri, 08 Feb 2019 09:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Ie3XSgY/RoieGTFSahZTNBAOsQCDh/k/ejXusljNQ68=;
        b=sJN6o3mJmvenBwynryEfEP9TCuSGHxg4zqjmJL0X3oZF3V7yLjFqIkoPFICL7P4JzF
         AlLfB19aIqaltgsKjOlvFt/3OVRFAE7L9RivKL5VZpIxUpbbcqk0r65WeqsIghN6hwe9
         zIm5DUinq3kWmqkjOrAMipu5PUzgrErwS9Lpf53bgNnjVevZNJy/OacdKbEOAJXs6FYx
         krgGR0iHxvEmznDz6m+sDXtGSHOLXhdSkhvFQcxVr9HEsEzCZa82k4LHtwtRdvKywRuy
         0c4k6UTGoNDIHfNS3z+vnVSVbUkC7eIuDPqTXHjghbJcbCFZd2AFh626Unq8emSEvO2d
         vwaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Ie3XSgY/RoieGTFSahZTNBAOsQCDh/k/ejXusljNQ68=;
        b=CFL+NblfxMjBPiLa/e3ulQIcWzVSkD7YEZFz7Vx4Wm5f9XtZKHyhG0MkZXpzNzDYf9
         qdmujZynS/DyvYCgOGLa3VyvEsRgwey5mKXN558txT4r99y0//nwRKQ7q2WhUv2+edTh
         qy3JhGa5cVmvMAplvKoFzh7kNj8rOwJyaSPjEWLz/w+Jqkr4mQ3aM7ahUGmF5qX5dfoh
         GkUlY9C5fgq4r6+750Fa3IdSr3Sja6zhQXSATMUQDhaPAqaKRWRl9Y253aDAu1EuAgTT
         Yh3rmWbAm9yKtdiCpLJ9Y8n8Qu+fv7W2aZnAw1kR+cdt9DCOORUdpnJdFHUuDVYffOxW
         xhMg==
X-Gm-Message-State: AHQUAubnFx9EvUD76dWuDNL0vK/VANsMY5l139mpmM4TC8Drj0W38umi
        pWfaww5tAyAeRYtDWdn2ofIvsQ==
X-Google-Smtp-Source: AHgI3IbdiXkkHq+moA+MaupqpOQf2DWt22ywS0cZBJN8SM8h4gbAoXYeNd4t1uMBUBe/31AHgEes9w==
X-Received: by 2002:a24:2208:: with SMTP id o8mr8083242ito.23.1549647312430;
        Fri, 08 Feb 2019 09:35:12 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id f142sm1522627itc.15.2019.02.08.09.35.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 08 Feb 2019 09:35:11 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 19/19] io_uring: add io_uring_event cache hit information
Date:   Fri,  8 Feb 2019 10:34:23 -0700
Message-Id: <20190208173423.27014-20-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190208173423.27014-1-axboe@kernel.dk>
References: <20190208173423.27014-1-axboe@kernel.dk>
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
index 175dac00eb47..48e864de5dca 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -583,11 +583,16 @@ static void io_fput(struct io_kiocb *req)
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

