Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-pf0-f196.google.com ([209.85.192.196]:50647 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753192AbdJMXgE (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 13 Oct 2017 19:36:04 -0400
Received: by mail-pf0-f196.google.com with SMTP id b6so3103986pfh.7
        for <linux-block@vger.kernel.org>; Fri, 13 Oct 2017 16:36:03 -0700 (PDT)
From: Michael Lyle <mlyle@lyle.org>
To: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Cc: axboe@fb.com, Yijing Wang <wangyijing@huawei.com>
Subject: [PATCH 05/15] bcache: Remove redundant set_capacity
Date: Fri, 13 Oct 2017 16:35:32 -0700
Message-Id: <20171013233542.20938-6-mlyle@lyle.org>
In-Reply-To: <20171013233542.20938-1-mlyle@lyle.org>
References: <20171013233542.20938-1-mlyle@lyle.org>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

From: Yijing Wang <wangyijing@huawei.com>

set_capacity() has been called in bcache_device_init(),
remove the redundant one.

Signed-off-by: Yijing Wang <wangyijing@huawei.com>
Reviewed-by: Eric Wheeler <bcache@linux.ewheeler.net>
Acked-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index a478d1ac0480..72c3b2929ef0 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1142,9 +1142,6 @@ static int cached_dev_init(struct cached_dev *dc, unsigned block_size)
 	if (ret)
 		return ret;
 
-	set_capacity(dc->disk.disk,
-		     dc->bdev->bd_part->nr_sects - dc->sb.data_offset);
-
 	dc->disk.disk->queue->backing_dev_info->ra_pages =
 		max(dc->disk.disk->queue->backing_dev_info->ra_pages,
 		    q->backing_dev_info->ra_pages);
-- 
2.11.0
