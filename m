Return-Path: <SRS0=8xnz=RR=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66399C4360F
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:44:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3400220854
	for <linux-block@archiver.kernel.org>; Thu, 14 Mar 2019 20:44:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="mK0amnxS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727919AbfCNUov (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Mar 2019 16:44:51 -0400
Received: from mail-it1-f193.google.com ([209.85.166.193]:36847 "EHLO
        mail-it1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727890AbfCNUov (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Mar 2019 16:44:51 -0400
Received: by mail-it1-f193.google.com with SMTP id h9so7347790itl.1
        for <linux-block@vger.kernel.org>; Thu, 14 Mar 2019 13:44:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=G1Jr4tdYvPOZT9iN+F+fcErmHVHIuOwHcm6qKgjAwBo=;
        b=mK0amnxSw+2w7/yYNc0Fn3k7i/v89nbwzu9S/duk9WFSE2unT65ayI4ziOSA0daRZj
         5EyuCl5km3boOh0/Hzeq9kycjMPvvVsidcoJPQXFjp+2CdqY2Ucul0kPcihjIWCIQBdq
         g/WRJqnikUxfxEf1/xQey94oIDFkVBHZN8vYc62c5N0Th+7dnynkkG+IvoXGKChBwEWg
         zRUvSWXNOgr/tCi5PiXR9FCFvRRWXrBc3KmEUnXTGyDv93SWd6ByOShVVO02JR9v4TMD
         rvdT+XUoWdW9lW3U64HXakV5At0rnlVyc9P1PBaxm0K9uhZLYtQFwyN7K+UKfQTWlg9f
         lEcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=G1Jr4tdYvPOZT9iN+F+fcErmHVHIuOwHcm6qKgjAwBo=;
        b=liKTV6kwcpeFWCLLY+kyb4Le6GH4bAG97ijKXsHmG3SEEUM27wvmO0pSsKJTYMjLr+
         +ce5GMnQ9rvn1ZsxkSsu+0pWZZym0MTiX+5p53YydWWpTuALQCvw5k/TSRacCRSCjM7w
         +RCRxEXS2BXmPp3nwAZm50CSjGHpIFkfA8vuf+PGgPsdrzaoBHODN01+BjbO624S9rhV
         JUNyb6s73FYZkl1YL+laPjT96/H+xRJNzJ7eeu3UpvSl/5tMip1U729IflF91wN8T7q0
         ViUFrE8DnyEVF0qrYsVZc4nV8HEPhjPNwJAcl1tJkKOvvz4wfNTDmSRo3KOTpardWCs6
         xQPA==
X-Gm-Message-State: APjAAAU8J704MI0s67bH7of892GmNa833bqHOyqj6CQcKuNB+geoSu5z
        JbBXHsJojavyONKwOjiIX/qRMw==
X-Google-Smtp-Source: APXvYqzt+rpMkTwzHoW03akfTRgMxucZclVWsAIApuPMV1CmRFtFmFbx+ypa4YpGHxFc8uJxgXNlKg==
X-Received: by 2002:a05:660c:6c3:: with SMTP id z3mr291942itk.83.1552596290372;
        Thu, 14 Mar 2019 13:44:50 -0700 (PDT)
Received: from x1.thefacebook.com ([216.160.245.98])
        by smtp.gmail.com with ESMTPSA id w19sm1820538ita.33.2019.03.14.13.44.48
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Mar 2019 13:44:49 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org
Cc:     viro@ZenIV.linux.org.uk, Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 6/8] iov_iter: add ITER_BVEC_FLAG_NO_REF flag
Date:   Thu, 14 Mar 2019 14:44:33 -0600
Message-Id: <20190314204435.7692-7-axboe@kernel.dk>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20190314204435.7692-1-axboe@kernel.dk>
References: <20190314204435.7692-1-axboe@kernel.dk>
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
index 46cf38b8d863..b89f91ab6e32 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -850,6 +850,9 @@ static int io_import_fixed(struct io_ring_ctx *ctx, int rw,
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

