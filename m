Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pl0-f65.google.com ([209.85.160.65]:40177 "EHLO
        mail-pl0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754823AbeCSAg5 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 18 Mar 2018 20:36:57 -0400
Received: by mail-pl0-f65.google.com with SMTP id x4-v6so274802pln.7
        for <linux-block@vger.kernel.org>; Sun, 18 Mar 2018 17:36:57 -0700 (PDT)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@fb.com, Bart Van Assche <bart.vanassche@wdc.com>
Subject: [for-4.17 14/20] bcache: Add __printf annotation to __bch_check_keys()
Date: Sun, 18 Mar 2018 17:36:27 -0700
Message-Id: <20180319003633.27225-15-mlyle@lyle.org>
In-Reply-To: <20180319003633.27225-1-mlyle@lyle.org>
References: <20180319003633.27225-1-mlyle@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Bart Van Assche <bart.vanassche@wdc.com>

Make it possible for the compiler to verify the consistency of the
format string passed to __bch_check_keys() and the arguments that
should be formatted according to that format string.

Signed-off-by: Bart Van Assche <bart.vanassche@wdc.com>
Reviewed-by: Michael Lyle <mlyle@lyle.org>
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
2.14.1
