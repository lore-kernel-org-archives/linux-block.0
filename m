Return-Path: <linux-block-owner@vger.kernel.org>
Received: from mx0a-00082601.pphosted.com ([67.231.145.42]:35711 "EHLO
	mx0a-00082601.pphosted.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752686AbcE0Shz (ORCPT
	<rfc822;linux-block@vger.kernel.org>);
	Fri, 27 May 2016 14:37:55 -0400
Date: Fri, 27 May 2016 12:37:49 -0600
From: Jens Axboe <axboe@fb.com>
To: <torvalds@linuxfoundation.org>
CC: <linux-block@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [GIT PULL] Block fixes for 4.7-rc1
Message-ID: <20160527183749.GA30050@kernel.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hi Linus,

A set of fixes that wasn't included in the first merge window pull
request. This pull request contains:

- A set of NVMe fixes from Keith, and one from Nic for the integrity
  side of it.

- Fix from Ming, clearing ->mq_ops if we don't successfully setup a
  queue for multiqueue.

- A set of stability fixes for bcache from Jiri, and also marking bcache
  as orphaned as it's no longer actively maintained (in mainline, at
  least).

Please pull!


  git://git.kernel.dk/linux-block.git for-linus


----------------------------------------------------------------
Jiri Kosina (4):
      bcache: bch_writeback_thread() is not freezable
      bcache: bch_allocator_thread() is not freezable
      bcache: bch_gc_thread() is not freezable
      MAINTAINERS: mark bcache as orphan

Keith Busch (7):
      NVMe: Allocate queues only for online cpus
      NVMe: Delete only created queues
      NVMe: Unbind driver on failure
      NVMe: Reduce driver log spamming
      NVMe: Allow user initiated rescan
      NVMe: Short-cut removal on surprise hot-unplug
      NVMe: Add device ID's with stripe quirk

Ming Lin (1):
      blk-mq: clear q->mq_ops if init fail

Nicholas Bellinger (1):
      nvme/host: Add missing blk_integrity tag_size + flags assignments

 MAINTAINERS                     |  2 +-
 block/blk-mq.c                  |  4 +++-
 drivers/md/bcache/alloc.c       |  2 --
 drivers/md/bcache/btree.c       |  2 --
 drivers/md/bcache/writeback.c   |  3 ---
 drivers/nvme/host/core.c        | 37 +++++++++++++++++++++++++++++++++++++
 drivers/nvme/host/nvme.h        |  1 +
 drivers/nvme/host/pci.c         | 23 ++++++++++++++++++-----
 include/uapi/linux/nvme_ioctl.h |  1 +
 9 files changed, 61 insertions(+), 14 deletions(-)

-- 
Jens Axboe

