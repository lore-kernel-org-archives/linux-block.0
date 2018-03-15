Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:46680 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752705AbeCOPI2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:08:28 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 01/16] bcache: Fix indentation
Date: Thu, 15 Mar 2018 08:07:59 -0700
Message-Id: <20180315150814.9412-2-bart.vanassche@wdc.com>
In-Reply-To: <20180315150814.9412-1-bart.vanassche@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

This patch avoids that smatch complains about inconsistent indentation.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 drivers/md/bcache/btree.c     | 2 +-
 drivers/md/bcache/writeback.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/btree.c b/drivers/md/bcache/btree.c
index fad9fe8817eb..c30609c54c03 100644
--- a/drivers/md/bcache/btree.c
+++ b/drivers/md/bcache/btree.c
@@ -2170,7 +2170,7 @@ int bch_btree_insert_check_key(struct btree *b, struct btree_op *op,
 
 		if (b->key.ptr[0] != btree_ptr ||
                    b->seq != seq + 1) {
-                       op->lock = b->level;
+			op->lock = b->level;
 			goto out;
                }
 	}
diff --git a/drivers/md/bcache/writeback.h b/drivers/md/bcache/writeback.h
index 587b25599856..a102d40a58bc 100644
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
2.16.2
