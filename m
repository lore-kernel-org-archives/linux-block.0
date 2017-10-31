Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.didichuxing.com ([111.202.154.82]:29035 "EHLO
        BJEXCAS002.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1752838AbdJaKjF (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 31 Oct 2017 06:39:05 -0400
Date: Tue, 31 Oct 2017 18:38:59 +0800
From: weiping zhang <zhangweiping@didichuxing.com>
To: <axboe@kernel.dk>, <jack@suse.cz>
CC: <linux-block@vger.kernel.org>, <linux-mm@kvack.org>
Subject: [PATCH v2 3/3] block: add WARN_ON if bdi register fail
Message-ID: <389034ebd68d3c1f3e49fac68b783195c287ce56.1509415695.git.zhangweiping@didichuxing.com>
References: <cover.1509415695.git.zhangweiping@didichuxing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <cover.1509415695.git.zhangweiping@didichuxing.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

device_add_disk need do more safety error handle, so this patch just
add WARN_ON.

Reviewed-by: Jan Kara <jack@suse.cz>
Signed-off-by: weiping zhang <zhangweiping@didichuxing.com>
---
 block/genhd.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/block/genhd.c b/block/genhd.c
index dd305c65ffb0..52834433878c 100644
--- a/block/genhd.c
+++ b/block/genhd.c
@@ -660,7 +660,7 @@ void device_add_disk(struct device *parent, struct gendisk *disk)
 
 	/* Register BDI before referencing it from bdev */
 	bdi = disk->queue->backing_dev_info;
-	bdi_register_owner(bdi, disk_to_dev(disk));
+	WARN_ON(bdi_register_owner(bdi, disk_to_dev(disk)));
 
 	blk_register_region(disk_devt(disk), disk->minors, NULL,
 			    exact_match, exact_lock, disk);
-- 
2.14.2
