Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44999 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757565AbeDXMPV (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Apr 2018 08:15:21 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 5/6] bcache: set dc->io_disable to true in conditional_stop_bcache_device()
Date: Tue, 24 Apr 2018 20:14:45 +0800
Message-Id: <20180424121446.130552-6-colyli@suse.de>
In-Reply-To: <20180424121446.130552-1-colyli@suse.de>
References: <20180424121446.130552-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Commit 7e027ca4b534b ("bcache: add stop_when_cache_set_failed option to
backing device") adds stop_when_cache_set_failed option and stops bcache
device if stop_when_cache_set_failed is auto and there is dirty data on
broken cache device. There might exists a small time gap that the cache
set is released and set to NULL but bcache device is not released yet
(because they are released in parallel). During this time gap, dc->c is
NULL so CACHE_SET_IO_DISABLE won't be checked, and dc->io_disable is still
false, so new coming I/O requests will be accepted and directly go into
backing device as no cache set attached to. If there is dirty data on
cache device, this behavior may introduce potential inconsistent data.

This patch sets dc->io_disable to true before calling bcache_device_stop()
to make sure the backing device will reject new coming I/O request as
well, so even in the small time gap no I/O will directly go into backing
device to corrupt data consistency.

Fixes: 7e027ca4b534b ("bcache: add stop_when_cache_set_failed option to backing device")
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 85b22a7a2366..487eb68b598f 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1555,6 +1555,20 @@ static void conditional_stop_bcache_device(struct cache_set *c,
 		 */
 		pr_warn("stop_when_cache_set_failed of %s is \"auto\" and cache is dirty, stop it to avoid potential data corruption.",
 			d->disk->disk_name);
+			/*
+			 * There might be a small time gap that cache set is
+			 * released but bcache device is not. Inside this time
+			 * gap, regular I/O requests will directly go into
+			 * backing device as no cache set attached to. This
+			 * behavior may also introduce potential inconsistence
+			 * data in writeback mode while cache is dirty.
+			 * Therefore before calling bcache_device_stop() due
+			 * to a broken cache device, dc->io_disable should be
+			 * explicitly set to true.
+			 */
+			dc->io_disable = true;
+			/* make others know io_disable is true earlier */
+			smp_mb();
 			bcache_device_stop(d);
 	} else {
 		/*
-- 
2.16.2
