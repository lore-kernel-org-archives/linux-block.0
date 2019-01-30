Return-Path: <SRS0=rtTj=QG=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D18D1C282D7
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 23:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7F50E20881
	for <linux-block@archiver.kernel.org>; Wed, 30 Jan 2019 23:05:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="RlgNY/Uz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725798AbfA3XFv (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jan 2019 18:05:51 -0500
Received: from mail-it1-f195.google.com ([209.85.166.195]:35638 "EHLO
        mail-it1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725535AbfA3XFv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jan 2019 18:05:51 -0500
Received: by mail-it1-f195.google.com with SMTP id p197so1094423itp.0
        for <linux-block@vger.kernel.org>; Wed, 30 Jan 2019 15:05:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=C9loeLTbSYEse0qSAM98Vwigm+r5TGAaAQSvtzxtn0w=;
        b=RlgNY/Uz9LPQs9gZctxpI3NdMR/mn5eyo4qn0XTGAtdPLQsjSMsv0HuFsmhJjWAfRt
         ozFNTLgDwv6U00GmiJU/JC5SrDDBGUBmqI8UNQp78ig3sRfQFz5Vax5ZkbdTb+lwN3t4
         dcr/HoTCkAHyOMETLcja49dLF7KIUcFjokqJnJS9qk2FGmb8hqBPpYYwfEHKvltaY6ij
         gTM44QQUGkedfmFHTQakV8eEhtRNB//QFi5PyRZiMQvzL7Ig55Xdf3nvJNzXqznV0Sng
         lOnfuu/v2zy+ZRAFxiE/hz305lg2CsaD9lnOaQwOmjASZwBTyEMRh23wpgVFCykuYpss
         Iq1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=C9loeLTbSYEse0qSAM98Vwigm+r5TGAaAQSvtzxtn0w=;
        b=HyC60Kg5romTfGRniyqBbyzVxMZJQnFsxNDqmNNCiR+Y2PcqM6qesv+Gh/NtnIU0bx
         EH5LO9TI00m85y1AuNo4Jom/x/h71h37iTEXcu+yhMLAADFVW/2vtXruRulWCSR9P4LK
         zp++5A9qPDgJMD1SALLducoXUfDl0pEOfNdh8T3sbrZevxyr8+FU2KusAtmwJgywXPCW
         PShNk6MhG5TswkaYgYpyf+g0XWtZT4oTMrUU6roNdG9vyG8prr+orozcElndKFIry+Nf
         aPcFcnaIlYfsxkwDTfrJMLjkV4QGNWvuIqgeG/WbIKx6TpGTxGTnSmk8elk2b3LO6q/8
         7ThQ==
X-Gm-Message-State: AHQUAuZB4E6s6CcJKoCNNnetE2DwLXR4wu3udi7uLZL9sJQbcXnEv/7s
        pE2u0pChuBj2Llg3vNx6pL0BKA==
X-Google-Smtp-Source: AHgI3Iavv500JlJjlDIOWlvH0cmvp4O/HWq09KilAzdRbO/56GyIMYaJa/AxmNGV9yAPwnxZ7WtlIA==
X-Received: by 2002:a24:1115:: with SMTP id 21mr4005266itf.5.1548885376529;
        Wed, 30 Jan 2019 13:56:16 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id 189sm1805081itw.33.2019.01.30.13.56.14
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 30 Jan 2019 13:56:15 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 18/18] io_uring: add io_uring_event cache hit information
Date:   Wed, 30 Jan 2019 14:55:40 -0700
Message-Id: <20190130215540.20871-19-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190130215540.20871-1-axboe@kernel.dk>
References: <20190130215540.20871-1-axboe@kernel.dk>
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
index 99a690f7d539..8f36ccac41f2 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -559,11 +559,16 @@ static void io_fput(struct io_kiocb *req)
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
index d319b2cd6319..6782e4e0464b 100644
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

