Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5C90C77B60
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232071AbjC0UOK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:14:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjC0UOJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:14:09 -0400
Received: from mail-qt1-f175.google.com (mail-qt1-f175.google.com [209.85.160.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1213BA6
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:21 -0700 (PDT)
Received: by mail-qt1-f175.google.com with SMTP id s12so6188811qtx.11
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679948000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dgaYGvMwSGrKRZ2WwE4xFce2cAfLE729BA8da+BNlMU=;
        b=hiwtCD/N/Ui4N4yjROOUzgjGal9lmJHqdhlVfdAdLWepF4ivwcXPLoJOGNc5doC+W4
         yg/xgvLLJ+c06mPfxM4C55qFyJG0ii4E3x8g0OGc1oImSCHkqqnsdIn+ICAkvbtAQmQv
         +xFD1TnZ+4iMNUm9fBodYF2XpA0DO7TqNgAuK6U/P/G74UfojFWbsc6OT3qrAxaBHvUB
         BeRmZ+BS/zrPO9fsR5K4F+iJ51JMimA2oWdtUmsLClU+NbwYOYEW0PnaFvqy+9y7hkYA
         rluLUuO8yn1+E8hcr2MewP+mwEQgavdDa8U4cJPxqF3CKJL+jcGS687bR0KQNiZ45jQi
         lWdA==
X-Gm-Message-State: AO0yUKU92yK2SGQoMHakM9DCEUPIOwHXnc+XSlrNL29LnymNQ2L4Efwf
        Q/BquYjAvWWMUZuUWroxvbok
X-Google-Smtp-Source: AK7set9AVHWFXkb3npjJh0xtSby8NWtVc9+BAEPPLkZMxF17dzC/dc7TdH75nxfrpPvYHfLhi0sMtQ==
X-Received: by 2002:a05:622a:198b:b0:3e2:6a40:5631 with SMTP id u11-20020a05622a198b00b003e26a405631mr22093845qtc.10.1679948000120;
        Mon, 27 Mar 2023 13:13:20 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id t23-20020ac865d7000000b003b635a5d56csm15119212qto.30.2023.03.27.13.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:19 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 08/20] dm bufio: add lock_history optimization for cache iterators
Date:   Mon, 27 Mar 2023 16:11:31 -0400
Message-Id: <20230327201143.51026-9-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Joe Thornber <ejt@redhat.com>

Sometimes it is beneficial to repeatedly get and drop locks as part of
an iteration.  Introduce lock_history struct to help avoid redundant
drop and gets of the same lock.

Optimizes cache_iterate, cache_mark_many and cache_evict.

Signed-off-by: Joe Thornber <ejt@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-bufio.c | 119 +++++++++++++++++++++++++++++++++++++++---
 1 file changed, 111 insertions(+), 8 deletions(-)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 1e000ec73bd6..9ac50024006d 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -421,6 +421,70 @@ static inline void cache_write_unlock(struct dm_buffer_cache *bc, sector_t block
 	up_write(&bc->trees[cache_index(block)].lock);
 }
 
+/*
+ * Sometimes we want to repeatedly get and drop locks as part of an iteration.
+ * This struct helps avoid redundant drop and gets of the same lock.
+ */
+struct lock_history {
+	struct dm_buffer_cache *cache;
+	bool write;
+	unsigned int previous;
+};
+
+static void lh_init(struct lock_history *lh, struct dm_buffer_cache *cache, bool write)
+{
+	lh->cache = cache;
+	lh->write = write;
+	lh->previous = NR_LOCKS;  /* indicates no previous */
+}
+
+static void __lh_lock(struct lock_history *lh, unsigned int index)
+{
+	if (lh->write)
+		down_write(&lh->cache->trees[index].lock);
+	else
+		down_read(&lh->cache->trees[index].lock);
+}
+
+static void __lh_unlock(struct lock_history *lh, unsigned int index)
+{
+	if (lh->write)
+		up_write(&lh->cache->trees[index].lock);
+	else
+		up_read(&lh->cache->trees[index].lock);
+}
+
+/*
+ * Make sure you call this since it will unlock the final lock.
+ */
+static void lh_exit(struct lock_history *lh)
+{
+	if (lh->previous != NR_LOCKS) {
+		__lh_unlock(lh, lh->previous);
+		lh->previous = NR_LOCKS;
+	}
+}
+
+/*
+ * Named 'next' because there is no corresponding
+ * 'up/unlock' call since it's done automatically.
+ */
+static void lh_next(struct lock_history *lh, sector_t b)
+{
+	unsigned int index = cache_index(b);
+
+	if (lh->previous != NR_LOCKS) {
+		if (lh->previous != index) {
+			__lh_unlock(lh, lh->previous);
+			__lh_lock(lh, index);
+			lh->previous = index;
+		}
+	} else {
+		__lh_lock(lh, index);
+		lh->previous = index;
+	}
+}
+
 static inline struct dm_buffer *le_to_buffer(struct lru_entry *le)
 {
 	return container_of(le, struct dm_buffer, lru);
@@ -550,6 +614,7 @@ typedef enum evict_result (*b_predicate)(struct dm_buffer *, void *);
  * predicate the hold_count of the selected buffer will be zero.
  */
 struct evict_wrapper {
+	struct lock_history *lh;
 	b_predicate pred;
 	void *context;
 };
@@ -563,16 +628,19 @@ static enum evict_result __evict_pred(struct lru_entry *le, void *context)
 	struct evict_wrapper *w = context;
 	struct dm_buffer *b = le_to_buffer(le);
 
+	lh_next(w->lh, b->block);
+
 	if (atomic_read(&b->hold_count))
 		return ER_DONT_EVICT;
 
 	return w->pred(b, w->context);
 }
 
-static struct dm_buffer *cache_evict(struct dm_buffer_cache *bc, int list_mode,
-				     b_predicate pred, void *context)
+static struct dm_buffer *__cache_evict(struct dm_buffer_cache *bc, int list_mode,
+				       b_predicate pred, void *context,
+				       struct lock_history *lh)
 {
-	struct evict_wrapper w = {.pred = pred, .context = context};
+	struct evict_wrapper w = {.lh = lh, .pred = pred, .context = context};
 	struct lru_entry *le;
 	struct dm_buffer *b;
 
@@ -587,6 +655,19 @@ static struct dm_buffer *cache_evict(struct dm_buffer_cache *bc, int list_mode,
 	return b;
 }
 
+static struct dm_buffer *cache_evict(struct dm_buffer_cache *bc, int list_mode,
+				     b_predicate pred, void *context)
+{
+	struct dm_buffer *b;
+	struct lock_history lh;
+
+	lh_init(&lh, bc, true);
+	b = __cache_evict(bc, list_mode, pred, context, &lh);
+	lh_exit(&lh);
+
+	return b;
+}
+
 /*--------------*/
 
 /*
@@ -609,12 +690,12 @@ static void cache_mark(struct dm_buffer_cache *bc, struct dm_buffer *b, int list
  * Runs through the lru associated with 'old_mode', if the predicate matches then
  * it moves them to 'new_mode'.  Not threadsafe.
  */
-static void cache_mark_many(struct dm_buffer_cache *bc, int old_mode, int new_mode,
-			    b_predicate pred, void *context)
+static void __cache_mark_many(struct dm_buffer_cache *bc, int old_mode, int new_mode,
+			      b_predicate pred, void *context, struct lock_history *lh)
 {
 	struct lru_entry *le;
 	struct dm_buffer *b;
-	struct evict_wrapper w = {.pred = pred, .context = context};
+	struct evict_wrapper w = {.lh = lh, .pred = pred, .context = context};
 
 	while (true) {
 		le = lru_evict(&bc->lru[old_mode], __evict_pred, &w);
@@ -627,6 +708,16 @@ static void cache_mark_many(struct dm_buffer_cache *bc, int old_mode, int new_mo
 	}
 }
 
+static void cache_mark_many(struct dm_buffer_cache *bc, int old_mode, int new_mode,
+			    b_predicate pred, void *context)
+{
+	struct lock_history lh;
+
+	lh_init(&lh, bc, true);
+	__cache_mark_many(bc, old_mode, new_mode, pred, context, &lh);
+	lh_exit(&lh);
+}
+
 /*--------------*/
 
 /*
@@ -645,8 +736,8 @@ enum it_action {
 
 typedef enum it_action (*iter_fn)(struct dm_buffer *b, void *context);
 
-static void cache_iterate(struct dm_buffer_cache *bc, int list_mode,
-			  iter_fn fn, void *context)
+static void __cache_iterate(struct dm_buffer_cache *bc, int list_mode,
+			    iter_fn fn, void *context, struct lock_history *lh)
 {
 	struct lru *lru = &bc->lru[list_mode];
 	struct lru_entry *le, *first;
@@ -658,6 +749,8 @@ static void cache_iterate(struct dm_buffer_cache *bc, int list_mode,
 	do {
 		struct dm_buffer *b = le_to_buffer(le);
 
+		lh_next(lh, b->block);
+
 		switch (fn(b, context)) {
 		case IT_NEXT:
 			break;
@@ -671,6 +764,16 @@ static void cache_iterate(struct dm_buffer_cache *bc, int list_mode,
 	} while (le != first);
 }
 
+static void cache_iterate(struct dm_buffer_cache *bc, int list_mode,
+			  iter_fn fn, void *context)
+{
+	struct lock_history lh;
+
+	lh_init(&lh, bc, false);
+	__cache_iterate(bc, list_mode, fn, context, &lh);
+	lh_exit(&lh);
+}
+
 /*--------------*/
 
 /*
-- 
2.40.0

