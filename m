Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:39104 "EHLO mx1.suse.de"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728435AbeHIJID (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Thu, 9 Aug 2018 05:08:03 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 07/17] bcache: fix indent by replacing blank by tabs
Date: Thu,  9 Aug 2018 14:43:10 +0800
Message-Id: <20180809064320.10229-8-colyli@suse.de>
In-Reply-To: <20180809064320.10229-1-colyli@suse.de>
References: <20180809064320.10229-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

bch_btree_insert_check_key() has unaligned indent, or indent by blank
characters. This patch makes the indent aligned and replace blank by
tabs.

Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/btree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index afd691b4cb6e..a072e3a6c91d 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -2229,10 +2229,10 @@ int bch_btree_insert_check_key(struct btree *b, struct btree_op *op,
 		rw_lock(true, b, b->level);
 
 		if (b->key.ptr[0] != btree_ptr ||
-                   b->seq != seq + 1) {
+		    b->seq != seq + 1) {
 			op->lock = b->level;
 			goto out;
-               }
+		}
 	}
 
 	SET_KEY_PTRS(check_key, 1);
-- 
2.18.0
