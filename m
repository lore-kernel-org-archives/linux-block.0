Return-Path: <SRS0=Do5T=QQ=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A34AC282CB
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:14:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 57442218D2
	for <linux-block@archiver.kernel.org>; Sat,  9 Feb 2019 21:14:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Zf3rH1Rr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbfBIVOa (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 9 Feb 2019 16:14:30 -0500
Received: from mail-pg1-f195.google.com ([209.85.215.195]:42624 "EHLO
        mail-pg1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727127AbfBIVOa (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 9 Feb 2019 16:14:30 -0500
Received: by mail-pg1-f195.google.com with SMTP id d72so3116665pga.9
        for <linux-block@vger.kernel.org>; Sat, 09 Feb 2019 13:14:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eHudftoFdpR9U9GakcEQGo6b0e8XVcQ+sDDpr03RbLU=;
        b=Zf3rH1RrPfju2u8SaQ42UE4X3CbTDGRVASuyt+436ePtYWKYHJXvJL6uRrSQiCxjz8
         QmrDKHFRt8MvY7Mh2sVddRR9htSMLGUjqjZZaSlq5kYf6UwUTIi+9YhE+RmfEGr411u8
         qbLePfT1SUPSaiJmDoie2s2GzZBXQbgEw4ODUYCXNNDQrXd1uUPYubxlfU0adniussEi
         kjzub0oacNocP2fuPAS8tANsbszoMp4lsbDPV8rpItUpRWdrpi71P9L9CPYHy6dUAVfy
         F/7hpMjV8k1xe2WMBK2wz6pH/rvPJm9I1qIyZRwuM2TPuClXiaZjnYqvDh6UWh+5mTo8
         sKoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eHudftoFdpR9U9GakcEQGo6b0e8XVcQ+sDDpr03RbLU=;
        b=YKygKmvxIH/qUuTeNsV2oE9HvwtbenKho0RltJI2sqoArwZeM0ryhtdjAkIedG2JcH
         w8+AE145SRuApOSB1ti/x50qpJZa5ySjjw/MI7zWqoumJD82iUoZL4H5C5cTd1TcyuhW
         SBb3s1vRtP7bT90twKlgAaIrzHBR7ACiUsvis1LuwUQcaXtgiflgnEMrGr1fy8J9ocRh
         1rY0u2huJjchJMQpF5qUjbN89PFcZNOK2+LiwpgkG5Oyms5QyZm1tHIuIZbHm0r29Uam
         VF4/0nGS8092vkh/1tmylQqaXWIXxyEvfFxLKQ2a2LgUmIp4ceqvRbvlz8lRufVnOcqJ
         MwoQ==
X-Gm-Message-State: AHQUAuZcl+20i0OLNUfIg+genWDL5hdPMvwdTn6eTOnXDpmH6Qz8E/Cg
        wPxCvYgjQy1BQJ6HutMkdP1GyA==
X-Google-Smtp-Source: AHgI3IayYXm15s/pobACwXJ+QhXK1hlLg4YojGDRp79Fvlv7f/Ba6hK3xStj1eyHp5vJ9ZMfuKXRcQ==
X-Received: by 2002:a62:ca48:: with SMTP id n69mr23029273pfg.162.1549746869900;
        Sat, 09 Feb 2019 13:14:29 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id a17sm7004942pgm.26.2019.02.09.13.14.28
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 09 Feb 2019 13:14:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 19/19] io_uring: add io_uring_event cache hit information
Date:   Sat,  9 Feb 2019 14:13:46 -0700
Message-Id: <20190209211346.26060-20-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190209211346.26060-1-axboe@kernel.dk>
References: <20190209211346.26060-1-axboe@kernel.dk>
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
index 11a549b5dcbf..d7a10484d748 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -587,11 +587,16 @@ static void io_fput(struct io_kiocb *req)
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

