Return-Path: <shaun@helios.aeonazure.com>
From: Shaun Tancheff <shaun@tancheff.com>
To: linux-block@vger.kernel.org
Cc: Shaun Tancheff <shaun@tancheff.com>,
	Christoph Hellwig <hch@lst.de>,
	axboe@kernel.dk,
	David Drysdale <drysdale@google.com>,
	Xiong Zhou <xzhou@redhat.com>,
	Stephen Rothwell <sfr@canb.auug.org.au>,
	linux-next@vger.kernel.org,
	linux-nvdimm@ml01.01.org,
	Larry Finger <Larry.Finger@lwfinger.net>,
	Catalin Marinas <catalin.marinas@arm.com>,
	LKML <linux-kernel@vger.kernel.org>,
	Jens Axboe <axboe@fb.com>,
	bart.vanassche@sandisk.com
Subject: [PATCH] Fix reported kmemleak
Date: Tue,  7 Jun 2016 11:23:30 -0500
Message-Id: <1465316612-9649-1-git-send-email-shaun@tancheff.com>
List-ID: <linux-block@vger.kernel.org>

This fixes a memory leak reported by a few people in 4.7-rc1

kmemleak report after 9082e87bfbf8 ("block: remove struct bio_batch")

This patch just formalizes the one in this discussion here:
https://lkml.kernel.org/r/20160606112620.GA29910@e104818-lin.cambridge.arm.com

The same issue appears here:
https://lkml.kernel.org/r/20160607102651.GA6480@dhcp12-144.nay.redhat.com

Patch is also available at:

https://github.com/stancheff/linux.git
branch: v4.7-rc2+bio_put

Cc: Christoph Hellwig <hch@lst.de>
Cc: axboe@kernel.dk
cc: David Drysdale <drysdale@google.com>
Cc: Xiong Zhou <xzhou@redhat.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org
Cc: linux-nvdimm@ml01.01.org
Cc: Christoph Hellwig <hch@lst.de>
Cc: Larry Finger <Larry.Finger@lwfinger.net>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: LKML <linux-kernel@vger.kernel.org>,
Cc: Jens Axboe <axboe@fb.com>,
Cc: bart.vanassche@sandisk.com

Shaun Tancheff (1):
  Missing bio_put following submit_bio_wait

 block/blk-lib.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.8.1
