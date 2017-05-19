Return-Path: <mka@google.com>
Return-Path: <mka@google.com>
From: Matthias Kaehlcke <mka@chromium.org>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Matthias Kaehlcke <mka@chromium.org>
Subject: [PATCH] block: partitions: mac: Mark mac_fix_string() as __maybe_unused
Date: Thu, 18 May 2017 18:24:54 -0700
Message-Id: <20170519012454.66962-1-mka@chromium.org>
List-ID: <linux-block@vger.kernel.org>

The function is only used when CONFIG_PPC_PMAC=y. Adding the attribute
fixes the following warning when building with clang:

block/partitions/mac.c:22:20: error: unused function 'mac_fix_string'
    [-Werror,-Wunused-function]

Signed-off-by: Matthias Kaehlcke <mka@chromium.org>
---
 block/partitions/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/partitions/mac.c b/block/partitions/mac.c
index 621317ac4d59..57483faddaac 100644
--- a/block/partitions/mac.c
+++ b/block/partitions/mac.c
@@ -19,7 +19,7 @@ extern void note_bootable_part(dev_t dev, int part, int goodness);
  * Code to understand MacOS partition tables.
  */
 
-static inline void mac_fix_string(char *stg, int len)
+static inline void __maybe_unused mac_fix_string(char *stg, int len)
 {
 	int i;
 
-- 
2.13.0.303.g4ebf302169-goog
