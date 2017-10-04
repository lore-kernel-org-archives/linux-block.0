Return-Path: <SRS0=lAXC=BD=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: ming.lei@redhat.com,
	axboe@kernel.dk,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V3 0/3] block/loop: handle discard/zeroout error
Date: Wed,  4 Oct 2017 07:52:42 -0700
Message-Id: <cover.1507072136.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

Fix some problems when setting up loop device with a block device as back file
and create/mount ext4 in the loop device.

Thanks,
Shaohua

Shaohua Li (3):
  block/loop: don't hijack error number
  block/loop: use FALLOC_FL_ZERO_RANGE for REQ_OP_WRITE_ZEROES
  block: don't print message for discard error

 block/blk-core.c     | 2 ++
 drivers/block/loop.c | 9 ++++++---
 2 files changed, 8 insertions(+), 3 deletions(-)

-- 
2.9.5
