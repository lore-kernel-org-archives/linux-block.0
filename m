Return-Path: <prvs=0415d39c2a=shli@fb.com>
From: Shaohua Li <shli@fb.com>
To: <linux-block@vger.kernel.org>
CC: <Kernel-team@fb.com>, <axboe@kernel.dk>
Subject: [PATCH 0/3]block/loop: handle discard/zeroout error
Date: Wed, 30 Aug 2017 12:17:15 -0700
Message-ID: <cover.1504120418.git.shli@fb.com>
MIME-Version: 1.0
Content-Type: text/plain
List-ID: <linux-block@vger.kernel.org>

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

 drivers/block/loop.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

-- 
2.9.5
