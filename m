Return-Path: <zhongjiang@huawei.com>
From: zhong jiang <zhongjiang@huawei.com>
To: <axboe@kernel.dk>
CC: <roger.pau@citrix.com>, <konrad.wilk@oracle.com>,
	<xen-devel@lists.xenproject.org>, <linux-block@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>
Subject: [PATCH] drivers/block/xen-blkback/common.h: use DIV_ROUND_UP instead of reimplementing its function
Date: Wed, 12 Sep 2018 13:45:00 +0800
Message-ID: <1536731100-56054-1-git-send-email-zhongjiang@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

DIV_ROUND_UP has implemented the code-opened function. Therefore, just
replace the implementation with DIV_ROUND_UP.

Signed-off-by: zhong jiang <zhongjiang@huawei.com>
---
 drivers/block/xen-blkback/common.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/xen-blkback/common.h b/drivers/block/xen-blkback/common.h
index 1d3002d..874613d 100644
--- a/drivers/block/xen-blkback/common.h
+++ b/drivers/block/xen-blkback/common.h
@@ -65,7 +65,7 @@
 	(XEN_PAGES_PER_INDIRECT_FRAME / XEN_PAGES_PER_SEGMENT)
 
 #define MAX_INDIRECT_PAGES \
-	((MAX_INDIRECT_SEGMENTS + SEGS_PER_INDIRECT_FRAME - 1)/SEGS_PER_INDIRECT_FRAME)
+		DIV_ROUND_UP(MAX_INDIRECT_SEGMENTS, SEGS_PER_INDIRECT_FRAME)
 #define INDIRECT_PAGES(_segs) DIV_ROUND_UP(_segs, XEN_PAGES_PER_INDIRECT_FRAME)
 
 /* Not a real protocol.  Used to generate ring structs which contain
-- 
1.7.12.4
