Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 72385C433EF
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:49:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 554E36052B
	for <linux-block@archiver.kernel.org>; Wed, 13 Oct 2021 16:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbhJMQvr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 13 Oct 2021 12:51:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbhJMQvr (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 13 Oct 2021 12:51:47 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A032C061570
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:49:44 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id s3so460748ild.0
        for <linux-block@vger.kernel.org>; Wed, 13 Oct 2021 09:49:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=0WZiUGBpj3AU/DnW4vKsqNt4ePNjbY4e14bB896ZXa8=;
        b=iU2WxsS/k+0R4nBt91557F0kMhEO+o4n+QS9sUoWu+3mnz+oXPWzOj9ANtbkZxV7Wg
         LZht0OIoy9j7eH7rwmd2qpBCtLwRK2GhpttK5Am42vOr2c0cgig1ZhksrxtzD/LH+Kws
         YkVDlUYyfcT7tgeV0cbSMCvSRGyTYk+/lFHJr5v4HnmjBZloSbBFhSlQpHYBp1LHCQn0
         rMttBm1pOmlztVfN2wju3WX2CAYRK97TN4IAUAYxxaSz9Nlqudb5ypnZsIEbQTFX7rMs
         40phQsJfHDhpXPQ9ZBqawKp7UklhhBqYfMFZhp2o4pTQyl+CzNgIZPz8LY/+ODcYvluO
         +apg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=0WZiUGBpj3AU/DnW4vKsqNt4ePNjbY4e14bB896ZXa8=;
        b=mPOZewddGw8v2xRZdeBptmTFvY2szu5niJAi6JJ7vHvpcb0HtgCFLHPV7huXcOMqtX
         gqe4gLMZspjnPK0xTVkSNI6LWB1dBdugzzBIgCfzWYrmLcoBHjGpWEXJyGnbqHTru6f2
         4qO0uDr6jIx2Leia0+yRvcrCU2W4Ze13mfYz1dmbECiqnVXoFHkv8ww7Z7VvUsH9Ob4W
         GkPNEltGxhdC0VE6SkqJ5DZqh5MR8VW2Uu2SXRnVmMFk+ckNQ613R2iZvu3bxXOZMxBX
         0QPQeIgiPUn8G7YLD1lmyEo/FM3WA1wB9OkOyqgd38G+bJw3QFpQ3Hq/wfnbKKJ0Xcf9
         m8Bw==
X-Gm-Message-State: AOAM531Id5sZbdyMpB9GfpJbggFOiHeHGlWgKopmddOGPmUNSI+k3YdJ
        U7KtXLwrmBWs2zsBS4f73svLgJV7Npg=
X-Google-Smtp-Source: ABdhPJwusLsByvq+TFtRRqBH9kYgyPD3y/Xu2D7dArOYxq6l3dIC9MmHKhIN+AF3/btXIEaJ+VJwWQ==
X-Received: by 2002:a92:c7a1:: with SMTP id f1mr67009ilk.263.1634143783252;
        Wed, 13 Oct 2021 09:49:43 -0700 (PDT)
Received: from p1.localdomain ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id v15sm17217ilg.87.2021.10.13.09.49.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Oct 2021 09:49:42 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
To:     linux-block@vger.kernel.org
Cc:     Jens Axboe <axboe@kernel.dk>
Subject: [PATCH 3/4] block: don't bother iter advancing a fully done bio
Date:   Wed, 13 Oct 2021 10:49:36 -0600
Message-Id: <20211013164937.985367-4-axboe@kernel.dk>
X-Mailer: git-send-email 2.33.0
In-Reply-To: <20211013164937.985367-1-axboe@kernel.dk>
References: <20211013164937.985367-1-axboe@kernel.dk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

If we're completing nbytes and nbytes is the size of the bio, don't bother
with calling into the iterator increment helpers. Just clear the bio
size and we're done.

Signed-off-by: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c         |  4 ++--
 include/linux/bio.h | 13 +++++++++++--
 2 files changed, 13 insertions(+), 4 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index a3c9ff23a036..874ff235aff7 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1289,7 +1289,7 @@ EXPORT_SYMBOL(submit_bio_wait);
  *
  * @bio will then represent the remaining, uncompleted portion of the io.
  */
-void bio_advance(struct bio *bio, unsigned bytes)
+void __bio_advance(struct bio *bio, unsigned bytes)
 {
 	if (bio_integrity(bio))
 		bio_integrity_advance(bio, bytes);
@@ -1297,7 +1297,7 @@ void bio_advance(struct bio *bio, unsigned bytes)
 	bio_crypt_advance(bio, bytes);
 	bio_advance_iter(bio, &bio->bi_iter, bytes);
 }
-EXPORT_SYMBOL(bio_advance);
+EXPORT_SYMBOL(__bio_advance);
 
 void bio_copy_data_iter(struct bio *dst, struct bvec_iter *dst_iter,
 			struct bio *src, struct bvec_iter *src_iter)
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 62d684b7dd4c..44b543e7baf6 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -119,6 +119,17 @@ static inline void bio_advance_iter_single(const struct bio *bio,
 		bvec_iter_advance_single(bio->bi_io_vec, iter, bytes);
 }
 
+extern void __bio_advance(struct bio *, unsigned);
+
+static inline void bio_advance(struct bio *bio, unsigned int nbytes)
+{
+	if (nbytes == bio->bi_iter.bi_size) {
+		bio->bi_iter.bi_size = 0;
+		return;
+	}
+	__bio_advance(bio, nbytes);
+}
+
 #define __bio_for_each_segment(bvl, bio, iter, start)			\
 	for (iter = (start);						\
 	     (iter).bi_size &&						\
@@ -381,8 +392,6 @@ static inline int bio_iov_vecs_to_alloc(struct iov_iter *iter, int max_segs)
 struct request_queue;
 
 extern int submit_bio_wait(struct bio *bio);
-extern void bio_advance(struct bio *, unsigned);
-
 extern void bio_init(struct bio *bio, struct bio_vec *table,
 		     unsigned short max_vecs);
 extern void bio_uninit(struct bio *);
-- 
2.33.0

