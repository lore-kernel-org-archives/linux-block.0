Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f193.google.com ([209.85.192.193]:37136 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754850AbeCSAhC (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Mar 2018 20:37:02 -0400
Received: by mail-pf0-f193.google.com with SMTP id h11so6370097pfn.4
        for <linux-block@vger.kernel.org>; Sun, 18 Mar 2018 17:37:02 -0700 (PDT)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@fb.com, Bart Van Assche <bart.vanassche@wdc.com>
Subject: [for-4.17 18/20] bcache: Suppress more warnings about set-but-not-used variables
Date: Sun, 18 Mar 2018 17:36:31 -0700
Message-Id: <20180319003633.27225-19-mlyle@lyle.org>
In-Reply-To: <20180319003633.27225-1-mlyle@lyle.org>
References: <20180319003633.27225-1-mlyle@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Bart Van Assche <bart.vanassche@wdc.com>

This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
---
 drivers/md/bcache/bset.c    | 4 ++--
 drivers/md/bcache/journal.c | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/md/bcache/bset.c b/drivers/md/bcache/bset.c
index e56d3ecdbfcb..579c696a5fe0 100644
--- a/drivers/md/bcache/bset.c
+++ b/drivers/md/bcache/bset.c
@@ -1072,7 +1072,7 @@ EXPORT_SYMBOL(bch_btree_iter_init);
 static inline struct bkey *__bch_btree_iter_next(struct btree_iter *iter,
 						 btree_iter_cmp_fn *cmp)
 {
-	struct btree_iter_set unused;
+	struct btree_iter_set b __maybe_unused;
 	struct bkey *ret = NULL;
 
 	if (!btree_iter_end(iter)) {
@@ -1087,7 +1087,7 @@ static inline struct bkey *__bch_btree_iter_next(struct btree_iter *iter,
 		}
 
 		if (iter->data->k == iter->data->end)
-			heap_pop(iter, unused, cmp);
+			heap_pop(iter, b, cmp);
 		else
 			heap_sift(iter, 0, cmp);
 	}
diff --git a/drivers/md/bcache/journal.c b/drivers/md/bcache/journal.c
index c94085f400a4..acd0e5c074dd 100644
--- a/drivers/md/bcache/journal.c
+++ b/drivers/md/bcache/journal.c
@@ -493,7 +493,7 @@ static void journal_reclaim(struct cache_set *c)
 	struct cache *ca;
 	uint64_t last_seq;
 	unsigned iter, n = 0;
-	atomic_t p;
+	atomic_t p __maybe_unused;
 
 	atomic_long_inc(&c->reclaim);
 
-- 
2.14.1
