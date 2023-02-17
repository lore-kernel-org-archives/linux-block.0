Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6599C61DA4
	for <linux-block@archiver.kernel.org>; Fri, 17 Feb 2023 02:54:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230077AbjBQCyh (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 16 Feb 2023 21:54:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjBQCyg (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 16 Feb 2023 21:54:36 -0500
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0981A54D04
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 18:54:34 -0800 (PST)
Received: by mail-pl1-x630.google.com with SMTP id 19so123176plo.7
        for <linux-block@vger.kernel.org>; Thu, 16 Feb 2023 18:54:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RCXGTUN3RYfz969Y6QFblGgigbmJyj+7zyqeKUQcI5k=;
        b=sTEcNYth62V3S4lGwjNdwYSeQQ/y/ylpxAvn9gDsNolOq9bpPWKWginEStZn2i8w49
         KofBDONzF0Nr1/n5lzFJfm3fKAkbVxC35s17hWFYp/7na+5IwtU/LkZeCZ/jD8/QlX5u
         SxKkfLmACcRzX6RDMx+hu/JE8Geq3DbCWMS1MC3i7bplz7B6PIwoZelpbiC5A9Guz0WJ
         dTuDDOppt2YL/puQG7g5be8z60SV8Kve/Y//z73X8ZZK48YODCoJw3vV5JN6DI+uPO8C
         qMLF+iu2nZaUgrNqEt3TSk2j4vjifuilc+d/+IVB9CutONGQXrsA0f10zhcgp667FspA
         mTTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=RCXGTUN3RYfz969Y6QFblGgigbmJyj+7zyqeKUQcI5k=;
        b=pY8Z7Sbew1kfoCYq+nxUhu2GMMTlCg8haCDFIWNUDjTrBjnyJMYqQCLTEDzMsFVeSD
         UP71UNWaZx4YZHdnDOLfhhg31nkN/+H1gOSumSSrlPQRKODTLbneLLnF/k/iNrsqDaHJ
         24fHk6FnKnpi9FKNQHw98bT1c0h9nnMvBgl2NYMkhP3r0nhdK7c3vFrlHTp+PtYEm6i5
         /kNBei/45kfIdpHQoTLZtZ97V4nWiB4bDSVbXgvW6tZm7+1TJhQ2BoAztuZgET9SrWMR
         n/ct1zOLOTXKOAx+1mCYMUfnW2K1WLx+KSnsaSM4gladQ0uxY/aa0T9SPHx27k0wGUuU
         CQsQ==
X-Gm-Message-State: AO0yUKVjk0DCW89DX6JTT0GxXabw0eTqo0rIHlWSWLuQNvLuqTmisbMJ
        uPWwAWZEtX5g4EB4qSIGjL3d/RgK9q4ZmXgv
X-Google-Smtp-Source: AK7set+9RwMZJezI6+FY/IoD0VHYzkUZ8qJRQfviiRbivn7t8AljeaD/77gs5C55O3RneTZJjycNEg==
X-Received: by 2002:a17:90b:46d8:b0:234:b170:1f27 with SMTP id jx24-20020a17090b46d800b00234b1701f27mr2423533pjb.0.1676602473341;
        Thu, 16 Feb 2023 18:54:33 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y1-20020a17090a86c100b002312586b5b1sm3814463pjv.57.2023.02.16.18.54.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Feb 2023 18:54:32 -0800 (PST)
Message-ID: <5afa0795-775d-f710-7989-4c8e1cd7b56f@kernel.dk>
Date:   Thu, 16 Feb 2023 19:54:31 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL for-6.3] Block updates for 6.3
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here are the main block updates for the 6.3 merge window. Note that this
will throw a trivial merge conflict due to a late fix for BFQ in the 6.2
release, both are trivial to resolve and just in case there are
questions, I've pushed a merged branch here:

https://git.kernel.dk/cgit/linux-block/log/?h=for-6.3/block-merged

which resolves those two as-of your git tree today.

This pull request contains:

- NVMe updates via Christoph:
	- Small improvements to the logging functionality (Amit Engel)
	- Authentication cleanups (Hannes Reinecke)
	- Cleanup and optimize the DMA mapping cod in the PCIe driver
	  (Keith Busch)
	- Work around the command effects for Format NVM (Keith Busch)
	- Misc cleanups (Keith Busch, Christoph Hellwig)
	- Fix and cleanup freeing single sgl (Keith Busch)

- MD updates via Song:
	- Fix a rare crash during the takeover process
	- Don't update recovery_cp when curr_resync is ACTIVE
	- Free writes_pending in md_stop
	- Change active_io to percpu

- Series updating drbd, inching us closer to unifying the out-of-tree
  driver with the in-tree one (Andreas, Christoph, Lars, Robert)

- BFQ update adding support for multi-actuator drives (Paolo, Federico,
  Davide)

- Make brd compliant with REQ_NOWAIT (me)

- Fix for IOPOLL and queue entering, fixing stalled IO waiting on
  timeouts (me)

- Fix for REQ_NOWAIT with multiple bios (me)

- Fix memory leak in blktrace cleanup (Greg)

- Series cleaning up sbitmap and fixing a potential hang (Kemeng)

- Series cleaning up some bits in BFQ, and fixing a bug in the request
  injection (Kemeng)

- Series cleaning up the request allocation and issue code, and fixing
  some bugs related to that (Kemeng)

- ublk updates and fixes:
	- Add support for unprivileged ublk (Ming)
	- Improve device deletion handling (Ming)
	- Misc (Liu, Ziyang)

- s390 dasd fixes (Alexander, Qiheng)

- Improve utility of request caching and fixes (Anuj, Xiao)

- zoned cleanups (Pankaj)

- More constification for kobjs (Thomas)

- blk-iocost cleanups (Yu)

- Remove bio splitting from drivers that don't need it (Christoph)

- Series switching blk-cgroups using struct gendisk. Some of this is now
  incomplete as select late reverts were done. (Christoph)

- Series adding bvec initialization helpers, and converting callers to
  use that rather than open-coding it (Christoph)

- Misc fixes and cleanups (Jinke, Keith, Arnd, Bart, Li, Martin,
  Matthew, Ulf, Zhong)

Please pull!


The following changes since commit 6d796c50f84ca79f1722bb131799e5a5710c4700:

  Linux 6.2-rc6 (2023-01-29 13:59:43 -0800)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.3/block-2023-02-16

for you to fetch changes up to f3ca73862453ac1e64fc6968a14bf66d839cd2d8:

  block: use proper return value from bio_failfast() (2023-02-16 19:39:15 -0700)

----------------------------------------------------------------
for-6.3/block-2023-02-16

----------------------------------------------------------------
Alexander Gordeev (1):
      s390/dasd: sort out physical vs virtual pointers usage

Amit Engel (3):
      nvme: add nvme_opcode_str function for all nvme cmd types
      nvme-tcp: add additional info for nvme_tcp_timeout log
      nvmet: for nvme admin set_features cmd, call nvmet_check_data_len_lte()

Andreas Gruenbacher (1):
      drbd: drbd_insert_interval(): Clarify comment

Anuj Gupta (2):
      nvme: set REQ_ALLOC_CACHE for uring-passthru request
      block: extend bio-cache for non-polled requests

Arnd Bergmann (1):
      blk-iocost: avoid 64-bit division in ioc_timer_fn

Bart Van Assche (2):
      loop: Improve the hw_queue_depth kernel module parameter implementation
      block: Remove the ALLOC_CACHE_SLACK constant

Christoph Böhmwalder (8):
      drbd: split off drbd_buildtag into separate file
      drbd: drop API_VERSION define
      drbd: split off drbd_config into separate file
      drbd: adjust drbd_limits license header
      drbd: make limits unsigned
      drbd: remove unnecessary assignment in vli_encode_bits
      drbd: remove macros using require_context
      MAINTAINERS: add drbd headers

Christoph Hellwig (54):
      ps3vram: remove bio splitting
      s390/dcssblk:: don't call bio_split_to_limits
      nvme: remove nvme_execute_passthru_rq
      block: don't call blk_throtl_stat_add for non-READ/WRITE commands
      blk-cgroup: delay blk-cgroup initialization until add_disk
      blk-cgroup: improve error unwinding in blkg_alloc
      blk-cgroup: simplify blkg freeing from initialization failure paths
      blk-cgroup: remove the !bdi->dev check in blkg_dev_name
      blk-cgroup: pin the gendisk in struct blkcg_gq
      blk-cgroup: store a gendisk to throttle in struct task_struct
      blk-wbt: pass a gendisk to wbt_{enable,disable}_default
      blk-wbt: pass a gendisk to wbt_init
      blk-wbt: move private information from blk-wbt.h to blk-wbt.c
      blk-wbt: open code wbt_queue_depth_changed in wbt_init
      blk-rq-qos: move rq_qos_add and rq_qos_del out of line
      blk-rq-qos: make rq_qos_add and rq_qos_del more useful
      blk-rq-qos: constify rq_qos_ops
      blk-rq-qos: store a gendisk instead of request_queue in struct rq_qos
      blk-cgroup: pass a gendisk to blkcg_{de,}activate_policy
      blk-cgroup: pass a gendisk to pd_alloc_fn
      blk-cgroup: pass a gendisk to blkg_lookup
      blk-cgroup: move the cgroup information to struct gendisk
      block: factor out a bvec_set_page helper
      block: add a bvec_set_folio helper
      block: add a bvec_set_virt helper
      sd: factor out a sd_set_special_bvec helper
      target: use bvec_set_page to initialize bvecs
      nvmet: use bvec_set_page to initialize bvecs
      nvme: use bvec_set_virt to initialize special_vec
      rbd: use bvec_set_page to initialize the copy up bvec
      virtio_blk: use bvec_set_virt to initialize special_vec
      zram: use bvec_set_page to initialize bvecs
      afs: use bvec_set_folio to initialize a bvec
      ceph: use bvec_set_page to initialize a bvec
      cifs: use bvec_set_page to initialize bvecs
      coredump: use bvec_set_page to initialize a bvec
      nfs: use bvec_set_page to initialize bvecs
      orangefs: use bvec_set_{page,folio} to initialize bvecs
      splice: use bvec_set_page to initialize a bvec
      io_uring: use bvec_set_page to initialize a bvec
      swap: use bvec_set_page to initialize bvecs
      rxrpc: use bvec_set_page to initialize a bvec
      sunrpc: use bvec_set_page to initialize bvecs
      vringh: use bvec_set_page to initialize a bvec
      libceph: use bvec_set_page to initialize bvecs
      blk-cgroup: fix freeing NULL blkg in blkg_create
      block: stub out and deprecated the capability attribute on the gendisk
      blk-cgroup: delay calling blkcg_exit_disk until disk_release
      Revert "blk-cgroup: simplify blkg freeing from initialization failure paths"
      Revert "blk-cgroup: move the cgroup information to struct gendisk"
      Revert "blk-cgroup: delay calling blkcg_exit_disk until disk_release"
      Revert "blk-cgroup: delay blk-cgroup initialization until add_disk"
      Revert "blk-cgroup: pass a gendisk to blkg_lookup"
      Revert "blk-cgroup: pin the gendisk in struct blkcg_gq"

Davide Zini (3):
      block, bfq: split also async bfq_queues on a per-actuator basis
      block, bfq: inject I/O to underutilized actuators
      block, bfq: balance I/O injection among underutilized actuators

Federico Gavioli (1):
      block, bfq: retrieve independent access ranges from request queue

Greg Kroah-Hartman (1):
      trace/blktrace: fix memory leak with using debugfs_lookup()

Hannes Reinecke (2):
      nvme-fabrics: clarify AUTHREQ result handling
      nvme-auth: don't use NVMe status codes

Hou Tao (2):
      md: don't update recovery_cp when curr_resync is ACTIVE
      md: use MD_RESYNC_* whenever possible

Jens Axboe (11):
      block: add a BUILD_BUG_ON() for adding more bio flags than we have space
      block: don't allow multiple bios for IOCB_NOWAIT issue
      block: treat poll queue enter similarly to timeouts
      Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.3/block
      Merge tag 'nvme-6.3-2023-02-07' of git://git.infradead.org/nvme into for-6.3/block
      Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.3/block
      Merge tag 'nvme-6.3-2023-02-15' of git://git.infradead.org/nvme into for-6.3/block
      brd: return 0/-error from brd_insert_page()
      brd: check for REQ_NOWAIT and set correct page allocation mask
      brd: mark as nowait compatible
      block: use proper return value from bio_failfast()

Jinke Han (1):
      block: Fix io statistics for cgroup in throttle path

Keith Busch (9):
      block: make BLK_DEF_MAX_SECTORS unsigned
      block: save user max_sectors limit
      nvme-pci: remove SGL segment descriptors
      nvme-pci: use mapped entries for sgl decision
      nvme-pci: place descriptor addresses in iod
      nvme: always initialize known command effects
      nvme: mask CSE effects for security receive
      nvme-pci: fix freeing single sgl
      nvme-pci: remove iod use_sgls

Kemeng Shi (27):
      sbitmap: remove unnecessary calculation of alloc_hint in __sbitmap_get_shallow
      sbitmap: remove redundant check in __sbitmap_queue_get_batch
      sbitmap: rewrite sbitmap_find_bit_in_index to reduce repeat code
      sbitmap: add sbitmap_find_bit to remove repeat code in __sbitmap_get/__sbitmap_get_shallow
      sbitmap: correct wake_batch recalculation to avoid potential IO hung
      block, bfq: correctly raise inject limit in bfq_choose_bfqq_for_injection
      block, bfq: remove unsed parameter reason in bfq_bfqq_is_slow
      block, bfq: initialize bfqq->decrease_time_jif correctly
      block, bfq: use helper macro RQ_BFQQ to get bfqq of request
      block, bfq: remove unnecessary dereference to get async_bfqq
      block, bfq: remove redundant check in bfq_put_cooperator
      block, bfq: remove unnecessary goto tag in bfq_dispatch_rq_from_bfqq
      block, bfq: remove unused bfq_wr_max_time in struct bfq_data
      blk-mq: avoid sleep in blk_mq_alloc_request_hctx
      blk-mq: remove stale comment for blk_mq_sched_mark_restart_hctx
      blk-mq: wait on correct sbitmap_queue in blk_mq_mark_tag_wait
      blk-mq: Fix potential io hung for shared sbitmap per tagset
      blk-mq: remove unnecessary list_empty check in blk_mq_try_issue_list_directly
      blk-mq: remove unncessary from_schedule parameter in blk_mq_plug_issue_direct
      blk-mq: make blk_mq_commit_rqs a general function for all commits
      blk-mq: remove unncessary error count and commit in blk_mq_plug_issue_direct
      blk-mq: use blk_mq_commit_rqs helper in blk_mq_try_issue_list_directly
      blk-mq: simplify flush check in blk_mq_dispatch_rq_list
      blk-mq: remove unnecessary error count and check in blk_mq_dispatch_rq_list
      blk-mq: remove set of bd->last when get driver tag for next request fails
      blk-mq: use switch/case to improve readability in blk_mq_try_issue_list_directly
      blk-mq: correct stale comment of .get_budget

Lars Ellenberg (1):
      drbd: interval tree: make removing an "empty" interval a no-op

Li Nan (2):
      blk-iocost: fix divide by 0 error in calc_lcoefs()
      blk-iocost: change div64_u64 to DIV64_U64_ROUND_UP in ioc_refresh_params()

Liu Xiaodong (1):
      block: ublk: check IO buffer based on flag need_get_data

Martin K. Petersen (1):
      block: bio-integrity: Copy flags when bio_integrity_payload is cloned

Matthew Wilcox (1):
      block: Remove mm.h from bvec.h

Ming Lei (10):
      ublk_drv: remove nr_aborted_queues from ublk_device
      ublk_drv: don't probe partitions if the ubq daemon isn't trusted
      ublk_drv: move ublk_get_device_from_id into ublk_ctrl_uring_cmd
      ublk_drv: add device parameter UBLK_PARAM_TYPE_DEVT
      ublk_drv: add module parameter of ublks_max for limiting max allowed ublk dev
      ublk_drv: add mechanism for supporting unprivileged ublk device
      block: ublk: fix doc build warning
      ublk_drv: only allow owner to open unprivileged disk
      block: ublk: improve handling device deletion
      block: sync mixed merged request's failfast with 1st bio's

Pankaj Raghav (3):
      block: remove superfluous check for request queue in bdev_is_zoned()
      block: add a new helper bdev_{is_zone_start, offset_from_zone_start}
      block: introduce bdev_zone_no helper

Paolo Valente (4):
      block, bfq: split sync bfq_queues on a per-actuator basis
      block, bfq: forbid stable merging of queues associated with different actuators
      block, bfq: move io_cq-persistent bfqq data into a dedicated struct
      block, bfq: turn bfqq_data into an array in bfq_io_cq

Qiheng Lin (1):
      s390/dasd: Fix potential memleak in dasd_eckd_init()

Robert Altnoeder (1):
      drbd: fix DRBD_VOLUME_MAX 65535 -> 65534

Thomas Weißschuh (1):
      block: make kobj_type structures constant

Ulf Hansson (1):
      block: Default to use cgroup support for BFQ

Xiao Ni (5):
      md: Factor out is_md_suspended helper
      md: Change active_io to percpu
      md: Free writes_pending in md_stop
      md: account io_acct_set usage with active_io
      block: Merge bio before checking ->cached_rq

Yu Kuai (7):
      blk-iocost: check return value of match_u64()
      blk-iocost: don't allow to configure bio based device
      blk-iocost: read params inside lock in sysfs apis
      blk-cgroup: dropping parent refcount after pd_free_fn() is done
      blk-cgroup: support to track if policy is online
      blk-cgroup: synchronize pd_free_fn() from blkg_free_workfn() and blkcg_deactivate_policy()
      block, bfq: cleanup 'bfqg->online'

Zhong Jinghua (1):
      blk-mq: cleanup unused methods: blk_mq_hw_sysfs_store

Ziyang Zhang (3):
      ublk: remove unnecessary NULL check in ublk_rq_has_data()
      ublk: mention WRITE_ZEROES in comment of ublk_complete_rq()
      ublk: pass NULL to blk_mq_alloc_disk() as queuedata

 Documentation/ABI/stable/sysfs-block |   3 +-
 Documentation/block/capability.rst   |  10 -
 Documentation/block/index.rst        |   1 -
 Documentation/block/ublk.rst         |  55 ++-
 MAINTAINERS                          |   1 +
 block/Kconfig.iosched                |   1 +
 block/bfq-cgroup.c                   | 105 +++---
 block/bfq-iosched.c                  | 629 +++++++++++++++++++++++------------
 block/bfq-iosched.h                  | 146 ++++++--
 block/bfq-wf2q.c                     |   2 +-
 block/bio-integrity.c                |   8 +-
 block/bio.c                          |  15 +-
 block/blk-cgroup.c                   | 150 +++++----
 block/blk-cgroup.h                   |  14 +-
 block/blk-core.c                     |  36 +-
 block/blk-crypto-sysfs.c             |   2 +-
 block/blk-ia-ranges.c                |   4 +-
 block/blk-integrity.c                |   2 +-
 block/blk-iocost.c                   |  78 +++--
 block/blk-iolatency.c                |  37 +--
 block/blk-ioprio.c                   |   6 +-
 block/blk-map.c                      |   6 +-
 block/blk-merge.c                    |  35 +-
 block/blk-mq-debugfs.c               |  10 +-
 block/blk-mq-sched.c                 |   7 +-
 block/blk-mq-sysfs.c                 |  30 +-
 block/blk-mq.c                       | 152 ++++-----
 block/blk-rq-qos.c                   |  67 ++++
 block/blk-rq-qos.h                   |  66 +---
 block/blk-settings.c                 |  10 +-
 block/blk-stat.c                     |   3 +-
 block/blk-sysfs.c                    |  28 +-
 block/blk-throttle.c                 |  11 +-
 block/blk-wbt.c                      | 116 +++++--
 block/blk-wbt.h                      |  98 +-----
 block/blk-zoned.c                    |   4 +-
 block/elevator.c                     |   4 +-
 block/fops.c                         |  21 +-
 block/genhd.c                        |   5 +-
 drivers/block/brd.c                  |  67 ++--
 drivers/block/drbd/Makefile          |   2 +-
 drivers/block/drbd/drbd_buildtag.c   |  22 ++
 drivers/block/drbd/drbd_debugfs.c    |   2 +-
 drivers/block/drbd/drbd_int.h        |  13 +-
 drivers/block/drbd/drbd_interval.c   |   6 +-
 drivers/block/drbd/drbd_main.c       |  20 +-
 drivers/block/drbd/drbd_proc.c       |   2 +-
 drivers/block/drbd/drbd_vli.h        |   2 +-
 drivers/block/loop.c                 |  14 +-
 drivers/block/null_blk/main.c        |   3 +-
 drivers/block/ps3vram.c              |   7 -
 drivers/block/rbd.c                  |   7 +-
 drivers/block/ublk_drv.c             | 405 ++++++++++++++++------
 drivers/block/virtio_blk.c           |   4 +-
 drivers/block/zram/zram_drv.c        |  15 +-
 drivers/md/md.c                      |  65 ++--
 drivers/md/md.h                      |   9 +-
 drivers/nvme/host/auth.c             |  30 +-
 drivers/nvme/host/constants.c        |  16 +
 drivers/nvme/host/core.c             | 123 +++----
 drivers/nvme/host/fabrics.c          |  19 +-
 drivers/nvme/host/ioctl.c            |   9 +-
 drivers/nvme/host/nvme.h             |  16 +-
 drivers/nvme/host/pci.c              | 104 ++----
 drivers/nvme/host/tcp.c              |   7 +-
 drivers/nvme/target/admin-cmd.c      |   2 +-
 drivers/nvme/target/io-cmd-file.c    |  10 +-
 drivers/nvme/target/passthru.c       |   5 +-
 drivers/nvme/target/tcp.c            |   5 +-
 drivers/nvme/target/zns.c            |   3 +-
 drivers/s390/block/dasd.c            |   5 +-
 drivers/s390/block/dasd_3990_erp.c   |  10 +-
 drivers/s390/block/dasd_alias.c      |   6 +-
 drivers/s390/block/dasd_eckd.c       | 104 +++---
 drivers/s390/block/dasd_eer.c        |   2 +-
 drivers/s390/block/dasd_fba.c        |  14 +-
 drivers/s390/block/dcssblk.c         |   4 -
 drivers/scsi/sd.c                    |  36 +-
 drivers/target/target_core_file.c    |  18 +-
 drivers/vhost/vringh.c               |   5 +-
 fs/afs/write.c                       |   8 +-
 fs/ceph/file.c                       |  12 +-
 fs/cifs/connect.c                    |   5 +-
 fs/cifs/fscache.c                    |  16 +-
 fs/cifs/misc.c                       |   5 +-
 fs/cifs/smb2ops.c                    |   6 +-
 fs/coredump.c                        |   7 +-
 fs/nfs/fscache.c                     |  16 +-
 fs/orangefs/inode.c                  |  22 +-
 fs/splice.c                          |   5 +-
 include/linux/blkdev.h               |  27 +-
 include/linux/bvec.h                 |  41 ++-
 include/linux/drbd.h                 |   7 -
 include/linux/drbd_config.h          |  16 +
 include/linux/drbd_genl_api.h        |   2 +-
 include/linux/drbd_limits.h          | 204 ++++++------
 include/linux/sched.h                |   2 +-
 include/uapi/linux/ublk_cmd.h        |  49 ++-
 io_uring/rsrc.c                      |   4 +-
 kernel/fork.c                        |   2 +-
 kernel/trace/blktrace.c              |   4 +-
 lib/sbitmap.c                        | 102 +++---
 mm/page_io.c                         |   8 +-
 mm/swapfile.c                        |   2 +-
 net/ceph/messenger_v1.c              |   7 +-
 net/ceph/messenger_v2.c              |  28 +-
 net/rxrpc/rxperf.c                   |   8 +-
 net/sunrpc/svcsock.c                 |   7 +-
 net/sunrpc/xdr.c                     |   5 +-
 109 files changed, 2224 insertions(+), 1599 deletions(-)
 delete mode 100644 Documentation/block/capability.rst
 create mode 100644 drivers/block/drbd/drbd_buildtag.c
 create mode 100644 include/linux/drbd_config.h

-- 
Jens Axboe

