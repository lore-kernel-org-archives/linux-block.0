Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 059CCC433F5
	for <linux-block@archiver.kernel.org>; Sun, 22 May 2022 21:49:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233037AbiEVVtu (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 22 May 2022 17:49:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbiEVVtt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 22 May 2022 17:49:49 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF5B34677
        for <linux-block@vger.kernel.org>; Sun, 22 May 2022 14:49:48 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id z7-20020a17090abd8700b001df78c7c209so15847979pjr.1
        for <linux-block@vger.kernel.org>; Sun, 22 May 2022 14:49:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:content-language:to:cc:from
         :subject:content-transfer-encoding;
        bh=+b7G221sJKXenwHqb+3aGxJ/bxlCZlHAaKRNOvzrxE8=;
        b=QtzA7YFvl2TjQjguWvwU/HHfbTSTxpSTkyT1VXZE2r28CVwLMnf2Ip1377aCTxbDmw
         r8jUT9kBAUHwS+QlM91Kk7NP+jmGgiS4a2c6kk2TtSjqWE0jFGtwAxvc/llVyVvP/VQt
         lzCcKp8hD0GjafSAnaLx+Lg/HZuXCHPIM4/UtBT9xyMR/yab3Xbma4B5vazcLBZoomyl
         8DoLyVY5VxQW1O3gBJU3qjKzAscvGo92dFmT6IB6fA280dyfpxPnsNjbYRfY4lOWUxqK
         0v+JwI4SFb/ECNxf5ZMOQYpJLyaS5jigS5/pQ1iizEwtzeeP9CmQV7QPA87JA/b2QmwJ
         EZqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:from:subject:content-transfer-encoding;
        bh=+b7G221sJKXenwHqb+3aGxJ/bxlCZlHAaKRNOvzrxE8=;
        b=dWj/ZNBQwnX9N7oFSNdNDNCTKYJzcpynDRKAXXWTvsUQDlYuKSj7Xpmz4qGb3bq1qM
         /mvxHCYsvCMYXLxJTtJxCH4qEXANhOuucxmfdshy8dUH/FUI2YA52Zr7X7kgag6LrRdC
         9/kGxazVszfjy3vEqGetkKZg0MNEsLshu6IOQa/f9K2xCEkaQ0JzLkxtHDCmbg6Rq8ri
         0qJatpVTtzAWBrfeMAvnDX6lFOdOAU8wn+JGdB+KqOJzMYNkdK0rULxDKyeD4QmMwwul
         qO1uvUP9h+QG5xgklEZGrXRsiNuWU1Ckb6A4sMcNsTuLW/HXT7DP7Up84TWEY+Cv7Wkd
         a3lA==
X-Gm-Message-State: AOAM532oSg1drB/y8elkNCfMZCJbF0zgoZaDiKMOAjvg+6gBmE2/+Yjn
        Cj+7zC03UVY3sX8elZ9tNnZogTL/Nn7tEw==
X-Google-Smtp-Source: ABdhPJzDcQjF4Q43hd85z6rmVhPYqvcADYKLxgpcrH+Y2oVFyHhIrlGRDdvpq47LVqBC76+Hrgb+Ig==
X-Received: by 2002:a17:902:cec7:b0:161:cfc9:45f6 with SMTP id d7-20020a170902cec700b00161cfc945f6mr20139656plg.136.1653256187548;
        Sun, 22 May 2022 14:49:47 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id k193-20020a633dca000000b003f60a8d7dadsm3360160pga.15.2022.05.22.14.49.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 May 2022 14:49:46 -0700 (PDT)
Message-ID: <4cf566ad-d7c6-cf62-3dd5-ed2069e3c2de@kernel.dk>
Date:   Sun, 22 May 2022 15:49:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 5.19-rc
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here are the core block changes for 5.19. This pull request contains:

- blk-throttle accounting fix (Laibin)

- Series removing redundant assignments (Michal)

- Expose bio cache via the bio_set, so that DM can use it (Mike)

- Series finishing off the bio allocation interface cleanups by dealing
  with the weirdest member of the family. bio_kmalloc combines a
  kmalloc for the bio and bio_vecs with a hidden bio_init call and magic
  cleanup semantics (Christoph)

- Series cleaning up the block layer API so that APIs consumed by file
  systems are (almost) only struct block_device based, so that file
  systems don't have to poke into block layer internals like the
  request_queue (Christoph)

- Series cleaning up the blk_execute_rq* API (Christoph)

- Series cleaning up various lose end in the blk-cgroup code to make it
  easier to follow in preparation of reworking the blkcg assignment for
  bios (Christoph)

- BFQ series fixing use-after-free issues in BFQ when processes with   
  merged queues get moved to different cgroups (Jan)

- BFQ fies (Jan)

- Various fixes and cleanups (Bart, Chengming, Fanjun, Julia, Ming,
  Wolfgang, me)

Please pull!


The following changes since commit b2d229d4ddb17db541098b83524d901257e93845:

  Linux 5.18-rc3 (2022-04-17 13:57:31 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.19/block-2022-05-22

for you to fetch changes up to 2aaf516084184e4e6f80da01b2b3ed882fd20a79:

  blk-mq: fix typo in comment (2022-05-21 06:32:16 -0600)

----------------------------------------------------------------
for-5.19/block-2022-05-22

----------------------------------------------------------------
Bart Van Assche (1):
      block: Fix the bio.bi_opf comment

Chengming Zhou (1):
      blk-iocost: combine local_stat and desc_stat to stat

Christoph Hellwig (52):
      btrfs: simplify ->flush_bio handling
      squashfs: always use bio_kmalloc in squashfs_bio_read
      target/pscsi: remove pscsi_get_bio
      block: turn bio_kmalloc into a simple kmalloc wrapper
      pktcdvd: stop using bio_reset
      target: remove an incorrect unmap zeroes data deduction
      target: pass a block_device to target_configure_unmap_from_queue
      target: fix discard alignment on partitions
      drbd: remove assign_p_sizes_qlim
      drbd: use bdev based limit helpers in drbd_send_sizes
      drbd: use bdev_alignment_offset instead of queue_alignment_offset
      drbd: cleanup decide_on_discard_support
      btrfs: use bdev_max_active_zones instead of open coding it
      ntfs3: use bdev_logical_block_size instead of open coding it
      mm: use bdev_is_zoned in claim_swapfile
      block: add a bdev_nonrot helper
      block: add a bdev_write_cache helper
      block: add a bdev_fua helper
      block: add a bdev_stable_writes helper
      block: add a bdev_max_zone_append_sectors helper
      block: use bdev_alignment_offset in part_alignment_offset_show
      block: use bdev_alignment_offset in disk_alignment_offset_show
      block: move bdev_alignment_offset and queue_limit_alignment_offset out of line
      block: remove queue_discard_alignment
      block: use bdev_discard_alignment in part_discard_alignment_show
      block: move {bdev,queue_limit}_discard_alignment out of line
      block: refactor discard bio size limiting
      block: add a bdev_max_discard_sectors helper
      block: remove QUEUE_FLAG_DISCARD
      block: add a bdev_discard_granularity helper
      block: decouple REQ_OP_SECURE_ERASE from REQ_OP_DISCARD
      direct-io: remove random prefetches
      blk-cgroup: remove __bio_blkcg
      nvme-fc: don't support the appid attribute without CONFIG_BLK_CGROUP_FC_APPID
      nvme-fc: fold t fc_update_appid into fc_appid_store
      blk-cgroup: move blkcg_{get,set}_fc_appid out of line
      blk-cgroup: move blk_cgroup_congested out line
      blk-cgroup: move blkcg_{pin,unpin}_online out of line
      blk-cgroup: move struct blkcg to block/blk-cgroup.h
      blktrace: cleanup the __trace_note_message interface
      blk-cgroup: replace bio_blkcg with bio_blkcg_css
      blk-cgroup: remove pointless CONFIG_BLOCK ifdefs
      blk-cgroup: remove unneeded includes from <linux/blk-cgroup.h>
      blk-cgroup: move blkcg_css to blk-cgroup.c
      blk-cgroup: cleanup blk_cgroup_congested
      blk-cgroup: cleanup blkcg_maybe_throttle_current
      kthread: unexport kthread_blkcg
      block: remove superfluous calls to blkcg_bio_issue_init
      block: allow passing a NULL bdev to bio_alloc_clone/bio_init_clone
      block: improve the error message from bio_check_eod
      block: reorder the REQ_ flags
      block: cleanup the VM accounting in submit_bio

Fanjun Kong (1):
      blk-cgroup: Remove unnecessary rcu_read_lock/unlock()

Jan Kara (13):
      bfq: Avoid false marking of bic as stably merged
      bfq: Avoid merging queues with different parents
      bfq: Split shared queues on move between cgroups
      bfq: Update cgroup information before merging bio
      bfq: Drop pointless unlock-lock pair
      bfq: Remove pointless bfq_init_rq() calls
      bfq: Track whether bfq_group is still online
      bfq: Get rid of __bio_blkcg() usage
      bfq: Make sure bfqg for which we are queueing requests is online
      bfq: Relax waker detection for shared queues
      bfq: Allow current waker to defend against a tentative one
      bfq: Remove superfluous conversion from RQ_BIC()
      bfq: Remove bfq_requeue_request_body()

Jens Axboe (1):
      blk-cgroup: delete rcu_read_lock_held() WARN_ON_ONCE()

Julia Lawall (1):
      blk-mq: fix typo in comment

Laibin Qiu (1):
      blk-throttle: Set BIO_THROTTLED when bio has been throttled

Michal Orzel (5):
      block/badblocks: Remove redundant assignments
      block/blk-map: Remove redundant assignment
      block/partitions/acorn: Remove redundant assignments
      block/partitions/atari: Remove redundant assignment
      block/partitions/ldm: Remove redundant assignments

Mike Snitzer (2):
      block: allow using the per-cpu bio cache from bio_alloc_bioset
      block: allow use of per-cpu bio alloc cache by block drivers

Ming Lei (2):
      block: change exported IO accounting interface from gendisk to bdev
      block: ignore RWF_HIPRI hint for sync dio

Wolfgang Bumiller (1):
      blk-cgroup: always terminate io.stat lines

Yu Kuai (2):
      block, bfq: protect 'bfqd->queued' by 'bfqd->lock'
      block, bfq: make bfq_has_work() more accurate

 arch/um/drivers/ubd_kern.c           |   2 -
 block/Makefile                       |   1 +
 block/badblocks.c                    |   2 -
 block/bfq-cgroup.c                   | 111 +++++++++------
 block/bfq-iosched.c                  |  95 +++++++------
 block/bfq-iosched.h                  |  11 +-
 block/bio.c                          | 146 +++++++++-----------
 block/blk-cgroup-fc-appid.c          |  57 ++++++++
 block/blk-cgroup.c                   | 168 +++++++++++++++++------
 block/blk-cgroup.h                   | 140 ++++++++++++-------
 block/blk-core.c                     |  81 ++++-------
 block/blk-crypto-fallback.c          |  15 +-
 block/blk-iocost.c                   |  76 +++++------
 block/blk-iolatency.c                |   8 +-
 block/blk-lib.c                      | 124 ++++++++++-------
 block/blk-map.c                      |  47 ++++---
 block/blk-mq-debugfs.c               |   2 -
 block/blk-mq.c                       |   2 +-
 block/blk-settings.c                 |  74 +++++++++-
 block/blk-throttle.c                 |   5 +-
 block/blk.h                          |  21 ---
 block/bounce.c                       |   1 -
 block/fops.c                         |  35 ++---
 block/genhd.c                        |   4 +-
 block/ioctl.c                        |  48 +++++--
 block/partitions/acorn.c             |   4 +-
 block/partitions/atari.c             |   1 -
 block/partitions/core.c              |  12 +-
 block/partitions/ldm.c               |  15 +-
 drivers/block/drbd/drbd_main.c       |  51 ++++---
 drivers/block/drbd/drbd_nl.c         |  94 ++++++-------
 drivers/block/drbd/drbd_receiver.c   |  13 +-
 drivers/block/loop.c                 |  27 ++--
 drivers/block/nbd.c                  |   5 +-
 drivers/block/null_blk/main.c        |   1 -
 drivers/block/pktcdvd.c              |  34 ++---
 drivers/block/rbd.c                  |   1 -
 drivers/block/rnbd/rnbd-clt.c        |   6 +-
 drivers/block/rnbd/rnbd-srv-dev.h    |   8 +-
 drivers/block/rnbd/rnbd-srv.c        |   5 +-
 drivers/block/virtio_blk.c           |   2 -
 drivers/block/xen-blkback/blkback.c  |  15 +-
 drivers/block/xen-blkback/xenbus.c   |   9 +-
 drivers/block/xen-blkfront.c         |   8 +-
 drivers/block/zram/zram_drv.c        |   6 +-
 drivers/md/bcache/alloc.c            |   2 +-
 drivers/md/bcache/debug.c            |  10 +-
 drivers/md/bcache/request.c          |   4 +-
 drivers/md/bcache/super.c            |   3 +-
 drivers/md/bcache/sysfs.c            |   2 +-
 drivers/md/dm-bufio.c                |   9 +-
 drivers/md/dm-cache-target.c         |   9 +-
 drivers/md/dm-clone-target.c         |   9 +-
 drivers/md/dm-io.c                   |   2 +-
 drivers/md/dm-log-writes.c           |   3 +-
 drivers/md/dm-raid.c                 |   9 +-
 drivers/md/dm-table.c                |  25 +---
 drivers/md/dm-thin.c                 |  15 +-
 drivers/md/dm.c                      |   3 +-
 drivers/md/md-linear.c               |  11 +-
 drivers/md/md.c                      |   5 +-
 drivers/md/raid0.c                   |   7 -
 drivers/md/raid1.c                   |  30 ++--
 drivers/md/raid10.c                  |  41 +++---
 drivers/md/raid5-cache.c             |   8 +-
 drivers/md/raid5.c                   |  14 +-
 drivers/mmc/core/queue.c             |   3 +-
 drivers/mtd/mtd_blkdevs.c            |   1 -
 drivers/nvme/host/core.c             |   4 +-
 drivers/nvme/host/fc.c               |  26 ++--
 drivers/nvme/target/io-cmd-bdev.c    |   2 +-
 drivers/nvme/target/zns.c            |   3 +-
 drivers/s390/block/dasd_fba.c        |   1 -
 drivers/scsi/lpfc/lpfc_scsi.c        |   4 +-
 drivers/scsi/sd.c                    |   2 -
 drivers/target/target_core_device.c  |  20 ++-
 drivers/target/target_core_file.c    |  10 +-
 drivers/target/target_core_iblock.c  |  17 +--
 drivers/target/target_core_pscsi.c   |  36 +----
 fs/btrfs/disk-io.c                   |  11 +-
 fs/btrfs/extent-tree.c               |   8 +-
 fs/btrfs/ioctl.c                     |  12 +-
 fs/btrfs/volumes.c                   |  15 +-
 fs/btrfs/volumes.h                   |   4 +-
 fs/btrfs/zoned.c                     |   3 +-
 fs/direct-io.c                       |  32 +----
 fs/exfat/file.c                      |   5 +-
 fs/exfat/super.c                     |  10 +-
 fs/ext4/ioctl.c                      |  10 +-
 fs/ext4/mballoc.c                    |  10 +-
 fs/ext4/super.c                      |  10 +-
 fs/f2fs/f2fs.h                       |   3 +-
 fs/f2fs/file.c                       |  19 ++-
 fs/f2fs/segment.c                    |   8 +-
 fs/fat/file.c                        |   5 +-
 fs/fat/inode.c                       |  10 +-
 fs/gfs2/rgrp.c                       |   7 +-
 fs/iomap/direct-io.c                 |  10 +-
 fs/jbd2/journal.c                    |   9 +-
 fs/jfs/ioctl.c                       |   5 +-
 fs/jfs/super.c                       |   8 +-
 fs/nilfs2/ioctl.c                    |   6 +-
 fs/nilfs2/sufile.c                   |   4 +-
 fs/nilfs2/the_nilfs.c                |   4 +-
 fs/ntfs3/file.c                      |   6 +-
 fs/ntfs3/super.c                     |  10 +-
 fs/ocfs2/ioctl.c                     |   5 +-
 fs/squashfs/block.c                  |  20 ++-
 fs/super.c                           |   2 +-
 fs/xfs/xfs_discard.c                 |   8 +-
 fs/xfs/xfs_log_cil.c                 |   2 +-
 fs/xfs/xfs_super.c                   |  12 +-
 fs/zonefs/super.c                    |   3 +-
 include/linux/backing-dev.h          |   6 +-
 include/linux/bio.h                  |  10 +-
 include/linux/blk-cgroup.h           | 258 +++--------------------------------
 include/linux/blk_types.h            |  21 +--
 include/linux/blkdev.h               | 119 +++++++---------
 include/linux/blktrace_api.h         |  10 +-
 include/linux/kthread.h              |   4 -
 include/target/target_core_backend.h |   4 +-
 kernel/kthread.c                     |   1 -
 kernel/trace/blktrace.c              |  26 ++--
 mm/backing-dev.c                     |  19 ++-
 mm/page_io.c                         |   4 +-
 mm/readahead.c                       |   1 +
 mm/swapfile.c                        |  32 ++---
 127 files changed, 1248 insertions(+), 1506 deletions(-)
 create mode 100644 block/blk-cgroup-fc-appid.c

-- 
Jens Axboe

