Return-Path: <ekorenevsky@gmail.com>
Return-Path: <ekorenevsky@gmail.com>
Date: Sun, 22 Jul 2018 01:28:49 +0300
From: Eugene Korenevsky <ekorenevsky@gmail.com>
To: Jens Axboe <axboe@kernel.dk>, linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Subject: [PATCH] genhd: register_disk: inform about dev_set_name() failure
Message-ID: <20180721222849.GA23331@vnote>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-ID: <linux-block@vger.kernel.org>

Although dev_set_name() failure is not fatal, it is better to print
a warning message into dmesg about it.

Signed-off-by: Eugene Korenevsky <ekorenevsky@gmail.com>
---
 block/genhd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index f1543a45e73b..071f8cbd529a 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -577,7 +577,9 @@ static void register_disk(struct device *parent, struct gendisk *disk)
 
 	ddev->parent = parent;
 
-	dev_set_name(ddev, "%s", disk->disk_name);
+	err = dev_set_name(ddev, "%s", disk->disk_name);
+	if (err)
+		pr_warn("%s: cannot set disk name: %d", __func__, err);
 
 	/* delay uevents, until we scanned partition table */
 	dev_set_uevent_suppress(ddev, 1);
-- 
2.18.0
