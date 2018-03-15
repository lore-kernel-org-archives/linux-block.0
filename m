Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46680 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752761AbeCOPI2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:08:28 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 05/16] bcache: Remove an unused variable
Date: Thu, 15 Mar 2018 08:08:03 -0700
Message-Id: <20180315150814.9412-6-bart.vanassche@wdc.com>
In-Reply-To: <20180315150814.9412-1-bart.vanassche@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
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
2.16.2
