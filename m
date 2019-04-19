Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A417EC282DA
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:24:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 703EB20652
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:24:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbfDSSYl (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:24:41 -0400
Received: from mx2.suse.de ([195.135.220.15]:33572 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727392AbfDSSXq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 14:23:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 80621AFC7;
        Fri, 19 Apr 2019 16:06:26 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [RFC PATCH v2 16/16] bcache: introduce spinlock_t flush_write_lock in struct journal
Date:   Sat, 20 Apr 2019 00:05:09 +0800
Message-Id: <20190419160509.66298-17-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190419160509.66298-1-colyli@suse.de>
References: <20190419160509.66298-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In btree_flush_write(), iterating all cached btree nodes and adding them
into ordered heap c->flush_btree takes quite long time. In order to
protect ordered heap c->flush_btree, spin lock c->journal.lock is held
for all the iteration and heap ordering. When journal space is fully
occupied, btree_flush_write() might be called frequently, if the cached
btree node iteration takes too much time, kenrel will complain that
normal journal kworkers are blocked too long. Of cause write performance
drops at this moment.

This patch introduces a new spin lock member in struct journal, named
flush_write_lock. This lock is only used in btree_flush_write() and
protect the ordered heap c->flush_btree during all the cached btree node
iteration. Then there won't be lock contention on c->journal.lock.

After this fix, when journal space is fully occupied, it is very rare to
observe the journal kworker blocking timeout warning.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/journal.c | 5 +++--
 drivers/md/bcache/journal.h | 1 +
 2 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 8536e76fcac9..6e38470f6924 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -519,7 +519,7 @@ static void btree_flush_write(struct cache_set *c)
 	atomic_long_inc(&c->flush_write);
 
 retry:
-	spin_lock(&c->journal.lock);
+	spin_lock(&c->journal.flush_write_lock);
 	if (heap_empty(&c->flush_btree)) {
 		for_each_cached_btree(b, c, i)
 			if (btree_current_write(b)->journal) {
@@ -540,7 +540,7 @@ static void btree_flush_write(struct cache_set *c)
 
 	b = NULL;
 	heap_pop(&c->flush_btree, b, journal_min_cmp);
-	spin_unlock(&c->journal.lock);
+	spin_unlock(&c->journal.flush_write_lock);
 
 	if (b) {
 		mutex_lock(&b->write_lock);
@@ -1099,6 +1099,7 @@ int bch_journal_alloc(struct cache_set *c)
 	struct journal *j = &c->journal;
 
 	spin_lock_init(&j->lock);
+	spin_lock_init(&j->flush_write_lock);
 	INIT_DELAYED_WORK(&j->work, journal_write_work);
 
 	c->journal_delay_ms = 100;
diff --git a/drivers/md/bcache/journal.h b/drivers/md/bcache/journal.h
index a8be14c6f6d9..d8ad99f6191b 100644
--- a/drivers/md/bcache/journal.h
+++ b/drivers/md/bcache/journal.h
@@ -103,6 +103,7 @@ struct journal_write {
 /* Embedded in struct cache_set */
 struct journal {
 	spinlock_t		lock;
+	spinlock_t		flush_write_lock;
 	/* used when waiting because the journal was full */
 	struct closure_waitlist	wait;
 	struct closure		io;
-- 
2.16.4

