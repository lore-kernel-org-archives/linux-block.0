Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44976 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1757525AbeDXMPH (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Tue, 24 Apr 2018 08:15:07 -0400
From: Coly Li <colyli@suse.de>
To: linux-bcache@vger.kernel.org
Cc: linux-block@vger.kernel.org, Coly Li <colyli@suse.de>
Subject: [PATCH 2/6] bcache: set CACHE_SET_IO_DISABLE in bch_cached_dev_error()
Date: Tue, 24 Apr 2018 20:14:42 +0800
Message-Id: <20180424121446.130552-3-colyli@suse.de>
In-Reply-To: <20180424121446.130552-1-colyli@suse.de>
References: <20180424121446.130552-1-colyli@suse.de>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Commit c7b7bd07404c5 ("bcache: add io_disable to struct cached_dev") tries
to stop bcache device by calling bcache_device_stop() when too many I/O
errors happened on backing device. But if there is internal I/O happening
on cache device (writeback scan, garbage collection, etc), a regular I/O
request triggers the internal I/Os may still holds a refcount of dc->count,
and the refcount may only be dropped after the internal I/O stopped.

By this patch, bch_cached_dev_error() will check if the backing device is
attached to a cache set, if yes that CACHE_SET_IO_DISABLE will be set to
flags of this cache set. Then internal I/Os on cache device will be
rejected and stopped immediately, and the bcache device can be stopped.

For people who are not familiar with the interesting refcount dependance,
let me explain a bit more how the fix works. Example the writeback thread
will scan cache device for dirty data writeback purpose. Before it stopps,
it holds a refcount of dc->count. When CACHE_SET_IO_DISABLE bit is set,
the internal I/O will stopped and the while-loop in bch_writeback_thread()
quits and calls cached_dev_put() to drop dc->count. If this is the last
refcount to drop, then cached_dev_detach_finish() will be called. In this
call back function, in turn closure_put(dc->disk.cl) is called to drop a
refcount of closure dc->disk.cl. If this is the last refcount of this
closure to drop, then cached_dev_flush() will be called. Then the cached
device is freed. So if CACHE_SET_IO_DISABLE is not set, the bache device
can not be stopped until all inernal cache device I/O stopped. For large
size cache device, and writeback thread competes locks with gc thread,
there might be a quite long time to wait.

Fixes: c7b7bd07404c5 ("bcache: add io_disable to struct cached_dev")
Signed-off-by: Coly Li <colyli@suse.de>
---
 drivers/md/bcache/super.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 06433fab8ece..85b22a7a2366 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1368,6 +1368,8 @@ int bch_flash_dev_create(struct cache_set *c, uint64_t size)
 
 bool bch_cached_dev_error(struct cached_dev *dc)
 {
+	struct cache_set *c;
+
 	if (!dc || test_bit(BCACHE_DEV_CLOSING, &dc->disk.flags))
 		return false;
 
@@ -1378,6 +1380,21 @@ bool bch_cached_dev_error(struct cached_dev *dc)
 	pr_err("stop %s: too many IO errors on backing device %s\n",
 		dc->disk.disk->disk_name, dc->backing_dev_name);
 
+	/*
+	 * If the cached device is still attached to a cache set,
+	 * even dc->io_disable is true and no more I/O requests
+	 * accepted, cache device internal I/O (writeback scan or
+	 * garbage collection) may still prevent bcache device from
+	 * being stopped. So here CACHE_SET_IO_DISABLE should be
+	 * set to c->flags too, to make the internal I/O to cache
+	 * device rejected and stopped immediately.
+	 * If c is NULL, that means the bcache device is not attached
+	 * to any cache set, then no CACHE_SET_IO_DISABLE bit to set.
+	 */
+	c = dc->disk.c;
+	if (c && test_and_set_bit(CACHE_SET_IO_DISABLE, &c->flags))
+		pr_warn("CACHE_SET_IO_DISABLE already set");
+
 	bcache_device_stop(&dc->disk);
 	return true;
 }
-- 
2.16.2
