Return-Path: <SRS0=lHMQ=S2=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B46EC282E1
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:49:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2518D206A3
	for <linux-block@archiver.kernel.org>; Wed, 24 Apr 2019 16:49:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732787AbfDXQtc (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 24 Apr 2019 12:49:32 -0400
Received: from mx2.suse.de ([195.135.220.15]:60052 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732215AbfDXQtb (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Wed, 24 Apr 2019 12:49:31 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx1.suse.de (Postfix) with ESMTP id 993C1AF68;
        Wed, 24 Apr 2019 16:49:30 +0000 (UTC)
From:   Coly Li <colyli@suse.de>
To:     axboe@kernel.dk
Cc:     linux-bcache@vger.kernel.org, linux-block@vger.kernel.org,
        Coly Li <colyli@suse.de>, stable@vger.kernel.org
Subject: [PATCH 08/18] bcache: never set KEY_PTRS of jouranl key to 0 in journal_reclaim()
Date:   Thu, 25 Apr 2019 00:48:33 +0800
Message-Id: <20190424164843.29535-9-colyli@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20190424164843.29535-1-colyli@suse.de>
References: <20190424164843.29535-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

In journal_reclaim() ja->cur_idx of each cache will be update to
reclaim available journal buckets. Variable 'int n' is used to count how
many cache is successfully reclaimed, then n is set to c->journal.key
by SET_KEY_PTRS(). Later in journal_write_unlocked(), a for_each_cache()
loop will write the jset data onto each cache.

The problem is, if all jouranl buckets on each cache is full, the
following code in journal_reclaim(),

529 for_each_cache(ca, c, iter) {
530       struct journal_device *ja = &ca->journal;
531       unsigned int next = (ja->cur_idx + 1) % ca->sb.njournal_buckets;
532
533       /* No space available on this device */
534       if (next == ja->discard_idx)
535               continue;
536
537       ja->cur_idx = next;
538       k->ptr[n++] = MAKE_PTR(0,
539                         bucket_to_sector(c, ca->sb.d[ja->cur_idx]),
540                         ca->sb.nr_this_dev);
541 }
542
543 bkey_init(k);
544 SET_KEY_PTRS(k, n);

If there is no available bucket to reclaim, the if() condition at line
534 will always true, and n remains 0. Then at line 544, SET_KEY_PTRS()
will set KEY_PTRS field of c->journal.key to 0.

Setting KEY_PTRS field of c->journal.key to 0 is wrong. Because in
journal_write_unlocked() the journal data is written in following loop,

649	for (i = 0; i < KEY_PTRS(k); i++) {
650-671		submit journal data to cache device
672	}

If KEY_PTRS field is set to 0 in jouranl_reclaim(), the journal data
won't be written to cache device here. If system crahed or rebooted
before bkeys of the lost journal entries written into btree nodes, data
corruption will be reported during bcache reload after rebooting the
system.

Indeed there is only one cache in a cache set, there is no need to set
KEY_PTRS field in journal_reclaim() at all. But in order to keep the
for_each_cache() logic consistent for now, this patch fixes the above
problem by not setting 0 KEY_PTRS of journal key, if there is no bucket
available to reclaim.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Hannes Reinecke <hare@suse.com>
Cc: stable@vger.kernel.org
---
 drivers/md/bcache/journal.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index 6e18057d1d82..5180bed911ef 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -541,11 +541,11 @@ static void journal_reclaim(struct cache_set *c)
 				  ca->sb.nr_this_dev);
 	}
 
-	bkey_init(k);
-	SET_KEY_PTRS(k, n);
-
-	if (n)
+	if (n) {
+		bkey_init(k);
+		SET_KEY_PTRS(k, n);
 		c->journal.blocks_free = c->sb.bucket_size >> c->block_bits;
+	}
 out:
 	if (!journal_full(&c->journal))
 		__closure_wake_up(&c->journal.wait);
@@ -672,6 +672,9 @@ static void journal_write_unlocked(struct closure *cl)
 		ca->journal.seq[ca->journal.cur_idx] = w->data->seq;
 	}
 
+	/* If KEY_PTRS(k) == 0, this jset gets lost in air */
+	BUG_ON(i == 0);
+
 	atomic_dec_bug(&fifo_back(&c->journal.pin));
 	bch_journal_next(&c->journal);
 	journal_reclaim(c);
-- 
2.16.4

