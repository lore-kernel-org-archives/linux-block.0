Return-Path: <SRS0=wMCK=QO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C2708C282CC
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9100421916
	for <linux-block@archiver.kernel.org>; Thu,  7 Feb 2019 19:56:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="OZoEPvuy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727341AbfBGT4b (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 7 Feb 2019 14:56:31 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55705 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727328AbfBGT4b (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 7 Feb 2019 14:56:31 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so2906453ith.5
        for <linux-block@vger.kernel.org>; Thu, 07 Feb 2019 11:56:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zS00KhsUXCPDI6cyOnnnPVzCLiZ1I0zI7Brf0oktcjQ=;
        b=OZoEPvuyeIXIgAZho8+iQZvgzNqTiDNbv77R7AuUcrfSndOQA8/EqrS7FdKk/4dIrX
         l9lm3Tnhv5HssZcdXu19WeurFoBJrck0WeHBLp2L7JC5irPXWBi2u38iQf6DdPyHSLXh
         qSGYim3O31Vg5eH5eeXP4kVg0KntQikTNLW6oXuFIZjM/D/mOBxKBYpshfWa5J7NWElw
         jV8xfZDvpz4hM1b0TDZtpRL0YxywH2grM/dGYdkFcyZGpGNdzlmg/Wcc0K+aEKepFTZW
         iamJM7Pqp1chZ1ipUOvDEugq2Gu5caZwc+YG7UWMbjWlNn1IN7MF/KyKYF02g5I0J68g
         /9qg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zS00KhsUXCPDI6cyOnnnPVzCLiZ1I0zI7Brf0oktcjQ=;
        b=O0aAPNphXnbYzlQ42T3Nk3nYQENUxbbjYU+oyIZ8sn02gBrBXzz/uM7U5YGUEbttgz
         QMWtnoaWsHrRF3vgylrHU1+w6KrJkLkuY85WSxU2aPN9/3D+62MUDtL64s+GGWJr5oPv
         CROvoCfOml4+Kpuzxy5nr7/37LSmYp58tXRA/JF59IckgCKjeGnnHWb0YbTdw8CUhok2
         MyZQiFWC81wmvMLf8pTPvU5xrGklEPP4Be3ACdyeP88fyXacJRR0pf7ZHci6bwa8yADJ
         CLXBQlRVoFxr+pbfJobRaGV/RjTgKxOuUN8SZVx3vjuYx4sKuVMGLfK2sbwc5FeSPdmd
         etsw==
X-Gm-Message-State: AHQUAub1dMJD34GEAKyqI3aAd0mVTHjstK3xsmb4XDEblgh9gPToFJVF
        QxswOZPl7ZgkX0H5Ii5K8qj9MQ==
X-Google-Smtp-Source: AHgI3IaRDm+gBKGKuscwZPZQmGuLK/DjJXJg7qKYcJpARVsfandY/V3WBPMksQvGDBex3cQqcICDHQ==
X-Received: by 2002:a6b:d318:: with SMTP id s24mr9548081iob.6.1549569390853;
        Thu, 07 Feb 2019 11:56:30 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y26sm5092782iob.16.2019.02.07.11.56.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 07 Feb 2019 11:56:29 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 18/18] io_uring: add io_uring_event cache hit information
Date:   Thu,  7 Feb 2019 12:55:52 -0700
Message-Id: <20190207195552.22770-19-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190207195552.22770-1-axboe@kernel.dk>
References: <20190207195552.22770-1-axboe@kernel.dk>
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
index af063145f901..69ab3f134b6d 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -579,11 +579,16 @@ static void io_fput(struct io_kiocb *req)
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

