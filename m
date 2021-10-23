Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A862C433F5
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 16:21:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4BB4461090
	for <linux-block@archiver.kernel.org>; Sat, 23 Oct 2021 16:21:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbhJWQYJ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sat, 23 Oct 2021 12:24:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbhJWQYJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sat, 23 Oct 2021 12:24:09 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2927EC061714
        for <linux-block@vger.kernel.org>; Sat, 23 Oct 2021 09:21:50 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id r7so1753212wrc.10
        for <linux-block@vger.kernel.org>; Sat, 23 Oct 2021 09:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=VuvUv0whHecDeqlvFKkvrtxzrfXxRHmWygKkSMZW+pM=;
        b=Tb7DZF6P3KW9hx4cOdeMQiDpKR+VdeRVD/qEVatLbqFqy2LE3PdA1xLMDiYuW/xO2j
         CgoKh0bkJZrFWXP51nigXeaTJyQdfytGJ4mQH4jx8SSnFqzKi3aippRYvNUeOj3b9LUA
         uKBr8FWoXjW8Tkl1yNkCWAA3bn3gF+ntagU/d2QwJSZxOSS4JwfYQnw6ZXR7yt8cAKW9
         UoAdJtjRQhCroiM/AfKN4GQ0dlx39qJw4KtYanwNP7f3N5uoB742L4+opgYwFd2eM5dZ
         KBF0kKg8c6yDrF9yq/UNR+e/o6eIYmO6Vd8bgUyYGRugefwBlk3qjC4daThfzUcg7OfX
         NEjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=VuvUv0whHecDeqlvFKkvrtxzrfXxRHmWygKkSMZW+pM=;
        b=vo/Hpxbee3ab+AcNJiztJzX16jjUFw85AMkaaM/weNArLe7V70B36iBvm8h0CRBWvm
         qerphsm4nrtmB+8IiSiWE6poio5+wix5zBadc/SJLzQtwf/fE2H2HxE2wfI4gseevFxe
         TVEpU+5dknPT+KDWiDLaRLGHEjyJTKEkdV75/tM8aZTbNMSaot4oi5uUAY3vw1yqaAoQ
         mrRZsVZaNdR6gTOnN5j/kXZQHFnnS9ukb/2p6WM9iVAQRirpdV9OO4k+ybU3xLQl9s90
         QoQaPGifebgD4KROZ/y2y2DL4pzwhg329nRKHkgi0MFGa81SRwJpmCsQN4WV2pfugYH8
         tErA==
X-Gm-Message-State: AOAM530/7or+Y9PANPTX2o6oIvxfzZqXj9vhibp36nv01hHxxW4+ew5Z
        GoXt6o3dH0Fp1ARRhq/c3k0Bu2eu+2M=
X-Google-Smtp-Source: ABdhPJzxdn4o62XnTDS6JmdDUHUg+Y6K+6bQ3mx9SR0+tHw5LcZgp6pkiwxUAZAvmJrzCrvjbcR0UQ==
X-Received: by 2002:a5d:5287:: with SMTP id c7mr8980826wrv.236.1635006108534;
        Sat, 23 Oct 2021 09:21:48 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.133.195])
        by smtp.gmail.com with ESMTPSA id c16sm2174799wrt.43.2021.10.23.09.21.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 Oct 2021 09:21:48 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH 3/5] block: avoid extra iter advance with async iocb
Date:   Sat, 23 Oct 2021 17:21:34 +0100
Message-Id: <aee615ac9cd6804c10c14938d011e0913f751960.1635006010.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1635006010.git.asml.silence@gmail.com>
References: <cover.1635006010.git.asml.silence@gmail.com>
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
 block/bio.c         |  2 +-
 block/fops.c        | 20 +++++++++++++++-----
 include/linux/bio.h |  1 +
 3 files changed, 17 insertions(+), 6 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index ead1f8a9ff5e..15ab0d6d1c06 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1046,7 +1046,7 @@ void __bio_release_pages(struct bio *bio, bool mark_dirty)
 }
 EXPORT_SYMBOL_GPL(__bio_release_pages);
 
-static void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
+void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter)
 {
 	size_t size = iov_iter_count(iter);
 
diff --git a/block/fops.c b/block/fops.c
index a7b328296912..8800b0ad5c29 100644
--- a/block/fops.c
+++ b/block/fops.c
@@ -352,11 +352,21 @@ static ssize_t __blkdev_direct_IO_async(struct kiocb *iocb,
 	bio->bi_end_io = blkdev_bio_end_io_async;
 	bio->bi_ioprio = iocb->ki_ioprio;
 
-	ret = bio_iov_iter_get_pages(bio, iter);
-	if (unlikely(ret)) {
-		bio->bi_status = BLK_STS_IOERR;
-		bio_endio(bio);
-		return ret;
+	if (!iov_iter_is_bvec(iter)) {
+		ret = bio_iov_iter_get_pages(bio, iter);
+		if (unlikely(ret)) {
+			bio->bi_status = BLK_STS_IOERR;
+			bio_endio(bio);
+			return ret;
+		}
+	} else {
+		/*
+		 * Users don't rely on the iterator being in any particular
+		 * state for async I/O returning -EIOCBQUEUED, hence we can
+		 * avoid expensive iov_iter_advance(). Bypass
+		 * bio_iov_iter_get_pages() and set the bvec directly.
+		 */
+		bio_iov_bvec_set(bio, iter);
 	}
 	dio->size = bio->bi_iter.bi_size;
 
diff --git a/include/linux/bio.h b/include/linux/bio.h
index c88700d1bdc3..fe6bdfbbef66 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -417,6 +417,7 @@ int bio_add_zone_append_page(struct bio *bio, struct page *page,
 void __bio_add_page(struct bio *bio, struct page *page,
 		unsigned int len, unsigned int off);
 int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
+void bio_iov_bvec_set(struct bio *bio, struct iov_iter *iter);
 void __bio_release_pages(struct bio *bio, bool mark_dirty);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
-- 
2.33.1

