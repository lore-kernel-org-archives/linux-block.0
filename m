Return-Path: <SRS0=61bd=TH=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D25DC004C9
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 19:38:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 220B72087F
	for <linux-block@archiver.kernel.org>; Tue,  7 May 2019 19:38:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="uvJiS215"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726563AbfEGTii (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 7 May 2019 15:38:38 -0400
Received: from mail-pl1-f194.google.com ([209.85.214.194]:42672 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726557AbfEGTii (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 7 May 2019 15:38:38 -0400
Received: by mail-pl1-f194.google.com with SMTP id x15so8673201pln.9
        for <linux-block@vger.kernel.org>; Tue, 07 May 2019 12:38:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=a8ofbmrG0Mu1kHeNEkyKMS1XibMKa2TVF0A3l1COd6A=;
        b=uvJiS215Y5AC9wbSVaRIISn0pbt0IWxOV+DAEg2Y50/odWsnKWcmUWJDy8LEC40axA
         kSHIN2qZpdhJg7ZJanxq02P6dDrpF6Pco1ZleK5p+D+3yj99GsJoVTLFvwBMWCfNgQ0j
         8r1RdW9zD23RA8Ez59rgPJ0UVNMDvBTvRLjDF0Qb74NxPqfcRI1MeBvsMRBZXYYahgN8
         +FL9NnOBEcs0HHLEkQ/vTO8nvnDApFtQpUolv3e7mcXeyvNsptQlgYJs8mlyE5SuHImA
         vjiYwRcULKYha24+iPKZFRt8WoTKjHiD48bAiqRMLUbVtdcADgnTr3VjX6Wlx4/Ddz+z
         dwsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=a8ofbmrG0Mu1kHeNEkyKMS1XibMKa2TVF0A3l1COd6A=;
        b=nWkHb3FiTjj+mxqTxwIj0cdTZeWcb9v06anom9JwQ5jHNMWIE+hh4QoQN94hLDBFKO
         h4lNd9R4Mpl3eolXgc9z68EavHGbFDZTWWZySmspnjwm0fWmSMht3H7mFK30u02Bz+SC
         0pcd50D5KYdMeu0OdUcEtu+Rx2yspyWxP/tEzm7cVBHy/DaVKgYYMDhqXjMmQ7uHn5Ch
         A2qd9FnqvSPccEWJoYTyuHC1YVhQXKhZ6d7jIws85eqzpGsegwd+aY6nVCrUHl3zyRfl
         Vz7OPuO2LCRbyhJc8ggSD303OnjqiYMD3i2NQHZ42foGNFM19xMh5PVChFAQl2LpIcYY
         G0gg==
X-Gm-Message-State: APjAAAW+H86N3gNGvovAeN2CD2FxeUQD1/b8KEeuDS+eASeX3uTxKGBx
        uQyc0ZI/DW2rCp+0RqEa/N2oibMrD7HDpg==
X-Google-Smtp-Source: APXvYqzlr6tvW6hda/Ub5JT8Jjj+0wV+UpoiRTgLjEp1yn0rNSZm+vH+QioMkngkKGHW7JEpC5k1eA==
X-Received: by 2002:a17:902:e612:: with SMTP id cm18mr18976557plb.255.1557257916311;
        Tue, 07 May 2019 12:38:36 -0700 (PDT)
Received: from [192.168.1.121] (66.29.164.166.static.utbb.net. [66.29.164.166])
        by smtp.gmail.com with ESMTPSA id r18sm18751549pfd.89.2019.05.07.12.38.34
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 May 2019 12:38:35 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 5.2-rc
Message-ID: <7bdf9bf7-d3da-4f1f-f7b8-d972e8610519@kernel.dk>
Date:   Tue, 7 May 2019 13:38:33 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

This is the main pull request for block/storage for 5.2. Nothing major
in this series, just fixes and improvements all over the map. This pull
request contains:

- Series of fixes for sed-opal (David, Jonas)

- Fixes and performance tweaks for BFQ (via Paolo)

- Set of fixes for bcache (via Coly)

- Set of fixes for md (via Song)

- Enabling multi-page for passthrough requests (Ming)

- Queue release fix series (Ming)

- Device notification improvements (Martin)

- Propagate underlying device rotational status in loop (Holger)

- Removal of mtip32xx trim support, which has been disabled for years
  (Christoph)

- Improvement and cleanup of nvme command handling (Christoph)

- Add block SPDX tags (Christoph)

- Cleanup/hardening of bio/bvec iteration (Christoph)

- A few NVMe pull requests (Christoph)

- Removal of CONFIG_LBDAF (Christoph)

- Various little fixes here and there


Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.2/block-20190507


----------------------------------------------------------------
Angelo Ruocco (1):
      block, bfq: fix some typos in comments

Arnd Bergmann (1):
      bcache: avoid clang -Wunintialized warning

Christoph Hellwig (44):
      nvmet: avoid double errno conversions
      block: add a req_bvec helper
      block: add a rq_integrity_vec helper
      block: add a rq_dma_dir helper
      block: add dma_map_bvec helper
      nvme-pci: remove nvme_init_iod
      nvme-pci: move the call to nvme_cleanup_cmd out of nvme_unmap_data
      nvme-pci: merge nvme_free_iod into nvme_unmap_data
      nvme-pci: only call nvme_unmap_data for requests transferring data
      nvme-pci: do not build a scatterlist to map metadata
      nvme-pci: split metadata handling from nvme_map_data / nvme_unmap_data
      nvme-pci: remove the inline scatterlist optimization
      nvme-pci: optimize mapping of small single segment requests
      nvme-pci: optimize mapping single segment requests using SGLs
      nvme-pci: tidy up nvme_map_data
      block: remove CONFIG_LBDAF
      md: add a missing endianness conversion in check_sb_changes
      md: use correct types in md_bitmap_print_sb
      md: use correct type in super_1_load
      md: use correct type in super_1_sync
      md: mark md_cluster_mod static
      md: add __acquires/__releases annotations to (un)lock_two_stripes
      md: add __acquires/__releases annotations to handle_active_stripes
      block: rewrite blk_bvec_map_sg to avoid a nth_page call
      block: refactor __bio_iov_bvec_add_pages
      block: don't allow multiple bio_iov_iter_get_pages calls per bio
      block: change how we get page references in bio_iov_iter_get_pages
      block: only allow contiguous page structs in a bio_vec
      block: avoid scatterlist offsets > PAGE_SIZE
      mtip32xx: remove trim support
      bcache: clean up do_btree_node_write a bit
      block: remove the i argument to bio_for_each_segment_all
      block: remove the __bio_add_pc_page export
      block: remove bogus comments in __bio_add_pc_page
      block: clean up __bio_add_pc_page a bit
      block: switch all files cleared marked as GPLv2 to SPDX tags
      block: switch all files cleared marked as GPLv2 or later to SPDX tags
      sed-opal.h: remove redundant licence boilerplate
      block: add a SPDX tag to blk-mq-rdma.h
      block: add SPDX tags to block layer files missing licensing information
      block: remove the unused blk_queue_dma_pad function
      nvme: move command size checks to the core
      nvme: mark nvme_core_init and nvme_core_exit static
      block: fix mismerge in bvec_advance

Coly Li (10):
      bcache: move definition of 'int ret' out of macro read_bucket()
      bcache: never set KEY_PTRS of journal key to 0 in journal_reclaim()
      bcache: add failure check to run_cache_set() for journal replay
      bcache: add comments for kobj release callback routine
      bcache: return error immediately in bch_journal_replay()
      bcache: add error check for calling register_bdev()
      bcache: Add comments for blkdev_put() in registration code path
      bcache: add comments for closure_fn to be called in closure_queue()
      bcache: improve bcache_reboot()
      bcache: remove redundant LIST_HEAD(journal) from run_cache_set()

David Kozub (12):
      block: sed-opal: fix IOC_OPAL_ENABLE_DISABLE_MBR
      block: sed-opal: fix typos and formatting
      block: sed-opal: close parameter list in cmd_finalize
      block: sed-opal: unify cmd start
      block: sed-opal: unify error handling of responses
      block: sed-opal: reuse response_get_token to decrease code duplication
      block: sed-opal: add token for OPAL_LIFECYCLE
      block: sed-opal: unify retrieval of table columns
      block: sed-opal: use named Opal tokens instead of integer literals
      block: sed-opal: pass steps via argument rather than via opal_dev
      block: sed-opal: don't repeat opal_discovery0 in each steps array
      block: sed-opal: rename next to execute_steps

Dongli Zhang (1):
      virtio_blk: replace 0 by HCTX_TYPE_DEFAULT to index blk_mq_tag_set->map

Enrico Weigelt, metux IT consult (1):
      nvmet: include <linux/scatterlist.h>

Francesco Pollicino (2):
      block, bfq: print SHARED instead of pid for shared queues in logs
      block, bfq: save & resume weight on a queue merge/split

Geliang Tang (1):
      bcache: use kmemdup_nul for CACHED_LABEL buffer

George Spelvin (1):
      bcache: Clean up bch_get_congested()

Guoju Fang (2):
      bcache: fix crashes stopping bcache device before read miss done
      bcache: fix inaccurate result of unused buckets

Gustavo A. R. Silva (1):
      nvmet-fc: use zero-sized array and struct_size() in kzalloc()

Hannes Reinecke (2):
      nvme-multipath: split bios with the ns_head bio_set before submitting
      nvme-multipath: don't print ANA group state by default

Hisao Tanabe (1):
      block: remove unused variable 'def'

Holger Hoffstätte (1):
      loop: properly observe rotational flag of underlying device

Hou Tao (1):
      brd: re-enable __GFP_HIGHMEM in brd_insert_page()

Jens Axboe (8):
      Merge branch 'nvme-5.2' of git://git.infradead.org/nvme into for-5.2/block
      Merge branch 'md-next' of https://github.com/liu-song-6/linux into for-5.2/block
      Merge tag 'v5.1-rc5' into for-5.2/block
      Merge tag 'v5.1-rc6' into for-5.2/block
      Merge branch 'md-next' of https://github.com/liu-song-6/linux into for-5.2/block
      Merge branch 'nvme-5.2' of git://git.infradead.org/nvme into for-5.2/block
      bcache: make is_discard_enabled() static
      Merge branch 'nvme-5.2' of git://git.infradead.org/nvme into for-5.2/block

Johannes Thumshirn (1):
      block: bio: ensure newly added bio flags don't override BVEC_POOL_IDX

Jonas Rabenstein (4):
      block: sed-opal: use correct macro for method length
      block: sed-opal: unify space check in add_token_*
      block: sed-opal: print failed function address
      block: sed-opal: split generation of bytestring header and content

Keith Busch (5):
      nvme-pci: use a flag for polled queues
      nvme-pci: remove q_dmadev from nvme_queue
      nvme-pci: remove unused nvme_iod member
      nvme-pci: shutdown on timeout during deletion
      nvme-pci: unquiesce admin queue on shutdown

Kenneth Heitke (1):
      nvme: log the error status on Identify Namespace failure

Klaus Birkelund Jensen (1):
      nvme-pci: fix psdt field for single segment sgls

Liang Chen (1):
      bcache: fix a race between cache register and cacheset unregister

Martin Wilck (5):
      block: genhd: remove async_events field
      block: disk_events: introduce event flags
      Revert "ide: unexport DISK_EVENT_MEDIA_CHANGE for ide-gd and ide-cd"
      Revert "block: unexport DISK_EVENT_MEDIA_CHANGE for legacy/fringe drivers"
      block: check_events: don't bother with events if unsupported

Max Gurtovoy (5):
      nvme: avoid double dereference to convert le to cpu
      nvmet: never fail double namespace enablement
      nvmet: add safety check for subsystem lock during nvmet_ns_changed
      nvmet-rdma: remove p2p_client initialization from fast-path
      nvmet: rename nvme_completion instances from rsp to cqe

Ming Lei (22):
      block: pass page to xen_biovec_phys_mergeable
      block: avoid to break XEN by multi-page bvec
      block: don't merge adjacent bvecs to one segment in bio blk_queue_split
      block: cleanup bio_add_pc_page
      block: check if page is mergeable in one helper
      block: put the same page when adding it to bio
      block: enable multi-page bvec for passthrough IO
      block: remove argument of 'request_queue' from __blk_bvec_map_sg
      block: reuse __blk_bvec_map_sg() for mapping page sized bvec
      block: don't check if adjacent bvecs in one bio can be mergeable
      block: loop: mark bvec as ITER_BVEC_FLAG_NO_REF
      block: fix build warning in merging bvecs
      block: clarify that bio_add_page() and related helpers can add multi pages
      block: don't run get_page() on pages from non-bvec iov iter
      nvme-loop: kill timeout handler
      blk-mq: grab .q_usage_counter when queuing request from plug code path
      blk-mq: move cancel of requeue_work into blk_mq_release
      blk-mq: free hw queue's resource in hctx's release handler
      blk-mq: split blk_mq_alloc_and_init_hctx into two parts
      blk-mq: always free hctx after request queue is freed
      blk-mq: move cancel of hctx->run_work into blk_mq_hw_sysfs_release
      block: don't drain in-progress dispatch in blk_cleanup_queue()

Minwoo Im (6):
      block: null: Add documentation for "zone_nr_conv" param
      nvmet: return a specified error it subsys_alloc fails
      nvme-rdma: fix typo in struct comment
      nvme-pci: remove an unneeded variable initialization
      nvme-pci: check more command sizes
      nvme-fabrics: check more command sizes

NeilBrown (2):
      Revert "MD: fix lock contention for flush bios"
      md: batch flush requests.

Nigel Croxon (2):
      Don't jump to compute_result state from check_result state
      md/raid: raid5 preserve the writeback action after the parity check

Paolo Valente (7):
      block, bfq: increase idling for weight-raised queues
      block, bfq: do not idle for lowest-weight queues
      block, bfq: tune service injection basing on request service times
      block, bfq: do not merge queues on flash storage with queueing
      block, bfq: do not tag totally seeky queues as soft rt
      block, bfq: always protect newly-created queues from existing active queues
      doc, block, bfq: add information on bfq execution time

Pawel Baldysiak (1):
      md: return -ENODEV if rdev has no mddev assigned

Raul E Rangel (1):
      block: fix function name in comment

Sagi Grimberg (9):
      nvmet-tcp: implement C2HData SUCCESS optimization
      nvmet-file: clamp-down file namespace lba_shift
      nvmet-tcp: don't fail maxr2t greater than 1
      nvme-tcp: fix a NULL deref when an admin connect times out
      nvme-rdma: fix a NULL deref when an admin connect times out
      nvme-tcp: rename function to have nvme_tcp prefix
      nvme: set 0 capacity if namespace block size exceeds PAGE_SIZE
      nvme-tcp: fix possible null deref on a timed out io queue connect
      nvmet: protect discovery change log event list iteration

Shenghui Wang (2):
      bcache: fix wrong usage use-after-freed on keylist in out_nocoalesce branch of btree_gc_coalesce
      bcache: avoid potential memleak of list of journal_replay(s) in the CACHE_SYNC branch of run_cache_set

Song Liu (1):
      Revert "Don't jump to compute_result state from check_result state"

Tang Junhui (1):
      bcache: fix failure in journal relplay

Weiping Zhang (1):
      block: don't show io_timeout if driver has no timeout handler

Yufen Yu (3):
      md: add mddev->pers to avoid potential NULL pointer dereference
      block: fix use-after-free on gendisk

 Documentation/block/bfq-iosched.txt                |  29 +-
 Documentation/block/null_blk.txt                   |   4 +
 Documentation/process/submit-checklist.rst         |  27 +-
 Documentation/translations/ja_JP/SubmitChecklist   |  22 +-
 arch/arc/configs/haps_hs_defconfig                 |   1 -
 arch/arc/configs/haps_hs_smp_defconfig             |   1 -
 arch/arc/configs/nsim_700_defconfig                |   1 -
 arch/arc/configs/nsim_hs_defconfig                 |   1 -
 arch/arc/configs/nsim_hs_smp_defconfig             |   1 -
 arch/arc/configs/nsimosci_defconfig                |   1 -
 arch/arc/configs/nsimosci_hs_defconfig             |   1 -
 arch/arc/configs/nsimosci_hs_smp_defconfig         |   1 -
 arch/arm/configs/aspeed_g4_defconfig               |   1 -
 arch/arm/configs/aspeed_g5_defconfig               |   1 -
 arch/arm/configs/at91_dt_defconfig                 |   1 -
 arch/arm/configs/clps711x_defconfig                |   1 -
 arch/arm/configs/efm32_defconfig                   |   1 -
 arch/arm/configs/ezx_defconfig                     |   1 -
 arch/arm/configs/h3600_defconfig                   |   1 -
 arch/arm/configs/imote2_defconfig                  |   1 -
 arch/arm/configs/moxart_defconfig                  |   1 -
 arch/arm/configs/multi_v4t_defconfig               |   1 -
 arch/arm/configs/omap1_defconfig                   |   1 -
 arch/arm/configs/stm32_defconfig                   |   1 -
 arch/arm/configs/u300_defconfig                    |   1 -
 arch/arm/configs/vexpress_defconfig                |   1 -
 arch/m68k/configs/amcore_defconfig                 |   1 -
 arch/m68k/configs/m5475evb_defconfig               |   1 -
 arch/m68k/configs/stmark2_defconfig                |   1 -
 arch/mips/configs/ar7_defconfig                    |   1 -
 arch/mips/configs/decstation_defconfig             |   1 -
 arch/mips/configs/decstation_r4k_defconfig         |   1 -
 arch/mips/configs/loongson1b_defconfig             |   1 -
 arch/mips/configs/loongson1c_defconfig             |   1 -
 arch/mips/configs/rb532_defconfig                  |   1 -
 arch/mips/configs/rbtx49xx_defconfig               |   1 -
 arch/parisc/configs/generic-32bit_defconfig        |   1 -
 arch/sh/configs/apsh4ad0a_defconfig                |   1 -
 arch/sh/configs/ecovec24-romimage_defconfig        |   1 -
 arch/sh/configs/rsk7264_defconfig                  |   1 -
 arch/sh/configs/rsk7269_defconfig                  |   1 -
 arch/sh/configs/sh7785lcr_32bit_defconfig          |   1 -
 block/Kconfig                                      |  24 -
 block/badblocks.c                                  |  10 +-
 block/bfq-cgroup.c                                 |  16 +-
 block/bfq-iosched.c                                | 811 +++++++++++++++++----
 block/bfq-iosched.h                                | 107 +--
 block/bfq-wf2q.c                                   |  23 +-
 block/bio-integrity.c                              |  16 +-
 block/bio.c                                        | 286 ++++----
 block/blk-cgroup.c                                 |   1 +
 block/blk-core.c                                   |  24 +-
 block/blk-exec.c                                   |   1 +
 block/blk-flush.c                                  |   3 +-
 block/blk-integrity.c                              |  16 +-
 block/blk-iolatency.c                              |   1 +
 block/blk-merge.c                                  | 147 ++--
 block/blk-mq-cpumap.c                              |   1 +
 block/blk-mq-debugfs.c                             |  13 +-
 block/blk-mq-pci.c                                 |  10 +-
 block/blk-mq-rdma.c                                |  10 +-
 block/blk-mq-sched.c                               |  13 +-
 block/blk-mq-sysfs.c                               |   9 +
 block/blk-mq-tag.c                                 |   1 +
 block/blk-mq-virtio.c                              |  10 +-
 block/blk-mq.c                                     | 192 +++--
 block/blk-mq.h                                     |   2 +-
 block/blk-rq-qos.c                                 |   2 +
 block/blk-rq-qos.h                                 |   1 +
 block/blk-settings.c                               |  17 +-
 block/blk-stat.c                                   |   1 +
 block/blk-sysfs.c                                  |  30 +-
 block/blk-timeout.c                                |   1 +
 block/blk-wbt.c                                    |   1 +
 block/blk-zoned.c                                  |   1 +
 block/blk.h                                        |   2 +-
 block/bounce.c                                     |   3 +-
 block/bsg-lib.c                                    |  16 +-
 block/bsg.c                                        |   9 +-
 block/elevator.c                                   |   7 +-
 block/genhd.c                                      |  68 +-
 block/ioctl.c                                      |   1 +
 block/ioprio.c                                     |   1 +
 block/kyber-iosched.c                              |  13 +-
 block/mq-deadline.c                                |   1 +
 block/opal_proto.h                                 |  12 +-
 block/partition-generic.c                          |   7 +
 block/partitions/acorn.c                           |   7 +-
 block/partitions/aix.h                             |   1 +
 block/partitions/amiga.h                           |   1 +
 block/partitions/efi.c                             |  16 +-
 block/partitions/efi.h                             |  16 +-
 block/partitions/ibm.h                             |   1 +
 block/partitions/karma.h                           |   1 +
 block/partitions/ldm.c                             |  16 +-
 block/partitions/ldm.h                             |  16 +-
 block/partitions/msdos.h                           |   1 +
 block/partitions/osf.h                             |   1 +
 block/partitions/sgi.h                             |   1 +
 block/partitions/sun.h                             |   1 +
 block/partitions/sysv68.h                          |   1 +
 block/partitions/ultrix.h                          |   1 +
 block/scsi_ioctl.c                                 |  16 +-
 block/sed-opal.c                                   | 726 ++++++++----------
 block/t10-pi.c                                     |  19 +-
 drivers/block/amiflop.c                            |   1 +
 drivers/block/ataflop.c                            |   1 +
 drivers/block/brd.c                                |   7 +-
 drivers/block/drbd/drbd_int.h                      |   5 -
 drivers/block/floppy.c                             |   1 +
 drivers/block/loop.c                               |  35 +-
 drivers/block/mtip32xx/mtip32xx.c                  |  89 ---
 drivers/block/mtip32xx/mtip32xx.h                  |  17 -
 drivers/block/paride/pcd.c                         |   1 +
 drivers/block/paride/pd.c                          |   1 +
 drivers/block/paride/pf.c                          |   1 +
 drivers/block/pktcdvd.c                            |   1 -
 drivers/block/ps3disk.c                            |   4 +-
 drivers/block/swim.c                               |   1 +
 drivers/block/swim3.c                              |   1 +
 drivers/block/virtio_blk.c                         |   3 +-
 drivers/block/xsysace.c                            |   1 +
 drivers/cdrom/gdrom.c                              |   1 +
 drivers/ide/ide-cd.c                               |   1 +
 drivers/ide/ide-cd_ioctl.c                         |   5 +-
 drivers/ide/ide-gd.c                               |   6 +-
 drivers/md/bcache/alloc.c                          |   5 +-
 drivers/md/bcache/btree.c                          |  12 +-
 drivers/md/bcache/journal.c                        |  42 +-
 drivers/md/bcache/request.c                        |  41 +-
 drivers/md/bcache/request.h                        |   2 +-
 drivers/md/bcache/super.c                          |  84 ++-
 drivers/md/bcache/sysfs.c                          |   2 -
 drivers/md/bcache/util.h                           |  26 +-
 drivers/md/dm-crypt.c                              |   3 +-
 drivers/md/dm-exception-store.h                    |  28 +-
 drivers/md/dm-integrity.c                          |   8 +-
 drivers/md/md-bitmap.c                             |   8 +-
 drivers/md/md.c                                    | 199 +++--
 drivers/md/md.h                                    |  25 +-
 drivers/md/raid1.c                                 |   6 +-
 drivers/md/raid5.c                                 |  16 +-
 drivers/nvdimm/pfn_devs.c                          |   4 +-
 drivers/nvme/host/core.c                           |  44 +-
 drivers/nvme/host/fabrics.c                        |   1 +
 drivers/nvme/host/multipath.c                      |  10 +-
 drivers/nvme/host/nvme.h                           |   3 -
 drivers/nvme/host/pci.c                            | 300 ++++----
 drivers/nvme/host/rdma.c                           |  10 +-
 drivers/nvme/host/tcp.c                            |  21 +-
 drivers/nvme/target/Kconfig                        |   1 +
 drivers/nvme/target/configfs.c                     |   4 +-
 drivers/nvme/target/core.c                         |  38 +-
 drivers/nvme/target/discovery.c                    |   9 +-
 drivers/nvme/target/fabrics-cmd.c                  |  16 +-
 drivers/nvme/target/fc.c                           |   9 +-
 drivers/nvme/target/io-cmd-bdev.c                  |   6 +-
 drivers/nvme/target/io-cmd-file.c                  |   7 +-
 drivers/nvme/target/loop.c                         |  22 +-
 drivers/nvme/target/nvmet.h                        |   4 +-
 drivers/nvme/target/rdma.c                         |  21 +-
 drivers/nvme/target/tcp.c                          |  38 +-
 drivers/scsi/sd.c                                  |  33 +-
 drivers/scsi/sr.c                                  |   1 +
 drivers/staging/erofs/data.c                       |   3 +-
 drivers/staging/erofs/unzip_vle.c                  |   3 +-
 drivers/xen/biomerge.c                             |   5 +-
 fs/block_dev.c                                     |   6 +-
 fs/btrfs/compression.c                             |   3 +-
 fs/btrfs/disk-io.c                                 |   4 +-
 fs/btrfs/extent_io.c                               |  10 +-
 fs/btrfs/inode.c                                   |   8 +-
 fs/btrfs/raid56.c                                  |   3 +-
 fs/crypto/bio.c                                    |   3 +-
 fs/direct-io.c                                     |   3 +-
 fs/ext4/page-io.c                                  |   3 +-
 fs/ext4/readpage.c                                 |   3 +-
 fs/ext4/resize.c                                   |   2 -
 fs/ext4/super.c                                    |  32 +-
 fs/f2fs/data.c                                     |   9 +-
 fs/gfs2/Kconfig                                    |   1 -
 fs/gfs2/lops.c                                     |   3 +-
 fs/gfs2/meta_io.c                                  |   3 +-
 fs/iomap.c                                         |   6 +-
 fs/mpage.c                                         |   3 +-
 fs/nfs/Kconfig                                     |   1 -
 fs/ocfs2/super.c                                   |  10 -
 fs/stack.c                                         |  15 +-
 fs/xfs/Kconfig                                     |   1 -
 fs/xfs/xfs_aops.c                                  |   3 +-
 fs/xfs/xfs_super.c                                 |  10 +-
 include/linux/bio.h                                |  20 +-
 include/linux/blk-mq-rdma.h                        |   1 +
 include/linux/blk-mq.h                             |   2 +
 include/linux/blk_types.h                          |  29 +-
 include/linux/blkdev.h                             |  42 +-
 include/linux/bsg-lib.h                            |  16 +-
 include/linux/bvec.h                               |  36 +-
 include/linux/genhd.h                              |  20 +-
 include/linux/kernel.h                             |  14 +-
 include/linux/nvme-rdma.h                          |   2 +-
 include/linux/sed-opal.h                           |  10 +-
 include/linux/types.h                              |   5 -
 include/uapi/linux/sed-opal.h                      |  11 +-
 include/xen/xen.h                                  |   4 +-
 lib/Kconfig.debug                                  |   1 -
 .../formal/srcu-cbmc/include/linux/types.h         |   4 -
 207 files changed, 2312 insertions(+), 2256 deletions(-)

-- 
Jens Axboe

