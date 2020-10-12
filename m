Return-Path: <SRS0=jKGj=DT=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB9E4C433E7
	for <linux-block@archiver.kernel.org>; Mon, 12 Oct 2020 13:58:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6BF422074F
	for <linux-block@archiver.kernel.org>; Mon, 12 Oct 2020 13:58:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="h9+KwIZ9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731308AbgJLN6r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Oct 2020 09:58:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388982AbgJLNkt (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Oct 2020 09:40:49 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C5DDC0613D1
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2020 06:40:47 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 67so17688785iob.8
        for <linux-block@vger.kernel.org>; Mon, 12 Oct 2020 06:40:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=a2fdkwvuYrkc9fgMn6KkZfZS3Z96i8aj+YRmjC53cg8=;
        b=h9+KwIZ9504AVAFR5Xwm9sFKLMv7dQxPhtO6K6Xoa+wNlj3KjR4HGnE7OImoudhgXG
         LzkEgi32BxclaeCiokB30eBQeusHeBiDPHuUYK3zk8nP8ypyNCXTGxHfW/XnYhioTx5J
         ujZZZxizQMvTYXilkAwG9j+WcTx4+F9R6pAV+HhHQfn54Q0dMtI0XpUyb0AIqe/l6rX1
         arAyCBvHIJ4hf1B57aJLa1m02gtrPbTAqsqQ7rOYwuRu20IEHYhuvmOXbr35sHrj6PrK
         Xp5g+m1pGd/hV0yp2nubuUefXmJdRDCl6QyVgFz1b/kJYcsuEg4kkQAlX9FTueaW58gH
         TauQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=a2fdkwvuYrkc9fgMn6KkZfZS3Z96i8aj+YRmjC53cg8=;
        b=Syb9wPXOT2bpa47c93N5L/bcKiA1Oj400sVSUHZnT8it680XI8UzzXmCKB6aXSuA87
         HGsv04KK8Bif2oLOVkxQRCpLpSJL9u1M4BsDnHBjELJj82BsgkL7U3dIzCNY4LwYrXqp
         kv3zzqX46lCoVV2tGy/58f010cGu2vPmebPcZpYZEN976YqlkMUrGRlMb7CVhyfkxkpH
         AU0n5DZesw3lIE1kEnKiqNtRW1KSbP9Uqjmz153Wa2ttfdNwy2mmZ1sRxDcE8hOcKqrT
         8FZ0uAzCWZzfomztwByuFKzxvu/urzduea0ktcnTWwgoM4Y65rtTdMCoIu/Y2iOCzBMG
         /0WA==
X-Gm-Message-State: AOAM530TXcQUrqBXy1TrcQu7yEHHlz6SGjgiDzy79ZDOaLHfF1FhEU9m
        VTXu1oyQEN9baM3WO6gquL2EVBHGvDiSkA==
X-Google-Smtp-Source: ABdhPJzRONo085AhZsUKOsWjD+BKRAiAlh5urgaT1I0FPxqkyAqjHiuHKOPSKmaqiFjDM9nCvFmBEQ==
X-Received: by 2002:a05:6602:208c:: with SMTP id a12mr16974053ioa.55.1602510046318;
        Mon, 12 Oct 2020 06:40:46 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id s77sm9557252ilk.8.2020.10.12.06.40.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Oct 2020 06:40:45 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block updates for 5.10-rc1
Message-ID: <deaa5b65-55f6-7ca5-e96c-9ea704c0eaee@kernel.dk>
Date:   Mon, 12 Oct 2020 07:40:45 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here's the 5.10 merge window block pull request:

- Series of merge handling cleanups (Baolin, Christoph)

- Series of blk-throttle fixes and cleanups (Baolin)

- Series cleaning up BDI, seperating the block device from the
  backing_dev_info (Christoph)

- Removal of bdget() as a generic API (Christoph)

- Removal of blkdev_get() as a generic API (Christoph)

- Cleanup of is-partition checks (Christoph)

- Series reworking disk revalidation (Christoph)

- Series cleaning up bio flags (Christoph)

- bio crypt fixes (Eric)

- IO stats inflight tweak (Gabriel)

- blk-mq tags fixes (Hannes)

- Buffer invalidation fixes (Jan)

- Allow soft limits for zone append (Johannes)

- Shared tag set improvements (John, Kashyap)

- Allow IOPRIO_CLASS_RT for CAP_SYS_NICE (Khazhismel)

- DM no-wait support (Mike, Konstantin)

- Request allocation improvements (Ming)

- Allow md/dm/bcache to use IO stat helpers (Song)

- Series improving blk-iocost (Tejun)

- Various cleanups (Geert, Damien, Danny, Julia, Tetsuo, Tian, Wang,
  Xianting, Yang, Yufen, yangerkun)

Please pull!


The following changes since commit e11d80a849e010f78243bb6f6af7dccef3a71a90:

  blk-stat: make q->stats->lock irqsafe (2020-09-01 16:48:46 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/block-5.10-2020-10-12

for you to fetch changes up to 8858e8d98d5457ba23bcd0d99ce23e272b8b09a1:

  block: fix uapi blkzoned.h comments (2020-10-09 12:47:02 -0600)

----------------------------------------------------------------
block-5.10-2020-10-12

----------------------------------------------------------------
Baolin Wang (20):
      block: Move bio merge related functions into blk-merge.c
      block: Move blk_mq_bio_list_merge() into blk-merge.c
      block: Add a new helper to attempt to merge a bio
      block: Remove blk_mq_attempt_merge() function
      block: Remove a duplicative condition
      block: Remove unused blk_mq_sched_free_hctx_data()
      blk-throttle: Fix some comments' typos
      blk-throttle: Use readable READ/WRITE macros
      blk-throttle: Define readable macros instead of static variables
      blk-throttle: Avoid calculating bps/iops limitation repeatedly
      blk-throttle: Avoid checking bps/iops limitation if bps or iops is unlimited
      block: Remove redundant 'return' statement
      blk-throttle: Remove a meaningless parameter for throtl_downgrade_state()
      blk-throttle: Avoid getting the current time if tg->last_finish_time is 0
      blk-throttle: Avoid tracking latency if low limit is invalid
      blk-throttle: Fix IO hang for a corner case
      blk-throttle: Move the list operation after list validation
      blk-throttle: Move service tree validation out of the throtl_rb_first()
      blk-throttle: Open code __throtl_de/enqueue_tg()
      blk-throttle: Re-use the throtl_set_slice_end()

Christoph Hellwig (87):
      block: replace bd_set_size with bd_set_nr_sectors
      block: fix locking for struct block_device size updates
      nvme: don't call revalidate_disk from nvme_set_queue_dying
      block: remove the BIO_NULL_MAPPED flag
      block: remove __blk_rq_unmap_user
      block: remove __blk_rq_map_user_iov
      block: remove the BIO_USER_MAPPED flag
      raw: deprecate the raw driver
      block: remove the alignment_offset field from struct hd_struct
      block: remove the discard_alignment field from struct hd_struct
      block: remove an outdated comment on the bd_dev field
      block: move the devcgroup_inode_permission call to blkdev_get
      block: cleanup __alloc_disk_node
      block: remove the disk argument to delete_partition
      block: remove the unused q argument to part_in_flight and part_in_flight_rw
      Documentation/filesystems/locking.rst: remove an incorrect sentence
      block: don't clear bd_invalidated in check_disk_size_change
      block: rename bd_invalidated
      block: add a new revalidate_disk_size helper
      block: use revalidate_disk_size in set_capacity_revalidate_and_notify
      nvme: opencode revalidate_disk in nvme_validate_ns
      sd: open code revalidate_disk
      nvdimm: simplify revalidate_disk handling
      block: remove revalidate_disk()
      block: add helper macros for queue sysfs entries
      block: make QUEUE_SYSFS_BIT_FNS more useful
      block: add a bdev_check_media_change helper
      amiflop: use bdev_check_media_change
      ataflop: use bdev_check_media_change
      floppy: use bdev_check_media_change
      swim: use bdev_check_media_change
      swim: simplify media change handling
      swim3: use bdev_check_media_changed
      xsysace: use bdev_check_media_change
      xsysace: simplify media change handling
      paride/pcd: use bdev_check_media_change
      gdrom: use bdev_check_media_change
      ide-cd: use bdev_check_media_changed
      ide-cd: remove idecd_revalidate_disk
      ide-gd: stop using the disk events mechanism
      md: use bdev_check_media_change
      sd: use bdev_check_media_change
      sr: use bdev_check_media_change
      sr: simplify sr_block_revalidate_disk
      block: remove check_disk_change
      block: fix bmd->is_null_mapped initialization
      block: move the NEED_PART_SCAN flag to struct gendisk
      block: cleanup partition scanning in register_disk
      block: cleanup blkdev_bszset
      pktcdvd: remove the if 0'ed pkt_start_recovery function
      pktcdvd: use blkdev_get_by_dev instead of open coding it
      zram: cleanup backing_dev_store
      raw: don't keep unopened block device around
      dasd: cleanup dasd_scan_partitions
      ocfs2: cleanup o2hb_region_dev_store
      mm: cleanup claim_swapfile
      PM: rewrite is_hibernate_resume_dev to not require an inode
      mm: split swap_type_of
      PM: mm: cleanup swsusp_swap_check
      block: mark blkdev_get static
      fs: remove the unused SB_I_MULTIROOT flag
      drbd: remove dead code in device_to_statistics
      bcache: inherit the optimal I/O size
      aoe: set an optimal I/O size
      bdi: initialize ->ra_pages and ->io_pages in bdi_init
      md: update the optimal I/O size on reshape
      block: lift setting the readahead size into the block layer
      bdi: remove BDI_CAP_CGROUP_WRITEBACK
      bdi: remove BDI_CAP_SYNCHRONOUS_IO
      mm: use SWP_SYNCHRONOUS_IO more intelligently
      bdi: replace BDI_CAP_STABLE_WRITES with a queue and a sb flag
      bdi: invert BDI_CAP_NO_ACCT_WB
      bdi: replace BDI_CAP_NO_{WRITEBACK,ACCT_DIRTY} with a single flag
      Documentation/hdio: fix up obscure bd_contains references
      block: add a bdev_is_partition helper
      md: compare bd_disk instead of bd_contains
      md: don't detour through bd_contains for the gendisk
      drbd: don't detour through bd_contains for the gendisk
      drbd: don't set ->bd_contains
      target/iblock: fix holder printing in iblock_show_configfs_dev_params
      block: use bd_partno in bdevname
      vsprintf: use bd_partno in bdev_name
      drbd: remove ->this_bdev
      block: add a bdget_part helper
      block: remove the unused blk_integrity_merge_rq export
      block: remove the unused blk_integrity_merge_bio export
      block: move blk_mq_sched_try_merge to blk-merge.c

Damien Le Moal (1):
      block: fix uapi blkzoned.h comments

Danny Lin (1):
      blk-wbt: Remove obsolete multiqueue I/O scheduling comment

Eric Biggers (3):
      block: make bio_crypt_clone() able to fail
      block: make blk_crypto_rq_bio_prep() able to fail
      block: warn if !__GFP_DIRECT_RECLAIM in bio_crypt_set_ctx()

Gabriel Krisman Bertazi (1):
      block: Consider only dispatched requests for inflight statistic

Geert Uytterhoeven (1):
      block: Make request_queue.rpm_status an enum

Hannes Reinecke (2):
      blk-mq: Rename blk_mq_update_tag_set_depth()
      blk-mq: Free tags in blk_mq_init_tags() upon error

Jan Kara (2):
      fs: Don't invalidate page buffers in block_write_full_page()
      block: Do not discard buffers under a mounted filesystem

Jens Axboe (1):
      Merge branch 'block-5.9' into for-5.10/block

Johannes Thumshirn (1):
      block: soft limit zone-append sectors as well

John Garry (6):
      blk-mq: Pass flags for tag init/free
      blk-mq: Use pointers for blk_mq_tags bitmap tags
      blk-mq: Facilitate a shared sbitmap per tagset
      blk-mq: Relocate hctx_may_queue()
      blk-mq: Record nr_active_requests per queue for when using shared sbitmap
      blk-mq: Record active_queues_shared_sbitmap per tag_set for when using shared sbitmap

Julia Lawall (1):
      block: drop double zeroing

Kashyap Desai (1):
      blk-mq, elevator: Count requests per hctx to improve performance

Khazhismel Kumykov (1):
      block: grant IOPRIO_CLASS_RT to CAP_SYS_NICE

Konstantin Khlebnikov (1):
      dm: add support for REQ_NOWAIT and enable it for linear target

Mike Snitzer (3):
      block: use lcm_not_zero() when stacking chunk_sectors
      block: allow 'chunk_sectors' to be non-power-of-2
      block: add QUEUE_FLAG_NOWAIT

Ming Lei (5):
      blk-mq: Rename BLK_MQ_F_TAG_SHARED as BLK_MQ_F_TAG_QUEUE_SHARED
      blk-mq: always allow reserved allocation in hctx_may_queue
      percpu_ref: reduce memory footprint of percpu_ref in fast path
      block: move 'q_usage_counter' into front of 'request_queue'
      percpu_ref: don't refer to ref->data if it isn't allocated

Ritika Srivastava (2):
      block: Return blk_status_t instead of errno codes
      block: better deal with the delayed not supported case in blk_cloned_rq_check_limits

Song Liu (3):
      block: introduce part_[begin|end]_io_acct
      md: use part_[begin|end]_io_acct instead of disk_[begin|end]_io_acct
      bcache: use part_[begin|end]_io_acct instead of disk_[begin|end]_io_acct

Tejun Heo (33):
      blk-iocost: use local[64]_t for percpu stat
      blk-iocost: rename propagate_active_weights() to propagate_weights()
      blk-iocost: clamp inuse and skip noops in __propagate_weights()
      blk-iocost: move iocg_kick_delay() above iocg_kick_waitq()
      blk-iocost: make iocg_kick_waitq() call iocg_kick_delay() after paying debt
      blk-iocost: s/HWEIGHT_WHOLE/WEIGHT_ONE/g
      blk-iocost: use WEIGHT_ONE based fixed point number for weights
      blk-iocost: make ioc_now->now and ioc->period_at 64bit
      blk-iocost: streamline vtime margin and timer slack handling
      blk-iocost: grab ioc->lock for debt handling
      blk-iocost: add absolute usage stat
      blk-iocost: calculate iocg->usages[] from iocg->local_stat.usage_us
      blk-iocost: replace iocg->has_surplus with ->surplus_list
      blk-iocost: decouple vrate adjustment from surplus transfers
      blk-iocost: restructure surplus donation logic
      blk-iocost: implement Andy's method for donation weight updates
      blk-iocost: revamp donation amount determination
      blk-iocost: revamp in-period donation snapbacks
      blk-iocost: revamp debt handling
      blk-iocost: implement delay adjustment hysteresis
      blk-iocost: halve debts if device stays idle
      blk-iocost: implement vtime loss compensation
      blk-iocost: restore inuse update tracepoints
      blk-iocost: add three debug stat - cost.wait, indebt and indelay
      blk-iocost: update iocost_monitor.py
      blk-iocost: fix divide-by-zero in transfer_surpluses()
      iocost: fix infinite loop bug in adjust_inuse_and_calc_cost()
      iocost: factor out ioc_forgive_debts()
      iocost: replace nr_shortages cond in ioc_forgive_debts() with busy_level one
      iocost: recalculate delay after debt reduction
      iocost: reimplement debt forgiveness using average usage
      iocost: add iocg_forgive_debt tracepoint
      iocost: consider iocgs with active delays for debt forgiveness

Tetsuo Handa (1):
      block: ratelimit handle_bad_sector() message

Tian Tao (2):
      virtio-blk: Use kobj_to_dev() instead of container_of()
      block: remove duplicate include statement in scsi_ioctl.c

Wang Hai (1):
      blktrace: make function blk_trace_bio_get_cgid() static

Xianting Tian (3):
      blk-mq: use BLK_MQ_NO_TAG for no tag
      blkcg: add plugging support for punt bio
      blk-mq: add cond_resched() in __blk_mq_alloc_rq_maps()

Yang Yang (1):
      blk-mq: move cancel of hctx->run_work to the front of blk_exit_queue

Yufen Yu (7):
      block: invoke blk_mq_exit_sched no matter whether have .exit_sched
      block: remove redundant mq check
      block: use helper function to test queue register
      blk-mq: use helper function to test hw stopped
      block: fix comment and add lockdep assert
      block: get rid of unnecessary local variable
      blk-mq: get rid of the dead flush handle code path

yangerkun (1):
      block-mq: fix comments in blk_mq_queue_tag_busy_iter

 Documentation/filesystems/locking.rst      |    3 -
 Documentation/userspace-api/ioctl/hdio.rst |   24 +-
 block/Kconfig                              |    2 -
 block/bfq-iosched.c                        |    9 +-
 block/bio.c                                |   20 +-
 block/blk-cgroup.c                         |   32 +-
 block/blk-core.c                           |  260 ++-----
 block/blk-crypto-internal.h                |   21 +-
 block/blk-crypto.c                         |   33 +-
 block/blk-integrity.c                      |    6 +-
 block/blk-iocost.c                         | 1623 +++++++++++++++++++++++++++++++++----------
 block/blk-iolatency.c                      |    2 +-
 block/blk-lib.c                            |    2 +-
 block/blk-map.c                            |  177 ++---
 block/blk-merge.c                          |  245 ++++++-
 block/blk-mq-debugfs.c                     |   11 +-
 block/blk-mq-sched.c                       |  156 +----
 block/blk-mq-sched.h                       |    3 -
 block/blk-mq-sysfs.c                       |    2 -
 block/blk-mq-tag.c                         |  156 +++--
 block/blk-mq-tag.h                         |   56 +-
 block/blk-mq.c                             |  101 ++-
 block/blk-mq.h                             |   76 +-
 block/blk-settings.c                       |   40 +-
 block/blk-sysfs.c                          |  291 ++------
 block/blk-throttle.c                       |  128 ++--
 block/blk.h                                |   29 +-
 block/bounce.c                             |   19 +-
 block/bsg-lib.c                            |    2 +-
 block/elevator.c                           |   23 +-
 block/genhd.c                              |  160 +++--
 block/ioctl.c                              |   33 +-
 block/ioprio.c                             |    2 +-
 block/kyber-iosched.c                      |    6 +-
 block/mq-deadline.c                        |    6 +
 block/partitions/core.c                    |   29 +-
 block/scsi_ioctl.c                         |    4 +-
 drivers/block/amiflop.c                    |    2 +-
 drivers/block/aoe/aoeblk.c                 |    3 +-
 drivers/block/aoe/aoecmd.c                 |    4 +-
 drivers/block/ataflop.c                    |    7 +-
 drivers/block/brd.c                        |    1 -
 drivers/block/drbd/drbd_actlog.c           |    2 +-
 drivers/block/drbd/drbd_int.h              |    1 -
 drivers/block/drbd/drbd_main.c             |   31 +-
 drivers/block/drbd/drbd_nl.c               |   26 +-
 drivers/block/drbd/drbd_receiver.c         |   12 +-
 drivers/block/drbd/drbd_req.c              |    2 +-
 drivers/block/drbd/drbd_worker.c           |    6 +-
 drivers/block/floppy.c                     |    8 +-
 drivers/block/loop.c                       |    4 +-
 drivers/block/nbd.c                        |   15 +-
 drivers/block/paride/pcd.c                 |    2 +-
 drivers/block/pktcdvd.c                    |   94 +--
 drivers/block/rbd.c                        |    4 +-
 drivers/block/rnbd/rnbd-clt.c              |   12 +-
 drivers/block/swim.c                       |   22 +-
 drivers/block/swim3.c                      |    4 +-
 drivers/block/virtio_blk.c                 |    4 +-
 drivers/block/xsysace.c                    |   26 +-
 drivers/block/zram/zram_drv.c              |   30 +-
 drivers/cdrom/gdrom.c                      |    2 +-
 drivers/char/raw.c                         |   56 +-
 drivers/ide/ide-cd.c                       |   16 +-
 drivers/ide/ide-disk.c                     |    5 +-
 drivers/ide/ide-floppy.c                   |    2 -
 drivers/ide/ide-gd.c                       |   48 +-
 drivers/ide/ide-ioctls.c                   |    4 +-
 drivers/infiniband/sw/rdmavt/mr.c          |    2 +-
 drivers/md/bcache/request.c                |   10 +-
 drivers/md/bcache/super.c                  |    5 +-
 drivers/md/dm-linear.c                     |    5 +-
 drivers/md/dm-raid.c                       |    2 +-
 drivers/md/dm-table.c                      |   43 +-
 drivers/md/dm.c                            |   26 +-
 drivers/md/md-cluster.c                    |    6 +-
 drivers/md/md-linear.c                     |    2 +-
 drivers/md/md.c                            |   29 +-
 drivers/md/md.h                            |    4 +-
 drivers/md/raid0.c                         |   16 -
 drivers/md/raid10.c                        |   46 +-
 drivers/md/raid5.c                         |   31 +-
 drivers/mmc/core/block.c                   |    2 +-
 drivers/mmc/core/queue.c                   |    3 +-
 drivers/mtd/mtdcore.c                      |    2 +
 drivers/nvdimm/blk.c                       |    3 +-
 drivers/nvdimm/btt.c                       |    5 +-
 drivers/nvdimm/bus.c                       |    9 +-
 drivers/nvdimm/nd.h                        |    2 +-
 drivers/nvdimm/pmem.c                      |    4 +-
 drivers/nvme/host/core.c                   |   53 +-
 drivers/nvme/host/multipath.c              |   10 +-
 drivers/nvme/host/nvme.h                   |   13 -
 drivers/s390/block/dasd_genhd.c            |   15 +-
 drivers/s390/block/dasd_ioctl.c            |   17 +-
 drivers/scsi/iscsi_tcp.c                   |    4 +-
 drivers/scsi/sd.c                          |   13 +-
 drivers/scsi/sr.c                          |   36 +-
 drivers/target/target_core_iblock.c        |    5 +-
 fs/9p/vfs_file.c                           |    2 +-
 fs/9p/vfs_super.c                          |    6 +-
 fs/afs/super.c                             |    1 -
 fs/block_dev.c                             |  184 +++--
 fs/btrfs/disk-io.c                         |    2 -
 fs/buffer.c                                |   16 -
 fs/fs-writeback.c                          |    7 +-
 fs/fuse/inode.c                            |    4 +-
 fs/namei.c                                 |    4 +-
 fs/nfs/super.c                             |    9 +-
 fs/nfsd/blocklayout.c                      |    4 +-
 fs/ocfs2/cluster/heartbeat.c               |   28 +-
 fs/super.c                                 |    2 +
 fs/ubifs/super.c                           |    2 +
 fs/vboxsf/super.c                          |    2 +
 include/linux/backing-dev.h                |   78 +--
 include/linux/blk-crypto.h                 |   20 +-
 include/linux/blk-mq.h                     |   15 +-
 include/linux/blk_types.h                  |    7 +-
 include/linux/blkdev.h                     |   84 ++-
 include/linux/device-mapper.h              |    6 +
 include/linux/fs.h                         |    2 +-
 include/linux/genhd.h                      |   15 +-
 include/linux/ide.h                        |    2 -
 include/linux/percpu-refcount.h            |   52 +-
 include/linux/suspend.h                    |    4 +-
 include/linux/swap.h                       |    3 +-
 include/trace/events/iocost.h              |   67 +-
 include/uapi/linux/blkzoned.h              |   15 +-
 include/uapi/linux/capability.h            |    2 +
 kernel/power/swap.c                        |   21 +-
 kernel/power/user.c                        |   26 +-
 kernel/trace/blktrace.c                    |   13 +-
 lib/percpu-refcount.c                      |  131 +++-
 lib/vsprintf.c                             |    4 +-
 mm/backing-dev.c                           |   14 +-
 mm/filemap.c                               |    4 +-
 mm/memcontrol.c                            |    2 +-
 mm/memory-failure.c                        |    2 +-
 mm/migrate.c                               |    2 +-
 mm/mmap.c                                  |    2 +-
 mm/page-writeback.c                        |   18 +-
 mm/page_io.c                               |   18 +-
 mm/swapfile.c                              |   49 +-
 tools/cgroup/iocost_monitor.py             |   54 +-
 144 files changed, 3229 insertions(+), 2446 deletions(-)

-- 
Jens Axboe

