Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2DD0CC282E1
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 08C9A222D2
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:23:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727874AbfDSSXu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:23:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:33634 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727870AbfDSSXt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 14:23:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id E6841AFAC;
        Fri, 19 Apr 2019 16:05:34 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [RFC PATCH v2 04/16] bcache: fix journal deadlock during jouranl replay
Date:   Sat, 20 Apr 2019 00:04:57 +0800
Message-Id: <20190419160509.66298-5-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190419160509.66298-1-colyli@suse.de>
References: <20190419160509.66298-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

A deadlock of bcache jouranling may happen during journal replay. Such
deadlock happens when,
- Journal space is totally full (no any free blocks) and system crashes
  or reboots.
- After reboot, the first journal entry handled by jouranl replay causes
  btree split and jouranl_meta() is called to write an empty jset to
  journal space.
- There is no journal space to write and journal_reclaim() fails to get
  any available bucket because this is the first replayed journal entry
  to be blocked.
Then the whole cache set is blocked from running.

This patch is an effort to fix such journal replay deadlock in a simpler
way,
- Add a bool varialbe 'in_replay' in struct journal, set it to true when
  journal replay starts, and set it to false when journal replay
  completed. in_replay is initialized to be false.
- Reserve 6 sectors in journal bucket, do not use them in normal bcache
  runtime. These sectors are only permitted to use during journal
  replay (when c->jouranl.in_replay is true)

Then in normal bcache runtime, journal space won't be totally full and
there are 6 sectors are always reserved for journal replay time. After
system reboots, if bch_btree_insert() in bch_journal_replay() causes
btree split and bch_journal_beta() gets called to require 1 sector
from journal buckets to write an empty jset, there are enough reserved
space to serve.

The reason to reserve 6 sectors is, we should choose a number that won't
fix into a bucket size. If the reserved space happens to be a whole
bucket, more logic has to be added in journal_replay() to handle
journal.blocks_free with reserved spaces in journal replay time. This is
why 6 sectors is choosed, it is 3KB and won't be any proper block size
or bucket size.

The bcache btree node size is quite large, so btree node split won't be
a frequent event. And when btree node split happens, new added key will
be insert directly into uppper level or neighbor nodes and won't go into
journal again, only bch_journal_meta() is called to write jset metadata
which occupies 1 block in journal space. If blocksize is set to 4K size,
reserve 6 sectors indeed is 2 blocks, so there can be two continuously
btree splitting happen during journal replay, this is very very rare in
practice. As default blocksize is set to sector size, that equals to
6 blocks reserved. Contiously splitting the btree for 6 times in journal
replay is almost impossible, so the reserved space seems to be enough
in my humble opinion.

If in future the reserved space turns out to be not enough, let's extend
it then.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/journal.c | 100 ++++++++++++++++++++++++++++++++++++++++----
 drivers/md/bcache/journal.h |   4 ++
 2 files changed, 97 insertions(+), 7 deletions(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index a6deb16c15c8..c60a702f53a9 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -415,6 +415,8 @@ int bch_journal_replay(struct cache_set *s, struct list_head *list)
 	uint64_t start = i->j.last_seq, end = i->j.seq, n = start;
 	struct keylist keylist;
 
+	s->journal.in_replay = true;
+
 	list_for_each_entry(i, list, list) {
 		BUG_ON(i->pin && atomic_read(i->pin) != 1);
 
@@ -448,6 +450,7 @@ int bch_journal_replay(struct cache_set *s, struct list_head *list)
 	pr_info("journal replay done, %i keys in %i entries, seq %llu",
 		keys, entries, end);
 err:
+	s->journal.in_replay = false;
 	while (!list_empty(list)) {
 		i = list_first_entry(list, struct journal_replay, list);
 		list_del(&i->list);
@@ -577,6 +580,22 @@ static void do_journal_discard(struct cache *ca)
 	}
 }
 
+static inline bool last_available_journal_bucket(struct cache_set *c)
+{
+	struct cache *ca;
+	unsigned int iter;
+	struct journal_device *ja;
+
+	for_each_cache(ca, c, iter) {
+		ja = &ca->journal;
+		if (unlikely((ja->cur_idx + 1) % ca->sb.njournal_buckets ==
+			     ja->last_idx))
+			return true;
+	}
+
+	return false;
+}
+
 static void journal_reclaim(struct cache_set *c)
 {
 	struct bkey *k = &c->journal.key;
@@ -584,6 +603,7 @@ static void journal_reclaim(struct cache_set *c)
 	uint64_t last_seq;
 	unsigned int iter, n = 0;
 	atomic_t p __maybe_unused;
+	bool last, do_wakeup = false;
 
 	atomic_long_inc(&c->reclaim);
 
@@ -606,8 +626,13 @@ static void journal_reclaim(struct cache_set *c)
 	for_each_cache(ca, c, iter)
 		do_journal_discard(ca);
 
-	if (c->journal.blocks_free)
+	last = last_available_journal_bucket(c);
+	if ((!last && c->journal.blocks_free) ||
+	    (last && (c->journal.blocks_free * c->sb.block_size) >
+		      BCH_JOURNAL_RPLY_RESERVE)) {
+		do_wakeup = true;
 		goto out;
+	}
 
 	/*
 	 * Allocate:
@@ -632,9 +657,10 @@ static void journal_reclaim(struct cache_set *c)
 		bkey_init(k);
 		SET_KEY_PTRS(k, n);
 		c->journal.blocks_free = c->sb.bucket_size >> c->block_bits;
+		do_wakeup = true;
 	}
 out:
-	if (!journal_full(&c->journal))
+	if (do_wakeup && !journal_full(&c->journal))
 		__closure_wake_up(&c->journal.wait);
 }
 
@@ -692,6 +718,21 @@ static void journal_write_unlock(struct closure *cl)
 	spin_unlock(&c->journal.lock);
 }
 
+static bool should_reclaim(struct cache_set *c,
+			   struct journal_write *w)
+{
+	if (unlikely(journal_full(&c->journal)))
+		return true;
+
+	if (unlikely(last_available_journal_bucket(c) &&
+		     (!c->journal.in_replay) &&
+		     (c->journal.blocks_free * c->sb.block_size <=
+			BCH_JOURNAL_RPLY_RESERVE)))
+		return true;
+
+	return false;
+}
+
 static void journal_write_unlocked(struct closure *cl)
 	__releases(c->journal.lock)
 {
@@ -710,7 +751,7 @@ static void journal_write_unlocked(struct closure *cl)
 	if (!w->need_write) {
 		closure_return_with_destructor(cl, journal_write_unlock);
 		return;
-	} else if (journal_full(&c->journal)) {
+	} else if (should_reclaim(c, w)) {
 		journal_reclaim(c);
 		spin_unlock(&c->journal.lock);
 
@@ -798,6 +839,52 @@ static void journal_try_write(struct cache_set *c)
 	}
 }
 
+static bool no_journal_wait(struct cache_set *c,
+			    size_t sectors)
+{
+	bool last = last_available_journal_bucket(c);
+	size_t reserved_sectors = 0;
+	size_t n = min_t(size_t,
+			 c->journal.blocks_free * c->sb.block_size,
+			 PAGE_SECTORS << JSET_BITS);
+
+	if (last && !c->journal.in_replay)
+		reserved_sectors = BCH_JOURNAL_RPLY_RESERVE;
+
+	if (sectors <= (n - reserved_sectors))
+		return true;
+
+	return false;
+}
+
+static bool should_try_write(struct cache_set *c,
+			     struct journal_write *w)
+{
+	size_t reserved_sectors, n, sectors;
+
+	if (journal_full(&c->journal))
+		return false;
+
+	if (!last_available_journal_bucket(c))
+		return true;
+
+	/* the check in no_journal_wait exceeds BCH_JOURNAL_RPLY_RESERVE */
+	if (w->data->keys == 0)
+		return false;
+
+	reserved_sectors = BCH_JOURNAL_RPLY_RESERVE;
+	n = min_t(size_t,
+		  (c->journal.blocks_free * c->sb.block_size),
+		  PAGE_SECTORS << JSET_BITS);
+	sectors = __set_blocks(w->data, w->data->keys,
+			       block_bytes(c)) * c->sb.block_size;
+	if (sectors <= (n - reserved_sectors))
+		return true;
+
+	return false;
+}
+
+
 static struct journal_write *journal_wait_for_write(struct cache_set *c,
 						    unsigned int nkeys)
 	__acquires(&c->journal.lock)
@@ -816,15 +903,13 @@ static struct journal_write *journal_wait_for_write(struct cache_set *c,
 		sectors = __set_blocks(w->data, w->data->keys + nkeys,
 				       block_bytes(c)) * c->sb.block_size;
 
-		if (sectors <= min_t(size_t,
-				     c->journal.blocks_free * c->sb.block_size,
-				     PAGE_SECTORS << JSET_BITS))
+		if (no_journal_wait(c, sectors))
 			return w;
 
 		if (wait)
 			closure_wait(&c->journal.wait, &cl);
 
-		if (!journal_full(&c->journal)) {
+		if (should_try_write(c, w)) {
 			if (wait)
 				trace_bcache_journal_entry_full(c);
 
@@ -933,6 +1018,7 @@ int bch_journal_alloc(struct cache_set *c)
 	INIT_DELAYED_WORK(&j->work, journal_write_work);
 
 	c->journal_delay_ms = 100;
+	j->in_replay = false;
 
 	j->w[0].c = c;
 	j->w[1].c = c;
diff --git a/drivers/md/bcache/journal.h b/drivers/md/bcache/journal.h
index 66f0facff84b..54408e248a39 100644
--- a/drivers/md/bcache/journal.h
+++ b/drivers/md/bcache/journal.h
@@ -108,6 +108,7 @@ struct journal {
 	struct closure		io;
 	int			io_in_flight;
 	struct delayed_work	work;
+	bool			in_replay;
 
 	/* Number of blocks free in the bucket(s) we're currently writing to */
 	unsigned int		blocks_free;
@@ -159,6 +160,9 @@ struct journal_device {
 
 #define JOURNAL_PIN	20000
 
+/* Reserved jouranl space in sectors */
+#define BCH_JOURNAL_RPLY_RESERVE	6U
+
 #define journal_full(j)						\
 	(!(j)->blocks_free || fifo_free(&(j)->pin) <= 1)
 
-- 
2.16.4

