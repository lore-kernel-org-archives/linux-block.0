Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pg0-f66.google.com ([74.125.83.66]:44108 "EHLO
        mail-pg0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754845AbeCSAhB (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Mar 2018 20:37:01 -0400
Received: by mail-pg0-f66.google.com with SMTP id l4so6251553pgp.11
        for <linux-block@vger.kernel.org>; Sun, 18 Mar 2018 17:37:01 -0700 (PDT)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@fb.com, Bart Van Assche <bart.vanassche@wdc.com>
Subject: [for-4.17 17/20] bcache: Remove an unused variable
Date: Sun, 18 Mar 2018 17:36:30 -0700
Message-Id: <20180319003633.27225-18-mlyle@lyle.org>
In-Reply-To: <20180319003633.27225-1-mlyle@lyle.org>
References: <20180319003633.27225-1-mlyle@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Bart Van Assche <bart.vanassche@wdc.com>

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
---
 drivers/md/bcache/extents.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/drivers/md/bcache/extents.c b/drivers/md/bcache/extents.c
index f9d391711595..c334e6666461 100644
--- a/drivers/md/bcache/extents.c
+++ b/drivers/md/bcache/extents.c
@@ -534,7 +534,6 @@ static bool bch_extent_bad_expensive(struct btree *b, const struct bkey *k,
 static bool bch_extent_bad(struct btree_keys *bk, const struct bkey *k)
 {
 	struct btree *b = container_of(bk, struct btree, keys);
-	struct bucket *g;
 	unsigned i, stale;
 
 	if (!KEY_PTRS(k) ||
@@ -549,7 +548,6 @@ static bool bch_extent_bad(struct btree_keys *bk, const struct bkey *k)
 		return false;
 
 	for (i = 0; i < KEY_PTRS(k); i++) {
-		g = PTR_BUCKET(b->c, k, i);
 		stale = ptr_stale(b->c, k, i);
 
 		btree_bug_on(stale > 96, b,
-- 
2.14.1
