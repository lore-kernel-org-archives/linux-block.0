Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 436ADC433F5
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 12:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F16B610A0
	for <linux-block@archiver.kernel.org>; Wed, 27 Oct 2021 12:21:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241838AbhJ0MYA (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 27 Oct 2021 08:24:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237238AbhJ0MX7 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 27 Oct 2021 08:23:59 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FEC2C061570
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 05:21:33 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id z200so1603360wmc.1
        for <linux-block@vger.kernel.org>; Wed, 27 Oct 2021 05:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=9pO6D7cQueBQZGbkr1DMJ0+9BSyr2Nbj9PUyzZfSxnI=;
        b=OCLk8CQIy/e+HNbJ+Q+QrX6pG+KIUBehRuSWhE7qba2odsxedyAzlk3RsR31eRNHQp
         /QxVxRMy/L5cnYHXxOB4mkzDI+teeSWar7KkcPepyN33pAGAZRjpy31L8JNXbBtDvypb
         bWKNZJLg4ApmxO58FmnSn1yEOcq9MBR8zAL2TgW5K4I/LsSANNlm8S12tZ8/xly2Aroj
         ZhsYleaU03TJCGvkFOP4ild8Yx1mB+vutUYfTdRVCUkJ59ct4ukcTMLmxwlNA01rUtqK
         eMjpUJ+IZMdPNEa6QatiwfPDi4RCuvDv3S4HkbEi3OpEHywK9ss9f5l5gTtJ9Mw/H6Sz
         pMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=9pO6D7cQueBQZGbkr1DMJ0+9BSyr2Nbj9PUyzZfSxnI=;
        b=cJamwRZymWU0c496oHC8CzXhrSRs5o2r5dgBJ3Q+leZI92AOJudLHvY5P7XqBBXD5i
         rD3tTyzyRAjTK0VfNqTsLCAwLg/Hsh3MQ1ndIaCvsacFRx16JwmRCfNuCLBBaLNiNm2G
         ZI5VMme5KwWfZTGwCs5uU7SLIVtX/2z5YZBpc8J1ZgOMD37DI25uOsZp6tp3grGbkI8V
         5iPTf4MoaxkbKxcFGUkgxsw4gHhjUB83MJ8PUhVrGMJ2k9w5cqFHhlAg5cDbQASIwr6G
         Fd2Q1RwenEzSk4wZkomJu9DDwcCxfwzUWR6fgQw6Ho4xH1Enn7onLCIGm/yCqGGO/YxS
         c/FA==
X-Gm-Message-State: AOAM530/yQWi7PSIPvZL98I/22LQ5lIRftRNYUw40oL5Jiu8It+PbFZB
        nPzvBaNcBWPaMD+UxEqf9wIDw2vp5F4=
X-Google-Smtp-Source: ABdhPJxrDpBoH5jMd6l0sb3Fg/vx1DcK4+p2inPwE+kxy55aYB8IEpPlyvPYhzd1Ki9fqvh0r/juaA==
X-Received: by 2002:a7b:cc07:: with SMTP id f7mr4351487wmh.106.1635337292093;
        Wed, 27 Oct 2021 05:21:32 -0700 (PDT)
Received: from 127.0.0.1localhost ([148.252.132.100])
        by smtp.gmail.com with ESMTPSA id d8sm22738807wrv.80.2021.10.27.05.21.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Oct 2021 05:21:31 -0700 (PDT)
From:   Pavel Begunkov <asml.silence@gmail.com>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>,
        Christoph Hellwig <hch@infradead.org>,
        Pavel Begunkov <asml.silence@gmail.com>
Subject: [PATCH v2 1/4] block: avoid extra iter advance with async iocb
Date:   Wed, 27 Oct 2021 13:21:07 +0100
Message-Id: <a6158edfbfa2ae3bc24aed29a72f035df18fad2f.1635337135.git.asml.silence@gmail.com>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <cover.1635337135.git.asml.silence@gmail.com>
References: <cover.1635337135.git.asml.silence@gmail.com>
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
index a7b328296912..092e5079e827 100644
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
+	if (iov_iter_is_bvec(iter)) {
+		/*
+		 * Users don't rely on the iterator being in any particular
+		 * state for async I/O returning -EIOCBQUEUED, hence we can
+		 * avoid expensive iov_iter_advance(). Bypass
+		 * bio_iov_iter_get_pages() and set the bvec directly.
+		 */
+		bio_iov_bvec_set(bio, iter);
+	} else {
+		ret = bio_iov_iter_get_pages(bio, iter);
+		if (unlikely(ret)) {
+			bio->bi_status = BLK_STS_IOERR;
+			bio_endio(bio);
+			return ret;
+		}
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

