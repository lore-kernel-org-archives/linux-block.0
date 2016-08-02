Return-Path: <iamyooon@gmail.com>
Return-Path: <iamyooon@gmail.com>
From: "seokhoon.yoon" <iamyooon@gmail.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	iamyooon@gmail.com
Subject: [PATCH 1/1] blkio: update cgroup's document path
Date: Tue,  2 Aug 2016 23:31:31 +0900
Message-Id: <1470148291-6269-1-git-send-email-iamyooon@gmail.com>
List-ID: <linux-block@vger.kernel.org>

cgroup's document path is changed to "cgroup-v1". update it.

Signed-off-by: seokhoon.yoon <iamyooon@gmail.com>
---
 block/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/Kconfig b/block/Kconfig
index 0363cd7..5665ffe 100644
--- a/block/Kconfig
+++ b/block/Kconfig
@@ -111,7 +111,7 @@ config BLK_DEV_THROTTLING
 	one needs to mount and use blkio cgroup controller for creating
 	cgroups and specifying per device IO rate policies.
 
-	See Documentation/cgroups/blkio-controller.txt for more information.
+	See Documentation/cgroup-v1/blkio-controller.txt for more information.
 
 config BLK_CMDLINE_PARSER
 	bool "Block device command line partition parser"
-- 
1.9.1
