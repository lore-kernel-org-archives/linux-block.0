Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DC8FCCA47E
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:32:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231737AbiF2Xcs (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231779AbiF2Xcq (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:32:46 -0400
Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 485E526D1
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:45 -0700 (PDT)
Received: by mail-pg1-f169.google.com with SMTP id 68so16757424pgb.10
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:32:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=NHXxAMiyobUlIzDMk6H1ZAEvKKMl9RNeoCGduwS4FSY=;
        b=KJ4N8Xjc5qckr84SZVwkLDmzIV3+oJnaJg5wNzQb9grAizkC8b18wyd48JRdeNu82I
         Wew0E6KZMtoPDaA2mBkuoL9oysuST1b80ugGEHFsAyOoXpPZYYBf9UbzYHeWP0KQvkpI
         dx9qMrP3o+B2cRzNE6pd0gF745Rzl87Mith2CKprovATYmcTaf3cp5wfikExcCtECU/z
         Hw5HVuEiWC/efO/rMcjhQ5JcHfmwFi4jtd0uY1A4dxEnC6rWOjgW98xZn7V7EI9CHk1j
         Ti7FJe7053q3Z+v0grb1JBN14b/e4OHif65g6BfyZBkvOC9VGcdoYPH9qgQVY7zKFybk
         +n7w==
X-Gm-Message-State: AJIora9vCVjsyBiYfYAXXMv5xjtgrUoKUc9rqJzVdGFjdjeCsqwlEkF/
        blXhUTUQvwQTxBd7AKWEqdIR/U5WHZTjfQ==
X-Google-Smtp-Source: AGRyM1uX3B9f61GSpa+1FeuSuomo6m5w+6yrYREjTD57oqfQ4ou7VRH3wo4MhJpDXWUeiUfXRTTHYg==
X-Received: by 2002:a63:a749:0:b0:40c:57e0:86c0 with SMTP id w9-20020a63a749000000b0040c57e086c0mr4988210pgo.265.1656545564561;
        Wed, 29 Jun 2022 16:32:44 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.32.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:32:43 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>,
        Coly Li <colyli@suse.de>
Subject: [PATCH v2 33/63] md/bcache: Combine two prio_io() arguments
Date:   Wed, 29 Jun 2022 16:31:15 -0700
Message-Id: <20220629233145.2779494-34-bvanassche@acm.org>
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
 drivers/md/bcache/super.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index a2f61a2225d2..ba3909bb6bea 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -587,8 +587,7 @@ static void prio_endio(struct bio *bio)
 	closure_put(&ca->prio);
 }
 
-static void prio_io(struct cache *ca, uint64_t bucket, int op,
-		    unsigned long op_flags)
+static void prio_io(struct cache *ca, uint64_t bucket, blk_opf_t opf)
 {
 	struct closure *cl = &ca->prio;
 	struct bio *bio = bch_bbio_alloc(ca->set);
@@ -601,7 +600,7 @@ static void prio_io(struct cache *ca, uint64_t bucket, int op,
 
 	bio->bi_end_io	= prio_endio;
 	bio->bi_private = ca;
-	bio_set_op_attrs(bio, op, REQ_SYNC|REQ_META|op_flags);
+	bio->bi_opf = opf | REQ_SYNC | REQ_META;
 	bch_bio_map(bio, ca->disk_buckets);
 
 	closure_bio_submit(ca->set, bio, &ca->prio);
@@ -661,7 +660,7 @@ int bch_prio_write(struct cache *ca, bool wait)
 		BUG_ON(bucket == -1);
 
 		mutex_unlock(&ca->set->bucket_lock);
-		prio_io(ca, bucket, REQ_OP_WRITE, 0);
+		prio_io(ca, bucket, REQ_OP_WRITE);
 		mutex_lock(&ca->set->bucket_lock);
 
 		ca->prio_buckets[i] = bucket;
@@ -705,7 +704,7 @@ static int prio_read(struct cache *ca, uint64_t bucket)
 			ca->prio_last_buckets[bucket_nr] = bucket;
 			bucket_nr++;
 
-			prio_io(ca, bucket, REQ_OP_READ, 0);
+			prio_io(ca, bucket, REQ_OP_READ);
 
 			if (p->csum !=
 			    bch_crc64(&p->magic, meta_bucket_bytes(&ca->sb) - 8)) {
