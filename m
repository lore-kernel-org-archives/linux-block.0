Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] sbitmap: initialize weight to zero
Date: Mon, 19 Sep 2016 14:34:08 +0100
Message-Id: <20160919133408.25559-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Variable weight is not being initialized to zero before it is
used to compute the weight sum. Ensure it is initialized to zero.

Found with static analysis with cppcheck:
[lib/sbitmap.c:177]: (error) Uninitialized variable: weight

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 lib/sbitmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/lib/sbitmap.c b/lib/sbitmap.c
index e408089..2cecf05 100644
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
2.9.3
