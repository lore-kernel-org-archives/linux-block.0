Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25420C6FD1C
	for <linux-block@archiver.kernel.org>; Fri, 24 Mar 2023 18:00:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231470AbjCXR7o (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 24 Mar 2023 13:59:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232263AbjCXR7a (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 24 Mar 2023 13:59:30 -0400
Received: from mail-qt1-f180.google.com (mail-qt1-f180.google.com [209.85.160.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7228C6A69
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 10:58:00 -0700 (PDT)
Received: by mail-qt1-f180.google.com with SMTP id bz27so2216625qtb.1
        for <linux-block@vger.kernel.org>; Fri, 24 Mar 2023 10:58:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679680629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uz4MQKqyyyXmrhMudVOv+R32y8m1MjTz5D9yPmV0boc=;
        b=ZQ/cVUGNlmmV95zmls7YPU25UeKuzUz/W7oHBD2/M8XJ4oWw3H54/UE4M2hW28Xus8
         ejHHdbpPjH2ymETwG9I8yb7SOlxdnSASIG1kpm0PZBnAEk1VSNnL8OrnjCNXlXjUHJry
         OpjkmFvnYkvnriHod9RvhI8t63GeUjtprc3PGzychLkXSyJnFhmUSXr94NDNBDu2NT73
         ZzNxtfhS/yKI9y2UEUkHK33zNS46moIfPYcjnP2WXlqwAriPFq+gaecJOSE9My129iYi
         sOUi0IWbZh0wvglX6FCnJ2as4NefC83jR9mM1tNKsVBv1ULs89L29N6sBFEqpIou1ms7
         Mf/w==
X-Gm-Message-State: AO0yUKU7t+YrQbyXYqfkk66b/uskTemTNdYTb5usRfmLES+mgn5hAuew
        itWWwK2aYAKjTMWgkXPz7EQ/
X-Google-Smtp-Source: AK7set9fHWCfv+WpbP227HebgcPFG2XPeSL9RTRyiG2kVwcMqW1edMInAthmNNTgnRLcW2xLweTTjA==
X-Received: by 2002:a05:622a:387:b0:3d4:17dc:3fcf with SMTP id j7-20020a05622a038700b003d417dc3fcfmr6176455qtx.5.1679680629263;
        Fri, 24 Mar 2023 10:57:09 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id i22-20020ac860d6000000b003dd8ad765dcsm8040082qtm.76.2023.03.24.10.57.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Mar 2023 10:57:08 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, ejt@redhat.com, mpatocka@redhat.com,
        heinzm@redhat.com, nhuck@google.com, ebiggers@kernel.org,
        keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v2 6/9] dm bufio: use multi-page bio vector
Date:   Fri, 24 Mar 2023 13:56:53 -0400
Message-Id: <20230324175656.85082-7-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230324175656.85082-1-snitzer@kernel.org>
References: <20230324175656.85082-1-snitzer@kernel.org>
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
index b638ddd161b4..927969b31e2f 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -1326,19 +1326,14 @@ static void use_bio(struct dm_buffer *b, enum req_op op, sector_t sector,
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
@@ -1346,18 +1341,7 @@ static void use_bio(struct dm_buffer *b, enum req_op op, sector_t sector,
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

