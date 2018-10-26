Return-Path: <ming.lei@redhat.com>
From: Ming Lei <ming.lei@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Ming Lei <ming.lei@redhat.com>,
	Rui Salvaterra <rsalvaterra@gmail.com>,
	stable@vger.kernel.org,
	Mike Snitzer <snitzer@redhat.com>,
	Christoph Hellwig <hch@lst.de>,
	Xiao Ni <xni@redhat.com>,
	Mariusz Dabrowski <mariusz.dabrowski@intel.com>
Subject: [PATCH 0/3] block: make sure discard/writesame bio is aligned with logical block size
Date: Fri, 26 Oct 2018 14:24:32 +0800
Message-Id: <20181026062435.21398-1-ming.lei@redhat.com>
List-ID: <linux-block@vger.kernel.org>

Hi,

The 1st & 3rd patch fixes bio size alignment issue.

The 2nd patch cleans up __blkdev_issue_discard() a bit.

Thanks,


Ming Lei (3):
  block: make sure discard bio is aligned with logical block size
  block: cleanup __blkdev_issue_discard()
  block: make sure writesame bio is aligned with logical block size

 block/blk-lib.c | 25 ++++++-------------------
 1 file changed, 6 insertions(+), 19 deletions(-)

Cc: Rui Salvaterra <rsalvaterra@gmail.com>
Cc: stable@vger.kernel.org
Cc: Mike Snitzer <snitzer@redhat.com>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Xiao Ni <xni@redhat.com>
Cc: Mariusz Dabrowski <mariusz.dabrowski@intel.com>

-- 
2.9.5
