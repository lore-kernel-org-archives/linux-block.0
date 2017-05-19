Return-Path: <mka@google.com>
Return-Path: <mka@google.com>
From: Matthias Kaehlcke <mka@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] block: partitions: mac: Put mac_fix_string() inside #ifdef section
Date: Fri, 19 May 2017 09:32:41 -0700
Message-Id: <20170519163241.30748-1-mka@chromium.org>
List-ID: <linux-block@vger.kernel.org>

The function is only used when CONFIG_PPC_PMAC=y, put it inside the
existing #ifdef section. This fixes the following warning when building
with clang:

block/partitions/mac.c:22:20: error: unused function 'mac_fix_string'
    [-Werror,-Wunused-function]

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 block/partitions/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/mac.c b/block/partitions/mac.c
index 621317ac4d59..4002e8b9f465 100644
--- a/block/partitions/mac.c
+++ b/block/partitions/mac.c
@@ -13,7 +13,6 @@
 #ifdef CONFIG_PPC_PMAC
 #include <asm/machdep.h>
 extern void note_bootable_part(dev_t dev, int part, int goodness);
-#endif
 
 /*
  * Code to understand MacOS partition tables.
@@ -26,6 +25,7 @@ static inline void mac_fix_string(char *stg, int len)
 	for (i = len - 1; i >= 0 && stg[i] == ' '; i--)
 		stg[i] = 0;
 }
+#endif
 
 int mac_partition(struct parsed_partitions *state)
 {
-- 
2.13.0.303.g4ebf302169-goog
