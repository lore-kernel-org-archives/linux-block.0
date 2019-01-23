Return-Path: <SRS0=btbQ=P7=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52E89C282C0
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:36:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 234002184C
	for <linux-block@archiver.kernel.org>; Wed, 23 Jan 2019 15:36:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RaXomNCo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726313AbfAWPgX (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 23 Jan 2019 10:36:23 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:36094 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726274AbfAWPgV (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 23 Jan 2019 10:36:21 -0500
Received: by mail-pl1-f194.google.com with SMTP id g9so1356279plo.3
        for <linux-block@vger.kernel.org>; Wed, 23 Jan 2019 07:36:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=je9ei4LMcX4NnvUJXJVHh3/Mgly0/gzwZl7hkm7tlLw=;
        b=RaXomNCoJ2Yswo9TBWYMkyKPjvvsMDJOZREfqq7unTabt1u2o3szwOk2Td6rKuN3Km
         vzmiQYpKVRrHeLZIvtdT3mTmrYhT3dM2Z3zGdWV+lRwcVE0Vl1qKtuVpfCRJ6q2SDitI
         aGZHRhmYcjRGLHkO94EKdw1O3Vkn8yw0Vk0axVKA8rqRZobpJ5YFZwvFcU2Kt1IwhC1n
         cbaHxgQrsZ84tgUXEf6T+kS7618IGmnNdClbv6OHkcX/9BTw5shZVi4fyQ9AqKpbrpoe
         yU0HXuHFFbDF+SoZfl2HHdmAUQBoOxET/xfQYKoZL+DzHhxbrZYkCY8K0AO0g/Ruvc7C
         bWzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=je9ei4LMcX4NnvUJXJVHh3/Mgly0/gzwZl7hkm7tlLw=;
        b=DJck1mV5UdB8+t3pGfSVrgo1pVzQL5kY73Qze4363QZFT4TFU0Hfg6GPn1VmSqe9Om
         3oLTbuJHvvkD3x7XOC08DmzUAz2Uibg/XETTbIU8bA2ChFdm6M2r5lsbhwxFlEtq8+R3
         Ba15S/qD1bZgxm3/BKNhhFIfuoltGPpvgsstNRQruL+R83gJO37uFaYShsEsKOZYZzK+
         934LXpcVcyDkN+cCDY3zbUYG83eW+Y4fTQDZHvj+UxeZWnioJ5rECuL1y4YjPOZWbaHw
         O8ZWb/RuD0nu5NVfaa5FBGvuia/xfCUckjDjQ0VZIVWYKt0doqCWY+4waaEicCqnrI7X
         AHfg==
X-Gm-Message-State: AJcUukep4BJ9aUzyqds4tjgYA+iKarzw/y26IMrLYZwZEXUWFi9rK3S7
        vwaS6qamO1LMTHh4ddQ3f7Op1g==
X-Google-Smtp-Source: ALg8bN7fc7e2N+fGx8Q7cnK25F/hMvwpE2AOSXbVYiO0iPLQ+txWWPis8xfMADwESfuG4K/UfK+THQ==
X-Received: by 2002:a17:902:6683:: with SMTP id e3mr2518543plk.93.1548257781238;
        Wed, 23 Jan 2019 07:36:21 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id u8sm30731715pfl.16.2019.01.23.07.36.19
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Jan 2019 07:36:20 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
        linux-block@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 13/13] io_uring: add io_uring_event cache hit information
Date:   Wed, 23 Jan 2019 08:35:31 -0700
Message-Id: <20190123153536.7081-21-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190123153536.7081-1-axboe@kernel.dk>
References: <20190123153536.7081-1-axboe@kernel.dk>
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
index aa903fa902d5..a40b1af356e0 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -561,11 +561,16 @@ static void io_fput(struct io_kiocb *req)
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

