Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	Omar Sandoval <osandov@fb.com>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] sbitmap: avoid maybe-uninitialized warning
Date: Mon, 19 Sep 2016 14:33:48 +0200
Message-Id: <20160919123359.1225305-1-arnd@arndb.de>
List-ID: <linux-block@vger.kernel.org>

The sbitmap code that has just been turned into a library module
returns uninitialized data for sbitmap_weight(), as pointed out by
gcc when building with -Wmaybe-uninitialized:

lib/sbitmap.c: In function 'sbitmap_weight':
lib/sbitmap.c:179:9: error: 'weight' may be used uninitialized in this function [-Werror=maybe-uninitialized]

Note that the value is never initialized, we just add data on
top, so it is wrong regardless of sb->map_nr.

This adds the missing initialization.

Fixes: 88459642cba4 ("blk-mq: abstract tag allocation out into sbitmap library")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 lib/sbitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index e40808921544..2cecf05c82fd 100644
--- a/lib/sbitmap.c
+++ b/lib/sbitmap.c
@@ -169,7 +169,7 @@ EXPORT_SYMBOL_GPL(sbitmap_any_bit_clear);
 
 unsigned int sbitmap_weight(const struct sbitmap *sb)
 {
-	unsigned int i, weight;
+	unsigned int i, weight = 0;
 
 	for (i = 0; i < sb->map_nr; i++) {
 		const struct sbitmap_word *word = &sb->map[i];
-- 
2.9.0
