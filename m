Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: Jens Axboe <axboe@kernel.dk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] blk-bwt: fix old-style function declaration
Date: Wed, 16 Nov 2016 16:29:57 +0100
Message-Id: <20161116153007.3543720-1-arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-block@vger.kernel.org>

The newly added driver causes a harmless warning in some configurations:

block/blk-wbt.c:250:1: error: ‘inline’ is not at beginning of declaration [-Werror=old-style-declaration]
 static bool inline stat_sample_valid(struct blk_rq_stat *stat)

This makes it use the expected format for the declaration.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 block/blk-wbt.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/blk-wbt.c b/block/blk-wbt.c
index 20712f0db6ea..9f97594e68ce 100644
--- a/block/blk-wbt.c
+++ b/block/blk-wbt.c
@@ -247,7 +247,7 @@ static bool calc_wb_limits(struct rq_wb *rwb)
 	return ret;
 }
 
-static bool inline stat_sample_valid(struct blk_rq_stat *stat)
+static inline bool stat_sample_valid(struct blk_rq_stat *stat)
 {
 	/*
 	 * We need at least one read sample, and a minimum of
-- 
2.9.0
