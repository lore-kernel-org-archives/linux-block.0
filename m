Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C42DC282DA
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:23:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D095B222CC
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:23:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbfDSSXu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:23:50 -0400
Received: from mx2.suse.de ([195.135.220.15]:33644 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727876AbfDSSXt (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 14:23:49 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 532F6AFAE;
        Fri, 19 Apr 2019 16:05:38 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [RFC PATCH v2 05/16] bcache: reserve space for journal_meta() in run time
Date:   Sat, 20 Apr 2019 00:04:58 +0800
Message-Id: <20190419160509.66298-6-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190419160509.66298-1-colyli@suse.de>
References: <20190419160509.66298-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Another journal deadlock of bcache jouranling can happen in normal
bcache runtime. It is very rare to happen but there are people report
bkey insert work queue blocked which caused by such deadlock.

This is how such jouranling deadlock in runtime happens,
- Journal space is totally full and no free space to reclaim, jouranling
  tasks waiting for space to write in journal_wait_for_write().
- In order to have free journal space, btree_flush_write() is called to
  flush earlest journaled in-memory btree key into btree node. Then all
  journaled bkey in early used journal buckets are flushed to on-disk
  btree, this journal bucket can be reclaimed for new coming jouranl
  request.
- But if the earlest jouranled bkey causes a btree node split during
  insert it into btree node, finally journal_meta() will be called to
  journal btree root (and other information) into the journal space.
- Unfortunately the journal space is full, and the jouranl entries has
  to be flushed in linear turn. So bch_journal_meta() from bkey insert
  is blocked too.
Then jouranling deadlock during bcache run time happens.

A method to fix such deadlock is to reserve some journal space too. The
reserved space can only be used when,
- Current journal bucket is the last journal bucket which has available
  space to write into.
- When calling bch_journal(), current jset is empty and there is no key
  in the inserting key list. This means the journal request if from
  bch_journal_meta() and no non-reserved space can be used.

Then if such journaling request is from bch_journal_meta() of inserting
the earlest journaled bkey back into btree, the deadlock condition won't
happen any more because the reserved space can be used for such
scenario.

Since there are already 6 sectors reserved for journal replay, here we
reserve 7 sectors for runtime meta journal from btree split caused by
flushing journal entries back to btree node. Depends on block size from
1 sector to 4KB, the reserved space can serve for form 7 to 2 journal
blocks. Indeed only one journal block reserved for such journal deadlock
scenario is enough, 2 continuous btree splits cause by two adjoin bkey
flushing from journal is very very rare to happen. So reserve 7 sectors
should works.

Another reason for reserving 7 sectors is, there are already 6 sectors
reserved fo journal repley, so in total there are 13 sectors reserved in
last available journal bucket. 13 sectors won't be a proper bucket size,
so we don't need to add more code to handle journal.blocks_free
initialization for whole reserved jouranl bucket. Even such code logic
is simple, less code is better in my humble opinion.

Again, if in future the reserved space turns out to be not enough, let's
extend it then.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/journal.c | 89 +++++++++++++++++++++++++++++++++------------
 drivers/md/bcache/journal.h |  1 +
 2 files changed, 66 insertions(+), 24 deletions(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index c60a702f53a9..6aa68ab7cd78 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -629,7 +629,7 @@ static void journal_reclaim(struct cache_set *c)
 	last = last_available_journal_bucket(c);
 	if ((!last && c->journal.blocks_free) ||
 	    (last && (c->journal.blocks_free * c->sb.block_size) >
-		      BCH_JOURNAL_RPLY_RESERVE)) {
+		      (BCH_JOURNAL_RESERVE + BCH_JOURNAL_RPLY_RESERVE))) {
 		do_wakeup = true;
 		goto out;
 	}
@@ -718,18 +718,27 @@ static void journal_write_unlock(struct closure *cl)
 	spin_unlock(&c->journal.lock);
 }
 
-static bool should_reclaim(struct cache_set *c,
-			   struct journal_write *w)
+static inline bool should_reclaim(struct cache_set *c,
+				  struct journal_write *w)
 {
-	if (unlikely(journal_full(&c->journal)))
-		return true;
+	bool last = last_available_journal_bucket(c);
 
-	if (unlikely(last_available_journal_bucket(c) &&
-		     (!c->journal.in_replay) &&
-		     (c->journal.blocks_free * c->sb.block_size <=
-			BCH_JOURNAL_RPLY_RESERVE)))
+	if (!last && journal_full(&c->journal))
 		return true;
 
+	if (unlikely(last)) {
+		size_t n = c->journal.blocks_free * c->sb.block_size;
+
+		if (!c->journal.in_replay) {
+			if (n <= BCH_JOURNAL_RESERVE +
+				 BCH_JOURNAL_RPLY_RESERVE)
+				return true;
+		} else {
+			if (n <= BCH_JOURNAL_RPLY_RESERVE)
+				return true;
+		}
+	}
+
 	return false;
 }
 
@@ -751,7 +760,9 @@ static void journal_write_unlocked(struct closure *cl)
 	if (!w->need_write) {
 		closure_return_with_destructor(cl, journal_write_unlock);
 		return;
-	} else if (should_reclaim(c, w)) {
+	}
+
+	if (should_reclaim(c, w)) {
 		journal_reclaim(c);
 		spin_unlock(&c->journal.lock);
 
@@ -840,16 +851,26 @@ static void journal_try_write(struct cache_set *c)
 }
 
 static bool no_journal_wait(struct cache_set *c,
-			    size_t sectors)
+			    size_t sectors,
+			    int nkeys)
 {
+	bool is_journal_meta = (nkeys == 0) ? true : false;
 	bool last = last_available_journal_bucket(c);
 	size_t reserved_sectors = 0;
-	size_t n = min_t(size_t,
-			 c->journal.blocks_free * c->sb.block_size,
-			 PAGE_SECTORS << JSET_BITS);
+	size_t n;
+
+	if (unlikely(last)) {
+		if (!is_journal_meta)
+			reserved_sectors = BCH_JOURNAL_RESERVE +
+					   BCH_JOURNAL_RPLY_RESERVE;
+		else
+			reserved_sectors = (!c->journal.in_replay) ?
+				BCH_JOURNAL_RPLY_RESERVE : 0;
+	}
 
-	if (last && !c->journal.in_replay)
-		reserved_sectors = BCH_JOURNAL_RPLY_RESERVE;
+	n = min_t(size_t,
+		  c->journal.blocks_free * c->sb.block_size,
+		  PAGE_SECTORS << JSET_BITS);
 
 	if (sectors <= (n - reserved_sectors))
 		return true;
@@ -858,26 +879,46 @@ static bool no_journal_wait(struct cache_set *c,
 }
 
 static bool should_try_write(struct cache_set *c,
-			     struct journal_write *w)
+			     struct journal_write *w,
+			     int nkeys)
 {
 	size_t reserved_sectors, n, sectors;
+	bool last, empty_jset;
 
 	if (journal_full(&c->journal))
 		return false;
 
-	if (!last_available_journal_bucket(c))
+	last = last_available_journal_bucket(c);
+	empty_jset = (w->data->keys == 0) ? true : false;
+
+	if (!last) {
+		/*
+		 * Not last available journal bucket, no reserved journal
+		 * space restriction, an empty jset should not be here.
+		 */
+		BUG_ON(empty_jset);
 		return true;
+	}
 
-	/* the check in no_journal_wait exceeds BCH_JOURNAL_RPLY_RESERVE */
-	if (w->data->keys == 0)
+	if (empty_jset) {
+		/*
+		 * If nkeys is 0 it means the journaling request is for meta
+		 * data, which should be returned in journal_wait_for_write()
+		 * by checking no_journal_wait(), and won't get here.
+		 */
+		BUG_ON(nkeys == 0);
 		return false;
+	}
 
-	reserved_sectors = BCH_JOURNAL_RPLY_RESERVE;
+	reserved_sectors = BCH_JOURNAL_RESERVE +
+			   BCH_JOURNAL_RPLY_RESERVE;
 	n = min_t(size_t,
 		  (c->journal.blocks_free * c->sb.block_size),
 		  PAGE_SECTORS << JSET_BITS);
-	sectors = __set_blocks(w->data, w->data->keys,
+	sectors = __set_blocks(w->data,
+			       w->data->keys,
 			       block_bytes(c)) * c->sb.block_size;
+
 	if (sectors <= (n - reserved_sectors))
 		return true;
 
@@ -903,13 +944,13 @@ static struct journal_write *journal_wait_for_write(struct cache_set *c,
 		sectors = __set_blocks(w->data, w->data->keys + nkeys,
 				       block_bytes(c)) * c->sb.block_size;
 
-		if (no_journal_wait(c, sectors))
+		if (no_journal_wait(c, sectors, nkeys))
 			return w;
 
 		if (wait)
 			closure_wait(&c->journal.wait, &cl);
 
-		if (should_try_write(c, w)) {
+		if (should_try_write(c, w, nkeys)) {
 			if (wait)
 				trace_bcache_journal_entry_full(c);
 
diff --git a/drivers/md/bcache/journal.h b/drivers/md/bcache/journal.h
index 54408e248a39..55f81443f304 100644
--- a/drivers/md/bcache/journal.h
+++ b/drivers/md/bcache/journal.h
@@ -162,6 +162,7 @@ struct journal_device {
 
 /* Reserved jouranl space in sectors */
 #define BCH_JOURNAL_RPLY_RESERVE	6U
+#define BCH_JOURNAL_RESERVE		7U
 
 #define journal_full(j)						\
 	(!(j)->blocks_free || fifo_free(&(j)->pin) <= 1)
-- 
2.16.4

