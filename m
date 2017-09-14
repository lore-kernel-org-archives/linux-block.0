Return-Path: <SRS0=TWoo=AP=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org
Cc: tj@kernel.org,
	lizefan@huawei.com,
	tglx@linutronix.de,
	kernel-team@fb.com,
	axboe@kernel.dk,
	Shaohua Li <shli@fb.com>
Subject: [PATCH V3 0/4] block: make loop block device cgroup aware
Date: Thu, 14 Sep 2017 14:02:03 -0700
Message-Id: <cover.1505422351.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

Hi,

The IO dispatched to under layer disk by loop block device isn't cloned from
original bio, so the IO loses cgroup information of original bio. These IO
escapes from cgroup control. The patches try to address this issue. The idea is
quite generic, but we currently only make it work for blkcg.

Thanks,
Shaohua

V2->V3:
- Make the API more robust pointed out by Tejun

V1->V2:
- Address a couple of issues pointed out by Tejun


Shaohua Li (4):
  kthread: add a mechanism to store cgroup info
  blkcg: delete unused APIs
  block: make blkcg aware of kthread stored original cgroup info
  block/loop: make loop cgroup aware

 block/bio.c                | 31 ----------------------
 drivers/block/loop.c       | 13 +++++++++
 drivers/block/loop.h       |  1 +
 include/linux/bio.h        |  2 --
 include/linux/blk-cgroup.h | 25 +++++-------------
 include/linux/kthread.h    | 11 ++++++++
 kernel/kthread.c           | 66 ++++++++++++++++++++++++++++++++++++++++++++--
 7 files changed, 96 insertions(+), 53 deletions(-)

-- 
2.9.5
