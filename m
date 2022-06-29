Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDD5FC433EF
	for <linux-block@archiver.kernel.org>; Wed, 29 Jun 2022 23:31:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiF2Xb5 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 29 Jun 2022 19:31:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229821AbiF2Xb4 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 29 Jun 2022 19:31:56 -0400
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE20930B
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:31:55 -0700 (PDT)
Received: by mail-pl1-f179.google.com with SMTP id jh14so15499991plb.1
        for <linux-block@vger.kernel.org>; Wed, 29 Jun 2022 16:31:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Iw2+V7CdxpxT0ywDoQBrSEAnLDlKm9G1WxYNU3eqmKg=;
        b=N77COVylXeTwz0P47jg4det4m6j3xQTE1iHsbsV2sTpL2E/QTr6W1yEkO1fl+ZWcDz
         g1ZRP1rs27/SJWbnMf0tyxhc2Ko97yoZN97X8EzEaty9/DO9D6eSHTDcwofgOAW5remm
         wiq+Czt+Hkpq8/GHtbl9poiAU3UCCXUIXRILMVbFSym3vsPPxRNAhJ7FY/EU9AbaMx5v
         z1zBzPeMmdUwgb4C5dS8r8TgcP3eSUMRuq3lkwFH7ncGgn+c+9eQduGAaH0PmD0edzZA
         uazCse/UXQMVuG5V91C29j+1RsUO++8emLO6DsPywBkpY/0idz5gdGyOHtDWIXMrHWsb
         QWLw==
X-Gm-Message-State: AJIora/udYcLc4IvMT/iG8YkLe2cyiZ4rZ1lJ4VGoskpHTKYetDWWxuT
        iBcDdsNLkKpsXjgKqT+9YBPN5Jhrq6c=
X-Google-Smtp-Source: AGRyM1sod5FOlMyYwrp+GNVgem3C8YQuD8fKSkDupR/JDJ4qmpKYIjz3WxRqLJzBfDxamDekYJcBLA==
X-Received: by 2002:a17:902:f685:b0:16a:3c40:e3b5 with SMTP id l5-20020a170902f68500b0016a3c40e3b5mr12965219plg.106.1656545514770;
        Wed, 29 Jun 2022 16:31:54 -0700 (PDT)
Received: from bvanassche-linux.mtv.corp.google.com ([2620:15c:211:201:3841:49ce:cba5:1586])
        by smtp.gmail.com with ESMTPSA id b21-20020a17090a8c9500b001ec8d191db4sm2763687pjo.17.2022.06.29.16.31.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 16:31:53 -0700 (PDT)
From:   Bart Van Assche <bvanassche@acm.org>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     linux-block@vger.kernel.org, Christoph Hellwig <hch@lst.de>,
        Bart Van Assche <bvanassche@acm.org>
Subject: [PATCH v2 00/63] Improve static type checking for request flags
Date:   Wed, 29 Jun 2022 16:30:42 -0700
Message-Id: <20220629233145.2779494-1-bvanassche@acm.org>
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
  fs/zonefs: Use the enum req_op type for request operations

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
 block/blk-mq.c                              |  15 +--
 block/blk-mq.h                              |   6 +-
 block/blk-throttle.c                        |   7 +-
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
 drivers/md/raid5.c                          |   5 +-
 drivers/nvdimm/btt.c                        |   4 +-
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
 fs/direct-io.c                              |  37 +++---
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
 fs/mpage.c                                  |   2 +-
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
 fs/ocfs2/cluster/heartbeat.c                |   9 +-
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
 158 files changed, 722 insertions(+), 716 deletions(-)

