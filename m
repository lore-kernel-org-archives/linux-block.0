Return-Path: <keith.busch@intel.com>
From: Keith Busch <keith.busch@intel.com>
To: Linux Block <linux-block@vger.kernel.org>,
	Linux NVMe <linux-nvme@lists.infradead.org>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>
Cc: Keith Busch <keith.busch@intel.com>
Subject: [PATCHv2 0/2] block: Discard merging fixes
Date: Thu,  1 Feb 2018 13:31:56 -0700
Message-Id: <20180201203158.24761-1-keith.busch@intel.com>
List-ID: <linux-block@vger.kernel.org>

This series fixes some incorrect accounting from merging discard requests.

The first patch fixes merging two discard requests by having a special
case for merging these using the unique constraints discards have.

The second fixes merging a new discard bio into an existing
request. Previously all the schedulers defaulted to a front merge,
so the  patch just checks merge type and adds a 'case' for handling
discard in each of the callers.

I've only been able to test with mq-deadline on NVMe as that is the only
driver currently supporting multiple discard ranges in a single command.

v1 -> v2: 

  Fixed patch 1 based on feedback from Jens, tested with recreate
  sequence.

  Added 2nd patch for merging discard bios into existing requests.

Keith Busch (2):
  block: Merge discard requests as a special case
  block: Handle merging discards in IO schedulers

 block/bfq-iosched.c      |  2 +-
 block/blk-core.c         |  4 ++++
 block/blk-merge.c        | 29 ++++++++++++++++++++++++++++-
 block/blk-mq-sched.c     |  2 ++
 block/cfq-iosched.c      |  2 +-
 block/deadline-iosched.c |  4 +++-
 block/elevator.c         |  2 +-
 block/mq-deadline.c      |  2 +-
 8 files changed, 41 insertions(+), 6 deletions(-)

-- 
2.14.3
