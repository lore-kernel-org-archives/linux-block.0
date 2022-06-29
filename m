Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4ECAC43334
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231730AbiF2Xcr (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231751AbiF2Xcq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:46 -0400
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF820FE4
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:43 -0700 (PDT)
Received: by mail-pj1-f52.google.com with SMTP id dw10-20020a17090b094a00b001ed00a16eb4so1008429pjb.2
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Xw/euZ02PUCFT1s6mVsZBN7kSGZJe43QumBcGutZbKo=;
        b=PESoXh+gVA7rwnM7F9jyqhV4OmQe2kDPiR7ciodUO/W4TyhIZhCgiSkOL1ikTRopjV
         8WIyKu6CyXfvyR+5yInJWKILTW6MGICCAciZIfOb2Zfqu8pakdXe45HGXjoNKTRM/91J
         gPFGvdmt5EA3GNmDtUkBFd1uVAbXYXk08gfDBrqIu1JVzc5ToVr5fSSQqYtMSQxxYfVl
         2YTRTuD530VsLBGgl1UQiZUokmdkpJYINzwgBemKh7x2KhOrFkvPeDwmyvMKGhVW9Fd7
         JclGX5dx16N854IZOeWfqedOuzsl+6Nyo6hVSNhKgUrpwNmU7R+ea0/rJJXc5J1fkyZU
         kumQ==
X-Gm-Message-State: AJIora+gqgfB8gMUlw3tQNliT6mpcMfzDJRa8l974HJWSDHrPY8kxhKg
        wz1VkDISl2Yzaq4S6fDzfjY=
X-Google-Smtp-Source: AGRyM1tgLuhyLwqtzdH8vBcM7LjyvzNLVLLU7Ds/lPxZgZT4ZyGHvBTPCzOo3wZggHLcAfX5Dtldew==
X-Received: by 2002:a17:90a:66c1:b0:1e8:43ae:f7c0 with SMTP id z1-20020a17090a66c100b001e843aef7c0mr6364021pjl.245.1656545563147;
        Wed, 29 Jun 2022 16:32:43 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:42 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Coly Li <colyli@suse.de>
Subject: [PATCH v2 32/63] md/bcache: Combine two uuid_io() arguments
Date:   Wed, 29 Jun 2022 16:31:14 -0700
Message-Id: <20220629233145.2779494-33-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
In-Reply-To: <20220629233145.2779494-1-bvanassche@acm.org>
References: <20220629233145.2779494-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve uniformity in the kernel of handling of request operation and
flags by passing these as a single argument.

Cc: Coly Li <colyli@suse.de>
Signed-off-by: Bart Van Assche <bvanassche@acm.org>
---
 drivers/md/bcache/super.c | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 9dd752d272f6..a2f61a2225d2 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -414,8 +414,8 @@ static void uuid_io_unlock(struct closure *cl)
 	up(&c->uuid_write_mutex);
 }
 
-static void uuid_io(struct cache_set *c, int op, unsigned long op_flags,
-		    struct bkey *k, struct closure *parent)
+static void uuid_io(struct cache_set *c, blk_opf_t opf, struct bkey *k,
+		    struct closure *parent)
 {
 	struct closure *cl = &c->uuid_write;
 	struct uuid_entry *u;
@@ -429,22 +429,22 @@ static void uuid_io(struct cache_set *c, int op, unsigned long op_flags,
 	for (i = 0; i < KEY_PTRS(k); i++) {
 		struct bio *bio = bch_bbio_alloc(c);
 
-		bio->bi_opf = REQ_SYNC | REQ_META | op_flags;
+		bio->bi_opf = opf | REQ_SYNC | REQ_META;
 		bio->bi_iter.bi_size = KEY_SIZE(k) << 9;
 
 		bio->bi_end_io	= uuid_endio;
 		bio->bi_private = cl;
-		bio_set_op_attrs(bio, op, REQ_SYNC|REQ_META|op_flags);
 		bch_bio_map(bio, c->uuids);
 
 		bch_submit_bbio(bio, c, k, i);
 
-		if (op != REQ_OP_WRITE)
+		if ((opf & REQ_OP_MASK) != REQ_OP_WRITE)
 			break;
 	}
 
 	bch_extent_to_text(buf, sizeof(buf), k);
-	pr_debug("%s UUIDs at %s\n", op == REQ_OP_WRITE ? "wrote" : "read", buf);
+	pr_debug("%s UUIDs at %s\n", (opf & REQ_OP_MASK) == REQ_OP_WRITE ?
+		 "wrote" : "read", buf);
 
 	for (u = c->uuids; u < c->uuids + c->nr_uuids; u++)
 		if (!bch_is_zero(u->uuid, 16))
@@ -463,7 +463,7 @@ static char *uuid_read(struct cache_set *c, struct jset *j, struct closure *cl)
 		return "bad uuid pointer";
 
 	bkey_copy(&c->uuid_bucket, k);
-	uuid_io(c, REQ_OP_READ, 0, k, cl);
+	uuid_io(c, REQ_OP_READ, k, cl);
 
 	if (j->version < BCACHE_JSET_VERSION_UUIDv1) {
 		struct uuid_entry_v0	*u0 = (void *) c->uuids;
@@ -511,7 +511,7 @@ static int __uuid_write(struct cache_set *c)
 
 	size =  meta_bucket_pages(&ca->sb) * PAGE_SECTORS;
 	SET_KEY_SIZE(&k.key, size);
-	uuid_io(c, REQ_OP_WRITE, 0, &k.key, &cl);
+	uuid_io(c, REQ_OP_WRITE, &k.key, &cl);
 	closure_sync(&cl);
 
 	/* Only one bucket used for uuid write */
