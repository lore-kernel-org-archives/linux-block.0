Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4231 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752602AbeCOPIb (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:08:31 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 14/16] bcache: Make csum_set() implementation easier to read
Date: Thu, 15 Mar 2018 08:08:12 -0700
Message-Id: <20180315150814.9412-15-bart.vanassche@wdc.com>
In-Reply-To: <20180315150814.9412-1-bart.vanassche@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Introduce two temporary variables to avoid having to repeat
expressions. This patch does not change any functionality.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 drivers/md/bcache/bcache.h | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/bcache.h b/drivers/md/bcache/bcache.h
index 12e5197f186c..72b1ea4576d9 100644
--- a/drivers/md/bcache/bcache.h
+++ b/drivers/md/bcache/bcache.h
@@ -777,10 +777,12 @@ static inline bool ptr_available(struct cache_set *c, const struct bkey *k,
  * This is used for various on disk data structures - cache_sb, prio_set, bset,
  * jset: The checksum is _always_ the first 8 bytes of these structs
  */
-#define csum_set(i)							\
-	bch_crc64(((void *) (i)) + sizeof(uint64_t),			\
-		  ((void *) bset_bkey_last(i)) -			\
-		  (((void *) (i)) + sizeof(uint64_t)))
+#define csum_set(i) ({						\
+	const void *p = (void *)(i) + sizeof(uint64_t);		\
+	const void *q = bset_bkey_last(i);			\
+								\
+	bch_crc64(p, q - p);					\
+})
 
 /* Error handling macros */
 
-- 
2.16.2
