Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60209C761A6
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232245AbjC0UOQ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:14:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjC0UON (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:14:13 -0400
Received: from mail-qt1-f176.google.com (mail-qt1-f176.google.com [209.85.160.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 230011BF9
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:26 -0700 (PDT)
Received: by mail-qt1-f176.google.com with SMTP id cj15so2316440qtb.5
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948005;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pVnf9GI1VNVce+UTfVz3CQAGt+fJmIpbfH8UFMjTV9Y=;
        b=X0OPFAQC5zI90eoYmVVxYxCLkuR5Cr7MbqXGe/AE0wFlY8tPPyvJFj3YH25OLCu2gn
         maDSvZ6JXRnjwx2Ls3ucBct8SShgilGcBc42A68GDQXhzYQxMnNLvGpcl1Hu4y6CUnk3
         N+Lov+zHPgkmM1orjUWi0t8zAbZUahJdsu2u/UzIT94Qmf+tAu/2OyjHrxz4A6PSmGTi
         cEtKK+1g96dZ4UxWhDTRP9/tNJO/CNhjkxz1wzjQklC4rY3uMW6zNXfxqJZqAeszJRQx
         ky9FByi4O5tMKR/P/laYQ21wwSYjlD7bnk7Ik4Ju8QQHwrEViKhj42EEpTxwQvLCgeuT
         yq4A==
X-Gm-Message-State: AO0yUKUU64HeJ1cCXxCdEIWdGF7eadSbeV8Yq+ZDU0p1BiaCHo13yY5R
        8CYUhTpZE+/z+7vRECCpIbTL
X-Google-Smtp-Source: AK7set/QhxRjmAYqq9vwOTVV6ZCx9K0pKe5GG2wkdvifb91iLlhC2h6StgNwdnfJ1O/ta0hPff4PHw==
X-Received: by 2002:a05:622a:1a03:b0:3e3:8427:fb56 with SMTP id f3-20020a05622a1a0300b003e38427fb56mr22558795qtb.63.1679948004961;
        Mon, 27 Mar 2023 13:13:24 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id 75-20020a370a4e000000b006ff8a122a1asm11508110qkk.78.2023.03.27.13.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:24 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 11/20] dm bufio: use multi-page bio vector
Date:   Mon, 27 Mar 2023 16:11:34 -0400
Message-Id: <20230327201143.51026-12-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Mikulas Patocka <mpatocka@redhat.com>

The kernel supports multi page bio vector entries, so we can use them
in dm-bufio as an optimization.

Signed-off-by: Mikulas Patocka <mpatocka@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-bufio.c | 24 ++++--------------------
 1 file changed, 4 insertions(+), 20 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index cca43ed13fd1..ae552644a0b4 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1312,19 +1312,14 @@ static void use_bio(struct dm_buffer *b, enum req_op op, sector_t sector,
 {
 	struct bio *bio;
 	char *ptr;
-	unsigned int vec_size, len;
+	unsigned int len;
 
-	vec_size = b->c->block_size >> PAGE_SHIFT;
-	if (unlikely(b->c->sectors_per_block_bits < PAGE_SHIFT - SECTOR_SHIFT))
-		vec_size += 2;
-
-	bio = bio_kmalloc(vec_size, GFP_NOWAIT | __GFP_NORETRY | __GFP_NOWARN);
+	bio = bio_kmalloc(1, GFP_NOWAIT | __GFP_NORETRY | __GFP_NOWARN);
 	if (!bio) {
-dmio:
 		use_dmio(b, op, sector, n_sectors, offset);
 		return;
 	}
-	bio_init(bio, b->c->bdev, bio->bi_inline_vecs, vec_size, op);
+	bio_init(bio, b->c->bdev, bio->bi_inline_vecs, 1, op);
 	bio->bi_iter.bi_sector = sector;
 	bio->bi_end_io = bio_complete;
 	bio->bi_private = b;
@@ -1332,18 +1327,7 @@ static void use_bio(struct dm_buffer *b, enum req_op op, sector_t sector,
 	ptr = (char *)b->data + offset;
 	len = n_sectors << SECTOR_SHIFT;
 
-	do {
-		unsigned int this_step = min((unsigned int)(PAGE_SIZE - offset_in_page(ptr)), len);
-
-		if (!bio_add_page(bio, virt_to_page(ptr), this_step,
-				  offset_in_page(ptr))) {
-			bio_put(bio);
-			goto dmio;
-		}
-
-		len -= this_step;
-		ptr += this_step;
-	} while (len > 0);
+	__bio_add_page(bio, virt_to_page(ptr), len, offset_in_page(ptr));
 
 	submit_bio(bio);
 }
-- 
2.40.0

