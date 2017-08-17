Return-Path: <prvs=395369d0d=bart.vanassche@wdc.com>
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>,
	Damien Le Moal <Damien.LeMoal@wdc.com>,
	Akhil Bhansali <Akhil.Bhansali@wdc.com>,
	Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 00/55] Convert skd driver to blk-mq
Date: Thu, 17 Aug 2017 13:12:43 -0700
Message-Id: <20170817201338.16537-1-bart.vanassche@wdc.com>
List-ID: <linux-block@vger.kernel.org>

Hello Jens,

As you know all existing single queue block drivers have to be converted
to blk-mq before the single queue block layer can be removed. Hence this
patch series that converts the skd (sTec s1120) driver to blk-mq. As the
following performance numbers show, this patch series does not affect
performance of the skd driver significantly:

======================================================================
sTec Measurements
===================
Kernel module configuration
...........................
$ cat /etc/modprobe.d/skd.conf
options skd skd_max_queue_depth=200 skd_isr_type=1

blk-sq driver
.............
Kernel: 4.11.10-300.fc26.x86_64
$ (cd /sys/block/skd*/queue && grep -aH '' add_random hw_sector_size max_segments nr_requests rotational rq_affinity scheduler write_cache)
add_random:0
hw_sector_size:512
max_segments:256
nr_requests:128
rotational:0
rq_affinity:2
scheduler:[noop] deadline cfq
write_cache:write back

$ ~bart/software/tools/measure-latency /dev/skd* 512 |&
  tee measurements.txt
I/O pattern: randread
     lat (usec): min=16, max=550, avg=88.33, stdev=14.85
I/O pattern: randwrite
     lat (usec): min=20, max=5096, avg=26.35, stdev=56.03
$ for opt in "" "-w"; do for s in 512 4096 65536; do \
  ~bart/software/tools/max-iops $opt -b$s -j1 /dev/skd*; done; done |&
  tee measurements.txt
   read: IOPS=103k, BW=50.1MiB/s (52.6MB/s)(3006MiB/60002msec)
   read: IOPS=81.4k, BW=318MiB/s (333MB/s)(18.7GiB/60003msec)
   read: IOPS=15.7k, BW=978MiB/s (1026MB/s)(57.4GiB/60015msec)
  write: IOPS=62.4k, BW=30.5MiB/s (31.1MB/s)(1826MiB/60004msec)
  write: IOPS=68.8k, BW=266MiB/s (279MB/s)(15.6GiB/60004msec)
  write: IOPS=13.9k, BW=818MiB/s (858MB/s)(47.1GiB/60012msec)

blk-mq driver
.............
Kernel: 4.13.0-rc2+
$ uname -r
4.13.0-rc2+
$ (cd /sys/block/skd*/queue && grep -aH '' add_random hw_sector_size max_segments nr_requests rotational rq_affinity scheduler write_cache)
add_random:0
hw_sector_size:512
max_segments:256
nr_requests:100
rotational:0
rq_affinity:2
scheduler:[none]
write_cache:write back

$ ~bart/software/tools/measure-latency /dev/skd* 512 |&
  tee measurements.txt
I/O pattern: randread
     lat (usec): min=18, max=297, avg=91.02, stdev=13.16
I/O pattern: randwrite
     lat (usec): min=20, max=4680, avg=26.96, stdev=54.80
$ for opt in "" "-w"; do for s in 512 4096 65536; do \
  ~bart/software/tools/max-iops $opt -b$s -j1 /dev/skd*; done; done |&
  tee measurements.txt
   read: IOPS=101k, BW=49.4MiB/s (51.8MB/s)(2959MiB/60002msec)
   read: IOPS=83.3k, BW=325MiB/s (341MB/s)(19.6GiB/60003msec)
   read: IOPS=15.7k, BW=977MiB/s (1024MB/s)(57.3GiB/60019msec)
  write: IOPS=63.2k, BW=30.8MiB/s (32.3MB/s)(1846MiB/60003msec)
  write: IOPS=70.3k, BW=274MiB/s (288MB/s)(16.9GiB/60003msec)
  write: IOPS=13.2k, BW=823MiB/s (863MB/s)(48.3GiB/60012msec)
======================================================================

Please consider this patch series for kernel v4.14.

Thanks,

Bart.

Bart Van Assche (55):
  block: Relax a check in blk_start_queue()
  skd: Avoid that module unloading triggers a use-after-free
  skd: Submit requests to firmware before triggering the doorbell
  skd: Switch to GPLv2
  skd: Update maintainer information
  skd: Remove unneeded #include directives
  skd: Remove ESXi code
  skd: Remove unnecessary blank lines
  skd: Avoid that gcc 7 warns about fall-through when building with W=1
  skd: Fix spelling in a source code comment
  skd: Fix a function name in a comment
  skd: Remove set-but-not-used local variables
  skd: Remove a set-but-not-used variable from struct skd_device
  skd: Remove useless barrier() calls
  skd: Switch from the pr_*() to the dev_*() logging functions
  skd: Fix endianness annotations
  skd: Document locking assumptions
  skd: Introduce the symbolic constant SKD_MAX_REQ_PER_MSG
  skd: Introduce SKD_SKCOMP_SIZE
  skd: Fix size argument in skd_free_skcomp()
  skd: Reorder the code in skd_process_request()
  skd: Simplify the code for deciding whether or not to send a FIT msg
  skd: Simplify the code for allocating DMA message buffers
  skd: Use a structure instead of hardcoding structure offsets
  skd: Check structure sizes at build time
  skd: Use __packed only when needed
  skd: Make the skd_isr() code more brief
  skd: Use ARRAY_SIZE() where appropriate
  skd: Simplify the code for handling data direction
  skd: Remove superfluous initializations from
    skd_isr_completion_posted()
  skd: Drop second argument of skd_recover_requests()
  skd: Use for_each_sg()
  skd: Remove a redundant init_timer() call
  skd: Remove superfluous occurrences of the 'volatile' keyword
  skd: Use kcalloc() instead of kzalloc() with multiply
  skb: Use symbolic names for SCSI opcodes
  skd: Move a function definition
  skd: Rework request failing code path
  skd: Convert explicit skd_request_fn() calls
  skd: Remove SG IO support
  skd: Remove dead code
  skd: Initialize skd_special_context.req.n_sg to one
  skd: Enable request tags for the block layer queue
  skd: Convert several per-device scalar variables into atomics
  skd: Introduce skd_process_request()
  skd: Split skd_recover_requests()
  skd: Move skd_free_sg_list() up
  skd: Coalesce struct request and struct skd_request_context
  skd: Convert to blk-mq
  skd: Switch to block layer timeout mechanism
  skd: Remove skd_device.in_flight
  skd: Reduce memory usage
  skd: Remove several local variables
  skd: Optimize locking
  skd: Bump driver version

 MAINTAINERS               |    6 +
 block/blk-core.c          |    2 +-
 drivers/block/skd_main.c  | 3196 ++++++++++++---------------------------------
 drivers/block/skd_s1120.h |   38 +-
 4 files changed, 846 insertions(+), 2396 deletions(-)

-- 
2.14.0
