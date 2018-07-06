Return-Path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jens Axboe <axboe@kernel.dk>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v3] block: Add default switch case to blk_pm_allow_request() to kill warning
Date: Fri,  6 Jul 2018 10:49:35 +0200
Message-Id: <20180706084935.30359-1-geert+renesas@glider.be>
List-ID: <linux-block@vger.kernel.org>

With gcc 4.9.0 and 7.3.0:

    block/blk-core.c: In function 'blk_pm_allow_request':
    block/blk-core.c:2747:2: warning: enumeration value 'RPM_ACTIVE' not handled in switch [-Wswitch]
      switch (rq->q->rpm_status) {
      ^

Convert the return statement below the switch() block into a default
case to fix this.

Fixes: e4f36b249b4d4e75 ("block: fix peeking requests during PM")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Christoph Hellwig <hch@lst.de>
---
v3:
  - Update line number,
  - Add gcc 7.3.0,

v2:
  - Add Reviewed-by,
  - Update line number.
---
 block/blk-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index f84a9b7b6f5aa167..40e495073bdeec32 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2750,9 +2750,9 @@ static bool blk_pm_allow_request(struct request *rq)
 		return rq->rq_flags & RQF_PM;
 	case RPM_SUSPENDED:
 		return false;
+	default:
+		return true;
 	}
-
-	return true;
 }
 #else
 static bool blk_pm_allow_request(struct request *rq)
-- 
2.17.1
