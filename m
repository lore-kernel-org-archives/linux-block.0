Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.didichuxing.com ([111.202.154.82]:21752 "EHLO
        BJEXMBX012.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S932291AbdJZRgt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 26 Oct 2017 13:36:49 -0400
Date: Fri, 27 Oct 2017 01:36:42 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>, <jack@suse.cz>
CC: <linux-block@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH 4/4] block: add WARN_ON if bdi register fail
Message-ID: <413b04ba6a2a0b03b0cb3c578865d71b2ef97921.1509038624.git.zhangweiping@didichuxing.com>
References: <cover.1509038624.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1509038624.git.zhangweiping@didichuxing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

device_add_disk need do more safety error handle, so this patch just
add WARN_ON.

Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/genhd.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index dd305c65ffb0..cb55eea821eb 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -660,7 +660,9 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
 
 	/* Register BDI before referencing it from bdev */
 	bdi = disk->queue->backing_dev_info;
-	bdi_register_owner(bdi, disk_to_dev(disk));
+	retval = bdi_register_owner(bdi, disk_to_dev(disk));
+	if (retval)
+		WARN_ON(1);
 
 	blk_register_region(disk_devt(disk), disk->minors, NULL,
 			    exact_match, exact_lock, disk);
-- 
2.14.2
