Return-Path: <yanaijie@huawei.com>
From: Jason Yan <yanaijie@huawei.com>
To: <axboe@kernel.dk>, <linux-block@vger.kernel.org>
CC: <miaoxie@huawei.com>, <zhaohongjiang@huawei.com>,
        Jason Yan
	<yanaijie@huawei.com>
Subject: [PATCH] brd: make rd_size static
Date: Fri, 10 Mar 2017 15:32:39 +0800
Message-ID: <1489131159-840-1-git-send-email-yanaijie@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

Fixes the following sparse warning:

drivers/block/brd.c:411:15: warning: symbol 'rd_size' was not declared.
Should it be static?

Signed-off-by: Jason Yan <yanaijie@huawei.com>
---
 drivers/block/brd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 3adc32a..e5d9f35 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -408,7 +408,7 @@ static int rd_nr = CONFIG_BLK_DEV_RAM_COUNT;
 module_param(rd_nr, int, S_IRUGO);
 MODULE_PARM_DESC(rd_nr, "Maximum number of brd devices");
 
-unsigned long rd_size = CONFIG_BLK_DEV_RAM_SIZE;
+static unsigned long rd_size = CONFIG_BLK_DEV_RAM_SIZE;
 module_param(rd_size, ulong, S_IRUGO);
 MODULE_PARM_DESC(rd_size, "Size of each RAM disk in kbytes.");
 
-- 
2.5.0
