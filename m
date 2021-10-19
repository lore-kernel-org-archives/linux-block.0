Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA202C433EF
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A85E96134F
	for <linux-block@archiver.kernel.org>; Tue, 19 Oct 2021 21:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbhJSV1C (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 19 Oct 2021 17:27:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbhJSV07 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 19 Oct 2021 17:26:59 -0400
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7155C061765
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:45 -0700 (PDT)
Received: by mail-wm1-x32c.google.com with SMTP id 67-20020a1c1946000000b0030d4c90fa87so5636597wmz.2
        for <linux-block@vger.kernel.org>; Tue, 19 Oct 2021 14:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=N3Wj0OHFHwFZGJdqptazKyvXEmGreuwbNc6lbiDxxRU=;
        b=aPSgmPYCWHFgO3iYQgOC2MuksSqldQpWfH2pCWAyPYvf6gXzgyyLcCoa8LENPz7ORs
         Ms65vmGi/S1/b6ZWxiT3qhAZNY17iDs/dbWPSH4thn19FFjb5fycLId2xImN+ogVJGTP
         OyJa4NP5mteiv1mHJf/5+Vg+XZPVVpzN0b3+jKaJUltinzr3gP1hKmvMrtBAu/9W56/v
         TdqxXVaeODupV1AXZ3c7ztvJ9iptFUS2NzFMD6CWZx+ZpYpdtXp7dalwcAL2umK8AOOp
         WwM83p2PzU3/GbyzZpJ8L0voYR2KFLO3vOzjLZV5kcMRqXI4d7pkuu7mHXuGLoEQuqdA
         vx2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=N3Wj0OHFHwFZGJdqptazKyvXEmGreuwbNc6lbiDxxRU=;
        b=Qszv6x/F1R/shv+ub/1QxMFX3De9CHiFhk0f7qvgIP3+H0O1W/bQ9DD06oArP/x4wx
         rLszBN3mY2Idhaja8fgPPlkcGv4aJ4WfAzLpU3UneJ8ETodW5dJz14/vGWZ8MW5RT8T9
         IFjqSUqjfiW9Wrkozljd/5dy8TqF6q9r7KJgPXe84NPf/D/tp9WN6VWwvyhuKfs2virb
         bBy+e6jI/1LPcsxPcOYmue3vyDt6ae8GtxPezNPnNhqM2vmVKx/qg8x1R7H8AYZTajPA
         qlRHWUM4oLwtr449SbGQFiETU12rWwnUEprBO2FHN/XwmmTw/CNwgiwkjuPQZ18GUR14
         xdwQ==
X-Gm-Message-State: AOAM533snoWMu6flXM1SRaX9P/EnkOsxDW7n+vcbjN/2si7Gvib21RYz
        2TvEWYtmfv8uB9zz9PveCGtov/O/c8HcPA==
X-Google-Smtp-Source: ABdhPJzR9YRjEn8X9GpkUWyMa7jgdn1M9EEkj3JAnIjDjEsVA2ZMkfxvIh2hfF7RcZwZw7dYVQ30Lw==
X-Received: by 2002:a7b:c351:: with SMTP id l17mr9029233wmj.120.1634678684146;
        Tue, 19 Oct 2021 14:24:44 -0700 (PDT)
Received: from 127.0.0.1localhost ([185.69.145.194])
        by smtp.gmail.com with ESMTPSA id m14sm216020wms.25.2021.10.19.14.24.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 Oct 2021 14:24:43 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 14/16] block: skip advance when async and not needed
Date:   Tue, 19 Oct 2021 22:24:23 +0100
Message-Id: <48fd2fe9d0367620ceda34b79857892841f18668.1634676157.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1634676157.git.asml.silence@gmail.com>
References: <cover.1634676157.git.asml.silence@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Nobody cares about iov iterators state if we return -EIOCBQUEUED, so as
the we now have __blkdev_direct_IO_async(), which gets pages only once,
we can skip expensive iov_iter_advance(). It's around 1-2% of all CPU
spent.

Signed-off-by: Pavel Begunkov <asml.silence@gmail.com>
---
 block/bio.c         | 13 ++++++++-----
 block/fops.c        |  2 +-
 include/linux/bio.h |  9 ++++++++-
 3 files changed, 17 insertions(+), 7 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 46a87c72d2b4..0ed836e98734 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1058,10 +1058,12 @@ static void __bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 	bio_set_flag(bio, BIO_CLONED);
 }
 
-static int bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
+static int bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter,
+			    bool hint_skip_advance)
 {
 	__bio_iov_bvec_set(bio, iter);
-	iov_iter_advance(iter, iter->count);
+	if (!hint_skip_advance)
+		iov_iter_advance(iter, iter->count);
 	return 0;
 }
 
@@ -1212,14 +1214,15 @@ static int __bio_iov_append_get_pages(struct bio *bio, struct iov_iter *iter)
  * It's intended for direct IO, so doesn't do PSI tracking, the caller is
  * responsible for setting BIO_WORKINGSET if necessary.
  */
-int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
+int bio_iov_iter_get_pages_hint(struct bio *bio, struct iov_iter *iter,
+				bool hint_skip_advance)
 {
 	int ret = 0;
 
 	if (iov_iter_is_bvec(iter)) {
 		if (bio_op(bio) == REQ_OP_ZONE_APPEND)
 			return bio_iov_bvec_set_append(bio, iter);
-		return bio_iov_bvec_set(bio, iter);
+		return bio_iov_bvec_set(bio, iter, hint_skip_advance);
 	}
 
 	do {
@@ -1233,7 +1236,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter)
 	bio_clear_flag(bio, BIO_WORKINGSET);
 	return bio->bi_vcnt ? 0 : ret;
 }
-EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages);
+EXPORT_SYMBOL_GPL(bio_iov_iter_get_pages_hint);
 
 static void submit_bio_wait_endio(struct bio *bio)
 {
diff --git a/block/fops.c b/block/fops.c
index ee27ffbdd018..d4c770c5085b 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -352,7 +352,7 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	dio->flags = 0;
 	dio->iocb = iocb;
 
-	ret = bio_iov_iter_get_pages(bio, iter);
+	ret = bio_iov_iter_get_pages_hint(bio, iter, true);
 	if (unlikely(ret)) {
 		bio->bi_status = BLK_STS_IOERR;
 		bio_endio(bio);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 4043e0774b89..51413fe33720 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -416,7 +416,8 @@ int bio_add_zone_append_page(struct bio *bio, struct page *page,
 			     unsigned int len, unsigned int offset);
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
-int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
+int bio_iov_iter_get_pages_hint(struct bio *bio, struct iov_iter *iter,
+				bool hint_skip_advance);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
@@ -428,6 +429,12 @@ extern void bio_free_pages(struct bio *bio);
 void guard_bio_eod(struct bio *bio);
 void zero_fill_bio(struct bio *bio);
 
+static inline int bio_iov_iter_get_pages(struct bio *bio,
+					 struct iov_iter *iter)
+{
+	return bio_iov_iter_get_pages_hint(bio, iter, false);
+}
+
 static inline void bio_release_pages(struct bio *bio, bool mark_dirty)
 {
 	if (!bio_flagged(bio, BIO_NO_PAGE_REF))
-- 
2.33.1

