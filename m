Return-Path: <linux-block-owner@vger.kernel.org>
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:25831 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730205AbeG0RnT (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 27 Jul 2018 13:43:19 -0400
From: Bart Van Assche <bart.vanassche@wdc.com>
To: Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bart.vanassche@wdc.com>
Subject: [PATCH 0/5] Improve blk-mq performance
Date: Fri, 27 Jul 2018 09:20:37 -0700
Message-Id: <20180727162042.13425-1-bart.vanassche@wdc.com>
Sender: linux-block-owner@vger.kernel.org
List-Id: linux-block@vger.kernel.org

Hello Jens,

The blk-mq timeout handling rework that went upstream during the v4.18
development cycle introduced a performance regression due to the atomic
instructions that were added in the hot path. This patch series improves
blk-mq performance by reducing the number of atomic instructions in the
hot path. This patch series introduces the number of IOPS reported by the
following test with 15% (fifteen per cent) on an x86_64 system:

#!/bin/bash

if [ -e /sys/kernel/config/nullb ]; then
    for d in /sys/kernel/config/nullb/*; do
        [ -d "$d" ] && rmdir "$d"
    done
fi
modprobe -r null_blk
[ -e /sys/module/null_blk ] && exit $?
modprobe null_blk nr_devices=0 &&
    udevadm settle &&
    cd /sys/kernel/config/nullb &&
    mkdir nullb0 &&
    cd nullb0 &&
    echo 0 > completion_nsec &&
    echo 4096 > blocksize &&
    echo 0 > home_node &&
    echo 1024 > size &&
    echo 0 > memory_backed &&
    echo 1 > power ||
    exit $?

(
    cd /sys/block/nullb0/queue &&
	echo 2 > rq_affinity
) || exit $?

iodepth=${1:-1}
runtime=30
args=()
if [ "$iodepth" = 1 ]; then
	args+=(--ioengine=psync)
else
	args+=(--ioengine=libaio --iodepth_batch=$((iodepth/2)))
fi
args+=(--iodepth=$iodepth --name=nullb0 --filename=/dev/nullb0\
    --rw=read --bs=4096 --loops=$((1<<20)) --direct=1 --numjobs=1 --thread\
    --runtime=$runtime --invalidate=1 --gtod_reduce=1 --ioscheduler=none)
numactl -m 0 -N 0 -- fio "${args[@]}"


Bart Van Assche (5):
  blk-mq: Rename BLK_EH_DONE into BLK_EH_DONT_RESET_TIMER
  block: Remove a superfluous #include directive
  block: Split blk_add_timer()
  block: Simplify blk_add_timer() and blk_mq_add_timer()
  blk-mq: Rework blk-mq timeout handling again

 Documentation/scsi/scsi_eh.txt            |   4 +-
 block/blk-core.c                          |   3 +
 block/blk-mq-debugfs.c                    |   3 +-
 block/blk-mq.c                            | 284 ++++++++++++++++------
 block/blk-mq.h                            |  10 +-
 block/blk-timeout.c                       | 109 +++++----
 block/blk.h                               |   1 +
 drivers/block/mtip32xx/mtip32xx.c         |   2 +-
 drivers/block/nbd.c                       |   4 +-
 drivers/block/null_blk_main.c             |   4 +-
 drivers/message/fusion/mptsas.c           |   2 +-
 drivers/mmc/core/queue.c                  |   2 +-
 drivers/nvme/host/pci.c                   |  10 +-
 drivers/nvme/host/rdma.c                  |   2 +-
 drivers/nvme/target/loop.c                |   2 +-
 drivers/s390/block/dasd.c                 |   6 +-
 drivers/scsi/gdth.c                       |   2 +-
 drivers/scsi/libiscsi.c                   |   6 +-
 drivers/scsi/megaraid/megaraid_sas_base.c |   2 +-
 drivers/scsi/mvumi.c                      |   2 +-
 drivers/scsi/qla4xxx/ql4_os.c             |   2 +-
 drivers/scsi/scsi_error.c                 |  18 +-
 drivers/scsi/scsi_transport_fc.c          |   4 +-
 drivers/scsi/scsi_transport_srp.c         |   4 +-
 drivers/scsi/ufs/ufshcd.c                 |   6 +-
 include/linux/blk-mq.h                    |  14 --
 include/linux/blkdev.h                    |  52 +++-
 27 files changed, 367 insertions(+), 193 deletions(-)

-- 
2.18.0
