Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27C8C433F5
	for <linux-block@archiver.kernel.org>; Mon,  3 Oct 2022 19:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229595AbiJCTSK (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 3 Oct 2022 15:18:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229692AbiJCTSJ (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 3 Oct 2022 15:18:09 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01D3831EDE
        for <linux-block@vger.kernel.org>; Mon,  3 Oct 2022 12:18:07 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id u2so1173075ilv.6
        for <linux-block@vger.kernel.org>; Mon, 03 Oct 2022 12:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date;
        bh=fgNG5YDysi/yj/gzefurXs8e0yWZ8J62PzryEBL5jBk=;
        b=iV+2wwd3a8Rpfra5fl0giCGDkAftBbn2jC7Ox1UqSgBRBNVhbls0MKKjAAD+zYZwPX
         9Tf76sKLWyoOZKJS5xx/XvisYhKfoWr7IxgcDDmMI8MTCMLZrgJXArPhQEFKz0yiToMo
         SNCIZ7jPzXEfN9eJVKrQ1y3vlVUIhJS9/QgByu/YMVp7txpeFin3gpo+Ut3Fh+zH75/4
         CHpwTGA13SEyBTQQDLipMAzqeerbFHEv8UYexzSl6awBu53/W3FWjn3nkbdbhyOOiH0v
         edBYxjnvmyfGtiUxLXxnIhg6u8wSlIqHjaww0fzuBHEFvWyD/sj2YE4tXu3sX6YdTD0A
         OD+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date;
        bh=fgNG5YDysi/yj/gzefurXs8e0yWZ8J62PzryEBL5jBk=;
        b=PCFTdUz2sNMJmU84WMRLAhcXzoFB8lh87Yvd/izz905M67OB3WbNvgrHoyQ7AKjbfF
         fM1iE1grx+fRgUNXXl3mXDBTsXQQTumwd/nR25U29V6Puza32CxJTI5KXDiSRSdKLTik
         jphYe2uP8TYfwxQFLlzZVU0Vo1xPnmmHv/VmbEtt1NfOD3PmesDf28YFLXm0JYTLDAaI
         +ZoGUrU6bgfGhTSQABLALnSNg5q21BxPd1sBGHH7VlGmSkNmrhap/gUfMOXz+6eAuIev
         ah47TujdfALp45iYAyQ7Y5bZuxJf3+CWg+v2ZPr6qy1Hkl/TXBiZf68cf9sVS0NQcw5L
         C8Iw==
X-Gm-Message-State: ACrzQf1MGQE8jF+jh3j0WTNsBEqPJRwezVLWXfx2T9dE+9bio7vqoWXG
        L3ehD59x0f24bZa4Zt9sN+g7SPHNHSeCRA==
X-Google-Smtp-Source: AMsMyM4mEvQN3gRVYNXCky+HY44UAexU90joKYp53CWRHZfJ1Z7GAqCBZUid9shU4499NuBqUVjxsA==
X-Received: by 2002:a05:6e02:1445:b0:2f9:c751:7b43 with SMTP id p5-20020a056e02144500b002f9c7517b43mr2958613ilo.106.1664824686148;
        Mon, 03 Oct 2022 12:18:06 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id c26-20020a02331a000000b003627dc2a94esm2335969jae.96.2022.10.03.12.18.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 12:18:05 -0700 (PDT)
Message-ID: <37a0bf85-4e31-18a1-5a20-7fe9fc5c0f3a@kernel.dk>
Date:   Mon, 3 Oct 2022 13:18:04 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 6.1-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here are the block changes queued up for the 6.1 merge window. Due to
needing synchronization between the core block and driver changes in a
lot of the past releases, this release has both driver and core changes
in a single branch. There will not be a separate 'drivers' pull request
because of that. This is a bit of an experiment - it makes my life
easier and avoids conflicts that can be avoided, or creating topic
branches that exist purely because core block changes are needed for
subsequent driver changes.

Note that merging this will throw a trivial conflict in block/genhd.c
due to blk_throtl_cancel_bios() now taking a disk rather than a queue,
which conflicts with a late cycle revert in the 6.0 series. Apart from
that, it merges cleanly.

This pull request contains:

- NVMe pull requests via Christoph:
	- handle number of queue changes in the TCP and RDMA drivers
	  (Daniel Wagner)
	- allow changing the number of queues in nvmet (Daniel Wagner)
	- also consider host_iface when checking ip options
	  (Daniel Wagner)
	- don't map pages which can't come from HIGHMEM
	  (Fabio M. De Francesco)
	- avoid unnecessary flush bios in nvmet (Guixin Liu)
	- shrink and better pack the nvme_iod structure (Keith Busch)
	- add comment for unaligned "fake" nqn (Linjun Bao)
	- print actual source IP address through sysfs "address" attr
	  (Martin Belanger)
	- various cleanups (Jackie Liu, Wolfram Sang, Genjian Zhang)
	- handle effects after freeing the request (Keith Busch)
	- copy firmware_rev on each init (Keith Busch)
	- restrict management ioctls to admin (Keith Busch)
	- ensure subsystem reset is single threaded (Keith Busch)
	- report the actual number of tagset maps in nvme-pci (Keith Busch)
	- small fabrics authentication fixups (Christoph Hellwig)
	- add common code for tagset allocation and freeing
	  (Christoph Hellwig)
	- stop using the request_queue in nvmet (Christoph Hellwig)
	- set min_align_mask before calculating max_hw_sectors
	  (Rishabh Bhatnagar)
	- send a rediscover uevent when a persistent discovery controller
	  reconnects (Sagi Grimberg)
	- misc nvmet-tcp fixes (Varun Prakash, zhenwei pi)

- MD pull request via Song:
	- Various raid5 fix and clean up, by Logan Gunthorpe and
	  David Sloan.
	- Raid10 performance optimization, by Yu Kuai.

- sbitmap wakeup hang fixes (Hugh, Keith, Jan, Yu)

- IO scheduler switching quisce fix (Keith)

- s390/dasd block driver updates (Stefan)

- Support for recovery for the ublk driver (ZiyangZhang)

- rnbd drivers fixes and updates (Guoqing, Santosh, ye, Christoph)

- blk-mq and null_blk map fixes (Bart)

- Various bcache fixes (Coly, Jilin, Jules)

- nbd signal hang fix (Shigeru)

- block writeback throttling fix (Yu)

- Optimize the passthrough mapping handling (me)

- Series preparing block cgroups to being gendisk based (Christoph)

- Get rid of an old PSI hack in the block layer, moving it to the
  callers instead where it belongs (Christoph)

- Series of blk-throttle fixes and cleanups (Yu)

- Misc fixes and cleanups (Liu Shixin, Liu Song, Miaohe, Pankaj,
  Ping-Xiang, Wolfram, Saurabh, Li Jinlin, Li Lei, Lin, Li zeming,
  Miaohe, Bart, Coly, Gaosheng

Please pull!


The following changes since commit 1c23f9e627a7b412978b4e852793c5e3c3efc555:

  Linux 6.0-rc2 (2022-08-21 17:32:54 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.1/block-2022-10-03

for you to fetch changes up to 30514bd2dd4e86a3ecfd6a93a3eadf7b9ea164a0:

  sbitmap: fix lockup while swapping (2022-09-29 17:58:17 -0600)

----------------------------------------------------------------
for-6.1/block-2022-10-03

----------------------------------------------------------------
Bart Van Assche (3):
      null_blk: Modify the behavior of null_map_queues()
      block: Change the return type of blk_mq_map_queues() into void
      block: Fix the enum blk_eh_timer_return documentation

Christoph Hellwig (48):
      mm: add PSI accounting around ->read_folio and ->readahead calls
      sched/psi: export psi_memstall_{enter,leave}
      btrfs: add manual PSI accounting for compressed reads
      erofs: add manual PSI accounting for the compressed address space
      block: remove PSI accounting from the bio layer
      rnbd-srv: simplify rnbd_srv_fill_msg_open_rsp
      rnbd-srv: remove rnbd_endio
      rnbd-srv: remove rnbd_dev_{open,close}
      rnbd-srv: remove struct rnbd_dev
      blk-cgroup: fix error unwinding in blkcg_init_queue
      blk-cgroup: remove blk_queue_root_blkg
      blk-cgroup: remove open coded blkg_lookup instances
      blk-cgroup: cleanup the blkg_lookup family of functions
      blk-cgroup: remove blkg_lookup_check
      blk-cgroup: pass a gendisk to blkcg_init_queue and blkcg_exit_queue
      blk-ioprio: pass a gendisk to blk_ioprio_init and blk_ioprio_exit
      blk-iolatency: pass a gendisk to blk_iolatency_init
      blk-iocost: simplify ioc_name
      blk-iocost: pass a gendisk to blk_iocost_init
      blk-iocost: cleanup ioc_qos_write
      blk-throttle: pass a gendisk to blk_throtl_init and blk_throtl_exit
      blk-throttle: pass a gendisk to blk_throtl_register_queue
      blk-throttle: pass a gendisk to blk_throtl_cancel_bios
      blk-cgroup: pass a gendisk to blkg_destroy_all
      blk-cgroup: pass a gendisk to blkcg_schedule_throttle
      blk-cgroup: pass a gendisk to the blkg allocation helpers
      nvmet-auth: don't try to cancel a non-initialized work_struct
      nvme: improve the NVME_CONNECT_AUTHREQ* definitions
      nvmet: add helpers to set the result field for connect commands
      nvme-auth: add a MAINTAINERS entry
      nvme: add common helpers to allocate and free tagsets
      nvme-tcp: remove the unused queue_size member in nvme_tcp_queue
      nvme-tcp: store the generic nvme_ctrl in set->driver_data
      nvme-tcp: use the tagset alloc/free helpers
      nvme-rdma: store the generic nvme_ctrl in set->driver_data
      nvme-rdma: use the tagset alloc/free helpers
      nvme-fc: keep ctrl->sqsize in sync with opts->queue_size
      nvme-fc: store the generic nvme_ctrl in set->driver_data
      nvme-fc: use the tagset alloc/free helpers
      nvme-loop: initialize sqsize later
      nvme-loop: store the generic nvme_ctrl in set->driver_data
      nvme-loop: use the tagset alloc/free helpers
      nvme: remove nvme_ctrl_init_connect_q
      block: replace blk_queue_nowait with bdev_nowait
      nvmet: don't look at the request_queue in nvmet_bdev_zone_mgmt_emulate_all
      nvmet: don't look at the request_queue in nvmet_bdev_set_limits
      blk-cgroup: don't update the blkg lookup hint in blkg_conf_prep
      s390/dasd: use blk_mq_alloc_disk

Coly Li (1):
      bcache: fix set_at_max_writeback_rate() for multiple attached devices

Daniel Wagner (4):
      nvmet: expose max queues to configfs
      nvme-tcp: handle number of queue changes
      nvme-rdma: handle number of queue changes
      nvme: consider also host_iface when checking ip options

David Sloan (1):
      md/raid5: Remove unnecessary bio_put() in raid5_read_one_chunk()

Fabio M. De Francesco (1):
      nvmet-tcp: don't map pages which can't come from HIGHMEM

Gaosheng Cui (3):
      block/drbd: remove unused w_start_resync declaration
      drbd: remove orphan _req_may_be_done() declaration
      block/drbd: remove useless comments in receive_DataReply()

Genjian Zhang (1):
      nvmet-auth: remove redundant parameters req

Guixin Liu (1):
      nvmet: avoid unnecessary flush bio

Guoqing Jiang (4):
      rnbd-srv: add comment in rnbd_srv_rdma_ev
      rnbd-srv: make process_msg_close returns void
      rnbd-srv: remove redundant setting of blk_open_flags
      md/raid10: fix compile warning

Hugh Dickins (1):
      sbitmap: fix lockup while swapping

Jackie Liu (2):
      nvme-auth: remove the redundant req->cqe->result.u16 assignment operation
      nvmet-auth: clean up with done_kfree

Jan Kara (1):
      sbitmap: Avoid leaving waitqueue in invalid state in __sbq_wake_up()

Jens Axboe (8):
      block: shrink rq_map_data a bit
      block: enable bio caching use for passthru IO
      block: use on-stack page vec for <= UIO_FASTIOV
      block: enable per-cpu bio caching for the fs bio set
      Revert "sbitmap: fix batched wait_cnt accounting"
      Merge tag 'nvme-6.1-2022-09-20' of git://git.infradead.org/nvme into for-6.1/block
      Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.1/block
      Merge tag 'nvme-6.1-2022-09-28' of git://git.infradead.org/nvme into for-6.1/block

Jiapeng Chong (1):
      block/blk-map: Remove set but unused variable 'added'

Jilin Yuan (1):
      bcache:: fix repeated words in comments

Jules Maselbas (1):
      bcache: bset: Fix comment typos

Keith Busch (12):
      sbitmap: fix batched wait_cnt accounting
      sbitmap: fix batched wait_cnt accounting
      nvme-pci: remove nvme_queue from nvme_iod
      nvme-pci: iod's 'aborted' is a bool
      nvme-pci: iod npages fits in s8
      nvme-pci: move iod dma_len fill gaps
      nvme: handle effects after freeing the request
      nvme: copy firmware_rev on each init
      nvme: restrict management ioctls to admin
      nvme: ensure subsystem reset is single threaded
      nvme-pci: report the actual number of tagset maps
      blk-mq: use quiesced elevator switch when reinitializing queues

Li Jinlin (1):
      block/blk-rq-qos: delete useless enmu RQ_QOS_IOPRIO

Li Lei (1):
      bcache: remove unnecessary flush_workqueue

Li zeming (1):
      blk-iocost: Remove unnecessary (void*) conversions

Lin Feng (1):
      bcache: remove unused bch_mark_cache_readahead function def in stats.h

Linjun Bao (1):
      nvme: add comment for unaligned "fake" nqn

Liu Shixin (1):
      block: aoe: use DEFINE_SHOW_ATTRIBUTE to simplify aoe_debugfs

Liu Song (2):
      sbitmap: remove unnecessary code in __sbitmap_queue_get_batch
      blk-mq: don't redirect completion for hctx withs only one ctx mapping

Logan Gunthorpe (7):
      md/raid5: Refactor raid5_get_active_stripe()
      md/raid5: Drop extern on function declarations in raid5.h
      md/raid5: Cleanup prototype of raid5_get_active_stripe()
      md/raid5: Don't read ->active_stripes if it's not needed
      md/raid5: Ensure stripe_fill happens on non-read IO with journal
      md: Remove extra mddev_get() in md_seq_start()
      md/raid5: Wait for MD_SB_CHANGE_PENDING in raid5d

Martin Belanger (1):
      nvme-tcp: print actual source IP address through sysfs "address" attr

Miaohe Lin (2):
      blk-mq: remove unneeded needs_restart check
      block: remove unneeded return value of bio_check_ro()

Pankaj Raghav (2):
      block: adapt blk_mq_plug() to not plug for writes that require a zone lock
      block: add rationale for not using blk_mq_plug() when applicable

Ping-Xiang Chen (1):
      block: fix comment typo in submit_bio of block-core.c.

Rishabh Bhatnagar (1):
      nvme-pci: set min_align_mask before calculating max_hw_sectors

Sagi Grimberg (2):
      nvme: enumerate controller flags
      nvme: send a rediscover uevent when a persistent discovery controller reconnects

Santosh Pradhan (1):
      block/rnbd-srv: Add event tracing support

Saurabh Sengar (1):
      md: Replace snprintf with scnprintf

Shigeru Yoshida (1):
      nbd: Fix hung when signal interrupts nbd_start_device_ioctl()

Song Liu (1):
      Merge branch 'md-next-raid10-optimize' into md-next

Stefan Haberland (7):
      s390/dasd: put block allocation in separate function
      s390/dasd: add query PPRC function
      s390/dasd: add copy pair setup
      s390/dasd: add copy pair swap capability
      s390/dasd: add ioctl to perform a swap of the drivers copy pair
      s390/dasd: suppress generic error messages for PPRC secondary devices
      s390/dasd: add device ping attribute

Uros Bizjak (1):
      sbitmap: Use atomic_long_try_cmpxchg in __sbitmap_queue_get_batch

Varun Prakash (2):
      nvmet-tcp: handle ICReq PDU received in NVMET_TCP_Q_LIVE state
      nvmet-tcp: add bounds check on Transfer Tag

Wolfram Sang (2):
      nvme: move from strlcpy with unused retval to strscpy
      block: move from strlcpy with unused retval to strscpy

XU pengfei (1):
      md/raid5: Fix spelling mistakes in comments

Yu Kuai (20):
      block, bfq: remove unused functions
      block, bfq: remove useless checking in bfq_put_queue()
      block, bfq: remove useless parameter for bfq_add/del_bfqq_busy()
      sbitmap: fix possible io hung due to lost wakeup
      blk-throttle: clean up codes that can't be reached
      blk-throttle: fix that io throttle can only work for single bio
      blk-throttle: prevent overflow while calculating wait time
      blk-throttle: factor out code to calculate ios/bytes_allowed
      blk-throttle: fix io hung due to configuration updates
      blk-throttle: use 'READ/WRITE' instead of '0/1'
      blk-throttle: calling throtl_dequeue/enqueue_tg in pairs
      blk-throttle: cleanup tg_update_disptime()
      blk-wbt: call rq_qos_add() after wb_normal is initialized
      md/raid10: factor out code from wait_barrier() to stop_waiting_barrier()
      md/raid10: don't modify 'nr_waitng' in wait_barrier() for the case nowait
      md/raid10: prevent unnecessary calls to wake_up() in fast path
      md/raid10: fix improper BUG_ON() in raise_barrier()
      md/raid10: convert resync_lock to use seqlock
      blk-throttle: remove THROTL_TG_HAS_IOPS_LIMIT
      blk-throttle: improve bypassing bios checkings

Zhou nan (1):
      md: Fix spelling mistake in comments of r5l_log

ZiyangZhang (6):
      ublk_drv: check 'current' instead of 'ubq_daemon'
      ublk_drv: define macros for recovery feature and check them
      ublk_drv: requeue rqs with recovery feature enabled
      ublk_drv: consider recovery feature in aborting mechanism
      ublk_drv: support UBLK_F_USER_RECOVERY_REISSUE
      ublk_drv: add START_USER_RECOVERY and END_USER_RECOVERY support

dougmill@linux.vnet.ibm.com (1):
      block: sed-opal: Add ioctl to return device status

ye xingchen (1):
      block/rnbd-clt: Remove the unneeded result variable

zhenwei pi (2):
      nvmet-tcp: fix NULL pointer dereference during release
      nvmet-tcp: remove nvmet_tcp_finish_cmd

 MAINTAINERS                               |   9 +
 arch/s390/include/asm/scsw.h              |   5 +
 arch/s390/include/uapi/asm/dasd.h         |  14 +
 block/bfq-cgroup.c                        |   5 -
 block/bfq-iosched.c                       |  14 +-
 block/bfq-iosched.h                       |  18 +-
 block/bfq-wf2q.c                          |   9 +-
 block/bio.c                               |  13 +-
 block/blk-cgroup.c                        | 183 ++++-----
 block/blk-cgroup.h                        |  68 +---
 block/blk-core.c                          |  37 +-
 block/blk-iocost.c                        |  39 +-
 block/blk-iolatency.c                     |   5 +-
 block/blk-ioprio.c                        |   8 +-
 block/blk-ioprio.h                        |   8 +-
 block/blk-map.c                           |  52 ++-
 block/blk-mq-cpumap.c                     |   4 +-
 block/blk-mq-debugfs.c                    |   2 -
 block/blk-mq-pci.c                        |   7 +-
 block/blk-mq-rdma.c                       |   6 +-
 block/blk-mq-tag.c                        |   2 +-
 block/blk-mq-virtio.c                     |   7 +-
 block/blk-mq.c                            |  32 +-
 block/blk-mq.h                            |   3 +-
 block/blk-rq-qos.h                        |   1 -
 block/blk-sysfs.c                         |   2 +-
 block/blk-throttle.c                      | 280 ++++++++------
 block/blk-throttle.h                      |  53 ++-
 block/blk-wbt.c                           |   9 +-
 block/blk-zoned.c                         |   9 +-
 block/blk.h                               |   7 +-
 block/elevator.c                          |   4 +-
 block/genhd.c                             |   7 +-
 block/opal_proto.h                        |   5 +
 block/sed-opal.c                          |  89 ++++-
 drivers/block/aoe/aoeblk.c                |  15 +-
 drivers/block/brd.c                       |   2 +-
 drivers/block/drbd/drbd_int.h             |   1 -
 drivers/block/drbd/drbd_nl.c              |   2 +-
 drivers/block/drbd/drbd_receiver.c        |   3 -
 drivers/block/drbd/drbd_req.h             |   2 -
 drivers/block/mtip32xx/mtip32xx.c         |  12 +-
 drivers/block/nbd.c                       |   6 +-
 drivers/block/null_blk/main.c             |   8 +-
 drivers/block/ps3vram.c                   |   2 +-
 drivers/block/rnbd/Makefile               |   6 +-
 drivers/block/rnbd/rnbd-clt.c             |   8 +-
 drivers/block/rnbd/rnbd-srv-dev.c         |  43 ---
 drivers/block/rnbd/rnbd-srv-dev.h         |  64 ----
 drivers/block/rnbd/rnbd-srv-trace.c       |  17 +
 drivers/block/rnbd/rnbd-srv-trace.h       | 207 ++++++++++
 drivers/block/rnbd/rnbd-srv.c             | 123 +++---
 drivers/block/rnbd/rnbd-srv.h             |   2 +-
 drivers/block/ublk_drv.c                  | 302 ++++++++++++++-
 drivers/block/virtio_blk.c                |   4 +-
 drivers/block/zram/zram_drv.c             |   6 +-
 drivers/md/bcache/bcache.h                |   2 +-
 drivers/md/bcache/bset.c                  |   2 +-
 drivers/md/bcache/stats.h                 |   1 -
 drivers/md/bcache/writeback.c             |  78 ++--
 drivers/md/dm-table.c                     |   4 +-
 drivers/md/md.c                           |   5 +-
 drivers/md/raid0.c                        |   2 +-
 drivers/md/raid10.c                       | 151 +++++---
 drivers/md/raid10.h                       |   2 +-
 drivers/md/raid5-cache.c                  |  11 +-
 drivers/md/raid5.c                        | 147 ++++----
 drivers/md/raid5.h                        |  32 +-
 drivers/nvme/host/core.c                  | 140 ++++++-
 drivers/nvme/host/fabrics.c               |  25 +-
 drivers/nvme/host/fc.c                    | 124 ++----
 drivers/nvme/host/ioctl.c                 |  15 +-
 drivers/nvme/host/nvme.h                  |  44 ++-
 drivers/nvme/host/pci.c                   |  78 ++--
 drivers/nvme/host/rdma.c                  | 171 +++------
 drivers/nvme/host/tcp.c                   | 169 ++++-----
 drivers/nvme/target/admin-cmd.c           |   2 +-
 drivers/nvme/target/configfs.c            |  29 ++
 drivers/nvme/target/core.c                |   1 +
 drivers/nvme/target/discovery.c           |   2 +-
 drivers/nvme/target/fabrics-cmd-auth.c    |  23 +-
 drivers/nvme/target/fabrics-cmd.c         |  19 +-
 drivers/nvme/target/io-cmd-bdev.c         |  19 +-
 drivers/nvme/target/loop.c                |  91 ++---
 drivers/nvme/target/nvmet.h               |   7 +-
 drivers/nvme/target/passthru.c            |   7 +-
 drivers/nvme/target/tcp.c                 |  91 ++---
 drivers/nvme/target/zns.c                 |   3 +-
 drivers/s390/block/dasd.c                 |  86 +----
 drivers/s390/block/dasd_3990_erp.c        |   5 +
 drivers/s390/block/dasd_devmap.c          | 609 +++++++++++++++++++++++++++++-
 drivers/s390/block/dasd_diag.c            |   2 +-
 drivers/s390/block/dasd_eckd.c            | 294 +++++++++++++--
 drivers/s390/block/dasd_eckd.h            |   9 +-
 drivers/s390/block/dasd_fba.c             |   2 +-
 drivers/s390/block/dasd_genhd.c           |  29 +-
 drivers/s390/block/dasd_int.h             |  75 +++-
 drivers/s390/block/dasd_ioctl.c           |  53 +++
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c    |   5 +-
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c    |   5 +-
 drivers/scsi/megaraid/megaraid_sas_base.c |   6 +-
 drivers/scsi/mpi3mr/mpi3mr_os.c           |   5 +-
 drivers/scsi/mpt3sas/mpt3sas_scsih.c      |   5 +-
 drivers/scsi/pm8001/pm8001_init.c         |   2 +-
 drivers/scsi/qla2xxx/qla_nvme.c           |   6 +-
 drivers/scsi/qla2xxx/qla_os.c             |  10 +-
 drivers/scsi/scsi_debug.c                 |   7 +-
 drivers/scsi/scsi_lib.c                   |   4 +-
 drivers/scsi/smartpqi/smartpqi_init.c     |   6 +-
 drivers/scsi/virtio_scsi.c                |   4 +-
 drivers/ufs/core/ufshcd.c                 |   9 +-
 fs/btrfs/compression.c                    |  14 +-
 fs/direct-io.c                            |   2 -
 fs/erofs/zdata.c                          |  13 +-
 include/linux/bio.h                       |   2 +-
 include/linux/blk-cgroup.h                |   5 +-
 include/linux/blk-mq-pci.h                |   4 +-
 include/linux/blk-mq-rdma.h               |   2 +-
 include/linux/blk-mq-virtio.h             |   2 +-
 include/linux/blk-mq.h                    |  23 +-
 include/linux/blk_types.h                 |   3 +-
 include/linux/blkdev.h                    |  15 +-
 include/linux/nvme.h                      |   4 +-
 include/linux/pagemap.h                   |   2 +
 include/linux/sbitmap.h                   |   3 +-
 include/linux/sed-opal.h                  |   1 +
 include/scsi/scsi_host.h                  |   2 +-
 include/uapi/linux/sed-opal.h             |  13 +
 include/uapi/linux/ublk_cmd.h             |   8 +-
 io_uring/io_uring.c                       |   2 +-
 kernel/sched/psi.c                        |   2 +
 lib/sbitmap.c                             | 109 ++++--
 mm/filemap.c                              |   7 +
 mm/readahead.c                            |  22 +-
 mm/swapfile.c                             |   2 +-
 135 files changed, 3204 insertions(+), 1644 deletions(-)
 delete mode 100644 drivers/block/rnbd/rnbd-srv-dev.c
 delete mode 100644 drivers/block/rnbd/rnbd-srv-dev.h
 create mode 100644 drivers/block/rnbd/rnbd-srv-trace.c
 create mode 100644 drivers/block/rnbd/rnbd-srv-trace.h

-- 
Jens Axboe
