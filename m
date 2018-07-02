Return-Path: <colin.king@canonical.com>
From: Colin King <colin.king@canonical.com>
To: Jiri Kosina <jikos@kernel.org>,
	Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org
Cc: kernel-janitors@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] block/floppy: remove redundant variable dflags
Date: Mon,  2 Jul 2018 08:42:34 +0100
Message-Id: <20180702074234.10435-1-colin.king@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-ID: <linux-block@vger.kernel.org>

From: Colin Ian King <colin.king@canonical.com>

Variable dflags is being assigned but is never used hence it is redundant
and can be removed.

Cleans up clang warning:
warning: variable 'dflags' set but not used [-Wunused-but-set-variable]

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 drivers/block/floppy.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/block/floppy.c b/drivers/block/floppy.c
index 8871b5044d9e..48f622728ce6 100644
--- a/drivers/block/floppy.c
+++ b/drivers/block/floppy.c
@@ -1461,7 +1461,6 @@ static void setup_rw_floppy(void)
 	int i;
 	int r;
 	int flags;
-	int dflags;
 	unsigned long ready_date;
 	void (*function)(void);
 
@@ -1485,8 +1484,6 @@ static void setup_rw_floppy(void)
 		if (fd_wait_for_completion(ready_date, function))
 			return;
 	}
-	dflags = DRS->flags;
-
 	if ((flags & FD_RAW_READ) || (flags & FD_RAW_WRITE))
 		setup_DMA();
 
-- 
2.17.1
