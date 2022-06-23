Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A8EA0CCA480
	for <linux-block@archiver.kernel.org>; Thu, 23 Jun 2022 19:00:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230186AbiFWTAg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 23 Jun 2022 15:00:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229902AbiFWTAD (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 23 Jun 2022 15:00:03 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33AAFB8596
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:35 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id 73-20020a17090a0fcf00b001eaee69f600so363117pjz.1
        for <linux-block@vger.kernel.org>; Thu, 23 Jun 2022 11:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=H9ng++FzfYz5sXe+cg63siW0ug1V3EaiSEUSKrsXuvA=;
        b=sKozEOxaV37Ohn7kTrbo6MoScmchhLpgRaM1sU5mJkb5cXxMAAhj19fFsiAikeKEmI
         AtO1+/Yv1jYRsie6HyRgm0WMUHw6vu2EOtZeTKt2IY4vGX1SIOGOJjC0V8GItgPe5KWB
         yrJOu2RooQpXj6eXmJj51jHbjMosKW0WJ095Vyby2kTC6ASmscG8SfJQYgis7yDcRGKU
         untm9G6AnQn4mLcimOEfl1q18PeFql+wTO6KC+hOOcNOUPWM6zmwLrBwq9f1oZiFdFz+
         Jg1g9jSQkSEIzeLm3h20GgbtQmTwX+4O1jBaDmJsfE5d6vUVGePwcHyYsBApZeCUN/uo
         s8Dg==
X-Gm-Message-State: AJIora8yhJLZ/ds0eQLDvFrEvwBqxrfyy0Pa8bUXG3oR6DP0T8Zgd/Vd
        4+pXBsRv1k+HRx76uXa7eqY=
X-Google-Smtp-Source: AGRyM1ssgxqJiHcZ4KMJ2104J4FR3dU72CPq6RKU1e00uYchKyzYUnw+Nt09CxLGI8abC3RAC5ROZw==
X-Received: by 2002:a17:90b:4b02:b0:1ed:13eb:11c9 with SMTP id lx2-20020a17090b4b0200b001ed13eb11c9mr2754214pjb.76.1656007534272;
        Thu, 23 Jun 2022 11:05:34 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:70af:1dc5:d20:a563])
        by smtp.gmail.com with ESMTPSA id a18-20020a056a000c9200b0051c4ecb0e3dsm16019967pfv.193.2022.06.23.11.05.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 11:05:33 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH 00/51] Improve static type checking for request flags
Date:   Thu, 23 Jun 2022 11:04:37 -0700
Message-Id: <20220623180528.3595304-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.rc0.161.g10f37bed90-goog
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Jens,

A source of confusion in the block layer is that can be nontrivial to determine
which type of flags a u32 function argument accepts. This patch series clears
up that confusion for request flags by introducing a new __bitwise type, namely
blk_opf_t. Additionally, the type 'int' is change into 'enum req_op' where used
to hold a request operation.

Analysis of the sparse warnings introduced by this conversion resulted in one
bug fix ("blktrace: Trace remap operations correctly").

Although the number of patches in this series is significant, the risk of this
patch series is low since most patches involve changing one integer type (int
or u32) into another integer type of the same size (enum req_op or blk_opf_t).

Please consider this patch series for kernel v5.20.

Thanks,

Bart.

Bart Van Assche (51):
  treewide: Rename enum req_opf into enum req_op
  block: Use enum req_op where appropriate
  block: Change the type of the last .rw_page() argument
  block: Change the type of req_op() and bio_op() into enum req_op
  block: Introduce the type blk_opf_t
  block: Use the new blk_opf_t type
  blktrace: Use the new blk_opf_t type
  blktrace: Trace remap operations correctly
  block/brd: Use the enum req_op type
  block/drbd: Use the enum req_op and blk_opf_t types
  block/floppy: Fix a sparse warning
  block/null_blk: Fix sparse warnings in tracing code
  um: Use enum req_op where appropriate
  dm/core: Use the enum req_op and blk_opf_t types
  dm/bufio: Change 'int rw' into 'enum req_op op'
  dm/kcopyd: Rename kcopyd_job.rw into kcopyd_job.op
  dm/ebs: Change 'int rw' into 'enum req_op op'
  dm/dm-flakey: Use the new blk_opf_t type
  dm/dm-integrity: Use the enum req_op and blk_opf_t types
  dm/dm-snap: Use the enum req_op and blk_opf_t types
  dm/dm-zoned: Use the enum req_op type
  md/core: Use the enum req_op and blk_opf_t types
  md/bcache: Use the enum req_op and blk_opf_t types
  md/raid1: Use the new blk_opf_t type
  md/raid10: Use the new blk_opf_t type
  md/raid5: Use the enum req_op and blk_opf_t types
  nvme/host: Use the enum req_op and blk_opf_t types
  nvme/target: Use the new blk_opf_t type
  scsi/core: Improve static type checking
  scsi/core: Change the return type of scsi_noretry_cmd() into bool
  scsi/core: Use the new blk_opf_t type
  scsi/device_handlers: Use the new blk_opf_t type
  scsi/ufs: Rename a 'dir' argument into 'op'
  scsi/target: Use the new blk_opf_t type
  mm: Use the new blk_opf_t type
  fs/buffer: Use the new blk_opf_t type
  fs/direct-io: Use the enum req_op and blk_opf_t types
  fs/mpage: Use the new blk_opf_t type
  fs/btrfs: Use the enum req_op and blk_opf_t types
  fs/ext4: Use the new blk_opf_t type
  fs/f2fs: Use the enum req_op and blk_opf_t types
  fs/gfs2: Use the enum req_op and blk_opf_t types
  fs/hfsplus: Use the enum req_op and blk_opf_t types
  fs/iomap: Use the new blk_opf_t type
  fs/jbd2: Fix the documentation of the jbd2_write_superblock() callers
  fs/nilfs: Use the enum req_op and blk_opf_t types
  fs/ntfs3: Use enum req_op where appropriate
  fs/ocfs2: Use the enum req_op and blk_opf_t types
  PM: Use the enum req_op and blk_opf_t types
  fs/xfs: Use the enum req_op and blk_opf_t types
  fs/zonefs: Fix sparse warnings in tracing code

 arch/um/drivers/ubd_kern.c                  |   4 +-
 block/bfq-cgroup.c                          |  16 +--
 block/bfq-iosched.c                         |   8 +-
 block/bfq-iosched.h                         |   8 +-
 block/bio.c                                 |  10 +-
 block/blk-cgroup-rwstat.h                   |   2 +-
 block/blk-core.c                            |   8 +-
 block/blk-flush.c                           |   6 +-
 block/blk-merge.c                           |   8 +-
 block/blk-mq-debugfs.c                      |   6 +-
 block/blk-mq.c                              |  13 ++-
 block/blk-mq.h                              |   6 +-
 block/blk-wbt.c                             |  18 +--
 block/blk-zoned.c                           |   7 +-
 block/blk.h                                 |   2 +-
 block/elevator.h                            |   2 +-
 block/fops.c                                |   8 +-
 block/kyber-iosched.c                       |   6 +-
 block/mq-deadline.c                         |   2 +-
 drivers/block/brd.c                         |   4 +-
 drivers/block/drbd/drbd_actlog.c            |   9 +-
 drivers/block/drbd/drbd_bitmap.c            |   3 +-
 drivers/block/drbd/drbd_int.h               |   6 +-
 drivers/block/drbd/drbd_receiver.c          |  11 +-
 drivers/block/floppy.c                      |   2 +-
 drivers/block/null_blk/main.c               |   9 +-
 drivers/block/null_blk/null_blk.h           |  12 +-
 drivers/block/null_blk/trace.h              |   6 +-
 drivers/block/null_blk/zoned.c              |   4 +-
 drivers/block/paride/pd.c                   |   2 +
 drivers/block/zram/zram_drv.c               |   2 +-
 drivers/md/bcache/super.c                   |   4 +-
 drivers/md/dm-bufio.c                       |  19 ++--
 drivers/md/dm-ebs-target.c                  |  15 +--
 drivers/md/dm-flakey.c                      |   8 +-
 drivers/md/dm-integrity.c                   |  14 ++-
 drivers/md/dm-io.c                          |  18 +--
 drivers/md/dm-kcopyd.c                      |  25 ++--
 drivers/md/dm-snap-persistent.c             |   6 +-
 drivers/md/dm-zoned-metadata.c              |   2 +-
 drivers/md/dm.c                             |   4 +-
 drivers/md/md.c                             |   3 +-
 drivers/md/md.h                             |   4 +-
 drivers/md/raid1.c                          |   2 +-
 drivers/md/raid10.c                         |   6 +-
 drivers/md/raid5.c                          |   5 +-
 drivers/nvdimm/btt.c                        |   2 +-
 drivers/nvdimm/pmem.c                       |   2 +-
 drivers/nvme/host/ioctl.c                   |   4 +-
 drivers/nvme/host/nvme.h                    |   2 +-
 drivers/nvme/target/io-cmd-bdev.c           |   3 +-
 drivers/nvme/target/zns.c                   |   6 +-
 drivers/scsi/device_handler/scsi_dh_alua.c  |   4 +-
 drivers/scsi/device_handler/scsi_dh_emc.c   |   2 +-
 drivers/scsi/device_handler/scsi_dh_hp_sw.c |   4 +-
 drivers/scsi/device_handler/scsi_dh_rdac.c  |   2 +-
 drivers/scsi/scsi_error.c                   |  16 +--
 drivers/scsi/scsi_lib.c                     |  10 +-
 drivers/scsi/scsi_priv.h                    |   2 +-
 drivers/scsi/sd_zbc.c                       |   2 +-
 drivers/target/target_core_iblock.c         |   4 +-
 drivers/ufs/core/ufshpb.c                   |   7 +-
 fs/btrfs/check-integrity.c                  |   4 +-
 fs/btrfs/compression.c                      |   6 +-
 fs/btrfs/compression.h                      |   2 +-
 fs/btrfs/extent_io.c                        |  18 +--
 fs/btrfs/inode.c                            |   4 +-
 fs/btrfs/raid56.c                           |   4 +-
 fs/buffer.c                                 |  21 ++--
 fs/direct-io.c                              |   4 +-
 fs/ext4/ext4.h                              |   8 +-
 fs/ext4/fast_commit.c                       |   2 +-
 fs/ext4/super.c                             |  14 +--
 fs/f2fs/data.c                              |  11 +-
 fs/f2fs/f2fs.h                              |   6 +-
 fs/f2fs/node.c                              |   2 +-
 fs/f2fs/segment.c                           |   2 +-
 fs/gfs2/log.c                               |   4 +-
 fs/gfs2/log.h                               |   2 +-
 fs/gfs2/lops.c                              |   4 +-
 fs/gfs2/lops.h                              |   2 +-
 fs/gfs2/meta_io.c                           |   6 +-
 fs/hfsplus/hfsplus_fs.h                     |   2 +-
 fs/hfsplus/wrapper.c                        |   5 +-
 fs/iomap/direct-io.c                        |   8 +-
 fs/jbd2/journal.c                           |  15 +--
 fs/mpage.c                                  |   2 +-
 fs/nilfs2/btnode.c                          |   4 +-
 fs/nilfs2/btnode.h                          |   5 +-
 fs/nilfs2/mdt.c                             |   3 +-
 fs/ntfs3/fsntfs.c                           |   2 +-
 fs/ntfs3/ntfs_fs.h                          |   2 +-
 fs/ocfs2/cluster/heartbeat.c                |   4 +-
 fs/xfs/xfs_bio_io.c                         |   2 +-
 fs/xfs/xfs_buf.c                            |   4 +-
 fs/xfs/xfs_linux.h                          |   2 +-
 fs/xfs/xfs_log_recover.c                    |   2 +-
 fs/zonefs/super.c                           |   5 +-
 fs/zonefs/trace.h                           |   8 +-
 include/linux/bio.h                         |  10 +-
 include/linux/blk-mq.h                      |  12 +-
 include/linux/blk_types.h                   | 119 +++++++++++---------
 include/linux/blkdev.h                      |  15 +--
 include/linux/blktrace_api.h                |   3 +-
 include/linux/buffer_head.h                 |   9 +-
 include/linux/dm-io.h                       |   5 +-
 include/linux/jbd2.h                        |   2 +-
 include/linux/writeback.h                   |   4 +-
 include/scsi/scsi_cmnd.h                    |   2 +-
 include/scsi/scsi_device.h                  |   2 +-
 include/trace/events/f2fs.h                 |  28 ++---
 include/trace/events/jbd2.h                 |  12 +-
 include/trace/events/nilfs2.h               |   4 +-
 kernel/power/swap.c                         |   4 +-
 kernel/trace/blktrace.c                     |  22 ++--
 115 files changed, 456 insertions(+), 415 deletions(-)

