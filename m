Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BB15C43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240395AbiGNSIc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239401AbiGNSIa (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:30 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D1166872F
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:28 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id a15so3623946pjs.0
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:28 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lbq/fitNhM4Ab21LAkdwWu4Y433hX3NHm2OxpWEWdI0=;
        b=Hv1x7GF9WvOH4mHyFqs9Oq5YMUsNxIT4SlZCXHS9e1EhHYeZ9Hq/CTq5qYNhFT+/k8
         jNrKmSzSPM0MaKp4Ft/UDCJZedShmk7p6L79o+0woyjk+c/fw1NpTBFTAxu6vdFPBeD3
         ykR0V+OcV/OZcOn3zFvSZtQ6mTkPCGztCLZgl2/bEMex6l4VsZA73KJrEiPpP9LBfbDi
         IkQfh4IcS5Z6P3eOFJ+zaT6IzPXwQGgfpMKAId/CsGKyg1Xo+Ozexxhcvp9fNG5/ucp6
         U8aO7sj0x1vLATZoJzhITI0WZMn0gReb6ejFXB27yNT31UeSbn3Fyw8KkvSIo4j3poUe
         CHKw==
X-Gm-Message-State: AJIora/OoS97t/xcf4E/dk8yrw0Ae4TQcm3ddPPljyOJ4CtpwWbcRW/H
        EMTCwNXWDBu0XKiGs5a5cdE=
X-Google-Smtp-Source: AGRyM1sqm/qjfZT8/2n9leiWtkhOiEmLYNZMMbT0lkJYKCN3qp0MgcT2ze07c65tHJRwcAHGHPBRPw==
X-Received: by 2002:a17:902:c10a:b0:16c:5b27:9d30 with SMTP id 10-20020a170902c10a00b0016c5b279d30mr9232477pli.32.1657822107413;
        Thu, 14 Jul 2022 11:08:27 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:26 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Coly Li <colyli@suse.de>,
        Mingzhe Zou <mingzhe.zou@easystack.cn>
Subject: [PATCH v3 32/63] md/bcache: Combine two uuid_io() arguments
Date:   Thu, 14 Jul 2022 11:06:58 -0700
Message-Id: <20220714180729.1065367-33-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
In-Reply-To: <20220714180729.1065367-1-bvanassche@acm.org>
References: <20220714180729.1065367-1-bvanassche@acm.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Improve uniformity in the kernel of handling of request operation and
flags by passing these as a single argument.

Cc: Coly Li <colyli@suse.de>
Cc: Mingzhe Zou <mingzhe.zou@easystack.cn>
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
