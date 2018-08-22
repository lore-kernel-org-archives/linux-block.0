Return-Path: <linux-block-owner@vger.kernel.org>
Received: from aserp2120.oracle.com ([141.146.126.78]:60994 "EHLO
        aserp2120.oracle.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726736AbeHVKYo (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 22 Aug 2018 06:24:44 -0400
From: Shan Hai <shan.hai@oracle.com>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org
Subject: [PATCH 1/1] bcache: release the lock before stopping the writeback thread
Date: Wed, 22 Aug 2018 15:00:56 +0800
Message-Id: <1534921256-13009-1-git-send-email-shan.hai@oracle.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

The writeback thread would exit with a lock held when the cache device is
detached via sysfs interface, fix it by releasing the held lock before exiting
the thread.

Signed-off-by: Shan Hai <shan.hai@oracle.com>
---
 drivers/md/bcache/writeback.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/writeback.c b/drivers/md/bcache/writeback.c
index 481d4cf..adc583f 100644
--- a/drivers/md/bcache/writeback.c
+++ b/drivers/md/bcache/writeback.c
@@ -679,8 +679,10 @@ static int bch_writeback_thread(void *arg)
 			 * data on cache. BCACHE_DEV_DETACHING flag is set in
 			 * bch_cached_dev_detach().
 			 */
-			if (test_bit(BCACHE_DEV_DETACHING, &dc->disk.flags))
+			if (test_bit(BCACHE_DEV_DETACHING, &dc->disk.flags)) {
+				up_write(&dc->writeback_lock);
 				break;
+			}
 		}
 
 		up_write(&dc->writeback_lock);
-- 
2.7.4
