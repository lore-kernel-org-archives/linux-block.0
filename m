Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D1DDC77B6E
	for <linux-block@archiver.kernel.org>; Mon, 27 Mar 2023 20:14:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232134AbjC0UOD (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 27 Mar 2023 16:14:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231929AbjC0UOC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 27 Mar 2023 16:14:02 -0400
Received: from mail-qv1-f44.google.com (mail-qv1-f44.google.com [209.85.219.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17BA211E
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:14 -0700 (PDT)
Received: by mail-qv1-f44.google.com with SMTP id jl13so7608756qvb.10
        for <linux-block@vger.kernel.org>; Mon, 27 Mar 2023 13:13:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679947994;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HnRXjPFL8ryVwQIZKj/idU8AtLLYydcfQZ5/bZxBP7E=;
        b=fq4sTO2+62wAlRztKwokTFj/Lv4Myvm/HFc5PVqLDCwpPyxrah80GE9YfHiKLNEiPh
         lPocyoxnIud2ZMr3pYYS7pZaLtkwylenLtD5D2IX8nYVZfmyOgzUCXnr8p6pTzwKr67A
         /PgrBUAUm0KppihrH8rz72DrunV1fntxCqxZothI//aD6ovwIpgzAhCuyp/reTMzDiwD
         kSDr4ddGlEGeekRz1ZgtSExQgcEZvXmJzDmVyM/iCEvVx3FLNk7D0gvt1SRk/kjRbErm
         vVQ9Bh8xej1gO8vCBbjK2+ao6KQzT1JrjuINl7teYOOB8TZMB1rb6i7/EbUTT2E3+MLi
         k77A==
X-Gm-Message-State: AAQBX9dDobLdYBdYJvEr571ddbPcAtWYGYMIAjq9VplMcNX7xu/iAksA
        Og8ScJgfnxaai8qe1m16q4f+
X-Google-Smtp-Source: AKy350aV2shDFEGq+y0+P6CuzF0QHTPYTOXNK5SCBfMQ/nybOe1LXkh957qYAcLDjaI6537aBHt8UA==
X-Received: by 2002:ad4:5dec:0:b0:5ad:5698:848e with SMTP id jn12-20020ad45dec000000b005ad5698848emr19825525qvb.48.1679947994512;
        Mon, 27 Mar 2023 13:13:14 -0700 (PDT)
Received: from localhost (pool-68-160-166-30.bstnma.fios.verizon.net. [68.160.166.30])
        by smtp.gmail.com with ESMTPSA id d13-20020a0cf6cd000000b005dd8b9345d3sm3161240qvo.107.2023.03.27.13.13.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 13:13:14 -0700 (PDT)
From:   Mike Snitzer <snitzer@kernel.org>
To:     dm-devel@redhat.com
Cc:     linux-block@vger.kernel.org, axboe@kernel.dk, ejt@redhat.com,
        mpatocka@redhat.com, heinzm@redhat.com, nhuck@google.com,
        ebiggers@kernel.org, keescook@chromium.org, luomeng12@huawei.com,
        Mike Snitzer <snitzer@kernel.org>
Subject: [dm-6.4 PATCH v3 05/20] dm bufio: add LRU abstraction
Date:   Mon, 27 Mar 2023 16:11:28 -0400
Message-Id: <20230327201143.51026-6-snitzer@kernel.org>
X-Mailer: git-send-email 2.40.0
In-Reply-To: <20230327201143.51026-1-snitzer@kernel.org>
References: <20230327201143.51026-1-snitzer@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

From: Joe Thornber <ejt@redhat.com>

A CLOCK algorithm is used in this LRU abstraction.  This avoids
relinking list nodes, which would require a write lock protecting it.

None of the LRU methods are threadsafe; locking must be done at a
higher level.

Code that uses this new LRU will be introduced in the next 2 commits.

As such, this commit will cause "defined but not used" compiler warnings
that will be resolved by the next 2 commits.

Signed-off-by: Joe Thornber <ejt@redhat.com>
Signed-off-by: Mike Snitzer <snitzer@kernel.org>
---
 drivers/md/dm-bufio.c | 235 ++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 235 insertions(+)

diff --git a/drivers/md/dm-bufio.c b/drivers/md/dm-bufio.c
index 64fb5fd39bd9..a0bb0de0d4e7 100644
--- a/drivers/md/dm-bufio.c
+++ b/drivers/md/dm-bufio.c
@@ -66,6 +66,241 @@
 #define LIST_DIRTY	1
 #define LIST_SIZE	2
 
+/*--------------------------------------------------------------*/
+
+/*
+ * Rather than use an LRU list, we use a clock algorithm where entries
+ * are held in a circular list.  When an entry is 'hit' a reference bit
+ * is set.  The least recently used entry is approximated by running a
+ * cursor around the list selecting unreferenced entries. Referenced
+ * entries have their reference bit cleared as the cursor passes them.
+ */
+struct lru_entry {
+	struct list_head list;
+	atomic_t referenced;
+};
+
+struct lru_iter {
+	struct lru *lru;
+	struct list_head list;
+	struct lru_entry *stop;
+	struct lru_entry *e;
+};
+
+struct lru {
+	struct list_head *cursor;
+	unsigned long count;
+
+	struct list_head iterators;
+};
+
+/*--------------*/
+
+static void lru_init(struct lru *lru)
+{
+	lru->cursor = NULL;
+	lru->count = 0;
+	INIT_LIST_HEAD(&lru->iterators);
+}
+
+static void lru_destroy(struct lru *lru)
+{
+	WARN_ON_ONCE(lru->cursor);
+	WARN_ON_ONCE(!list_empty(&lru->iterators));
+}
+
+/*
+ * Insert a new entry into the lru.
+ */
+static void lru_insert(struct lru *lru, struct lru_entry *le)
+{
+	/*
+	 * Don't be tempted to set to 1, makes the lru aspect
+	 * perform poorly.
+	 */
+	atomic_set(&le->referenced, 0);
+
+	if (lru->cursor) {
+		list_add_tail(&le->list, lru->cursor);
+	} else {
+		INIT_LIST_HEAD(&le->list);
+		lru->cursor = &le->list;
+	}
+	lru->count++;
+}
+
+/*--------------*/
+
+/*
+ * Convert a list_head pointer to an lru_entry pointer.
+ */
+static inline struct lru_entry *to_le(struct list_head *l)
+{
+	return container_of(l, struct lru_entry, list);
+}
+
+/*
+ * Initialize an lru_iter and add it to the list of cursors in the lru.
+ */
+static void lru_iter_begin(struct lru *lru, struct lru_iter *it)
+{
+	it->lru = lru;
+	it->stop = lru->cursor ? to_le(lru->cursor->prev) : NULL;
+	it->e = lru->cursor ? to_le(lru->cursor) : NULL;
+	list_add(&it->list, &lru->iterators);
+}
+
+/*
+ * Remove an lru_iter from the list of cursors in the lru.
+ */
+static inline void lru_iter_end(struct lru_iter *it)
+{
+	list_del(&it->list);
+}
+
+/* Predicate function type to be used with lru_iter_next */
+typedef bool (*iter_predicate)(struct lru_entry *le, void *context);
+
+/*
+ * Advance the cursor to the next entry that passes the
+ * predicate, and return that entry.  Returns NULL if the
+ * iteration is complete.
+ */
+static struct lru_entry *lru_iter_next(struct lru_iter *it,
+				       iter_predicate pred, void *context)
+{
+	struct lru_entry *e;
+
+	while (it->e) {
+		e = it->e;
+
+		/* advance the cursor */
+		if (it->e == it->stop)
+			it->e = NULL;
+		else
+			it->e = to_le(it->e->list.next);
+
+		if (pred(e, context))
+			return e;
+	}
+
+	return NULL;
+}
+
+/*
+ * Invalidate a specific lru_entry and update all cursors in
+ * the lru accordingly.
+ */
+static void lru_iter_invalidate(struct lru *lru, struct lru_entry *e)
+{
+	struct lru_iter *it;
+
+	list_for_each_entry(it, &lru->iterators, list) {
+		/* Move c->e forwards if necc. */
+		if (it->e == e) {
+			it->e = to_le(it->e->list.next);
+			if (it->e == e)
+				it->e = NULL;
+		}
+
+		/* Move it->stop backwards if necc. */
+		if (it->stop == e) {
+			it->stop = to_le(it->stop->list.prev);
+			if (it->stop == e)
+				it->stop = NULL;
+		}
+	}
+}
+
+/*--------------*/
+
+/*
+ * Remove a specific entry from the lru.
+ */
+static void lru_remove(struct lru *lru, struct lru_entry *le)
+{
+	lru_iter_invalidate(lru, le);
+	if (lru->count == 1) {
+		lru->cursor = NULL;
+	} else {
+		if (lru->cursor == &le->list)
+			lru->cursor = lru->cursor->next;
+		list_del(&le->list);
+	}
+	lru->count--;
+}
+
+/*
+ * Mark as referenced.
+ */
+static inline void lru_reference(struct lru_entry *le)
+{
+	atomic_set(&le->referenced, 1);
+}
+
+/*--------------*/
+
+/*
+ * Remove the least recently used entry (approx), that passes the predicate.
+ * Returns NULL on failure.
+ */
+enum evict_result {
+	ER_EVICT,
+	ER_DONT_EVICT,
+	ER_STOP, /* stop looking for something to evict */
+};
+
+typedef enum evict_result (*le_predicate)(struct lru_entry *le, void *context);
+
+static struct lru_entry *lru_evict(struct lru *lru, le_predicate pred, void *context)
+{
+	unsigned long tested = 0;
+	struct list_head *h = lru->cursor;
+	struct lru_entry *le;
+
+	if (!h)
+		return NULL;
+	/*
+	 * In the worst case we have to loop around twice. Once to clear
+	 * the reference flags, and then again to discover the predicate
+	 * fails for all entries.
+	 */
+	while (tested < lru->count) {
+		le = container_of(h, struct lru_entry, list);
+
+		if (atomic_read(&le->referenced)) {
+			atomic_set(&le->referenced, 0);
+		} else {
+			tested++;
+			switch (pred(le, context)) {
+			case ER_EVICT:
+				/*
+				 * Adjust the cursor, so we start the next
+				 * search from here.
+				 */
+				lru->cursor = le->list.next;
+				lru_remove(lru, le);
+				return le;
+
+			case ER_DONT_EVICT:
+				break;
+
+			case ER_STOP:
+				lru->cursor = le->list.next;
+				return NULL;
+			}
+		}
+
+		h = h->next;
+
+		cond_resched();
+	}
+
+	return NULL;
+}
+
+/*--------------------------------------------------------------*/
+
 /*
  * Linking of buffers:
  *	All buffers are linked to buffer_tree with their node field.
-- 
2.40.0

