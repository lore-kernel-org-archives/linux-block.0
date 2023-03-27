Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E79F9C6FD1D
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjC0UO1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:14:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjC0UO0 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:14:26 -0400
Received: from mail-qv1-f49.google.com (mail-qv1-f49.google.com [209.85.219.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BEA3C00
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:36 -0700 (PDT)
Received: by mail-qv1-f49.google.com with SMTP id 59so7589111qva.11
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948015;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xis1PZIHxgZc33JUTcnyVvy12Vhl77i8OslXpZXLdgA=;
        b=ieP7hbFbub5hiLTsWAfr55rcpqyCGnVQTT9Ok0Q2V/CUTuj+7sJYZyJi6NP/bJuDEy
         ZaEREWOFMyUBIjOAtxV+cdEwVXpLDbrj2I6l5HRvCNwZ7wSIDDmyFNObsS2Qi1CPIXCi
         z9Ka9vwpSpw6wPVfBHUDfdT3seybodNWqd8Gh2MECg0pruTMQj9NZN3/BU9BFum/cYs+
         SbvHRbMN5u8rIZMyOEdl3GorqwRKq7vUclcfpL+Kcm2ZyxCdhxwjzsEMBWXsHRl3bbT0
         ThE28A83DF6BJNRZ0kh3KwKWyBuMSsepsUt/05NwK6QruFl7aHhf3Rbbw/3naSABep5N
         z0QQ==
X-Gm-Message-State: AAQBX9d1XWYo34TqPv4vMWWQOrcCxl9mcfrofTu94/rgouNMs6yWqwq3
        rMTRSB/nQITaoQsfuKf0UyVT
X-Google-Smtp-Source: AKy350bdI7fPLiZRLW4GPQlt6CDNO3b2uDbMBtu6JVcWz3roMzyEeTD8mnUG2okibZRJCTBwmlMNmw==
X-Received: by 2002:a05:6214:27c6:b0:56b:fb18:adcd with SMTP id ge6-20020a05621427c600b0056bfb18adcdmr19738100qvb.8.1679948015146;
        Mon, 27 Mar 2023 13:13:35 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id cw2-20020ad44dc2000000b005dd8b9345aesm3214903qvb.70.2023.03.27.13.13.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:34 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 17/20] dm bufio: prepare to intelligently size dm_buffer_cache's buffer_trees
Date:   Mon, 27 Mar 2023 16:11:40 -0400
Message-Id: <20230327201143.51026-18-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Add num_locks member to dm_buffer_cache struct and use it rather than
the NR_LOCKS magic value (64).

Next commit will size the dm_buffer_cache's buffer_trees according to
dm_num_sharded_locks().

Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-bufio.c | 48 +++++++++++++++++++++++--------------------
 1 file changed, 26 insertions(+), 22 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index ae552644a0b4..2250799a70e4 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -380,7 +380,6 @@ struct dm_buffer {
  */
 
 #define NR_LOCKS 64
-#define LOCKS_MASK (NR_LOCKS - 1)
 
 struct buffer_tree {
 	struct rw_semaphore lock;
@@ -388,37 +387,38 @@ struct buffer_tree {
 } ____cacheline_aligned_in_smp;
 
 struct dm_buffer_cache {
+	struct lru lru[LIST_SIZE];
 	/*
 	 * We spread entries across multiple trees to reduce contention
 	 * on the locks.
 	 */
+	unsigned int num_locks;
 	struct buffer_tree trees[NR_LOCKS];
-	struct lru lru[LIST_SIZE];
 };
 
-static inline unsigned int cache_index(sector_t block)
+static inline unsigned int cache_index(sector_t block, unsigned int num_locks)
 {
-	return block & LOCKS_MASK;
+	return block & (num_locks - 1);
 }
 
 static inline void cache_read_lock(struct dm_buffer_cache *bc, sector_t block)
 {
-	down_read(&bc->trees[cache_index(block)].lock);
+	down_read(&bc->trees[cache_index(block, bc->num_locks)].lock);
 }
 
 static inline void cache_read_unlock(struct dm_buffer_cache *bc, sector_t block)
 {
-	up_read(&bc->trees[cache_index(block)].lock);
+	up_read(&bc->trees[cache_index(block, bc->num_locks)].lock);
 }
 
 static inline void cache_write_lock(struct dm_buffer_cache *bc, sector_t block)
 {
-	down_write(&bc->trees[cache_index(block)].lock);
+	down_write(&bc->trees[cache_index(block, bc->num_locks)].lock);
 }
 
 static inline void cache_write_unlock(struct dm_buffer_cache *bc, sector_t block)
 {
-	up_write(&bc->trees[cache_index(block)].lock);
+	up_write(&bc->trees[cache_index(block, bc->num_locks)].lock);
 }
 
 /*
@@ -429,13 +429,15 @@ struct lock_history {
 	struct dm_buffer_cache *cache;
 	bool write;
 	unsigned int previous;
+	unsigned int no_previous;
 };
 
 static void lh_init(struct lock_history *lh, struct dm_buffer_cache *cache, bool write)
 {
 	lh->cache = cache;
 	lh->write = write;
-	lh->previous = NR_LOCKS;  /* indicates no previous */
+	lh->no_previous = cache->num_locks;
+	lh->previous = lh->no_previous;
 }
 
 static void __lh_lock(struct lock_history *lh, unsigned int index)
@@ -459,9 +461,9 @@ static void __lh_unlock(struct lock_history *lh, unsigned int index)
  */
 static void lh_exit(struct lock_history *lh)
 {
-	if (lh->previous != NR_LOCKS) {
+	if (lh->previous != lh->no_previous) {
 		__lh_unlock(lh, lh->previous);
-		lh->previous = NR_LOCKS;
+		lh->previous = lh->no_previous;
 	}
 }
 
@@ -471,9 +473,9 @@ static void lh_exit(struct lock_history *lh)
  */
 static void lh_next(struct lock_history *lh, sector_t b)
 {
-	unsigned int index = cache_index(b);
+	unsigned int index = cache_index(b, lh->no_previous); /* no_previous is num_locks */
 
-	if (lh->previous != NR_LOCKS) {
+	if (lh->previous != lh->no_previous) {
 		if (lh->previous != index) {
 			__lh_unlock(lh, lh->previous);
 			__lh_lock(lh, index);
@@ -500,11 +502,13 @@ static struct dm_buffer *list_to_buffer(struct list_head *l)
 	return le_to_buffer(le);
 }
 
-static void cache_init(struct dm_buffer_cache *bc)
+static void cache_init(struct dm_buffer_cache *bc, unsigned int num_locks)
 {
 	unsigned int i;
 
-	for (i = 0; i < NR_LOCKS; i++) {
+	bc->num_locks = num_locks;
+
+	for (i = 0; i < bc->num_locks; i++) {
 		init_rwsem(&bc->trees[i].lock);
 		bc->trees[i].root = RB_ROOT;
 	}
@@ -517,7 +521,7 @@ static void cache_destroy(struct dm_buffer_cache *bc)
 {
 	unsigned int i;
 
-	for (i = 0; i < NR_LOCKS; i++)
+	for (i = 0; i < bc->num_locks; i++)
 		WARN_ON_ONCE(!RB_EMPTY_ROOT(&bc->trees[i].root));
 
 	lru_destroy(&bc->lru[LIST_CLEAN]);
@@ -576,7 +580,7 @@ static struct dm_buffer *cache_get(struct dm_buffer_cache *bc, sector_t block)
 	struct dm_buffer *b;
 
 	cache_read_lock(bc, block);
-	b = __cache_get(&bc->trees[cache_index(block)].root, block);
+	b = __cache_get(&bc->trees[cache_index(block, bc->num_locks)].root, block);
 	if (b) {
 		lru_reference(&b->lru);
 		__cache_inc_buffer(b);
@@ -650,7 +654,7 @@ static struct dm_buffer *__cache_evict(struct dm_buffer_cache *bc, int list_mode
 
 	b = le_to_buffer(le);
 	/* __evict_pred will have locked the appropriate tree. */
-	rb_erase(&b->node, &bc->trees[cache_index(b->block)].root);
+	rb_erase(&b->node, &bc->trees[cache_index(b->block, bc->num_locks)].root);
 
 	return b;
 }
@@ -816,7 +820,7 @@ static bool cache_insert(struct dm_buffer_cache *bc, struct dm_buffer *b)
 
 	cache_write_lock(bc, b->block);
 	BUG_ON(atomic_read(&b->hold_count) != 1);
-	r = __cache_insert(&bc->trees[cache_index(b->block)].root, b);
+	r = __cache_insert(&bc->trees[cache_index(b->block, bc->num_locks)].root, b);
 	if (r)
 		lru_insert(&bc->lru[b->list_mode], &b->lru);
 	cache_write_unlock(bc, b->block);
@@ -842,7 +846,7 @@ static bool cache_remove(struct dm_buffer_cache *bc, struct dm_buffer *b)
 		r = false;
 	} else {
 		r = true;
-		rb_erase(&b->node, &bc->trees[cache_index(b->block)].root);
+		rb_erase(&b->node, &bc->trees[cache_index(b->block, bc->num_locks)].root);
 		lru_remove(&bc->lru[b->list_mode], &b->lru);
 	}
 
@@ -911,7 +915,7 @@ static void cache_remove_range(struct dm_buffer_cache *bc,
 {
 	unsigned int i;
 
-	for (i = 0; i < NR_LOCKS; i++) {
+	for (i = 0; i < bc->num_locks; i++) {
 		down_write(&bc->trees[i].lock);
 		__remove_range(bc, &bc->trees[i].root, begin, end, pred, release);
 		up_write(&bc->trees[i].lock);
@@ -2432,7 +2436,7 @@ struct dm_bufio_client *dm_bufio_client_create(struct block_device *bdev, unsign
 		r = -ENOMEM;
 		goto bad_client;
 	}
-	cache_init(&c->cache);
+	cache_init(&c->cache, NR_LOCKS);
 
 	c->bdev = bdev;
 	c->block_size = block_size;
-- 
2.40.0

