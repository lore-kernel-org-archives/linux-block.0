Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f68.google.com ([209.85.160.68]:41169 "EHLO
        mail-pl0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754301AbeCSAg4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Mar 2018 20:36:56 -0400
Received: by mail-pl0-f68.google.com with SMTP id b7-v6so5143319plr.8
        for <linux-block@vger.kernel.org>; Sun, 18 Mar 2018 17:36:56 -0700 (PDT)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@fb.com, Bart Van Assche <bart.vanassche@wdc.com>
Subject: [for-4.17 13/20] bcache: Fix indentation
Date: Sun, 18 Mar 2018 17:36:26 -0700
Message-Id: <20180319003633.27225-14-mlyle@lyle.org>
In-Reply-To: <20180319003633.27225-1-mlyle@lyle.org>
References: <20180319003633.27225-1-mlyle@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Bart Van Assche <bart.vanassche@wdc.com>

This patch avoids that smatch complains about inconsistent indentation.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
Reviewed-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/btree.c     | 2 +-
 drivers/md/bcache/writeback.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index d64aff0b8abc..143ed5a758e7 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -2178,7 +2178,7 @@ int bch_btree_insert_check_key(struct btree *b, struct btree_op *op,
 
 		if (b->key.ptr[0] != btree_ptr ||
                    b->seq != seq + 1) {
-                       op->lock = b->level;
+			op->lock = b->level;
 			goto out;
                }
 	}
diff --git a/drivers/md/bcache/writeback.h b/drivers/md/bcache/writeback.h
index 0bba8f1c6cdf..610fb01de629 100644
--- a/drivers/md/bcache/writeback.h
+++ b/drivers/md/bcache/writeback.h
@@ -39,7 +39,7 @@ static inline uint64_t  bcache_flash_devs_sectors_dirty(struct cache_set *c)
 
 		if (!d || !UUID_FLASH_ONLY(&c->uuids[i]))
 			continue;
-	   ret += bcache_dev_sectors_dirty(d);
+		ret += bcache_dev_sectors_dirty(d);
 	}
 
 	mutex_unlock(&bch_register_lock);
-- 
2.14.1
