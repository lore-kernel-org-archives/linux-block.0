Return-Path: <SRS0=sa6N=XL=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2B323C49ED7
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 14:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D38D620650
	for <linux-block@archiver.kernel.org>; Mon, 16 Sep 2019 14:52:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="sq8vDZeq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733199AbfIPOwK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 16 Sep 2019 10:52:10 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45907 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726690AbfIPOwJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 16 Sep 2019 10:52:09 -0400
Received: by mail-pg1-f196.google.com with SMTP id 4so122598pgm.12
        for <linux-block@vger.kernel.org>; Mon, 16 Sep 2019 07:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=CUJehUnbHNl//BHmGYXB9LfuW/ahU7xQACTrbLo5QUU=;
        b=sq8vDZeqckDFFWiPeoJX7cHyAyb0KVG+iP8f9bQbfj+DfFvvcVlc0BTlEVJN4fv9Ip
         HCc++LyD7MXq9H3+1uLWHQvQhe9SrNizYGZoxeEi0I2lQEmTy7jvv2kkXlhxpAl2L7QV
         UQLTmotfe/J+Jg/3N0KaeV5z0r2MnbO/365b1X0uKWWaWS/vvclHwtIAnuwJaJhpDK/a
         oBjw3S0Om00DZK351G2T9VRa+Dp8hUScXcindlAJmYqeI9x/hwVpU2hxyuicNGNDOgSN
         xp40BxWKET9dVux+TPLyo2c3KYAmDc2PFCqWehw/d5ODYC0XSjseV5bxGcnEZwJU8k6c
         NTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=CUJehUnbHNl//BHmGYXB9LfuW/ahU7xQACTrbLo5QUU=;
        b=MWzgJUdAuSttdaydEloIdis3zMoQsr2ekqc86P8APA8INuB8Bsea2NSTyZ2Y+R0S6X
         JhcCiPb5UyX8Zw57EGxHi3pfrIT9arl0o8lDDps9vwEdjJSdl8eidIajvrqmX+iLqEVi
         sMZRfGSOrSIaF6yiVkrwCcBxeYfPAcG8xmWHTc/kn2J6jlwmyBnfOXKru3YMLdU4FQcy
         2pj6RUzfGae45iPfTlnYEGxazooCUo3d1MBAIBXztbiTEaDG1PTw6J8XpteFGAy4yKND
         ocOE9g9RBENdhzmQCsG7d99FibBb4U04Vi1PWlZ6xnJyJ96hch484laIQi/qDmfSD0Up
         o5vQ==
X-Gm-Message-State: APjAAAW4TwIgkmEvjm/wGpF73/nNbmLKSoFFEX9bcvVW5O5Xy79Ejn7j
        Z40uAuv8YPqTPbxeD5DXlPbwmmPrANk0uQ==
X-Google-Smtp-Source: APXvYqwVfARXfgQLh8lLdhuLrsoboYbgw5M5VKwZyUfWYt9PffHpFFobTLNsVvN0PiwHClIiNAehUg==
X-Received: by 2002:a17:90a:23ee:: with SMTP id g101mr108056pje.122.1568645526485;
        Mon, 16 Sep 2019 07:52:06 -0700 (PDT)
Received: from ?IPv6:2605:e000:100e:83a1:30f3:8cde:93f5:74f2? ([2605:e000:100e:83a1:30f3:8cde:93f5:74f2])
        by smtp.gmail.com with ESMTPSA id f62sm47291123pfg.74.2019.09.16.07.52.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 16 Sep 2019 07:52:05 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 5.4
Message-ID: <61b11672-f41b-9708-2486-f284a99483a8@kernel.dk>
Date:   Mon, 16 Sep 2019 08:52:03 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here are the main 5.4 changes for block for this series. This pull
request contains:

- Two NVMe pull requests:
   - ana log parse fix from Anton
   - nvme quirks support for Apple devices from Ben
   - fix missing bio completion tracing for multipath stack devices from
     Hannes and Mikhail
   - IP TOS settings for nvme rdma and tcp transports from Israel
   - rq_dma_dir cleanups from Israel
   - tracing for Get LBA Status command from Minwoo
   - Some nvme-tcp cleanups from Minwoo, Potnuri and Myself
   - Some consolidation between the fabrics transports for handling the CAP
     register
   - reset race with ns scanning fix for fabrics (move fabrics commands to
     a dedicated request queue with a different lifetime from the admin
     request queue)."
   - controller reset and namespace scan races fixes
   - nvme discovery log change uevent support
   - naming improvements from Keith
   - multiple discovery controllers reject fix from James
   - some regular cleanups from various people

- Series fixing (and re-fixing) null_blk debug printing and nr_devices
  checks (André)

- A few pull requests from Song, with fixes from Andy, Guoqing,
  Guilherme, Neil, Nigel, and Yufen.

- REQ_OP_ZONE_RESET_ALL support (Chaitanya)

- Bio merge handling unification (Christoph)

- Pick default elevator correctly for devices with special needs
  (Damien)

- Block stats fixes (Hou)

- Timeout and support devices nbd fixes (Mike)

- Series fixing races around elevator switching and device add/remove
  (Ming)

- sed-opal cleanups (Revanth)

- Per device weight support for BFQ (Fam)

- Support for blk-iocost, a new model that can properly account cost of
  IO workloads. (Tejun)

- blk-cgroup writeback fixes (Tejun)

- paride queue init fixes (zhengbin)

- blk_set_runtime_active() cleanup (Stanley)

- Block segment mapping optimizations (Bart)

- lightnvm fixes (Hans/Minwoo/YueHaibing)

- Various little fixes and cleanups

Note that you'll get a simple merge conflict drivers/nvme/host/nvme.h
due to a quirk fix that was merged in mainline after for-5.4/block was
kicked off. It's trivial to resolve, you just have to renumber a few
defines around that conflict.

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.4/block-2019-09-16


----------------------------------------------------------------
Alessio Balsini (1):
      loop: Add LOOP_SET_DIRECT_IO to compat ioctl

Amit (1):
      nvmet: fix a wrong error status returned in error log page

André Almeida (6):
      docs: block: null_blk: enhance document style
      null_blk: fix module name at log message
      null_blk: validate the number of devices
      null_blk: do not fail the module load with zero devices
      null_blk: match the type of parameter nr_devices
      null_blk: format pr_* logs with pr_fmt

Andy Shevchenko (1):
      md: Convert to use int_pow()

Anton Eidelman (1):
      nvme-multipath: fix ana log nsid lookup when nsid is not found

Bart Van Assche (8):
      block: Declare several function pointer arguments 'const'
      block: Document the bio splitting functions
      block: Simplify bvec_split_segs()
      block: Simplify blk_bio_segment_split()
      block: Improve physical block alignment of split bios
      block: Fix spelling in the header above blkg_lookup()
      block: Fix a comment in blk_cleanup_queue()
      block: Remove blk_mq_register_dev()

Benjamin Herrenschmidt (4):
      nvme-pci: Pass the queue to SQ_SIZE/CQ_SIZE macros
      nvme-pci: Add support for variable IO SQ element size
      nvme-pci: Add support for Apple 2018+ models
      nvme-pci: Support shared tags across queues for Apple 2018 controllers

Chaitanya Kulkarni (10):
      block: add req op to reset all zones and flag
      blk-zoned: implement REQ_OP_ZONE_RESET_ALL
      scsi: implement REQ_OP_ZONE_RESET_ALL
      null_blk: implement REQ_OP_ZONE_RESET_ALL
      null_blk: move duplicate code to callers
      null_blk: create a helper for throttling
      null_blk: create a helper for badblocks
      null_blk: create a helper for mem-backed ops
      null_blk: create a helper for zoned devices
      null_blk: create a helper for req completion

Christoph Hellwig (3):
      block: improve the gap check in __bio_add_pc_page
      block: create a bio_try_merge_pc_page helper
      block: move same page handling from __bio_add_pc_page to the callers

Colin Ian King (1):
      nvme: tcp: remove redundant assignment to variable ret

Damien Le Moal (8):
      block: mq-deadline: Fix queue restart handling
      block: Cleanup elevator_init_mq() use
      block: Change elevator_init_mq() to always succeed
      block: Introduce elevator features
      block: Improve default elevator selection
      block: Delay default elevator initialization
      block: Set ELEVATOR_F_ZBD_SEQ_WRITE for nullblk zoned disks
      sd: Set ELEVATOR_F_ZBD_SEQ_WRITE for ZBC disks

Dan Carpenter (1):
      bcache: Fix an error code in bch_dump_read()

Edmund Nadolski (1):
      nvme: include admin_q sync with nvme_sync_queues

Fam Zheng (3):
      bfq: Fix the missing barrier in __bfq_entity_update_weight_prio
      bfq: Extract bfq_group_set_weight from bfq_io_set_weight_legacy
      bfq: Add per-device weight

Guilherme G. Piccoli (1):
      md raid0/linear: Mark array as 'broken' and fail BIOs if a member is gone

Guoqing Jiang (7):
      md: allow last device to be forcibly removed from RAID1/RAID10.
      md: don't set In_sync if array is frozen
      md: don't call spare_active in md_reap_sync_thread if all member devices can't work
      md/raid5: use bio_end_sector to calculate last_sector
      raid5: don't set STRIPE_HANDLE to stripe which is in batch list
      raid5: remove STRIPE_OPS_REQ_PENDING
      raid5: use bio_end_sector in r5_next_bio

Hannes Reinecke (1):
      nvme: trace bio completion

Hans Holmberg (4):
      lightnvm: remove nvm_submit_io_sync_fn
      lightnvm: move metadata mapping to lower level driver
      lightnvm: pblk: use kvmalloc for metadata
      block: stop exporting bio_map_kern

Hou Tao (4):
      raid1: use an int as the return value of raise_barrier()
      raid1: factor out a common routine to handle the completion of sync write
      block: make rq sector size accessible for block stats
      block: also check RQF_STATS in blk_mq_need_time_stamp()

Israel Rukshin (9):
      nvme-fabrics: Add type of service (TOS) configuration
      nvme-rdma: Add TOS for rdma transport
      nvme-tcp: Use struct nvme_ctrl directly
      nvme-tcp: Add TOS for tcp transport
      nvmet-tcp: Add TOS for tcp transport
      nvme-pci: Tidy up nvme_unmap_data
      nvme-fc: Use rq_dma_dir macro
      nvme-rdma: Use rq_dma_dir macro
      nvme: Remove redundant assignment of cq vector

James Smart (2):
      nvme-fc: Fail transport errors with NVME_SC_HOST_PATH
      nvme: Treat discovery subsystems as unique subsystems

Jann Horn (1):
      floppy: fix usercopy direction

Jens Axboe (9):
      Merge branch 'md-next' of https://github.com/liu-song-6/linux into for-5.4/block
      lightnvm: remove unused 'geo' variable
      null_blk: fix inline misuse
      Merge branch 'md-next' of git://git.kernel.org/.../song/md into for-5.4/block
      Merge branch 'nvme-5.4' of git://git.infradead.org/nvme into for-5.4/block
      Merge branch 'md-next' of git://git.kernel.org/.../song/md into for-5.4/block
      block: fix elevator_get_by_features()
      Merge branch 'nvme-5.4' of git://git.infradead.org/nvme into for-5.4/block
      Merge branch 'md-next' of git://git.kernel.org/.../song/md into for-5.4/block

Johannes Weiner (1):
      block: annotate refault stalls from IO submission

Junxiao Bi (1):
      block: remove struct request_queue queue_head

Keith Busch (1):
      nvme: Assign subsys instance from first ctrl

Kent Overstreet (1):
      closures: fix a race on wakeup from closure_sync

Marcos Paulo de Souza (3):
      block: elevator.c: Remove now unused elevator= argument
      Documenation: switching-sched: Remove notes about elevator argument
      Documentation:kernel-per-CPU-kthreads.txt: Remove reference to elevator=

Markus Elfring (1):
      nvmet: Use PTR_ERR_OR_ZERO() in nvmet_init_discovery()

Mike Christie (5):
      nbd: add set cmd timeout helper
      nbd: add function to convert blk req op to nbd cmd
      nbd: add missing config put
      nbd: fix zero cmd timeout handling v2
      nbd: fix max number of supported devs

Ming Lei (13):
      blk-mq: introduce blk_mq_request_completed()
      blk-mq: introduce blk_mq_tagset_wait_completed_request()
      nvme: don't abort completed request in nvme_cancel_request
      nvme: wait until all completed request's complete fn is called
      blk-mq: remove blk_mq_complete_request_sync
      blk-mq: add callback of .cleanup_rq
      scsi: implement .cleanup_rq callback
      blk-mq: balance mapping between present CPUs and queues
      block: don't hold q->sysfs_lock in elevator_init_mq
      blk-mq: don't hold q->sysfs_lock in blk_mq_map_swqueue
      block: add helper for checking if queue is registered
      block: split .sysfs_lock into two locks
      block: fix race between switching elevator and removing queues

Minwoo Im (7):
      nvme: tcp: selects CRYPTO_CRC32C for nvme-tcp
      nvme: add Get LBA Status command opcode
      nvme: trace: support for Get LBA Status opcode parsed
      nvme: trace: parse Get LBA Status command in detail
      nvmet: trace: parse Get LBA Status command in detail
      lightnvm: introduce pr_fmt for the prefix nvm
      lightnvm: print error when target is not found

NeilBrown (4):
      md: only call set_in_sync() when it is expected to succeed.
      md: don't report active array_state until after revalidate_disk() completes.
      md/raid0: avoid RAID0 data corruption due to layout confusion.
      md: add feature flag MD_FEATURE_RAID0_LAYOUT

Nigel Croxon (2):
      raid5 improve too many read errors msg by adding limits
      raid5: don't increment read_errors on EILSEQ return

Pavel Begunkov (1):
      bfq: Fix bfq linkage error

Potnuri Bharat Teja (1):
      nvme-tcp: Use protocol specific operations while reading socket

Revanth Rajashekar (3):
      block: sed-opal: Add/remove spaces
      block: sed-opal: Remove always false conditional statement
      block: sed-opal: Removed duplicate OPAL_METHOD_LENGTH definition

Sagi Grimberg (19):
      nvme-tcp: cleanup nvme_tcp_recv_pdu
      nvme: have nvme_init_identify set ctrl->cap
      nvme-pci: set ctrl sqsize to the device q_depth
      nvme: move sqsize setting to the core
      nvme: don't pass cap to nvme_disable_ctrl
      nvme-tcp: support simple polling
      nvmet-tcp: fix possible NULL deref
      nvmet-tcp: fix possible memory leak
      nvme: make fabrics command run on a separate request queue
      nvme: fail cancelled commands with NVME_SC_HOST_PATH_ERROR
      nvme-tcp: fail command with NVME_SC_HOST_PATH_ERROR send failed
      nvme: pass status to nvme_error_status
      nvme: make nvme_identify_ns propagate errors back
      nvme: make nvme_report_ns_ids propagate error back
      nvme: fix ns removal hang when failing to revalidate due to a transient error
      nvme-fabrics: allow discovery subsystems accept a kato
      nvme: enable aen regardless of the presence of I/O queues
      nvme: add uevent variables for controller devices
      nvme: send discovery log page change events to userspace

Shile Zhang (1):
      bcache: add cond_resched() in __bch_cache_cmp()

Stanley Chu (2):
      block: bypass blk_set_runtime_active for uninitialized q->dev
      scsi: core: remove dummy q->dev check

Stephen Rothwell (1):
      blkcg: blk-iocost: predeclare used structs

Tejun Heo (27):
      writeback, cgroup: Adjust WB_FRN_TIME_CUT_DIV to accelerate foreign inode switching
      writeback, cgroup: inode_switch_wbs() shouldn't give up on wb_switch_rwsem trylock fail
      writeback: Generalize and expose wb_completion
      bdi: Add bdi->id
      writeback: Separate out wb_get_lookup() from wb_get_create()
      writeback, memcg: Implement cgroup_writeback_by_id()
      writeback, memcg: Implement foreign dirty flushing
      blkcg: pass @q and @blkcg into blkcg_pol_alloc_pd_fn()
      blkcg: make ->cpd_init_fn() optional
      blkcg: separate blkcg_conf_get_disk() out of blkg_conf_prep()
      block/rq_qos: add rq_qos_merge()
      block/rq_qos: implement rq_qos_ops->queue_depth_changed()
      blkcg: s/RQ_QOS_CGROUP/RQ_QOS_LATENCY/
      blk-mq: add optional request->alloc_time_ns
      blkcg: implement blk-iocost
      blkcg: add tools/cgroup/iocost_monitor.py
      blkcg: add tools/cgroup/iocost_coef_gen.py
      blkcg: fix missing free on error path of blk_iocost_init()
      blkcg: add missing NULL check in ioc_cpd_alloc()
      writeback: add tracepoints for cgroup foreign writebacks
      writeback: don't access page->mapping directly in track_foreign_dirty TP
      blk-iocost: Fix incorrect operation order during iocg free
      blk-iocost: Account force-charged overage in absolute vtime
      blk-iocost: Don't let merges push vtime into the future
      iocost_monitor: Always use strings for json values
      iocost_monitor: Report more info with higher accuracy
      iocost_monitor: Report debt

Tom Wu (1):
      nvmet: fix data units read and written counters in SMART log

Xiao Ni (1):
      md/raid6: Set R5_ReadError when there is read failure on parity disk

YueHaibing (1):
      lightnvm: remove set but not used variables 'data_len' and 'rq_len'

Yufen Yu (3):
      md/raid1: end bio when the device faulty
      md/raid10: end bio when the device faulty
      md/raid1: fail run raid1 array when active disk less than one

Zhou Wang (1):
      lib: scatterlist: Fix to support no mapped sg

zhengbin (4):
      blk-mq: Fix memory leak in blk_mq_init_allocated_queue error handling
      paride/pf: need to set queue to NULL before put_disk
      paride/pcd: need to set queue to NULL before put_disk
      paride/pcd: need to check if cd->disk is null in pcd_detect

 Documentation/admin-guide/cgroup-v2.rst            |   97 +
 Documentation/admin-guide/kernel-parameters.txt    |    6 -
 .../admin-guide/kernel-per-CPU-kthreads.rst        |    8 +-
 Documentation/block/null_blk.rst                   |   33 +-
 Documentation/block/switching-sched.rst            |    4 -
 block/Kconfig                                      |   13 +
 block/Makefile                                     |    1 +
 block/bfq-cgroup.c                                 |  156 +-
 block/bfq-iosched.h                                |    3 +
 block/bfq-wf2q.c                                   |    2 +
 block/bio.c                                        |   60 +-
 block/blk-cgroup.c                                 |   73 +-
 block/blk-core.c                                   |   37 +-
 block/blk-iocost.c                                 | 2457 ++++++++++++++++++++
 block/blk-iolatency.c                              |    8 +-
 block/blk-merge.c                                  |  151 +-
 block/blk-mq-cpumap.c                              |   29 +-
 block/blk-mq-sysfs.c                               |   23 +-
 block/blk-mq-tag.c                                 |   32 +
 block/blk-mq.c                                     |   69 +-
 block/blk-pm.c                                     |   12 +-
 block/blk-rq-qos.c                                 |   18 +
 block/blk-rq-qos.h                                 |   28 +-
 block/blk-settings.c                               |   18 +-
 block/blk-sysfs.c                                  |   50 +-
 block/blk-throttle.c                               |    9 +-
 block/blk-wbt.c                                    |   20 +-
 block/blk-wbt.h                                    |    4 -
 block/blk-zoned.c                                  |   39 +
 block/blk.h                                        |    4 +-
 block/elevator.c                                   |  217 +-
 block/genhd.c                                      |    9 +
 block/mq-deadline.c                                |   20 +-
 block/opal_proto.h                                 |    5 +-
 block/sed-opal.c                                   |   49 +-
 drivers/block/floppy.c                             |    4 +-
 drivers/block/loop.c                               |    1 +
 drivers/block/nbd.c                                |  127 +-
 drivers/block/null_blk.h                           |   18 +-
 drivers/block/null_blk_main.c                      |  183 +-
 drivers/block/null_blk_zoned.c                     |   59 +-
 drivers/block/paride/pcd.c                         |   12 +-
 drivers/block/paride/pf.c                          |    2 +-
 drivers/lightnvm/core.c                            |   97 +-
 drivers/lightnvm/pblk-core.c                       |  116 +-
 drivers/lightnvm/pblk-gc.c                         |   19 +-
 drivers/lightnvm/pblk-init.c                       |   38 +-
 drivers/lightnvm/pblk-read.c                       |   26 +-
 drivers/lightnvm/pblk-recovery.c                   |   42 +-
 drivers/lightnvm/pblk-write.c                      |   20 +-
 drivers/lightnvm/pblk.h                            |   31 +-
 drivers/md/bcache/closure.c                        |   10 +-
 drivers/md/bcache/debug.c                          |    5 +-
 drivers/md/bcache/sysfs.c                          |    1 +
 drivers/md/dm-rq.c                                 |    3 +-
 drivers/md/md-linear.c                             |    5 +
 drivers/md/md.c                                    |   96 +-
 drivers/md/md.h                                    |   20 +
 drivers/md/raid0.c                                 |   41 +-
 drivers/md/raid0.h                                 |   14 +
 drivers/md/raid1.c                                 |   89 +-
 drivers/md/raid10.c                                |   32 +-
 drivers/md/raid5.c                                 |   27 +-
 drivers/md/raid5.h                                 |    5 +-
 drivers/nvme/host/Kconfig                          |    1 +
 drivers/nvme/host/core.c                           |  201 +-
 drivers/nvme/host/fabrics.c                        |   38 +-
 drivers/nvme/host/fabrics.h                        |    3 +
 drivers/nvme/host/fc.c                             |   73 +-
 drivers/nvme/host/lightnvm.c                       |   45 +-
 drivers/nvme/host/multipath.c                      |    8 +-
 drivers/nvme/host/nvme.h                           |   36 +-
 drivers/nvme/host/pci.c                            |  102 +-
 drivers/nvme/host/rdma.c                           |   61 +-
 drivers/nvme/host/tcp.c                            |  144 +-
 drivers/nvme/host/trace.c                          |   18 +
 drivers/nvme/target/admin-cmd.c                    |   22 +-
 drivers/nvme/target/discovery.c                    |    4 +-
 drivers/nvme/target/loop.c                         |   30 +-
 drivers/nvme/target/tcp.c                          |   24 +-
 drivers/nvme/target/trace.c                        |   18 +
 drivers/scsi/scsi_lib.c                            |   13 +
 drivers/scsi/scsi_pm.c                             |    3 +-
 drivers/scsi/sd.c                                  |    5 +-
 drivers/scsi/sd.h                                  |    5 +-
 drivers/scsi/sd_zbc.c                              |   12 +-
 fs/fs-writeback.c                                  |  174 +-
 include/linux/backing-dev-defs.h                   |   23 +
 include/linux/backing-dev.h                        |    5 +
 include/linux/blk-cgroup.h                         |    6 +-
 include/linux/blk-mq.h                             |   20 +-
 include/linux/blk_types.h                          |    6 +
 include/linux/blkdev.h                             |   73 +-
 include/linux/elevator.h                           |    8 +
 include/linux/lightnvm.h                           |    8 +-
 include/linux/memcontrol.h                         |   39 +
 include/linux/nvme.h                               |    5 +-
 include/linux/writeback.h                          |    2 +
 include/trace/events/iocost.h                      |  178 ++
 include/trace/events/writeback.h                   |  126 +
 include/uapi/linux/raid/md_p.h                     |    2 +
 lib/sg_split.c                                     |   12 +-
 mm/backing-dev.c                                   |  120 +-
 mm/memcontrol.c                                    |  139 ++
 mm/page-writeback.c                                |    4 +
 tools/cgroup/iocost_coef_gen.py                    |  178 ++
 tools/cgroup/iocost_monitor.py                     |  277 +++
 107 files changed, 5895 insertions(+), 1283 deletions(-)
 create mode 100644 block/blk-iocost.c
 create mode 100644 include/trace/events/iocost.h
 create mode 100644 tools/cgroup/iocost_coef_gen.py
 create mode 100644 tools/cgroup/iocost_monitor.py

-- 
Jens Axboe

