Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mail-wr0-f195.google.com ([209.85.128.195]:43869 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754442AbeAKNJU (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 11 Jan 2018 08:09:20 -0500
Received: by mail-wr0-f195.google.com with SMTP id s13so2086756wra.10
        for <linux-block@vger.kernel.org>; Thu, 11 Jan 2018 05:09:19 -0800 (PST)
From: Ilya Dryomov <idryomov@gmail.com>
To: linux-block@vger.kernel.org
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@infradead.org>,
        Tejun Heo <tj@kernel.org>, David Disseldorp <ddiss@suse.de>,
        Sagi Grimberg <sagi@grimberg.me>
Subject: [PATCH v3 0/2] block: enforce ioctl(BLKROSET) and set_disk_ro()
Date: Thu, 11 Jan 2018 14:09:10 +0100
Message-Id: <1515676152-18476-1-git-send-email-idryomov@gmail.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello,

I was doing some cleanup work on rbd BLKROSET handler and discovered
that we ignore partition rw/ro setting (hd_struct->policy) for pretty
much everything but straight writes.

David (CCed) has blktests patches standing by.

(Another aspect of this is that we don't enforce open(2) mode.  Tejun
took a stab at this a few years ago, but his patch had to be reverted:

  75f1dc0d076d ("block: check bdev_read_only() from blkdev_get()")
  e51900f7d38c ("block: revert block_dev read-only check")

It is a separate issue and refusing writes to read-only devices is
obviously more important, but perhaps it's time to revisit that as
well?)

v2 -> v3:
- lookup part only once; combine read-only check with existing
  should_fail_request check

v1 -> v2:
- added unlikely() per Sagi's suggestion

Thanks,

                Ilya


Ilya Dryomov (2):
  block: fail op_is_write() requests to read-only partitions
  block: add bdev_read_only() checks to common helpers

 block/blk-core.c | 56 ++++++++++++++++++++++++++++++++++++++------------------
 block/blk-lib.c  | 12 ++++++++++++
 2 files changed, 50 insertions(+), 18 deletions(-)

-- 
2.4.3
