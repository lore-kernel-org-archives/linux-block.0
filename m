Return-Path: <elviskitone@gmail.com>
Return-Path: <elviskitone@gmail.com>
Date: Fri, 22 Jun 2018 14:35:57 +0300
From: Kitone Elvis Peter <elviskitone@gmail.com>
To: axboe@kernel.dk
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/3] block: Replace symbolic permissions
Message-ID: <20180622113557.GA6594@kitone-HP-ProBook-4530s>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Replace S_IRUGO with 0444 in module parameter declarations.
This makes it more readable and it matches the style used 
in other declarations.

Signed-off-by: Kitone Elvis Peter <elviskitone@gmail.com>
---
 drivers/block/brd.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 4f998ed..e2a1278 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -332,15 +332,15 @@ static const struct block_device_operations brd_fops = {
  * And now the modules code and kernel interface.
  */
 static int rd_nr = CONFIG_BLK_DEV_RAM_COUNT;
-module_param(rd_nr, int, S_IRUGO);
+module_param(rd_nr, int, 0444);
 MODULE_PARM_DESC(rd_nr, "Maximum number of brd devices");
 
 unsigned long rd_size = CONFIG_BLK_DEV_RAM_SIZE;
-module_param(rd_size, ulong, S_IRUGO);
+module_param(rd_size, ulong, 0444);
 MODULE_PARM_DESC(rd_size, "Size of each RAM disk in kbytes.");
 
 static int max_part = 1;
-module_param(max_part, int, S_IRUGO);
+module_param(max_part, int, 0444);
 MODULE_PARM_DESC(max_part, "Num Minors to reserve between devices");
 
 MODULE_LICENSE("GPL");
-- 
2.7.4
