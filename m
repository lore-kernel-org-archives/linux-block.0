Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 1/2] brd: Make rd_size argument static
Date: Tue, 25 Oct 2016 13:53:26 +0200
Message-Id: <1477396407-28847-1-git-send-email-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

rd_size does not appear to be used outside of brd. Make it static.

Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/brd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 0c76d4016eeb..8b22e4a04918 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -443,7 +443,7 @@ static int rd_nr = CONFIG_BLK_DEV_RAM_COUNT;
 module_param(rd_nr, int, S_IRUGO);
 MODULE_PARM_DESC(rd_nr, "Maximum number of brd devices");
 
-int rd_size = CONFIG_BLK_DEV_RAM_SIZE;
+static int rd_size = CONFIG_BLK_DEV_RAM_SIZE;
 module_param(rd_size, int, S_IRUGO);
 MODULE_PARM_DESC(rd_size, "Size of each RAM disk in kbytes.");
 
-- 
2.6.6
