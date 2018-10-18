Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Vitaly Kuznetsov <vkuznets@redhat.com>,
	Dave Chinner <dchinner@redhat.com>,
	Linux FS Devel <linux-fsdevel@vger.kernel.org>,
	"Darrick J . Wong" <darrick.wong@oracle.com>,
	xfs@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bvanassche@acm.org>,
	Matthew Wilcox <willy@infradead.org>
Subject: [PATCH 0/5] block: introduce helpers for allocating io buffer from slab
Date: Thu, 18 Oct 2018 21:18:12 +0800
Message-Id: <20181018131817.11813-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi,

Filesystems may allocate io buffer from slab, and use this buffer to
submit bio. This way may break storage drivers if they have special
requirement on DMA alignment.

The patch 1 adds one warning if the io buffer isn't aligned to DMA
alignment.

The 2nd & 3rd patches make DMA alignment as stacked limit.

The 4th patch introduces helpers for allocating io buffer from slab,
and DMA alignment is respected on this allocation.

The 5th patch converts xfs to use the introduced helpers for allocating
io buffer from slab.

See previous discussion on this topic:

https://marc.info/?t=153734857500004&r=1&w=2

Thanks,
Ming

Ming Lei (5):
  block: warn on un-aligned DMA IO buffer
  block: move .dma_alignment into q->limits
  block: make dma_alignment as stacked limit
  block: introduce helpers for allocating IO buffers from slab
  xfs: use block layer helpers to allocate io buffer from slab

 block/Makefile              |   3 +-
 block/blk-core.c            |   2 +
 block/blk-merge.c           |   2 +
 block/blk-sec-buf.c         | 144 ++++++++++++++++++++++++++++++++++++++++++++
 block/blk-settings.c        |  89 +++++++++++++++------------
 fs/xfs/xfs_buf.c            |  28 ++++++++-
 fs/xfs/xfs_super.c          |  13 +++-
 include/linux/blk-sec-buf.h |  43 +++++++++++++
 include/linux/blkdev.h      |   9 ++-
 9 files changed, 287 insertions(+), 46 deletions(-)
 create mode 100644 block/blk-sec-buf.c
 create mode 100644 include/linux/blk-sec-buf.h

Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Linux FS Devel <linux-fsdevel@vger.kernel.org>
Cc: Darrick J. Wong <darrick.wong@oracle.com>
Cc: xfs@vger.kernel.org
Cc: Dave Chinner <dchinner@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Bart Van Assche <bvanassche@acm.org>
Cc: Matthew Wilcox <willy@infradead.org>


-- 
2.9.5
