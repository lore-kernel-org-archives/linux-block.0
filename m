Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29B1BC43334
	for <linux-block@archiver.kernel.org>; Thu, 14 Jul 2022 18:07:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232131AbiGNSHh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 14 Jul 2022 14:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231521AbiGNSHg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 14 Jul 2022 14:07:36 -0400
Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91143474DB
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:35 -0700 (PDT)
Received: by mail-pg1-f170.google.com with SMTP id 72so2305529pge.0
        for <linux-block@vger.kernel.org>; Thu, 14 Jul 2022 11:07:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=oiI/Ezrd9C+XmlPm/sknsG6WrNWoF4G/AaxGMH2HwTY=;
        b=dDFFYtrtD3l5Vyh16GQLtvnxAiwqxdjbITbfBjBy3+p4OEtx2sxkaR5IH8lHvFeb94
         NhT05fRRQdcR6Pqk60ZvolKTXpoLlXsziasmzvXHEfiXxtDnaBdU+MdGOcNbDgsU/RsB
         Sc9YWpO+4iDRrJLkYq4oqVRZ7cSS+Ga0PuUsu6janyOiNfKssIWoV5Dzge9BgCoAvLxh
         HsRGYqyx4jwO/oVM4HV2N9Sfkd24VUwf79hkYfqQQnEGSCfnESXZ5+idg21bxNVTo48m
         f+hmdsm/sVFcqh4KJbRKXDsrVxY3HdpAYkuan7O0Yvw48TfiDMkzSmSnkqavOlyzO0bO
         RcJQ==
X-Gm-Message-State: AJIora8u6aW6E9+iKrwAdX8mEZ8vweRDCW3YYoY8f58+3+UgnHh/QVxG
        Oq3+THmosCHtQ82s8Mo29NI=
X-Google-Smtp-Source: AGRyM1sSxYnbd0I+zpApQyW2UIXd8phr0jj1T3UOaNfg5bpxOwlXjzdsgL65o085AuEDss9DiNN2HQ==
X-Received: by 2002:a05:6a00:a0c:b0:528:5233:f119 with SMTP id p12-20020a056a000a0c00b005285233f119mr9769713pfh.69.1657822054729;
        Thu, 14 Jul 2022 11:07:34 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:9fab:70d1:f0e7:922b])
        by smtp.gmail.com with ESMTPSA id m5-20020a170902db0500b0016bebb0cb96sm1781846plx.266.2022.07.14.11.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Jul 2022 11:07:34 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Jaegeuk Kim <jaegeuk@kernel.org>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v3 00/63] Improve static type checking for request flags
Date:   Thu, 14 Jul 2022 11:06:26 -0700
Message-Id: <20220714180729.1065367-1-bvanassche@acm.org>
X-Mailer: git-send-email 2.37.0.170.g444d1eabd0-goog
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

Changes compared to v2:
- Renamed 'op' arguments and variables into 'opf' in case these hold both a
  request operation and flags (BFQ, mq-deadline, Kyber and NVMe target code).
- Added more Reviewed-by tags.

Changes compared to v1:
- Combined request operation and flags into a single variable or argument.
- Changed the type of several enum req_op arguments into blk_opf_t for future
  extensibility.
- Removed the __force casts from tracing code.
- Added a few additional patches that convert additional block drivers.

Bart Van Assche (63):
  treewide: Rename enum req_opf into enum req_op
  block: Use enum req_op where appropriate
  block: Change the type of the last .rw_page() argument
  block: Change the type of req_op() and bio_op() into enum req_op
  block: Introduce the type blk_opf_t
  block: Use the new blk_opf_t type
  block/bfq: Use the new blk_opf_t type
  block/mq-deadline: Use the new blk_opf_t type
  block/kyber: Use the new blk_opf_t type
  blktrace: Trace remapped requests correctly
  blktrace: Use the new blk_opf_t type
  block/brd: Use the enum req_op type
  block/drbd: Use the enum req_op and blk_opf_t types
  block/drbd: Combine two drbd_submit_peer_request() arguments
  block/floppy: Fix a sparse warning
  block/rnbd: Use blk_opf_t where appropriate
  xen-blkback: Use the enum req_op and blk_opf_t types
  block/zram: Use enum req_op where appropriate
  nvdimm-btt: Use the enum req_op type
  um: Use enum req_op where appropriate
  dm/core: Reduce the size of struct dm_io_request
  dm/core: Rename kcopyd_job.rw into kcopyd.op
  dm/core: Combine request operation type and flags
  dm/ebs: Change 'int rw' into 'enum req_op op'
  dm/dm-flakey: Use the new blk_opf_t type
  dm/dm-integrity: Combine request operation and flags
  dm mirror log: Use the new blk_opf_t type
  dm-snap: Combine request operation type and flags
  dm/zone: Use the enum req_op type
  dm/dm-zoned: Use the enum req_op type
  md/core: Combine two sync_page_io() arguments
  md/bcache: Combine two uuid_io() arguments
  md/bcache: Combine two prio_io() arguments
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
  fs/buffer: Combine two submit_bh() and ll_rw_block() arguments
  fs/direct-io: Reduce the size of struct dio
  fs/mpage: Use the new blk_opf_t type
  fs/btrfs: Use the enum req_op and blk_opf_t types
  fs/ext4: Use the new blk_opf_t type
  fs/f2fs: Use the enum req_op and blk_opf_t types
  fs/gfs2: Use the enum req_op and blk_opf_t types
  fs/hfsplus: Use the enum req_op and blk_opf_t types
  fs/iomap: Use the new blk_opf_t type
  fs/jbd2: Fix the documentation of the jbd2_write_superblock() callers
  fs/nfs: Use enum req_op where appropriate
  fs/nilfs2: Use the enum req_op and blk_opf_t types
  fs/ntfs3: Use enum req_op where appropriate
  fs/ocfs2: Use the enum req_op and blk_opf_t types
  PM: Use the enum req_op and blk_opf_t types
  fs/xfs: Use the enum req_op and blk_opf_t types
  fs/zonefs: Use the enum req_op type for tracing request operations

 arch/um/drivers/ubd_kern.c                  |   4 +-
 block/bfq-cgroup.c                          |  26 ++---
 block/bfq-iosched.c                         |  16 +--
 block/bfq-iosched.h                         |   8 +-
 block/bio.c                                 |  10 +-
 block/blk-cgroup-rwstat.h                   |   8 +-
 block/blk-core.c                            |   8 +-
 block/blk-flush.c                           |   6 +-
 block/blk-merge.c                           |   8 +-
 block/blk-mq-debugfs.c                      |   6 +-
 block/blk-mq.c                              |  15 +--
 block/blk-mq.h                              |   6 +-
 block/blk-throttle.c                        |   7 +-
 block/blk-wbt.c                             |  18 +--
 block/blk-zoned.c                           |   7 +-
 block/blk.h                                 |   2 +-
 block/elevator.h                            |   2 +-
 block/fops.c                                |  12 +-
 block/kyber-iosched.c                       |   8 +-
 block/mq-deadline.c                         |   4 +-
 drivers/block/brd.c                         |   4 +-
 drivers/block/drbd/drbd_actlog.c            |   9 +-
 drivers/block/drbd/drbd_bitmap.c            |   2 +-
 drivers/block/drbd/drbd_int.h               |   5 +-
 drivers/block/drbd/drbd_receiver.c          |  24 ++--
 drivers/block/drbd/drbd_worker.c            |   2 +-
 drivers/block/floppy.c                      |   2 +-
 drivers/block/null_blk/main.c               |   9 +-
 drivers/block/null_blk/null_blk.h           |  12 +-
 drivers/block/null_blk/trace.h              |   2 +-
 drivers/block/null_blk/zoned.c              |   4 +-
 drivers/block/paride/pd.c                   |   2 +
 drivers/block/rnbd/rnbd-proto.h             |   7 +-
 drivers/block/xen-blkback/blkback.c         |   6 +-
 drivers/block/zram/zram_drv.c               |   4 +-
 drivers/md/bcache/super.c                   |  25 ++--
 drivers/md/dm-bufio.c                       |  26 ++---
 drivers/md/dm-ebs-target.c                  |  15 +--
 drivers/md/dm-flakey.c                      |   8 +-
 drivers/md/dm-integrity.c                   |  76 ++++++-------
 drivers/md/dm-io.c                          |  38 +++----
 drivers/md/dm-kcopyd.c                      |  26 ++---
 drivers/md/dm-log.c                         |   8 +-
 drivers/md/dm-raid.c                        |   2 +-
 drivers/md/dm-raid1.c                       |  12 +-
 drivers/md/dm-snap-persistent.c             |  25 ++--
 drivers/md/dm-writecache.c                  |  12 +-
 drivers/md/dm-zone.c                        |   2 +-
 drivers/md/dm-zoned-metadata.c              |   5 +-
 drivers/md/dm-zoned.h                       |   2 +-
 drivers/md/dm.c                             |  12 +-
 drivers/md/md-bitmap.c                      |   6 +-
 drivers/md/md.c                             |  10 +-
 drivers/md/md.h                             |   3 +-
 drivers/md/raid1.c                          |  12 +-
 drivers/md/raid10.c                         |  20 ++--
 drivers/md/raid5-cache.c                    |  12 +-
 drivers/md/raid5-ppl.c                      |  12 +-
 drivers/md/raid5.c                          |   3 +-
 drivers/nvdimm/btt.c                        |   4 +-
 drivers/nvdimm/pmem.c                       |   2 +-
 drivers/nvme/host/ioctl.c                   |   4 +-
 drivers/nvme/host/nvme.h                    |   2 +-
 drivers/nvme/target/io-cmd-bdev.c           |  17 +--
 drivers/nvme/target/zns.c                   |  10 +-
 drivers/scsi/device_handler/scsi_dh_alua.c  |   4 +-
 drivers/scsi/device_handler/scsi_dh_emc.c   |   2 +-
 drivers/scsi/device_handler/scsi_dh_hp_sw.c |   4 +-
 drivers/scsi/device_handler/scsi_dh_rdac.c  |   2 +-
 drivers/scsi/scsi_error.c                   |  16 +--
 drivers/scsi/scsi_lib.c                     |  12 +-
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
 fs/buffer.c                                 |  56 ++++-----
 fs/direct-io.c                              |  40 ++++---
 fs/ext4/ext4.h                              |   8 +-
 fs/ext4/fast_commit.c                       |   4 +-
 fs/ext4/mmp.c                               |   2 +-
 fs/ext4/super.c                             |  20 ++--
 fs/f2fs/data.c                              |  11 +-
 fs/f2fs/f2fs.h                              |   6 +-
 fs/f2fs/node.c                              |   2 +-
 fs/f2fs/segment.c                           |   2 +-
 fs/gfs2/bmap.c                              |   5 +-
 fs/gfs2/dir.c                               |   5 +-
 fs/gfs2/log.c                               |   4 +-
 fs/gfs2/log.h                               |   2 +-
 fs/gfs2/lops.c                              |   4 +-
 fs/gfs2/lops.h                              |   2 +-
 fs/gfs2/meta_io.c                           |  18 ++-
 fs/gfs2/quota.c                             |   2 +-
 fs/hfsplus/hfsplus_fs.h                     |   2 +-
 fs/hfsplus/part_tbl.c                       |   5 +-
 fs/hfsplus/super.c                          |   4 +-
 fs/hfsplus/wrapper.c                        |  12 +-
 fs/iomap/direct-io.c                        |   8 +-
 fs/isofs/compress.c                         |   2 +-
 fs/jbd2/commit.c                            |   8 +-
 fs/jbd2/journal.c                           |  19 ++--
 fs/jbd2/recovery.c                          |   4 +-
 fs/mpage.c                                  |   6 +-
 fs/nfs/blocklayout/blocklayout.c            |  13 +--
 fs/nilfs2/btnode.c                          |   8 +-
 fs/nilfs2/btnode.h                          |   4 +-
 fs/nilfs2/btree.c                           |   6 +-
 fs/nilfs2/gcinode.c                         |   7 +-
 fs/nilfs2/mdt.c                             |  19 ++--
 fs/ntfs/aops.c                              |   6 +-
 fs/ntfs/compress.c                          |   2 +-
 fs/ntfs/file.c                              |   2 +-
 fs/ntfs/logfile.c                           |   2 +-
 fs/ntfs/mft.c                               |   4 +-
 fs/ntfs3/file.c                             |   2 +-
 fs/ntfs3/fsntfs.c                           |   2 +-
 fs/ntfs3/inode.c                            |   2 +-
 fs/ntfs3/ntfs_fs.h                          |   2 +-
 fs/ocfs2/aops.c                             |   2 +-
 fs/ocfs2/buffer_head_io.c                   |   8 +-
 fs/ocfs2/cluster/heartbeat.c                |  11 +-
 fs/ocfs2/super.c                            |   2 +-
 fs/reiserfs/inode.c                         |   4 +-
 fs/reiserfs/journal.c                       |  12 +-
 fs/reiserfs/stree.c                         |   4 +-
 fs/reiserfs/super.c                         |   2 +-
 fs/udf/dir.c                                |   2 +-
 fs/udf/directory.c                          |   2 +-
 fs/udf/inode.c                              |   2 +-
 fs/ufs/balloc.c                             |   2 +-
 fs/xfs/xfs_bio_io.c                         |   2 +-
 fs/xfs/xfs_buf.c                            |   4 +-
 fs/xfs/xfs_linux.h                          |   2 +-
 fs/xfs/xfs_log_recover.c                    |   2 +-
 fs/zonefs/super.c                           |   5 +-
 fs/zonefs/trace.h                           |   4 +-
 include/linux/bio.h                         |  10 +-
 include/linux/blk-mq.h                      |  12 +-
 include/linux/blk_types.h                   | 119 +++++++++++---------
 include/linux/blkdev.h                      |  12 +-
 include/linux/blktrace_api.h                |   3 +-
 include/linux/buffer_head.h                 |   9 +-
 include/linux/dm-io.h                       |   4 +-
 include/linux/jbd2.h                        |   2 +-
 include/linux/writeback.h                   |   4 +-
 include/scsi/scsi_cmnd.h                    |   4 +-
 include/scsi/scsi_device.h                  |   2 +-
 include/trace/events/f2fs.h                 |  22 ++--
 include/trace/events/jbd2.h                 |  12 +-
 include/trace/events/nilfs2.h               |   4 +-
 kernel/power/swap.c                         |  29 +++--
 kernel/trace/blktrace.c                     |  51 ++++-----
 158 files changed, 751 insertions(+), 743 deletions(-)

