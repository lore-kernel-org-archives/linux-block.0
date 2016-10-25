Return-Path: <jack@suse.cz>
From: Jan Kara <jack@suse.cz>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bart.vanassche@sandisk.com>,
	Jan Kara <jack@suse.cz>
Subject: [PATCH 2/2] brd: Switch rd_size to unsigned long
Date: Tue, 25 Oct 2016 13:53:27 +0200
Message-Id: <1477396407-28847-2-git-send-email-jack@suse.cz>
In-Reply-To: <1477396407-28847-1-git-send-email-jack@suse.cz>
References: <1477396407-28847-1-git-send-email-jack@suse.cz>
List-ID: <linux-block@vger.kernel.org>

Currently rd_size was int which lead to overflow and bogus device size
once the requested ramdisk size was 1 TB or more. Although these days
ramdisks with 1 TB size are mostly a mistake, the days when they are
useful are not far.

Reported-by: Bart Van Assche <bart.vanassche@sandisk.com>
Signed-off-by: Jan Kara <jack@suse.cz>
---
 drivers/block/brd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/brd.c b/drivers/block/brd.c
index 8b22e4a04918..6af087068ab3 100644
--- a/drivers/block/brd.c
+++ b/drivers/block/brd.c
@@ -443,8 +443,8 @@ static int rd_nr = CONFIG_BLK_DEV_RAM_COUNT;
 module_param(rd_nr, int, S_IRUGO);
 MODULE_PARM_DESC(rd_nr, "Maximum number of brd devices");
 
-static int rd_size = CONFIG_BLK_DEV_RAM_SIZE;
-module_param(rd_size, int, S_IRUGO);
+static unsigned long rd_size = CONFIG_BLK_DEV_RAM_SIZE;
+module_param(rd_size, ulong, S_IRUGO);
 MODULE_PARM_DESC(rd_size, "Size of each RAM disk in kbytes.");
 
 static int max_part = 1;
-- 
2.6.6
