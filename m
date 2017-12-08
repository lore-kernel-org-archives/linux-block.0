Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:59088 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752845AbdLHNO3 (ORCPT <rfc822;linux-block@vger.kernel.org>);
        Fri, 8 Dec 2017 08:14:29 -0500
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@fb.com>, linux-block@vger.kernel.org
Cc: Christoph Hellwig <hch@infradead.org>,
        Ming Lei <ming.lei@redhat.com>
Subject: [PATCH 00/10] block: cleanup on direct access to bvec table(prepare for multipage bvec)
Date: Fri,  8 Dec 2017 21:13:59 +0800
Message-Id: <20171208131409.11889-1-ming.lei@redhat.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi,

This patchse cleans up most of direct access to bvec table in tree, and
these patches are the follow-up of patch1 ~ 16 in the patchset of 'block:
support multipage bvec(V3)'[1]. 

Changes against [1]:
1) split the cleanup patches from [1]
2) address comments from Christoph:
	- introduce bio helpers for dealing with the cleanup
	- move bio_alloc_pages() to bcache


[1] https://marc.info/?t=150218197600001&r=1&w=2

Thanks,
Ming

Ming Lei (10):
  block: introduce bio helpers for converting to multipage bvec
  block: conver to bio_first_bvec() & bio_first_page()
  fs: convert to bio_last_bvec()
  block: bounce: avoid direct access to bvec table
  block: bounce: don't access bio->bi_io_vec in copy_to_high_bio_irq
  dm: limit the max bio size as BIO_MAX_PAGES * PAGE_SIZE
  bcache: comment on direct access to bvec table
  block: move bio_alloc_pages() to bcache
  btrfs: avoid access to .bi_vcnt directly
  btrfs: avoid to access bvec table directly for a cloned bio

 block/bio.c                      | 28 ----------------------------
 block/bounce.c                   | 33 +++++++++++++++++++--------------
 drivers/block/drbd/drbd_bitmap.c |  2 +-
 drivers/block/zram/zram_drv.c    |  2 +-
 drivers/md/bcache/btree.c        |  1 +
 drivers/md/bcache/super.c        |  8 ++++----
 drivers/md/bcache/util.c         | 34 ++++++++++++++++++++++++++++++++++
 drivers/md/bcache/util.h         |  1 +
 drivers/md/dm.c                  | 10 +++++++++-
 fs/btrfs/compression.c           |  4 ++--
 fs/btrfs/extent_io.c             | 11 ++++++-----
 fs/btrfs/extent_io.h             |  2 +-
 fs/btrfs/inode.c                 |  8 +++++---
 fs/buffer.c                      |  2 +-
 fs/f2fs/data.c                   |  2 +-
 include/linux/bio.h              | 25 ++++++++++++++++++++++++-
 include/linux/bvec.h             |  9 +++++++++
 kernel/power/swap.c              |  2 +-
 mm/page_io.c                     |  4 ++--
 19 files changed, 122 insertions(+), 66 deletions(-)

-- 
2.9.5
