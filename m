Return-Path: <SRS0=Mgfj=RC=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85AA1C43381
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 20:20:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53885213A2
	for <linux-block@archiver.kernel.org>; Wed, 27 Feb 2019 20:20:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="N6iCyfDD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729994AbfB0UUO (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Feb 2019 15:20:14 -0500
Received: from mail-pf1-f193.google.com ([209.85.210.193]:34674 "EHLO
        mail-pf1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727240AbfB0UUO (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Feb 2019 15:20:14 -0500
Received: by mail-pf1-f193.google.com with SMTP id u9so8548492pfn.1
        for <linux-block@vger.kernel.org>; Wed, 27 Feb 2019 12:20:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZwCQgAWayhCK5mb6gyRTNwhT0ZUL37gK/m9X+xNNO/o=;
        b=N6iCyfDD5XOxZRxt7e9BVeu/3cZuoZ27HakIqY5Dhx0jeZnHGjSxr89i+QDR7kREM2
         hZVsyvHb0zRo0NhB26NEuhe7gVQO+FlkYsvfWSLlyfivcAWWlq3mf4u2YLWQTvsANoxI
         3GakPOG5BeLl1NmTiJOrzdE5CuOMfTJbVmFLbF5Ney6qsUfSPXi4PGMJdOJ2fZRPbJir
         SEIURh5Bk4haW2Tz07VySbEkGh/b5WPfnGiL0h0fW8o81aaqogdVdQiwSJV//FB+h6By
         sGHGcgkuwLtJy8bqBqtK9/X28qounQBjAkFDjEktyOU9hAsGDW4bzsqWDPGFUG6pVA2m
         zoKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=ZwCQgAWayhCK5mb6gyRTNwhT0ZUL37gK/m9X+xNNO/o=;
        b=Dzi/Y0lM9hn6uYTdod0le9V4qV4UU9a+ze/45zaa0exYao0FgwcG0kxcAKIyzMyjIz
         d1ZCtB3fiZRiJUQiWZQSdjyFCc68hguNjCn0a3PVVv5YQWpVjYHJDczO4hkWkAHmzUTp
         sRSAX+u1f3uKFUo0uT87ZdBSPAh7MRfMQm5alAXiMJg93128rpvJffm+CugtqdqXj79s
         IzkYSukwM56uUMNsgUFVcwY7G4kVBjBWg96874HIacy8cWcHpvG7ltmldS4xZ1RxbuRP
         vn5bqbxUT4ME++p8xEfzmTQFXbf4ZjuKnpPKgPfasEhdqEMj/5XulDCeZOLrk2upQk1A
         dhYQ==
X-Gm-Message-State: AHQUAuYx8PSeVaCwFhQ9TZ+CUOHq/ypxaYacyi/ZbADQgNMhbPlAuVDY
        Y3Uvv0MfXlXVxENMVOTSmM7IQA==
X-Google-Smtp-Source: AHgI3IZr4tYfRUOw2Tb22oAXcFDtNo17F70chhMgcWwFzRtkXJ8sJzHKBEUb8ceX9tjpI+tL6OaqgQ==
X-Received: by 2002:a63:cc43:: with SMTP id q3mr4766247pgi.387.1551298813670;
        Wed, 27 Feb 2019 12:20:13 -0800 (PST)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id d23sm22945959pfn.180.2019.02.27.12.20.10
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Feb 2019 12:20:12 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     hch@lst.de, viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/2] iov_iter: add ITER_BVEC_FLAG_NO_REF flag
Date:   Wed, 27 Feb 2019 13:20:05 -0700
Message-Id: <20190227202006.18844-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190227202006.18844-1-axboe@kernel.dk>
References: <20190227202006.18844-1-axboe@kernel.dk>
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
 include/linux/uio.h | 19 ++++++++++++++-----
 2 files changed, 17 insertions(+), 5 deletions(-)

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
index ecf584f6b82d..ecc88378ec40 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -23,11 +23,15 @@ struct kvec {
 };
 
 enum iter_type {
-	ITER_IOVEC = 0,
-	ITER_KVEC = 2,
-	ITER_BVEC = 4,
-	ITER_PIPE = 8,
-	ITER_DISCARD = 16,
+	/* iter types */
+	ITER_IOVEC = 4,
+	ITER_KVEC = 8,
+	ITER_BVEC = 16,
+	ITER_PIPE = 32,
+	ITER_DISCARD = 64,
+
+	/* set if ITER_BVEC doesn't hold a bv_page ref */
+	ITER_BVEC_FLAG_NO_REF = 2,
 };
 
 struct iov_iter {
@@ -84,6 +88,11 @@ static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 	return i->type & (READ | WRITE);
 }
 
+static inline const bool iov_iter_bvec_no_ref(const struct iov_iter *i)
+{
+	return (i->type & ITER_BVEC_FLAG_NO_REF) != 0;
+}
+
 /*
  * Total number of bytes covered by an iovec.
  *
-- 
2.17.1

