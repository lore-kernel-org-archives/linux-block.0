Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f66.google.com ([209.85.218.66]:34266 "EHLO
        mail-oi0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725973AbeIANoC (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Sat, 1 Sep 2018 09:44:02 -0400
MIME-Version: 1.0
From: Junhui Tang <tang.junhui.linux@gmail.com>
Date: Sat, 1 Sep 2018 17:34:40 +0800
Message-ID: <CA+NNRhEk+aRdzfs5vDOwKLDznEZjVRE32n4M+L=wV5ySrpmRpQ@mail.gmail.com>
Subject: [PATCH] bcache: correct dirty data statistics
To: colyli@suse.de
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>From fb4bdec3fce8016e813b4b8da6e705fb65d910f2 Mon Sep 17 00:00:00 2001
From: Tang Junhui <tang.junhui.linux@gmail.com>
Date: Sun, 2 Sep 2018 01:22:22 +0800
Subject: [PATCH] bcache: correct dirty data statistics

When bcache device is clean, dirty keys may still exist after
journal replay, so we need to count these dirty keys even
device in clean status, otherwise after writeback, the amount
of dirty data would be incorrect.

Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>
---
 drivers/md/bcache/super.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 55a3764..c5f0f65 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -1139,11 +1139,12 @@ int bch_cached_dev_attach(struct cached_dev
*dc, struct cache_set *c,
  }

  if (BDEV_STATE(&dc->sb) == BDEV_STATE_DIRTY) {
- bch_sectors_dirty_init(&dc->disk);
  atomic_set(&dc->has_dirty, 1);
  bch_writeback_queue(dc);
  }

+ bch_sectors_dirty_init(&dc->disk);
+
  bch_cached_dev_run(dc);
  bcache_device_link(&dc->disk, c, "bdev");
  atomic_inc(&c->attached_dev_nr);
-- 
1.8.3.1
