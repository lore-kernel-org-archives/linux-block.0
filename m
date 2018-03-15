Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa2.hgst.iphmx.com ([68.232.143.124]:4231 "EHLO
        esa2.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752748AbeCOPI2 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 15 Mar 2018 11:08:28 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Michael Lyle <mlyle@lyle.org>,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Coly Li <colyli@suse.de>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 02/16] bcache: Add __printf annotation to __bch_check_keys()
Date: Thu, 15 Mar 2018 08:08:00 -0700
Message-Id: <20180315150814.9412-3-bart.vanassche@wdc.com>
In-Reply-To: <20180315150814.9412-1-bart.vanassche@wdc.com>
References: <20180315150814.9412-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Make it possible for the compiler to verify the consistency of the
format string passed to __bch_check_keys() and the arguments that
should be formatted according to that format string.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
---
 drivers/md/bcache/bset.h | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/md/bcache/bset.h b/drivers/md/bcache/bset.h
index fa506c1aa524..0c24280f3b98 100644
--- a/drivers/md/bcache/bset.h
+++ b/drivers/md/bcache/bset.h
@@ -531,14 +531,15 @@ int __bch_keylist_realloc(struct keylist *, unsigned);
 #ifdef CONFIG_BCACHE_DEBUG
 
 int __bch_count_data(struct btree_keys *);
-void __bch_check_keys(struct btree_keys *, const char *, ...);
+void __printf(2, 3) __bch_check_keys(struct btree_keys *, const char *, ...);
 void bch_dump_bset(struct btree_keys *, struct bset *, unsigned);
 void bch_dump_bucket(struct btree_keys *);
 
 #else
 
 static inline int __bch_count_data(struct btree_keys *b) { return -1; }
-static inline void __bch_check_keys(struct btree_keys *b, const char *fmt, ...) {}
+static inline void __printf(2, 3)
+	__bch_check_keys(struct btree_keys *b, const char *fmt, ...) {}
 static inline void bch_dump_bucket(struct btree_keys *b) {}
 void bch_dump_bset(struct btree_keys *, struct bset *, unsigned);
 
-- 
2.16.2
