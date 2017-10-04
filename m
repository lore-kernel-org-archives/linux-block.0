Return-Path: <SRS0=lAXC=BD=fb.com=shli@kernel.org>
From: Shaohua Li <shli@kernel.org>
To: linux-block@vger.kernel.org
Cc: vgoyal@redhat.com,
	tj@kernel.org,
	axboe@kernel.dk,
	Kernel-team@fb.com,
	Shaohua Li <shli@fb.com>
Subject: [RFC 0/2] block: export latency info for cgroups
Date: Wed,  4 Oct 2017 10:41:18 -0700
Message-Id: <cover.1507138530.git.shli@fb.com>
List-ID: <linux-block@vger.kernel.org>

From: Shaohua Li <shli@fb.com>

Hi,

latency info is a good sign to determine if IO is healthy. The patches export
such info to cgroup io.stat.

Thanks,
Shaohua

Shaohua Li (2):
  block: record blkcss in request
  blockcg: export latency info for each cgroup

 block/blk-cgroup.c         | 29 +++++++++++++-
 block/blk-core.c           | 12 ++++++
 block/blk-stat.c           | 95 +++++++++++++++++++++++++++++++++++++++++++++-
 block/blk.h                |  5 +++
 include/linux/blk-cgroup.h |  7 ++++
 include/linux/blkdev.h     |  1 +
 6 files changed, 146 insertions(+), 3 deletions(-)

-- 
2.9.5
