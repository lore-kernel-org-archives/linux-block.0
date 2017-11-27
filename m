Return-Path: <geert@linux-m68k.org>
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Jens Axboe <axboe@kernel.dk>,
	Christoph Hellwig <hch@lst.de>
Cc: Arnd Bergmann <arnd@arndb.de>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] block: Add default switch case to blk_pm_allow_request() to kill warning
Date: Mon, 27 Nov 2017 21:40:54 +0100
Message-Id: <1511815254-18166-1-git-send-email-geert+renesas@glider.be>
List-ID: <linux-block@vger.kernel.org>

With gcc 4.9.0:

    block/blk-core.c: In function 'blk_pm_allow_request':
    block/blk-core.c:2607:2: warning: enumeration value 'RPM_ACTIVE' not handled in switch [-Wswitch]
      switch (rq->q->rpm_status) {
      ^

Convert the return statement below the switch() block into a default
case to fix this.

Fixes: e4f36b249b4d4e75 ("block: fix peeking requests during PM")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
 block/blk-core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/block/blk-core.c b/block/blk-core.c
index b8881750a3acd705..579e683c95e26049 100644
--- a/block/blk-core.c
+++ b/block/blk-core.c
@@ -2610,9 +2610,9 @@ static bool blk_pm_allow_request(struct request *rq)
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
2.7.4
