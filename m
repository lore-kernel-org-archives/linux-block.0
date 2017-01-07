Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mga14.intel.com ([192.55.52.115]:22471 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S933163AbdAGBG6 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 6 Jan 2017 20:06:58 -0500
Subject: [RFC PATCH v2 0/2] block: fix backing_dev_info lifetime
From: Dan Williams <dan.j.williams@intel.com>
To: linux-block@vger.kernel.org
Cc: Andi Kleen <ak@linux.intel.com>, Jan Kara <jack@suse.cz>,
        Rabin Vincent <rabinv@axis.com>, linux-nvdimm@lists.01.org,
        linux-kernel@vger.kernel.org, Jens Axboe <axboe@fb.com>,
        Jeff Moyer <jmoyer@redhat.com>, Wei Fang <fangwei1@huawei.com>,
        linux-fsdevel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Date: Fri, 06 Jan 2017 17:02:51 -0800
Message-ID: <148375097100.37020.495735345355345658.stgit@dwillia2-desk3.amr.corp.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

v1 of these changes [1] was a one line change to bdev_get_queue() to
prevent a shutdown crash when del_gendisk() races the final
__blkdev_put().

While it is known at del_gendisk() time that the queue is still alive,
Jan Kara points to other paths [2] that are racing __blkdev_put() where
the assumption that ->bd_queue, or inode->i_wb is valid does not hold.

Fix that broken assumption, make it the case that if you have a live
block_device, or block_device-inode that the corresponding queue and
inode-write-back data is still valid.

These changes survive a run of the libnvdimm unit test suite which puts
some stress on the block_device shutdown path.

---

Changes since v1 [1]:

* Introduce "block: fix lifetime of request_queue / backing_dev_info
  relative to bdev" to keep the queue allocated and the inode attached
  for writeback until ->destroy_inode() time.

* Rework the comments in "block: fix blk_get_backing_dev_info() crash,
  use bdev->bd_queue" to reflect the assumptions about the liveness of
  ->bd_queue.

[1]: http://marc.info/?l=linux-block&m=148366637105761&w=2
[2]: http://www.spinics.net/lists/linux-fsdevel/msg105153.html

---

Dan Williams (2):
      block: fix lifetime of request_queue / backing_dev_info relative to bdev
      block: fix blk_get_backing_dev_info() crash, use bdev->bd_queue


 block/blk-core.c       |    7 ++++---
 fs/block_dev.c         |   25 +++++++++++++++----------
 include/linux/blkdev.h |    6 +++++-
 include/linux/fs.h     |    1 +
 4 files changed, 25 insertions(+), 14 deletions(-)
