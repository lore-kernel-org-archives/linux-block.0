Return-Path: <colyli@suse.de>
From: Coly Li <colyli@suse.de>
To: axboe@kernel.dk,
	linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org,
	Coly Li <colyli@suse.de>
Subject: [PATCH v3 07/17] bcache: fix indent by replacing blank by tabs
Date: Sat, 11 Aug 2018 13:19:50 +0800
Message-Id: <20180811052000.103680-8-colyli@suse.de>
In-Reply-To: <20180811052000.103680-1-colyli@suse.de>
References: <20180811052000.103680-1-colyli@suse.de>
List-ID: <linux-block@vger.kernel.org>

bch_btree_insert_check_key() has unaligned indent, or indent by blank
characters. This patch makes the indent aligned and replace blank by
tabs.

Signed-off-by: Coly Li <colyli@suse.de>
Reviewed-by: Shenghui Wang <shhuiw@foxmail.com>
---
 drivers/md/bcache/btree.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index c2e4174a2e03..e7d4817681f2 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -2231,10 +2231,10 @@ int bch_btree_insert_check_key(struct btree *b, struct btree_op *op,
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
