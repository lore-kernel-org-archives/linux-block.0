Return-Path: <prvs=752cffea0=Bart.VanAssche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH v5 0/3] Ensure that a request queue is dissociated from the cgroup controller
Date: Thu,  9 Aug 2018 07:53:35 -0700
Message-Id: <20180809145338.6160-1-bart.vanassche@wdc.com>
MIME-Version: 1.0
Content-Type: text/plain
Return-Path: bart.vanassche@wdc.com
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

Several block drivers call alloc_disk() followed by put_disk() if something
fails before device_add_disk() is called without calling blk_cleanup_queue().
Make sure that also for this scenario a request queue is dissociated from the
cgroup controller. This patch avoids that loading the parport_pc, paride and
pf drivers trigger a kernel crash. Since this patch series fixes a regression,
please consider these patches for kernel v4.19.

Thanks,

Bart.

Changes between v4 and v5:
- Instead of using #ifdef CONFIG_CGROUP / #endif, introduced a new function in
  the cgroups code.

Changes between v3 and v4:
- Added "Cc: stable" tags.

Changes between v2 and v3:
- Avoid code duplication by introducing a new helper function.

Changes between v1 and v2:
- Fixed the build for CONFIG_BLK_CGROUP=n.

Bart Van Assche (3):
  blkcg: Introduce blkg_root_lookup()
  block: Introduce blk_exit_queue()
  block: Ensure that a request queue is dissociated from the cgroup
    controller

 block/blk-core.c           | 54 +++++++++++++++++++++-----------------
 block/blk-sysfs.c          | 15 +++++++++++
 block/blk.h                |  1 +
 include/linux/blk-cgroup.h | 18 +++++++++++++
 4 files changed, 64 insertions(+), 24 deletions(-)

-- 
2.18.0
