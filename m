Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: Jens Axboe <axboe@kernel.dk>,
	linux-nvme@lists.infradead.org,
	linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [RFC PATCH 0/3] blk-mq: Timeout rework
Date: Mon, 21 May 2018 17:11:28 -0600
Message-Id: <20180521231131.6685-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

The current blk-mq code potentially locks requests out of completion by
the thousands, making drivers jump through hoops to handle them. This
patch set allows drivers to complete their requests whenever they're
completed without requiring drivers know anything about the timeout code
with minimal syncronization.

Other proposals under current consideration still have moments that
prevent a driver from progressing a request to the completed state.

The timeout is ultimatley made safe by reference counting the request
when timeout handling claims the request. By holding the reference count,
we don't need to do any tricks to prevent a driver from completing the
request out from under the timeout handler, allowing the actual state
to be changed inline with the true state, and drivers don't need to be
aware any of this is happening.

In order to make the overhead as minimal as possible, the request's
reference is taken only when it appears that actual timeout handling
needs to be done.

Keith Busch (3):
  blk-mq: Reference count request usage
  blk-mq: Fix timeout and state order
  blk-mq: Remove generation seqeunce

 block/blk-core.c       |   6 -
 block/blk-mq-debugfs.c |   1 -
 block/blk-mq.c         | 291 +++++++++++++------------------------------------
 block/blk-mq.h         |  20 +---
 block/blk-timeout.c    |   1 -
 include/linux/blkdev.h |  26 +----
 6 files changed, 83 insertions(+), 262 deletions(-)

-- 
2.14.3
