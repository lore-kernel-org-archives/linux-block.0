Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-oi0-f65.google.com ([209.85.218.65]:41531 "EHLO
        mail-oi0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727623AbeIGQlw (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Fri, 7 Sep 2018 12:41:52 -0400
MIME-Version: 1.0
From: Junhui Tang <tang.junhui.linux@gmail.com>
Date: Fri, 7 Sep 2018 20:01:41 +0800
Message-ID: <CA+NNRhHMQDo8MZ7x=jiZnu8PdRD+pw_PE9CzH5-9oNQga92Wkw@mail.gmail.com>
Subject: [PATCH] bcache: fix ioctl in flash device
To: colyli@suse.de
Cc: linux-bcache@vger.kernel.org, linux-block@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

>From 799ad1d9443a28eb640c8dbc3abe8a224f3a1292 Mon Sep 17 00:00:00 2001
From: Tang Junhui <tang.junhui.linux@gmail.com>
Date: Sat, 8 Sep 2018 03:51:30 +0800
Subject: [PATCH] bcache: fix ioctl in flash device

When doing ioctl in flash device, it will call ioctl_dev() in super.c,
then we should not to get cached device since flash only device has
no backend device. This patch just move the jugement dc->io_disable
to cached_dev_ioctl() to make ioctl in flash device correctly.

Signed-off-by: Tang Junhui <tang.junhui.linux@gmail.com>
---
 drivers/md/bcache/request.c | 3 +++
 drivers/md/bcache/super.c   | 4 ----
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/md/bcache/request.c b/drivers/md/bcache/request.c
index 7dbe8b6..bafc85e 100644
--- a/drivers/md/bcache/request.c
+++ b/drivers/md/bcache/request.c
@@ -1212,6 +1212,9 @@ static int cached_dev_ioctl(struct bcache_device
*d, fmode_t mode,
      unsigned int cmd, unsigned long arg)
 {
  struct cached_dev *dc = container_of(d, struct cached_dev, disk);
+
+ if (dc->io_disable)
+ return -EIO;
  return __blkdev_driver_ioctl(dc->bdev, mode, cmd, arg);
 }

diff --git a/drivers/md/bcache/super.c b/drivers/md/bcache/super.c
index 55a3764..ced830e 100644
--- a/drivers/md/bcache/super.c
+++ b/drivers/md/bcache/super.c
@@ -636,10 +636,6 @@ static int ioctl_dev(struct block_device *b, fmode_t mode,
       unsigned int cmd, unsigned long arg)
 {
  struct bcache_device *d = b->bd_disk->private_data;
- struct cached_dev *dc = container_of(d, struct cached_dev, disk);
-
- if (dc->io_disable)
- return -EIO;

  return d->ioctl(d, mode, cmd, arg);
 }
-- 
1.8.3.1
