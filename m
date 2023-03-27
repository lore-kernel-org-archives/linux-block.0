Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8842C761A6
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232443AbjC0UOV (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:14:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232200AbjC0UOU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:14:20 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1B021FDC
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:32 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id h16so3007841qtn.7
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948012;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBN3e8d5Qq0hFXuPFkD52ybusL049Itzx+LBtkZ2VOM=;
        b=V+2bhA9WBWWqxWYYjWNHW0UGNRybuMKby2/pkKPBfjyOm8e9DpFdYbkYGpwGU3747j
         z8Nv9ZQlHq6pPjq3TvO8lzN6tUmQaYlMC47KTYmYAf1hRkwkfBTtRRWG+hxySN333NAA
         4c2mHq6ptS88rxXxzCO912c5gDan573ELCOK3HK3qhCOo2ZFSMn0/4onqdXlDg78lwd0
         8UV1f1x9BEw4AwM+G4/dDo5gS3mC+CBuJTmTuKn2wD82YvBNs233MRKPt+Dheh7+8ezP
         6wHYgMewTvQeo8PH5HXtvXzi25LIEwnBxplEMGbLRKTlrEikbYQvSgtLA7BzpV7m0Qld
         pflA==
X-Gm-Message-State: AO0yUKUUFbkG6Yu4TlFWJwu9XW7ZjO/jaWWrNIEKyuBuPmrv5Ny0cZuh
        m5ZT09w0hh2Hs76u1gY+Klzn
X-Google-Smtp-Source: AK7set/KcR8zPzvyZmCoD66iZdu4uOgZL06cjihbV5XKhpEFExLT5A/6x5Rr5XaBiwEgxAgiHfTc4g==
X-Received: by 2002:ac8:58c6:0:b0:3e3:9199:d27 with SMTP id u6-20020ac858c6000000b003e391990d27mr22314214qta.53.1679948012077;
        Mon, 27 Mar 2023 13:13:32 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id b126-20020ae9eb84000000b007468b183a65sm11345416qkg.30.2023.03.27.13.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:31 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 15/20] dm bio prison v1: add dm_cell_key_has_valid_range
Date:   Mon, 27 Mar 2023 16:11:38 -0400
Message-Id: <20230327201143.51026-16-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Don't have bio_detain() BUG_ON if a dm_cell_key is beyond
BIO_PRISON_MAX_RANGE or spans a boundary.

Update dm-thin.c:build_key() to use dm_cell_key_has_valid_range() which
will do this checking without using BUG_ON. Also update
process_discard_bio() to check the discard bio that DM core passes in
(having first imposed max_discard_granularity based splitting).

dm_cell_key_has_valid_range() will merely WARN_ON_ONCE if it returns
false because if it does: it is programmer error that should be caught
with proper testing. So relax the BUG_ONs to be WARN_ON_ONCE.

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-bio-prison-v1.c | 14 +++++++++-----
 drivers/md/dm-bio-prison-v1.h |  5 +++++
 drivers/md/dm-thin.c          | 21 +++++++++++++++------
 3 files changed, 29 insertions(+), 11 deletions(-)

diff --git a/drivers/md/dm-bio-prison-v1.c b/drivers/md/dm-bio-prison-v1.c
index 2b8af861e5f6..78bb559b521c 100644
--- a/drivers/md/dm-bio-prison-v1.c
+++ b/drivers/md/dm-bio-prison-v1.c
@@ -120,12 +120,17 @@ static unsigned lock_nr(struct dm_cell_key *key)
 	return (key->block_begin >> BIO_PRISON_MAX_RANGE_SHIFT) & LOCK_MASK;
 }
 
-static void check_range(struct dm_cell_key *key)
+bool dm_cell_key_has_valid_range(struct dm_cell_key *key)
 {
-	BUG_ON(key->block_end - key->block_begin > BIO_PRISON_MAX_RANGE);
-	BUG_ON((key->block_begin >> BIO_PRISON_MAX_RANGE_SHIFT) !=
-	       ((key->block_end - 1) >> BIO_PRISON_MAX_RANGE_SHIFT));
+	if (WARN_ON_ONCE(key->block_end - key->block_begin > BIO_PRISON_MAX_RANGE))
+		return false;
+	if (WARN_ON_ONCE((key->block_begin >> BIO_PRISON_MAX_RANGE_SHIFT) !=
+			 (key->block_end - 1) >> BIO_PRISON_MAX_RANGE_SHIFT))
+		return false;
+
+	return true;
 }
+EXPORT_SYMBOL(dm_cell_key_has_valid_range);
 
 static int __bio_detain(struct rb_root *root,
 			struct dm_cell_key *key,
@@ -172,7 +177,6 @@ static int bio_detain(struct dm_bio_prison *prison,
 {
 	int r;
 	unsigned l = lock_nr(key);
-	check_range(key);
 
 	spin_lock_irq(&prison->regions[l].lock);
 	r = __bio_detain(&prison->regions[l].cell, key, inmate, cell_prealloc, cell_result);
diff --git a/drivers/md/dm-bio-prison-v1.h b/drivers/md/dm-bio-prison-v1.h
index 0b8acd6708fb..2a097ed0d85e 100644
--- a/drivers/md/dm-bio-prison-v1.h
+++ b/drivers/md/dm-bio-prison-v1.h
@@ -83,6 +83,11 @@ int dm_get_cell(struct dm_bio_prison *prison,
 		struct dm_bio_prison_cell *cell_prealloc,
 		struct dm_bio_prison_cell **cell_result);
 
+/*
+ * Returns false if key is beyond BIO_PRISON_MAX_RANGE or spans a boundary.
+ */
+bool dm_cell_key_has_valid_range(struct dm_cell_key *key);
+
 /*
  * An atomic op that combines retrieving or creating a cell, and adding a
  * bio to it.
diff --git a/drivers/md/dm-thin.c b/drivers/md/dm-thin.c
index 33ad5695f959..2b13c949bd72 100644
--- a/drivers/md/dm-thin.c
+++ b/drivers/md/dm-thin.c
@@ -118,25 +118,27 @@ enum lock_space {
 	PHYSICAL
 };
 
-static void build_key(struct dm_thin_device *td, enum lock_space ls,
+static bool build_key(struct dm_thin_device *td, enum lock_space ls,
 		      dm_block_t b, dm_block_t e, struct dm_cell_key *key)
 {
 	key->virtual = (ls == VIRTUAL);
 	key->dev = dm_thin_dev_id(td);
 	key->block_begin = b;
 	key->block_end = e;
+
+	return dm_cell_key_has_valid_range(key);
 }
 
 static void build_data_key(struct dm_thin_device *td, dm_block_t b,
 			   struct dm_cell_key *key)
 {
-	build_key(td, PHYSICAL, b, b + 1llu, key);
+	(void) build_key(td, PHYSICAL, b, b + 1llu, key);
 }
 
 static void build_virtual_key(struct dm_thin_device *td, dm_block_t b,
 			      struct dm_cell_key *key)
 {
-	build_key(td, VIRTUAL, b, b + 1llu, key);
+	(void) build_key(td, VIRTUAL, b, b + 1llu, key);
 }
 
 /*----------------------------------------------------------------*/
@@ -1702,7 +1704,8 @@ static void break_up_discard_bio(struct thin_c *tc, dm_block_t begin, dm_block_t
 				<< BIO_PRISON_MAX_RANGE_SHIFT;
 			len = min_t(sector_t, data_end - data_begin, next_boundary - data_begin);
 
-			build_key(tc->td, PHYSICAL, data_begin, data_begin + len, &data_key);
+			/* This key is certainly within range given the above splitting */
+			(void) build_key(tc->td, PHYSICAL, data_begin, data_begin + len, &data_key);
 			if (bio_detain(tc->pool, &data_key, NULL, &data_cell)) {
 				/* contention, we'll give up with this range */
 				data_begin += len;
@@ -1778,8 +1781,13 @@ static void process_discard_bio(struct thin_c *tc, struct bio *bio)
 		return;
 	}
 
-	build_key(tc->td, VIRTUAL, begin, end, &virt_key);
-	if (bio_detain(tc->pool, &virt_key, bio, &virt_cell))
+	if (unlikely(!build_key(tc->td, VIRTUAL, begin, end, &virt_key))) {
+		DMERR_LIMIT("Discard doesn't respect bio prison limits");
+		bio_endio(bio);
+		return;
+	}
+
+	if (bio_detain(tc->pool, &virt_key, bio, &virt_cell)) {
 		/*
 		 * Potential starvation issue: We're relying on the
 		 * fs/application being well behaved, and not trying to
@@ -1788,6 +1796,7 @@ static void process_discard_bio(struct thin_c *tc, struct bio *bio)
 		 * cell will never be granted.
 		 */
 		return;
+	}
 
 	tc->pool->process_discard_cell(tc, virt_cell);
 }
-- 
2.40.0

