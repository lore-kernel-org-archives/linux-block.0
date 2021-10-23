Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 276C5C433F5
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 16:21:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CD4761073
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 16:21:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbhJWQYJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Oct 2021 12:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhJWQYI (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Oct 2021 12:24:08 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04C4FC061714
        for <linux-block@vger.kernel.org>; Sat, 23 Oct 2021 09:21:49 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id u18so382485wrg.5
        for <linux-block@vger.kernel.org>; Sat, 23 Oct 2021 09:21:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1EgAyDTNJczgY/QgtEiRbb/2pP/JWJ0lkUXSaV8aVUk=;
        b=ZLbf0mHJW3xWQZwiGxpN3fhoNcyUcsHPSJ7QdHJzvvJqMsU67s5UlZQCR6ml28PrWO
         8oJiAou3SVcsXjeig9fBJv5HGMB4sR44aS/1U2Eq3Qhb+Ynujnz1Jz7Sm8LCRgwYu1nw
         hjG7myFPLiucAn0HlafBz97MLB2sBvbZSekznH+DHaqyfde3CcBVAMsEmX6/FtJxLAVD
         dDjg0I+LGFV31mKdCYN5EJqhvUlmXsmx9MwDFtqlPRayoDZIlnWUm0tHtZLbDiBIiEpe
         8HW8lgNBxoBsoc+hpz25A2Ukei+MeOOO5+2O1/OrPsNC73lPna2O3YAgAW56+W5JUl3m
         AyqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1EgAyDTNJczgY/QgtEiRbb/2pP/JWJ0lkUXSaV8aVUk=;
        b=NqBguU+RKlDaySrlHwxUXPL/6qnW4/H8Z534x7X5/IdHmglLWGSXljdLNUWps0iD3v
         OI9mta84FxPbHCQGEDdKK5ZF/TfTMueaw2cVd1/By+aRcwCmGvSfbb3qHYl/KvtxGbmG
         a1hj9Ommx9KwZryWqVcvufjk5w2sebXmrfhoQQduUwWuQySaAepBLKYgzFu4xWOpDEx+
         FpC/gU+Plq/kJqZptdQKU/tjTq6XjaIi7DJKDhjKOdMDUyp3gvLbJ9mDCgy8mhxFEJfS
         b7d68gOpnd3r1tcWdDvatJmZThTFaw6t3aaYt6YjuJl3jdgE9nd+hRAW8BpdqPv7jel6
         9lDw==
X-Gm-Message-State: AOAM531YMZ9SNwSvakjXPhKLWGylSosTkkkDQ77FO9eWPlDlUvRyxshZ
        +FPmsmyXvOK1VCXO1SSlp1XgBjKeBh4=
X-Google-Smtp-Source: ABdhPJx9NZz8tzieoIkN4hgClxa3OS+JyAVAXBPZPQoaPTaI8ieKKKpTBQQqMLzjrzWIhim9gKOxKA==
X-Received: by 2002:adf:d1ee:: with SMTP id g14mr9080943wrd.264.1635006107430;
        Sat, 23 Oct 2021 09:21:47 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.133.195])
        by smtp.gmail.com with ESMTPSA id c16sm2174799wrt.43.2021.10.23.09.21.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 09:21:47 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 2/5] block: refactor bio_iov_bvec_set()
Date:   Sat, 23 Oct 2021 17:21:33 +0100
Message-Id: <bcf1ac36fce769a514e19475f3623cd86a1d8b72.1635006010.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1635006010.git.asml.silence@gmail.com>
References: <cover.1635006010.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Combine bio_iov_bvec_set() and bio_iov_bvec_set_append() and let the
caller to do iov_iter_advance(). Also get rid of __bio_iov_bvec_set(),
which was duplicated in the final binary, and replace a weird
iov_iter_truncate() of a temporal iter copy with min() better reflecting
the intention.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c | 37 ++++++++++++++-----------------------
 1 file changed, 14 insertions(+), 23 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 46a87c72d2b4..ead1f8a9ff5e 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1046,36 +1046,27 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
 
-static void __bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
+static void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 {
+	size_t size = iov_iter_count(iter);
+
 	WARN_ON_ONCE(bio->bi_max_vecs);
 
+	if (bio_op(bio) == REQ_OP_ZONE_APPEND) {
+		struct request_queue *q = bdev_get_queue(bio->bi_bdev);
+		size_t max_sectors = queue_max_zone_append_sectors(q);
+
+		size = min(size, max_sectors << SECTOR_SHIFT);
+	}
+
 	bio->bi_vcnt = iter->nr_segs;
 	bio->bi_io_vec = (struct bio_vec *)iter->bvec;
 	bio->bi_iter.bi_bvec_done = iter->iov_offset;
-	bio->bi_iter.bi_size = iter->count;
+	bio->bi_iter.bi_size = size;
 	bio_set_flag(bio, BIO_NO_PAGE_REF);
 	bio_set_flag(bio, BIO_CLONED);
 }
 
-static int bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
-{
-	__bio_iov_bvec_set(bio, iter);
-	iov_iter_advance(iter, iter->count);
-	return 0;
-}
-
-static int bio_iov_bvec_set_append(struct bio *bio, struct iov_iter *iter)
-{
-	struct request_queue *q = bdev_get_queue(bio->bi_bdev);
-	struct iov_iter i = *iter;
-
-	iov_iter_truncate(&i, queue_max_zone_append_sectors(q) << 9);
-	__bio_iov_bvec_set(bio, &i);
-	iov_iter_advance(iter, i.count);
-	return 0;
-}
-
 static void bio_put_pages(struct page **pages, size_t size, size_t off)
 {
 	size_t i, nr = DIV_ROUND_UP(size + (off & ~PAGE_MASK), PAGE_SIZE);
@@ -1217,9 +1208,9 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	int ret = 0;
 
 	if (iov_iter_is_bvec(iter)) {
-		if (bio_op(bio) == REQ_OP_ZONE_APPEND)
-			return bio_iov_bvec_set_append(bio, iter);
-		return bio_iov_bvec_set(bio, iter);
+		bio_iov_bvec_set(bio, iter);
+		iov_iter_advance(iter, bio->bi_iter.bi_size);
+		return 0;
 	}
 
 	do {
-- 
2.33.1

