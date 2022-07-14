Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68E08CCA47B
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:08:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239401AbiGNSIc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:08:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240244AbiGNSIb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:08:31 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B37B68735
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:30 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id z12-20020a17090a7b8c00b001ef84000b8bso9374377pjc.1
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:08:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=h3iVpyxY6sHq05vhn1PxSPgRB3CanlMXzBgvnOiLDdQ=;
        b=3qOkaPTERXWQjquqBj2Y5JUg8vbvf9CzkaeVA74it5KvDal8kQQNg6drjKRUagnMjO
         y36gajuJwnbjE0wYlUUfn0hmZ78DLj1io5k8BzlqXoWAt1B0w3OvfyWixLHAHNrvXf4g
         YeJ2YRiSkoQXG/VIh5EUVP0GL30MbtK7FN2Yzq1W8+5Sr5Jum+bBVlhSc3ysq+QlWqUX
         qsjH/63XM+D5V8+5QuXtXiJlG07eOwIQVd2De57KNhgw1pBy0cEO83PSguzAWSzZLOkk
         btLH9BlcpJeQDR7giiS1p5tes2uj+Ka4fBFqp3WBuQrgBrQY82KMaAdeCVj9E35rtqvx
         Il+Q==
X-Gm-Message-State: AJIora9JyyfQKLa8M9o0zYl1TsLG1VNSrcmxhvSJ7HFbk79+u4kvbyt3
        GEgJbXiQqdWSW10E3NrEiLwV4YP/ZzQ=
X-Google-Smtp-Source: AGRyM1snUrsUCxYQsD1siR6GdNINZOy2bMXrSQekFjd6G1JVWG/tyxG0rGbhN93bWkoOM+E6gMUUbg==
X-Received: by 2002:a17:902:e946:b0:16b:d4e1:a405 with SMTP id b6-20020a170902e94600b0016bd4e1a405mr9411751pll.16.1657822109402;
        Thu, 14 Jul 2022 11:08:29 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.08.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:08:28 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Coly Li <colyli@suse.de>,
        Mingzhe Zou <mingzhe.zou@easystack.cn>
Subject: [PATCH v3 33/63] md/bcache: Combine two prio_io() arguments
Date:   Thu, 14 Jul 2022 11:06:59 -0700
Message-Id: <20220714180729.1065367-34-bvanassche@acm.org>
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
