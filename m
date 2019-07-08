Return-Path: <SRS0=8/B6=VF=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65047C606CF
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 21:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1EF8E2086D
	for <linux-block@archiver.kernel.org>; Mon,  8 Jul 2019 21:21:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="jj+ZEGyq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732518AbfGHVV1 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 8 Jul 2019 17:21:27 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:40974 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732476AbfGHVV1 (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 8 Jul 2019 17:21:27 -0400
Received: by mail-pg1-f196.google.com with SMTP id q4so8310760pgj.8
        for <linux-block@vger.kernel.org>; Mon, 08 Jul 2019 14:21:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=wMJu4mPnAWNf/4dSuZDT+ZDIOq/faT/yte8JZSdIGmw=;
        b=jj+ZEGyq03IenfizP12aAxiWM8Y3scpiEFZkHT8JPOIOFEsZl6Ll3fAkUNpF4aBq0m
         J0ay05x81uF0UVK16DR4X+1QeeEnWXYBbtD94g8BhKIYxVWvei1tdtWcpziYSqIOaEF2
         bf7F2fOOmeepDORhWGhlH9U/mbghSOTjqavV7hKNBUFV3A+hnaZGOaUD6qHavF8CX3ko
         1dnkbd+HFRrc80/TovXaKShbjtQlS1X/BrgN15zuqNrPoAlTZJTcz4T9wD1pDcxMuBzl
         nrdGF83ii02VJMJQsdsg644/6VOlPdGkZnyqQ9kPQxGGhTS7t4lu6G/QgK+yINAIBbP+
         5VBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=wMJu4mPnAWNf/4dSuZDT+ZDIOq/faT/yte8JZSdIGmw=;
        b=IWX39Qm2OlfMzzRm9Yrj9TABrEhn/Cu0dagW0CwSGyBtQ/0Tpj0Gz3j1PfYG7AH1LO
         T5jQ5fVJHlFLAN6h8JxXuLmF+Qd9u219544Qt4LUYAf7VL1t5tiSQbcnADFkiAONKNNE
         54KkzFkngQxdhDfh0V7JdEPGh8MUANXvHRRju68lPZm6joHavV5RvQz9s/+APtDjV+T+
         TkW4Ih8T/B2oAmQRQKmRuZq79/F/YVHlL+kKQbvi+aw1zB7rrij6Y64A+SXy3XPdNGe+
         ZABQ5naHtfG9kQphQH9LRJwdk64+GW06Td5RfcLzAVX4WGjMEAnRcQedL2zW1eCz68Lg
         WpUg==
X-Gm-Message-State: APjAAAVxOb8/Z4bmMeWIt45nLx2/hK3cheZyDtR9dzlKWFLOxQBCYSQV
        5i521mdEabDhui+OrKXuDN10tOyKOgnHFg==
X-Google-Smtp-Source: APXvYqy6RPQ5JHiMHuJ9TaaeWJBDq1fFP44FVww5P8HoOFsmGvpUcPVhhrNGF/cxhvnvfYg6slGN7A==
X-Received: by 2002:a17:90a:d996:: with SMTP id d22mr28271124pjv.86.1562620885306;
        Mon, 08 Jul 2019 14:21:25 -0700 (PDT)
Received: from ?IPv6:2620:10d:c081:1134::10d5? ([2620:10d:c090:180::1:5742])
        by smtp.gmail.com with ESMTPSA id v185sm23422392pfb.14.2019.07.08.14.21.23
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jul 2019 14:21:24 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 5.3-rc
Message-ID: <14ea5503-b60e-9b1c-5a2a-0c48f7b96990@kernel.dk>
Date:   Mon, 8 Jul 2019 15:21:21 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

This is the main block pull request for 5.3. Nothing earth shattering or
major in here, just fixes, additions, and improvements all over the map.
This pull request contains:

- Series of documentation fixes (Bart)

- Optimization of the blk-mq ctx get/put (Bart)

- null_blk removal race condition fix (Bob)

- req/bio_op() cleanups (Chaitanya)

- Series cleaning up the segment accounting, and request/bio mapping
  (Christoph)

- Series cleaning up the page getting/putting for bios (Christoph)

- block cgroup cleanups and moving it to where it is used (Christoph)

- block cgroup fixes (Tejun)

- Series of fixes and improvements to bcache, most notably a write
  deadlock fix (Coly)

- blk-iolatency STS_AGAIN and accounting fixes (Dennis)

- Series of improvements and fixes to BFQ (Douglas, Paolo)

- debugfs_create() return value check removal for drbd (Greg)

- Use struct_size(), where appropriate (Gustavo)

- Two lighnvm fixes (Heiner, Geert)

- MD fixes, including a read balance and corruption fix (Guoqing,
  Marcos, Xiao, Yufen)

- block opal shadow mbr additions (Jonas, Revanth)

- sbitmap compare-and-exhange improvemnts (Pavel)

- Fix for potential bio->bi_size overflow (Ming)

- NVMe pull requests:
     - improved PCIe suspent support (Keith Busch)
     - error injection support for the admin queue (Akinobu Mita)
     - Fibre Channel discovery improvements (James Smart)
     - tracing improvements including nvmetc tracing support (Minwoo Im)
     - misc fixes and cleanups (Anton Eidelman, Minwoo Im, Chaitanya
       Kulkarni)"

- Various little fixes and improvements to drivers and core.


  git://git.kernel.dk/linux-block.git tags/for-5.3/block-20190708


----------------------------------------------------------------
Akinobu Mita (3):
      nvme: prepare for fault injection into admin commands
      nvme: enable to inject errors into admin commands
      Documentation: nvme: add an example for nvme fault injection

Alexandru Ardelean (1):
      bcache: use sysfs_match_string() instead of __sysfs_match_string()

Anton Eidelman (1):
      nvme: fix possible io failures when removing multipathed ns

Arnd Bergmann (1):
      floppy: fix harmless clang build warning

Bart Van Assche (6):
      block, documentation: Fix wbt_lat_usec documentation
      block, documentation: Sort queue sysfs attribute names alphabetically
      block, documentation: Explain the word 'segments'
      block, documentation: Document discard_zeroes_data, fua, max_discard_segments and write_zeroes_max_bytes
      blk-mq: remove blk_mq_put_ctx()
      blk-mq: simplify blk_mq_make_request()

Bob Liu (1):
      block: null_blk: fix race condition for null_del_dev

Chaitanya Kulkarni (12):
      block: use req_op() to maintain consistency
      null_blk: remove duplicate 0 initialization
      block: get rid of redundant else
      block: use right format specifier for op
      block: code cleanup queue_poll_stat_show()
      block: add centralize REQ_OP_XXX to string helper
      block: use blk_op_str() in blk-mq-debugfs.c
      block: update print_req_error()
      f2fs: use block layer helper for show_bio_op macro
      nvme-pci: set the errno on ctrl state change error
      nvme-pci: clean up nvme_remove_dead_ctrl a bit
      null_blk: fix type mismatch null_handle_cmd()

Christoph Hellwig (24):
      block: initialize the write priority in blk_rq_bio_prep
      block: remove blk_init_request_from_bio
      block: remove the bi_phys_segments field in struct bio
      block: simplify blk_recalc_rq_segments
      block: untangle the end of blk_bio_segment_split
      block: mark blk_rq_bio_prep as inline
      blk-cgroup: factor out a helper to read rwstat counter
      blk-cgroup: pass blkg_rwstat structures by reference
      blk-cgroup: introduce a new struct blkg_rwstat_sample
      blk-cgroup: move struct blkg_stat to bfq
      bfq-iosched: move bfq_stat_recursive_sum into the only caller
      block: rename CONFIG_DEBUG_BLK_CGROUP to CONFIG_BFQ_CGROUP_DEBUG
      block: improve print_req_error
      cgroup: export css_next_descendant_pre for bfq
      block: move the BIO_NO_PAGE_REF check into bio_release_pages
      block: optionally mark pages dirty in bio_release_pages
      block: use bio_release_pages in bio_unmap_user
      block: use bio_release_pages in bio_map_user_iov
      iomap: use bio_release_pages in iomap_dio_bio_end_io
      block_dev: use bio_release_pages in blkdev_bio_end_io
      block_dev: use bio_release_pages in bio_unmap_user
      direct-io: use bio_release_pages in dio_bio_complete
      block: never take page references for ITER_BVEC
      block: nr_phys_segments needs to be zero for REQ_OP_WRITE_ZEROES

Coly Li (36):
      bcache: don't set max writeback rate if gc is running
      bcache: check c->gc_thread by IS_ERR_OR_NULL in cache_set_flush()
      bcache: fix return value error in bch_journal_read()
      Revert "bcache: set CACHE_SET_IO_DISABLE in bch_cached_dev_error()"
      bcache: avoid flushing btree node in cache_set_flush() if io disabled
      bcache: ignore read-ahead request failure on backing device
      bcache: add io error counting in write_bdev_super_endio()
      bcache: remove unnecessary prefetch() in bset_search_tree()
      bcache: add return value check to bch_cached_dev_run()
      bcache: remove unncessary code in bch_btree_keys_init()
      bcache: check CACHE_SET_IO_DISABLE in allocator code
      bcache: check CACHE_SET_IO_DISABLE bit in bch_journal()
      bcache: more detailed error message to bcache_device_link()
      bcache: add more error message in bch_cached_dev_attach()
      bcache: improve error message in bch_cached_dev_run()
      bcache: remove "XXX:" comment line from run_cache_set()
      bcache: make bset_search_tree() be more understandable
      bcache: add pendings_cleanup to stop pending bcache device
      bcache: fix mistaken sysfs entry for io_error counter
      bcache: destroy dc->writeback_write_wq if failed to create dc->writeback_thread
      bcache: stop writeback kthread and kworker when bch_cached_dev_run() failed
      bcache: avoid a deadlock in bcache_reboot()
      bcache: acquire bch_register_lock later in cached_dev_detach_finish()
      bcache: acquire bch_register_lock later in cached_dev_free()
      bcache: fix potential deadlock in cached_def_free()
      bcache: add code comments for journal_read_bucket()
      bcache: set largest seq to ja->seq[bucket_index] in journal_read_bucket()
      bcache: shrink btree node cache after bch_btree_check()
      bcache: Revert "bcache: free heap cache_set->flush_btree in bch_journal_free"
      bcache: Revert "bcache: fix high CPU occupancy during journal"
      bcache: only clear BTREE_NODE_dirty bit when it is set
      bcache: add comments for mutex_lock(&b->write_lock)
      bcache: remove retry_flush_write from struct cache_set
      bcache: fix race in btree_flush_write()
      bcache: performance improvement for btree_flush_write()
      bcache: add reclaimed_journal_buckets to struct cache_set

Damien Le Moal (1):
      block: Remove unused code

Dan Carpenter (1):
      md/raid1: Fix a warning message in remove_wb()

Dennis Zhou (2):
      blk-iolatency: only account submitted bios
      blk-iolatency: fix STS_AGAIN handling

Douglas Anderson (2):
      block, bfq: Init saved_wr_start_at_switch_to_srt in unlikely case
      block, bfq: NULL out the bic when it's no longer valid

Fuqian Huang (2):
      block: mtip32xx: Remove call to memset after dma_alloc_coherent
      block: skd_main.c: Remove call to memset after dma_alloc_coherent

Geert Uytterhoeven (1):
      lightnvm: fix uninitialized pointer in nvm_remove_tgt()

Greg Kroah-Hartman (1):
      block: drbd: no need to check return value of debugfs_create functions

Guoqing Jiang (6):
      md/raid10: read balance chooses idlest disk for SSD
      md/raid1: fix potential data inconsistency issue with write behind device
      md: introduce mddev_create/destroy_wb_pool for the change of member device
      md-bitmap: create and destroy wb_info_pool with the change of backlog
      md-bitmap: create and destroy wb_info_pool with the change of bitmap
      md: add bitmap_abort label in md_run

Gustavo A. R. Silva (3):
      md: raid10: Use struct_size() in kmalloc()
      block: genhd: Use struct_size() helper
      block: bio: Use struct_size() in kmalloc()

Heiner Litz (1):
      lightnvm: pblk: fix freeing of merged pages

James Smart (8):
      nvmet: add transport discovery change op
      nvmet-fc: add transport discovery change event callback support
      nvme-fcloop: add support for nvmet discovery_event op
      lpfc: add support to generate RSCN events for nport
      lpfc: add nvmet discovery_event op support
      lpfc: add support for translating an RSCN rcv into a discovery rescan
      lpfc: add sysfs interface to post NVME RSCN
      nvme-fc: add message when creating new association

Jens Axboe (4):
      Merge branch 'md-next' of https://github.com/liu-song-6/linux into for-5.3/block
      Merge branch 'nvme-5.3' of git://git.infradead.org/nvme into for-5.3/block
      Merge branch 'md-next' of https://github.com/liu-song-6/linux into for-5.3/block
      Merge tag 'v5.2-rc6' into for-5.3/block

Jonas Rabenstein (3):
      block: sed-opal: add ioctl for done-mark of shadow mbr
      block: sed-opal: ioctl for writing to shadow mbr
      block: sed-opal: check size of shadow mbr

Keith Busch (2):
      nvme: export get and set features
      nvme-pci: use host managed power state for suspend

Marcos Paulo de Souza (3):
      drivers: md: Unify common definitions of raid1 and raid10
      md: md.c: Return -ENODEV when mddev is NULL in rdev_attr_show
      md: raid1-10: Unify r{1,10}bio_pool_free

Ming Lei (1):
      block: fix .bi_size overflow

Minwoo Im (11):
      block: move tag field position in struct request
      nvme: introduce nvme_is_fabrics to check fabrics cmd
      nvme-pci: remove unnecessary zero for static var
      nvme-pci: remove queue_count_ops for write_queues and poll_queues
      nvme-pci: adjust irq max_vector using num_possible_cpus()
      nvme-pci: properly report state change failure in nvme_reset_work
      nvme-trace: do not export nvme_trace_disk_name
      nvme-trace: move opcode symbol print to nvme.h
      nvme-trace: support for fabrics commands in host-side
      nvme-trace: print result and status in hex format
      nvmet: introduce target-side trace

Paolo Valente (7):
      block, bfq: reset inject limit when think-time state changes
      block, bfq: fix rq_in_driver check in bfq_update_inject_limit
      block, bfq: update base request service times when possible
      block, bfq: bring forward seek&think time update
      block, bfq: detect wakers and unconditionally inject their I/O
      block, bfq: preempt lower-weight or lower-priority queues
      block, bfq: re-schedule empty queues if they deserve I/O plugging

Pavel Begunkov (3):
      blk-mq/debugfs: Fix improper print qualifier
      blk-core: Remove blk_end_request*() declarations
      sbitmap: Replace cmpxchg with xchg

Revanth Rajashekar (2):
      block: sed-opal: PSID reverttper capability
      block: sed-opal: "Never True" conditions

Tejun Heo (5):
      blk-iolatency: clear use_delay when io.latency is set to zero
      blkcg: update blkcg_print_stat() to handle larger outputs
      blkcg: perpcu_ref init/exit should be done from blkg_alloc/free()
      blkcg: blkcg_activate_policy() should initialize ancestors first
      blkcg, writeback: dead memcgs shouldn't contribute to writeback ownership arbitration

Xiao Ni (1):
      raid5-cache: Need to do start() part job after adding journal device

Yufen Yu (2):
      md: fix spelling typo and add necessary space
      md/raid1: get rid of extra blank line and space

 Documentation/block/bfq-iosched.txt                |  12 +-
 Documentation/block/biodoc.txt                     |   1 -
 Documentation/block/queue-sysfs.txt                |  64 +-
 Documentation/cgroup-v1/blkio-controller.txt       |  12 +-
 .../fault-injection/nvme-fault-injection.txt       |  56 ++
 block/Kconfig.iosched                              |   7 +
 block/bfq-cgroup.c                                 | 212 +++--
 block/bfq-iosched.c                                | 967 ++++++++++++++-------
 block/bfq-iosched.h                                |  48 +-
 block/bio.c                                        |  96 +-
 block/blk-cgroup.c                                 | 139 +--
 block/blk-core.c                                   | 111 ++-
 block/blk-iolatency.c                              |  51 +-
 block/blk-map.c                                    |  10 +-
 block/blk-merge.c                                  | 112 +--
 block/blk-mq-debugfs.c                             |  42 +-
 block/blk-mq-sched.c                               |  31 +-
 block/blk-mq-sched.h                               |  10 +-
 block/blk-mq-tag.c                                 |   8 -
 block/blk-mq.c                                     |  44 +-
 block/blk-mq.h                                     |   7 +-
 block/blk.h                                        |  36 +-
 block/genhd.c                                      |   5 +-
 block/kyber-iosched.c                              |   6 +-
 block/mq-deadline.c                                |   5 +-
 block/opal_proto.h                                 |  16 +
 block/sed-opal.c                                   | 197 ++++-
 drivers/block/drbd/drbd_debugfs.c                  |  64 +-
 drivers/block/drbd/drbd_debugfs.h                  |   4 +-
 drivers/block/drbd/drbd_main.c                     |   3 +-
 drivers/block/floppy.c                             |   2 +-
 drivers/block/loop.c                               |  16 +-
 drivers/block/mtip32xx/mtip32xx.c                  |   5 -
 drivers/block/null_blk_main.c                      |  14 +-
 drivers/block/skd_main.c                           |   1 -
 drivers/lightnvm/core.c                            |   2 +-
 drivers/lightnvm/pblk-core.c                       |  18 +-
 drivers/md/bcache/alloc.c                          |   9 +
 drivers/md/bcache/bcache.h                         |   6 +-
 drivers/md/bcache/bset.c                           |  61 +-
 drivers/md/bcache/btree.c                          |  53 +-
 drivers/md/bcache/btree.h                          |   2 +
 drivers/md/bcache/io.c                             |  12 +
 drivers/md/bcache/journal.c                        | 141 ++-
 drivers/md/bcache/journal.h                        |   4 +
 drivers/md/bcache/super.c                          | 227 ++++-
 drivers/md/bcache/sysfs.c                          |  67 +-
 drivers/md/bcache/util.h                           |   2 -
 drivers/md/bcache/writeback.c                      |   8 +
 drivers/md/md-bitmap.c                             |  20 +
 drivers/md/md.c                                    | 129 ++-
 drivers/md/md.h                                    |  23 +
 drivers/md/raid1-10.c                              |  30 +
 drivers/md/raid1.c                                 | 119 ++-
 drivers/md/raid10.c                                |  86 +-
 drivers/md/raid5.c                                 |  12 +-
 drivers/nvme/host/core.c                           |  45 +-
 drivers/nvme/host/fabrics.c                        |   2 +-
 drivers/nvme/host/fault_inject.c                   |  41 +-
 drivers/nvme/host/fc.c                             |   6 +
 drivers/nvme/host/lightnvm.c                       |   2 +-
 drivers/nvme/host/nvme.h                           |  42 +-
 drivers/nvme/host/pci.c                            | 143 ++-
 drivers/nvme/host/trace.c                          |  64 +-
 drivers/nvme/host/trace.h                          |  66 +-
 drivers/nvme/target/Makefile                       |   3 +
 drivers/nvme/target/core.c                         |  12 +-
 drivers/nvme/target/discovery.c                    |   4 +
 drivers/nvme/target/fabrics-cmd.c                  |   2 +-
 drivers/nvme/target/fc.c                           |  13 +-
 drivers/nvme/target/fcloop.c                       |  37 +
 drivers/nvme/target/nvmet.h                        |   2 +
 drivers/nvme/target/trace.c                        | 201 +++++
 drivers/nvme/target/trace.h                        | 141 +++
 drivers/scsi/lpfc/lpfc.h                           |   2 +
 drivers/scsi/lpfc/lpfc_attr.c                      |  60 ++
 drivers/scsi/lpfc/lpfc_crtn.h                      |   4 +
 drivers/scsi/lpfc/lpfc_els.c                       | 127 +++
 drivers/scsi/lpfc/lpfc_hbadisc.c                   |  35 +
 drivers/scsi/lpfc/lpfc_hw.h                        |   2 +
 drivers/scsi/lpfc/lpfc_nvme.c                      |  44 +
 drivers/scsi/lpfc/lpfc_nvmet.c                     |  17 +
 drivers/scsi/lpfc/lpfc_sli.c                       |   1 +
 fs/block_dev.c                                     |  19 +-
 fs/direct-io.c                                     |  15 +-
 fs/fs-writeback.c                                  |   8 +-
 fs/io_uring.c                                      |   3 -
 fs/iomap.c                                         |  10 +-
 fs/xfs/xfs_aops.c                                  |   2 +-
 include/linux/bio.h                                |  31 +-
 include/linux/blk-cgroup.h                         | 106 +--
 include/linux/blk-mq.h                             |   2 +-
 include/linux/blk_types.h                          |   6 -
 include/linux/blkdev.h                             |  19 +-
 include/linux/elevator.h                           |   2 +-
 include/linux/nvme-fc-driver.h                     |   6 +
 include/linux/nvme.h                               |  66 +-
 include/linux/sed-opal.h                           |   3 +
 include/linux/uio.h                                |  10 +-
 include/trace/events/f2fs.h                        |  11 +-
 include/uapi/linux/sed-opal.h                      |  21 +
 init/Kconfig                                       |   8 -
 kernel/cgroup/cgroup.c                             |   1 +
 lib/sbitmap.c                                      |  10 +-
 104 files changed, 3368 insertions(+), 1554 deletions(-)
 create mode 100644 drivers/nvme/target/trace.c
 create mode 100644 drivers/nvme/target/trace.h

-- 
Jens Axboe

