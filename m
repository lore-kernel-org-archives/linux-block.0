Return-Path: <prvs=408be853d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 0/5] Five BFQ patches for kernel v4.14
Date: Wed, 30 Aug 2017 11:42:06 -0700
Message-Id: <20170830184211.12471-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

This series consists of five small patches. Three patches address compiler
warnings, one patch is a fix for the BFQ sysfs interface and a fifth patch
makes the BFQ code slightly more consistent. Please consider these patches
for kernel v4.14.

Thanks,

Bart.

Bart Van Assche (5):
  bfq: Annotate fall-through in a switch statement
  bfq: Declare local functions static
  bfq: Check kstrtoul() return value
  bfq: Suppress compiler warnings about comparisons
  bfq: Use icq_to_bic() consistently

 block/bfq-cgroup.c  | 18 +++++++-------
 block/bfq-iosched.c | 71 +++++++++++++++++++++++++++++++++++------------------
 2 files changed, 56 insertions(+), 33 deletions(-)

-- 
2.14.1
