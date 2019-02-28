Return-Path: <SRS0=9mBv=RD=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA11FC43381
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 21:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7D57C218AE
	for <linux-block@archiver.kernel.org>; Thu, 28 Feb 2019 21:36:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="STqJ3kBH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730072AbfB1Vgs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 28 Feb 2019 16:36:48 -0500
Received: from mail-io1-f67.google.com ([209.85.166.67]:38585 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727775AbfB1Vgs (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 28 Feb 2019 16:36:48 -0500
Received: by mail-io1-f67.google.com with SMTP id p18so17893130ioh.5
        for <linux-block@vger.kernel.org>; Thu, 28 Feb 2019 13:36:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=s4r3IKeU2bKeb+yed6nB7uqZH66NYELE7D70Un3HupY=;
        b=STqJ3kBHRxEAk8qedva5PRItvR1R+NQDSADuYDHancWggYhYWDguaLEU5DLUtM11Nf
         iCu5GUZYsQsxSc5K+qZP8+A5YoHihMk4Gg16NLB5tjtJkkBMhMsNXFu1ZWTgLBu7Y6Wc
         56cc4osrPR9KV5PW5g/ZcqtGuMbnfOQpE2ZmsELh0U1JisIicRTA11lYpUD0b1dN1t+L
         1nsZiSz9+F9XckQg1F1m5eAJicaRCMzOfNdX5JoFoKTZ+/N47IAODY8T/bjRKrIHdMX3
         Y5sfeRtg069r9BVeDPwyXIjFAAZ7F6c8u5O+UKXShh2pDdcalMSTK/Jm+AZYox2yO3D7
         vI4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=s4r3IKeU2bKeb+yed6nB7uqZH66NYELE7D70Un3HupY=;
        b=Ifec8KSf15rUbJcJn03SeLAery7JT+7FxBfPDt6D0HoUt0bs4MWGruRMelYNGftKAb
         0HrggPagusWDI9g8m16eXXNKcjNqu++Zxe/azy8Ws2Stp2nCwYJC+H94EsIBdsi5hSNC
         4K5ya1dtrvMlviuOMhQ2zCLHn/nJ4UIPOT/hB0eSsiVWpLVGv89Agyz6HzaIR/AwdyeJ
         IjIV6EeJdcX3MY3GHVmjT/JEYwJNwC/B+/HdRhfpETO79NOKJ3dCjyy7jL2iflwRknqI
         DIqTcoJfYj6NP/hsH813N8VepljtdDXY4SYg2XiDC8a64NFTu+PJZycL67df2KbQ/Zgx
         fmtg==
X-Gm-Message-State: APjAAAVx8gI9fxSCo+xsUiC+2ERMtPm0FYboo9cTG1hFr8l8HLkOw3Un
        I/JQ0NG5qCosRxElAbtZvs4XJw==
X-Google-Smtp-Source: APXvYqw/5hYeaYZke66pd7zSDw4jxeTOXXbaJK5YZdJIvpINHTK+O0OhBguWyH4RBX0O48U34+rodQ==
X-Received: by 2002:a6b:b5c7:: with SMTP id e190mr943982iof.26.1551389807582;
        Thu, 28 Feb 2019 13:36:47 -0800 (PST)
Received: from x1.localdomain ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id m79sm1376311itm.25.2019.02.28.13.36.45
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 28 Feb 2019 13:36:46 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] iov_iter: add ITER_BVEC_FLAG_NO_REF flag
Date:   Thu, 28 Feb 2019 14:36:41 -0700
Message-Id: <20190228213642.306-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190228213642.306-1-axboe@kernel.dk>
References: <20190228213642.306-1-axboe@kernel.dk>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

For ITER_BVEC, if we're holding on to kernel pages, the caller
doesn't need to grab a reference to the bvec pages, and drop that
same reference on IO completion. This is essentially safe for any
ITER_BVEC, but some use cases end up reusing pages and uncondtionally
dropping a page reference on completion. And example of that is
sendfile(2), that ends up being a splice_in + splice_out on the
pipe pages.

Add a flag that tells us it's fine to not grab a page reference
to the bvec pages, since that caller knows not to drop a reference
when it's done with the pages.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 fs/io_uring.c       |  3 +++
 include/linux/uio.h | 24 +++++++++++++++++++-----
 2 files changed, 22 insertions(+), 5 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index f2df45bd61c3..6bdf280a7fb9 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -869,6 +869,9 @@ static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
 	iov_iter_bvec(iter, rw, imu->bvec, imu->nr_bvecs, offset + len);
 	if (offset)
 		iov_iter_advance(iter, offset);
+
+	/* don't drop a reference to these pages */
+	iter->type |= ITER_BVEC_FLAG_NO_REF;
 	return 0;
 }
 
diff --git a/include/linux/uio.h b/include/linux/uio.h
index ecf584f6b82d..4e926641fa80 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -23,14 +23,23 @@ struct kvec {
 };
 
 enum iter_type {
-	ITER_IOVEC = 0,
-	ITER_KVEC = 2,
-	ITER_BVEC = 4,
-	ITER_PIPE = 8,
-	ITER_DISCARD = 16,
+	/* set if ITER_BVEC doesn't hold a bv_page ref */
+	ITER_BVEC_FLAG_NO_REF = 2,
+
+	/* iter types */
+	ITER_IOVEC = 4,
+	ITER_KVEC = 8,
+	ITER_BVEC = 16,
+	ITER_PIPE = 32,
+	ITER_DISCARD = 64,
 };
 
 struct iov_iter {
+	/*
+	 * Bit 0 is the read/write bit, set if we're writing.
+	 * Bit 1 is the BVEC_FLAG_NO_REF bit, set if type is a bvec and
+	 * the caller isn't expecting to drop a page reference when done.
+	 */
 	unsigned int type;
 	size_t iov_offset;
 	size_t count;
@@ -84,6 +93,11 @@ static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 	return i->type & (READ | WRITE);
 }
 
+static inline bool iov_iter_bvec_no_ref(const struct iov_iter *i)
+{
+	return (i->type & ITER_BVEC_FLAG_NO_REF) != 0;
+}
+
 /*
  * Total number of bytes covered by an iovec.
  *
-- 
2.17.1

