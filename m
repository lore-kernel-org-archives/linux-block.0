Return-Path: <SRS0=Wszy=AI=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: kernel-team@fb.com,
	axboe@kernel.dk,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V2 0/3] block/loop: handle discard/zeroout error
Date: Wed,  6 Sep 2017 17:13:23 -0700
Message-Id: <cover.1504742003.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

Fix some problems when setting up loop device with a block device as back file
and create/mount ext4 in the loop device.

BTW: blkdev_issue_zeroout retries if we immediately find the device doesn't
support zeroout, but it doesn't retry if submit_bio_wait returns -EOPNOTSUPP.
Is this correct behavior?

Thanks,
Shaohua

Shaohua Li (3):
  block/loop: don't hijack error number
  block/loop: use FALLOC_FL_ZERO_RANGE for REQ_OP_WRITE_ZEROES
  block/loop: suppress discard IO error message

 drivers/block/loop.c | 12 +++++++++---
 1 file changed, 9 insertions(+), 3 deletions(-)

-- 
2.9.5
