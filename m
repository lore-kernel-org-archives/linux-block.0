Return-Path: <SRS0=cp6W=SV=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5BFDCC282E1
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:24:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35D31222AF
	for <linux-block@archiver.kernel.org>; Fri, 19 Apr 2019 18:24:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727735AbfDSSYP (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 19 Apr 2019 14:24:15 -0400
Received: from mx2.suse.de ([195.135.220.15]:33588 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727658AbfDSSXq (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 19 Apr 2019 14:23:46 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id A101CAFC3;
        Fri, 19 Apr 2019 16:06:18 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     linux-bcache@vger.kernel.org
Cc:     linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [RFC PATCH v2 14/16] bcache: try to flush btree nodes as many as possible
Date:   Sat, 20 Apr 2019 00:05:07 +0800
Message-Id: <20190419160509.66298-15-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190419160509.66298-1-colyli@suse.de>
References: <20190419160509.66298-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

When btree_flush_write() is called, it means the journal space is
exhuasted already. Current code only selects a single btree node to
write out, which may introduce huge cache bounce from the spinlock on
multiple cpu cores, when a lot of kworkers on journaling code path to
call btree_flush_write() for journal space reclaiming.

This patch tries to flush as many btree node as possible inside
a single call to btree_flush_write(), then the frequence of calling
btree_flush_write() can be reduced, which in turn reduces the cache
bounce from spinlock on multiple cpu cores. Please notice that this
patch does not reduce the total times of acquiring spinlock, a spin
lock is still acquired when select every single btree node to write
out, but this patch will try best to hold the spinlock on same cpu
core, which avoids the cache bounce where the spinlock is acquired by
multiple different cpu cores.

After the patch applied, in my pressure testing, 'top' shows more than
50% sys cpu time reduced from the kworks which competing spinlock
inside btree_flush_write().

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/journal.c | 7 ++++++-
 drivers/md/bcache/journal.h | 4 ++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index bc0e01151155..8536e76fcac9 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -514,6 +514,7 @@ static void btree_flush_write(struct cache_set *c)
 	 */
 	struct btree *b;
 	int i;
+	int n = FLUSH_BTREE_HEAP;
 
 	atomic_long_inc(&c->flush_write);
 
@@ -552,6 +553,10 @@ static void btree_flush_write(struct cache_set *c)
 
 		__bch_btree_node_write(b, NULL);
 		mutex_unlock(&b->write_lock);
+
+		/* try to flush btree nodes as many as possible */
+		if (--n > 0)
+			goto retry;
 	}
 }
 
@@ -1102,7 +1107,7 @@ int bch_journal_alloc(struct cache_set *c)
 	j->w[0].c = c;
 	j->w[1].c = c;
 
-	if (!(init_heap(&c->flush_btree, 128, GFP_KERNEL)) ||
+	if (!(init_heap(&c->flush_btree, FLUSH_BTREE_HEAP, GFP_KERNEL)) ||
 	    !(init_fifo(&j->pin, JOURNAL_PIN, GFP_KERNEL)) ||
 	    !(j->w[0].data = (void *) __get_free_pages(GFP_KERNEL, JSET_BITS)) ||
 	    !(j->w[1].data = (void *) __get_free_pages(GFP_KERNEL, JSET_BITS)))
diff --git a/drivers/md/bcache/journal.h b/drivers/md/bcache/journal.h
index 55f81443f304..a8be14c6f6d9 100644
--- a/drivers/md/bcache/journal.h
+++ b/drivers/md/bcache/journal.h
@@ -158,8 +158,8 @@ struct journal_device {
 #define journal_pin_cmp(c, l, r)				\
 	(fifo_idx(&(c)->journal.pin, (l)) > fifo_idx(&(c)->journal.pin, (r)))
 
-#define JOURNAL_PIN	20000
-
+#define FLUSH_BTREE_HEAP	128
+#define JOURNAL_PIN		20000
 /* Reserved jouranl space in sectors */
 #define BCH_JOURNAL_RPLY_RESERVE	6U
 #define BCH_JOURNAL_RESERVE		7U
-- 
2.16.4

