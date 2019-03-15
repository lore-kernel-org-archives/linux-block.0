Return-Path: <SRS0=+tqK=RS=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42FA8C10F00
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:59:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 78825218AC
	for <linux-block@archiver.kernel.org>; Fri, 15 Mar 2019 14:59:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="WvisMBKb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729319AbfCOO7p (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 15 Mar 2019 10:59:45 -0400
Received: from mail-pf1-f196.google.com ([209.85.210.196]:40141 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727668AbfCOO7p (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 15 Mar 2019 10:59:45 -0400
Received: by mail-pf1-f196.google.com with SMTP id y124so6525003pfy.7
        for <linux-block@vger.kernel.org>; Fri, 15 Mar 2019 07:59:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=BPF7HYIndwYCravUgyQt5YZcBBFvcmqnVAdETebox5w=;
        b=WvisMBKbDsB+smLauX/MDEbJ1706Y11py46IH0eerWwAvAJ9bTtJ1oEdgPbWtGq7nu
         k/g8LcJ/CTUL7e1Rj3cfytt4llW3XQ1SME8m5rQD4ZR15RHrQ1pUlloJoO2NqBWp+2KE
         bYID6HOR1QW7sfq2WdPtDyWu8DxziePduW4buoGqSg4ep/uOXEREDkwsVgT3kgwVwkHF
         /p4oJoo2PjHsMqqQag3AvV7Bg/MFq4ztQ22xhMGs5zzLus1/hR9RwSQ7sQy1po4PeIFo
         JAkLH3/q9iAe95/Ma1cehtfMlDYysX4hZgQXLChGkfPvB3zBmyNXNnL/tzirIbQBATk6
         U6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=BPF7HYIndwYCravUgyQt5YZcBBFvcmqnVAdETebox5w=;
        b=Nd64n7Q3QtX68ADgr78AXCZwA/KVZwPBSGYUALaXvO9AMq5lhLdOBohnp3H5cd9sDs
         mgS/GEC6f5t/3vCSsIeveLV9m99XvmSs0k+bvQQzJx+7VGJhFjSZcEUA50IhRKXA3PGr
         +E/Cbia5Tql4m/NwzjUpkbEne/P6aSaoKz6yUS/3gG6E/oIKFEvu6bTlJJI4Z3heV5/Y
         BDJPc9Dsqf5J4cK+beu8tahUH+S/t6K520sOL0fAh9bf87NbtR187jXTa6P7o08SMRt+
         apO2UV6X1xe8yoiXlIpYKlgrHUwDW/BWVUNvF0Q4Jk2L0ZlR3JpulCKRG/nh3DUEnnH2
         7QDw==
X-Gm-Message-State: APjAAAU/R+xvSO8WT0zmhqhbeN1UGzyUj7h+il9d7bwv4K2zAPGMwWgR
        YuDA5d6IrxZzBlyoSZ/y4K+rnZ73zY2KhA==
X-Google-Smtp-Source: APXvYqxXg87XrVTeTdWlDT7n6CgdvY8C2ocObXBjDXmAHzsUahS75D6fLAfOEDtnRjyxH7JcKzK6sA==
X-Received: by 2002:a62:3890:: with SMTP id f138mr4568373pfa.148.1552661984006;
        Fri, 15 Mar 2019 07:59:44 -0700 (PDT)
Received: from x1.localdomain (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id f28sm4287179pfh.178.2019.03.15.07.59.42
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 15 Mar 2019 07:59:43 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 1/3] iov_iter: add ITER_BVEC_FLAG_NO_REF flag
Date:   Fri, 15 Mar 2019 08:59:36 -0600
Message-Id: <20190315145938.21516-2-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190315145938.21516-1-axboe@kernel.dk>
References: <20190315145938.21516-1-axboe@kernel.dk>
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
index 5be6e4f99a9e..f66a4a5daf35 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -862,6 +862,9 @@ static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
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

