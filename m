Return-Path: <SRS0=rnrW=QF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D823FC282C7
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AAF7920989
	for <linux-block@archiver.kernel.org>; Tue, 29 Jan 2019 19:27:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="AYeBxnkj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729314AbfA2T1m (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jan 2019 14:27:42 -0500
Received: from mail-it1-f193.google.com ([209.85.166.193]:55801 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729290AbfA2T1m (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jan 2019 14:27:42 -0500
Received: by mail-it1-f193.google.com with SMTP id m62so6407245ith.5
        for <linux-block@vger.kernel.org>; Tue, 29 Jan 2019 11:27:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=v5K59bw1CcvKrb+G/lUaoQyAp/SmYB6SVD5uB13D+Z4=;
        b=AYeBxnkjTiqoDyFOH+/fjNAYv2uQ7USeGyjtdQ6D+k3TYs1AId2E6rAOyXrc3PTPoF
         y6X08+65iCh8DdOizHwuv61aiMk7ukESBRDJleBKTKWkFtzZqBB+jOoLzgvXUVZ2B9q3
         nL/Po4T2i9mqlmYZIIdHRCj9RQ8GAKfO9wg5DaTnG7GNfYcm2LkHoJ/Ho19sLGDNetVJ
         yipXamBkGmqQiJ+08VvgJpJbcU8ZDuOTSrk5wPtJevhPMPj26ZfCducfk1YWtR1wo27X
         cv4HQ+54M1wH31ou/kr8fGzPfjcS+jT3A3jtTKFtSZOa1iOViTjZwgpyyPo7Nowg/WkX
         22lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=v5K59bw1CcvKrb+G/lUaoQyAp/SmYB6SVD5uB13D+Z4=;
        b=Pmc6JI2wnnrK0TwT1T6sYOD9SwV8qAosCMBzfdQk6M0BpGW2UOufLfz17R2ejB4Kq4
         D24/daF6+BLculd1er/vYZWTYW65yddScrn1mjUWZdUwZYGXYs8TOYuh6myA/ovBNLoQ
         RMh4zk9uQfsSsI8LHplT+L/vruEokVTxt20eutzugM5XAtE0o5K7wA2FCm1YjKAwZq/V
         o3AwlABpzrYg1M+66tamtfIpCIotDFqlNqDnSUaYngkDDtMHv4yvN7ReL5o1avd//TsD
         tDdvUfRSJagQ8CndRGLsioMhQ3eopoJmgWPLUOrqiopxpkumg2Lj8+/rWofpn8ebID0P
         ct7A==
X-Gm-Message-State: AHQUAua01skNSKDvoIF79i3gWXFKp5dE25ZV+lhiuvUj82fV/3TZoBEX
        cO6qaGAg8pwlmk9UOUJm3hUwlg==
X-Google-Smtp-Source: ALg8bN75VY82GDDitKHpDVSuXJGBxtmX84X04kAgTFd72iDdCek7wL57qMYihAn1bkZEOGJv6Npnag==
X-Received: by 2002:a24:5e05:: with SMTP id h5mr14555404itb.103.1548790061114;
        Tue, 29 Jan 2019 11:27:41 -0800 (PST)
Received: from localhost.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id y3sm15223203iol.55.2019.01.29.11.27.38
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 29 Jan 2019 11:27:40 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-aio@kvack.org, linux-block@vger.kernel.org,
        linux-api@vger.kernel.org
Cc:     hch@lst.de, jmoyer@redhat.com, avi@scylladb.com, jannh@google.com,
        Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 18/18] io_uring: add io_uring_event cache hit information
Date:   Tue, 29 Jan 2019 12:27:02 -0700
Message-Id: <20190129192702.3605-19-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190129192702.3605-1-axboe@kernel.dk>
References: <20190129192702.3605-1-axboe@kernel.dk>
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
index af2519d3e434..c6187a8f62a9 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -551,11 +551,16 @@ static void io_fput(struct io_kiocb *req)
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

