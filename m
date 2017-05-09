Return-Path: <linux-block-owner@vger.kernel.org>
Received: from iad1-shared-relay2.dreamhost.com ([208.113.157.41]:43861 "EHLO
        iad1-shared-relay2.dreamhost.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1751659AbdF3KQ1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 30 Jun 2017 06:16:27 -0400
Received: from iad1-shared-relay1.dreamhost.com (iad1-shared-relay1.dreamhost.com [208.113.157.50])
        by iad1-shared-relay2.dreamhost.com (Postfix) with ESMTP id ED5DA3E51D7
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:12:06 -0700 (PDT)
Received: from ware.dreamhost.com (ware.dreamhost.com [64.111.127.160])
        by iad1-shared-relay1.dreamhost.com (Postfix) with ESMTP id 2D43FB400A8
        for <linux-block@vger.kernel.org>; Thu, 29 Jun 2017 15:12:06 -0700 (PDT)
In-Reply-To: <20170629134510.GA32385@infradead.org>
References: <20170629134510.GA32385@infradead.org>
From: Jan Kara <jack@suse.cz>
Date: Tue, 9 May 2017 12:03:11 -0700
Subject: [PATCH 01/19] bcache: Fix leak of bdev reference
To: linux-block@vger.kernel.org
Message-Id: <20170629221205.B41DC100127@ware.dreamhost.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

If blkdev_get_by_path() in register_bcache() fails, we try to lookup the
block device using lookup_bdev() to detect which situation we are in to
properly report error. However we never drop the reference returned to
us from lookup_bdev(). Fix that.

Signed-off-by: Jan Kara <jack@suse.cz>
Cc: stable@vger.kernel.org
---
 drivers/md/bcache/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 8352fad..9a2c190 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1964,6 +1964,8 @@ static ssize_t register_bcache(struct kobject *k, struct kobj_attribute *attr,
 			else
 				err = "device busy";
 			mutex_unlock(&bch_register_lock);
+			if (!IS_ERR(bdev))
+				bdput(bdev);
 			if (attr == &ksysfs_register_quiet)
 				goto out;
 		}
-- 
1.8.3.1
