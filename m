Return-Path: <linux-block-owner@vger.kernel.org>
Received: from out30-132.freemail.mail.aliyun.com ([115.124.30.132]:39316 "EHLO
        out30-132.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1753836AbeGETHk (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 5 Jul 2018 15:07:40 -0400
From: Liu Bo <bo.liu@linux.alibaba.com>
To: <linux-block@vger.kernel.org>
Subject: [PATCH] null_blk: remove NULLB_DEV_FL_CONFIGURED on turning off nullb device
Date: Fri,  6 Jul 2018 03:07:13 +0800
Message-Id: <1530817633-128360-1-git-send-email-bo.liu@linux.alibaba.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Currently mbps knob could only be set once before switching power knob to
on, after power knob has been set at least once, there is no way to set
mbps knob again due to -EBUSY.

As nullb is mainly used for testing, in order to make it flexible, this
removes the flag NULLB_DEV_FL_CONFIGURED so that mbps knob can be reset
when power knob is off, e.g.

echo 0 > /config/nullb/a/power
echo 40 > /config/nullb/a/mbps
echo 1 > /config/nullb/a/power

So does other knobs under /config/nullb/a.

Signed-off-by: Liu Bo <bo.liu@linux.alibaba.com>
---
 drivers/block/null_blk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/block/null_blk.c b/drivers/block/null_blk.c
index 2bdadd7f1454..ec0c49867996 100644
--- a/drivers/block/null_blk.c
+++ b/drivers/block/null_blk.c
@@ -390,6 +390,7 @@ static ssize_t nullb_device_power_store(struct config_item *item,
 		null_del_dev(dev->nullb);
 		mutex_unlock(&lock);
 		clear_bit(NULLB_DEV_FL_UP, &dev->flags);
+		clear_bit(NULLB_DEV_FL_CONFIGURED, &dev->flags);
 	}
 
 	return count;
-- 
1.8.3.1
