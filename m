Return-Path: <evgreen@chromium.org>
Return-Path: <evgreen@chromium.org>
From: Evan Green <evgreen@chromium.org>
To: Jens Axboe <axboe@kernel.dk>,
	linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Sam Hurst <shurst@google.com>,
	Evan Green <evgreen@chromium.org>
Subject: [PATCH] loop: Add LOOP_SET_BLOCK_SIZE in compat ioctl
Date: Mon,  2 Jul 2018 16:03:46 -0700
Message-Id: <20180702230346.72350-1-evgreen@chromium.org>
List-ID: <linux-block@vger.kernel.org>

This change adds LOOP_SET_BLOCK_SIZE as one of the supported ioctls
in lo_compat_ioctl. It only takes an unsigned long argument, and
in practice a 32-bit value works fine.

Signed-off-by: Evan Green <evgreen@chromium.org>
---
 drivers/block/loop.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/loop.c b/drivers/block/loop.c
index d6b6f434fd4b..4cb1d1be3cfb 100644
--- a/drivers/block/loop.c
+++ b/drivers/block/loop.c
@@ -1613,6 +1613,7 @@ static int lo_compat_ioctl(struct block_device *bdev, fmode_t mode,
 		arg = (unsigned long) compat_ptr(arg);
 	case LOOP_SET_FD:
 	case LOOP_CHANGE_FD:
+	case LOOP_SET_BLOCK_SIZE:
 		err = lo_ioctl(bdev, mode, cmd, arg);
 		break;
 	default:
-- 
2.16.4
