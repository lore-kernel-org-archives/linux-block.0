Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F148BEB64DC
	for <linux-block@archiver.kernel.org>; Mon, 26 Jun 2023 02:39:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230058AbjFZCj3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 25 Jun 2023 22:39:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbjFZCjZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 25 Jun 2023 22:39:25 -0400
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4153510C2
        for <linux-block@vger.kernel.org>; Sun, 25 Jun 2023 19:39:16 -0700 (PDT)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-1b5585e84b4so3636735ad.0
        for <linux-block@vger.kernel.org>; Sun, 25 Jun 2023 19:39:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1687747155; x=1690339155;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PUmQSvoiHUD6ChTL6jPW3qNJt0UNmDWMcmDVRa6dI3k=;
        b=gZqkA7cm5KyggB9iLV9nGEkvImEU+FlFEWBvkozOtFCHZZzVzdo0+2MI50YAjAG6ND
         bT6KoDZIT1544muXjayRSYs2nRSlkikZu/ErO8hj6PIyzaih0MkSbFsnhdfxbtt1Cbbs
         /Xb0xySErgrurHtS3t1Xzn+dReaiVV1K4pgj2sjyB0lAuO+Rx/GeN50W5ZnMSfrsVZt0
         KPWbxI7QehpfUfeE7zP2gEZQ/SlwRASlxjVu06k5mntdwdRg6G5jW3s7GPBsMjpfGTPQ
         S4EEDNSwRudPonW8SNvE15xNsAXQ1RY1oAp5dtjMhy+fZIznY666+ljxXh6aCgOWkaPF
         RNTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687747155; x=1690339155;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=PUmQSvoiHUD6ChTL6jPW3qNJt0UNmDWMcmDVRa6dI3k=;
        b=ZIflHKuSGKZeFmgDg4ix6uUDb8BJ9s7VOiURVxV/mIjRj07vNh6/I41wciFJWfXhPL
         tgf2il/nEjQmuCb7PcG6L9vexI++xcsGujH1emP38Ty27oLd+pa2pCCKeCU96anJHtiI
         llrHIh78noQ7dITJ0P9NOoKRfFHViWBRv2IoNXL/eKcvliAtcuAO51TLFWY4epbFprtg
         uzesZrCGewO3ZaFLX9y+nTsyQWx4PQFJn8PphCGyVGMKcJ9Xd7nWSN9xQ8zmcxt6T34y
         CIPs/8cJxiAFExZ3j4P8592i+dFoZWus3HHsrDz/MR983YmjmT2q/mAhppN373/BQ/6J
         ZXNA==
X-Gm-Message-State: AC+VfDwdwXGOiaFzULqKOXUKetQUhbNMVufF9u576croj10I5Tf4mPmT
        eOTwdfK6APmPkC+TW31uG/4z9WvPpylMl29m7WI=
X-Google-Smtp-Source: ACHHUZ6JUGJzcqmwnk+kvK5lCynXfSgPfDhpvsXMMYqIxYkpMZhNlu6XJoKFC74ww/Xms89vZduAiQ==
X-Received: by 2002:a17:902:ecc6:b0:1ae:1364:6086 with SMTP id a6-20020a170902ecc600b001ae13646086mr34629121plh.2.1687747155354;
        Sun, 25 Jun 2023 19:39:15 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y8-20020a1709029b8800b001b23eb0b4bbsm3010943plp.147.2023.06.25.19.39.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 19:39:14 -0700 (PDT)
Message-ID: <f1ee5428-1302-ecaf-e87f-43bdabebfaea@kernel.dk>
Date:   Sun, 25 Jun 2023 20:39:13 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block updates for 6.5
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here are the block updates for the 6.5 kernel release. This has the
splice changes previously sent out merged in due to followup block
related changes that depend on them, so you'll want to merge the splice
bits first.

This pull request contains:

- NVMe pull request via Keith
	- Various cleanups all around (Irvin, Chaitanya, Christophe)
	- Better struct packing (Christophe JAILLET)
	- Reduce controller error logs for optional commands (Keith)
	- Support for >=64KiB block sizes (Daniel Gomez)
	- Fabrics fixes and code organization (Max, Chaitanya,
	  Daniel Wagner)

- bcache updates via Coly
	- Fix a race at init time (Mingzhe Zou)
	- Misc fixes and cleanups (Andrea, Thomas, Zheng, Ye)

- Use page pinning in the block layer for dio (David)

- Convert old block dio code to page pinning (David, Christoph)

- Series of cleanups for pktcdvd (Andy)

- Series of cleanups for rnbd (Guoqing)

- Series using the unchecked __bio_add_page() for the initial single
  page additions (Johannes)

- Series fixing overflows in the Amiga partition handling code (Michael)

- Series improving mq-deadline zoned device support (Bart)

- Keep passthrough requests out of the IO schedulers (Christoph, Ming)

- Series improving support for flush requests, making them less special
  to deal with (Christoph)

- Series adding bdev holder ops and shutdown methods (Christoph)

- Series fixing the name_to_dev_t() situation and use cases (Christoph)

- Series decoupling the block open flags from fmode_t (Christoph)

- ublk updates and cleanups, including adding user copy support (Ming)

- BFQ sanity checking (Bart)

- Convert brd from radix to xarray (Pankaj)

- Constify various structures (Thomas, Ivan)

- More fine grained persistent reservation ioctl capability checks
  (Jingbo)

- Misc fixes and cleanups (Arnd, Azeem, Demi, Ed, Hengqi, Hou, Jan,
  Jordy, Li, Min, Yu, Zhong, Waiman

This will throw a merge conflict in two spots:

drivers/nvme/host/core.c
	Resolution here is to just remove the offending block, as the
	moved code has the fix already.

block/fops.c
	Resolution here is to retain the conditional FMODE_NOWAIT
	setting, and just kill the (now redundant) private_data
	assignment.

Please pull!


The following changes since commit 9eee8bd81421c5e961cbb1a3c3fa1a06fad545e8:

  splice: kdoc for filemap_splice_read() and copy_splice_read() (2023-05-24 08:42:17 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.5/block-2023-06-23

for you to fetch changes up to fcaa174a9c995cf0af3967e55644a1543ea07e36:

  scsi/sg: don't grab scsi host module reference (2023-06-23 08:28:18 -0600)

----------------------------------------------------------------
for-6.5/block-2023-06-23

----------------------------------------------------------------
Andrea Tomassetti (1):
      bcache: Remove dead references to cache_readaheads

Andy Shevchenko (9):
      pktcdvd: Get rid of custom printing macros
      pktcdvd: replace sscanf() by kstrtoul()
      pktcdvd: use sysfs_emit() to instead of scnprintf()
      pktcdvd: Get rid of pkt_seq_show() forward declaration
      pktcdvd: Drop redundant castings for sector_t
      pktcdvd: Use DEFINE_SHOW_ATTRIBUTE() to simplify code
      pktcdvd: Use put_unaligned_be16() and get_unaligned_be16()
      pktcdvd: Get rid of redundant 'else'
      pktcdvd: Sort headers

Arnd Bergmann (1):
      raid6: neon: add missing prototypes

Azeem Shaikh (1):
      block: Replace all non-returning strlcpy with strscpy

Bart Van Assche (16):
      block: Decode all flag names in the debugfs output
      block: mq-deadline: Add a word in a source code comment
      block: Simplify blk_req_needs_zone_write_lock()
      block: Fix the type of the second bdev_op_is_zoned_write() argument
      block: Introduce op_needs_zoned_write_locking()
      block: Introduce blk_rq_is_seq_zoned_write()
      block: mq-deadline: Clean up deadline_check_fifo()
      block: mq-deadline: Simplify deadline_skip_seq_writes()
      block: mq-deadline: Reduce lock contention
      block: mq-deadline: Track the dispatch position
      block: mq-deadline: Handle requeued requests correctly
      block: mq-deadline: Fix handling of at-head zoned writes
      block: BFQ: Add several invariant checks
      blk-mq: use the I/O scheduler for writes from the flush state machine
      block: BFQ: Move an invariant check
      block: Improve kernel-doc headers

Chaitanya Kulkarni (8):
      nvme-core: fix memory leak in dhchap_secret_store
      nvme-core: fix memory leak in dhchap_ctrl_secret
      nvme-core: add missing fault-injection cleanup
      nvme-core: fix dev_pm_qos memleak
      nvmet-auth: remove unnecessary break after goto
      nvme-fcloop: no need to return from void function
      nvme-fabrics: error out to unlock the mutex
      nvme-fabrics: open code __nvmf_host_find()

Christoph Hellwig (93):
      blk-mq: remove RQF_ELVPRIV
      blk-mq: make sure elevator callbacks aren't called for passthrough request
      fs: remove the special !CONFIG_BLOCK def_blk_fops
      blk-mq: factor out a blk_rq_init_flush helper
      blk-mq: reflow blk_insert_flush
      blk-mq: defer to the normal submission path for non-flush flush commands
      blk-mq: defer to the normal submission path for post-flush requests
      blk-mq: do not do head insertions post-pre-flush commands
      blk-mq: don't use the requeue list to queue flush commands
      block: don't plug in blkdev_write_iter
      block: Replace BIO_NO_PAGE_REF with BIO_PAGE_REFFED with inverted logic
      drbd: stop defining __KERNEL_SYSCALLS__
      block: factor out a bd_end_claim helper from blkdev_put
      block: refactor bd_may_claim
      block: turn bdev_lock into a mutex
      block: consolidate the shutdown logic in blk_mark_disk_dead and del_gendisk
      block: avoid repeated work in blk_mark_disk_dead
      block: unhash the inode earlier in delete_partition
      block: delete partitions later in del_gendisk
      block: remove blk_drop_partitions
      block: introduce holder ops
      block: add a mark_dead holder operation
      fs: add a method to shut down the file system
      xfs: wire up sops->shutdown
      xfs: wire up the ->mark_dead holder operation for log and RT devices
      ext4: split ext4_shutdown
      ext4: wire up sops->shutdown
      ext4: wire up the ->mark_dead holder operation for log devices
      driver core: return bool from driver_probe_done
      PM: hibernate: factor out a helper to find the resume device
      PM: hibernate: remove the global snapshot_test variable
      PM: hibernate: move finding the resume device out of software_resume
      init: remove pointless Root_* values
      init: rename mount_block_root to mount_root_generic
      init: refactor mount_root
      init: pass root_device_name explicitly
      init: don't remove the /dev/ prefix from error messages
      init: handle ubi/mtd root mounting like all other root types
      init: factor the root_wait logic in prepare_namespace into a helper
      init: move the nfs/cifs/ram special cases out of name_to_dev_t
      init: improve the name_to_dev_t interface
      init: clear root_wait on all invalid root= strings
      block: move the code to do early boot lookup of block devices to block/
      block: move more code to early-lookup.c
      dm-snap: simplify the origin_dev == cow_dev check in snapshot_ctr
      dm: open code dm_get_dev_t in dm_init_init
      dm: remove dm_get_dev_t
      dm: only call early_lookup_bdev from early boot context
      PM: hibernate: don't use early_lookup_bdev in resume_store
      mtd: block2mtd: factor the early block device open logic into a helper
      mtd: block2mtd: don't call early_lookup_bdev after the system is running
      block: mark early_lookup_bdev as __init
      block: fix rootwait=
      block: fix rootwait= again
      block: also call ->open for incremental partition opens
      cdrom: remove the unused bdev argument to cdrom_open
      cdrom: remove the unused mode argument to cdrom_ioctl
      cdrom: remove the unused cdrom_close_write release code
      cdrom: track if a cdrom_device_info was opened for data
      cdrom: remove the unused mode argument to cdrom_release
      block: pass a gendisk on bdev_check_media_change
      block: pass a gendisk to ->open
      block: remove the unused mode argument to ->release
      block: rename blkdev_close to blkdev_release
      swsusp: don't pass a stack address to blkdev_get_by_path
      bcache: don't pass a stack address to blkdev_get_by_path
      rnbd-srv: don't pass a holder for non-exclusive blkdev_get_by_path
      btrfs: don't pass a holder for non-exclusive blkdev_get_by_path
      block: use the holder as indication for exclusive opens
      block: add a sb_open_mode helper
      fs: remove sb->s_mode
      scsi: replace the fmode_t argument to scsi_cmd_allowed with a simple bool
      scsi: replace the fmode_t argument to scsi_ioctl with a simple bool
      scsi: replace the fmode_t argument to ->sg_io_fn with a simple bool
      nvme: replace the fmode_t argument to the nvme ioctl handlers with a simple bool
      mtd: block: use a simple bool to track open for write
      rnbd-srv: replace sess->open_flags with a "bool readonly"
      ubd: remove commented out code in ubd_open
      block: move a few internal definitions out of blkdev.h
      block: remove unused fmode_t arguments from ioctl handlers
      block: replace fmode_t with a block-specific type for block open flags
      block: always use I_BDEV on file->f_mapping->host to find the bdev
      block: store the holder in file->private_data
      fs: remove the now unused FMODE_* flags
      swim3: fix the floppy_locked_ioctl prototype
      splice: don't call file_accessed in copy_splice_read
      splice: simplify a conditional in copy_splice_read
      block: remove BIO_PAGE_REFFED
      iov_iter: remove iov_iter_get_pages and iov_iter_get_pages_alloc
      swim: fix a missing FMODE_ -> BLK_OPEN_ conversion in floppy_open
      block: document the holder argument to blkdev_get_by_path
      block: fix the exclusive open mask in disk_scan_partitions
      block: don't return -EINVAL for not found names in devt_from_devname

Christophe JAILLET (6):
      nvmet: reorder fields in 'struct nvmet_sq'
      nvme: reorder fields in 'struct nvme_ctrl'
      nvmet: reorder fields in 'struct nvmf_ctrl_options'
      nvmet: reorder fields in 'struct nvme_dhchap_queue_context'
      nvmet: reorder fields in 'struct nvmefc_fcp_req'
      nvmet-auth: remove some dead code

Daniel Gomez (1):
      nvme: Increase block size variable size to 32-bit

Daniel Wagner (1):
      nvmet-fcloop: Do not wait on completion when unregister fails

David Howells (9):
      iomap: Don't get an reference on ZERO_PAGE for direct I/O block zeroing
      block: Fix bio_flagged() so that gcc can better optimise it
      block: Add BIO_PAGE_PINNED and associated infrastructure
      block: Convert bio_iov_iter_get_pages to use iov_iter_extract_pages
      block: convert bio_map_user_iov to use iov_iter_extract_pages
      mm: Don't pin ZERO_PAGE in pin_user_pages()
      mm: Provide a function to get an additional pin on a page
      block: Use iov_iter_extract_pages() and page pinning in direct-io.c
      block: Fix dio_cleanup() to advance the head index

Demi Marie Obenour (1):
      block: increment diskseq on all media change events

Ed Tsai (1):
      blk-mq: check on cpu id when there is only one ctx mapping

Guoqing Jiang (8):
      block/rnbd: kill rnbd_flags_supported
      block/rnbd-srv: remove unused header
      block/rnbd: introduce rnbd_access_modes
      block/rnbd-srv: no need to check sess_dev
      block/rnbd-srv: rename one member in rnbd_srv_dev
      block/rnbd-srv: init ret with 0 instead of -EPERM
      block/rnbd-srv: init err earlier in rnbd_srv_init_module
      block/rnbd-srv: make process_msg_sess_info returns void

Hengqi Chen (1):
      block: introduce block_io_start/block_io_done tracepoints

Hou Tao (1):
      blk-ioprio: Introduce promote-to-rt policy

Irvin Cote (3):
      nvme-pci: cleaning up nvme_pci_init_request
      nvme-core: remove redundant check from nvme_init_ns_head
      nvme-core: use nvme_ns_head_multipath instead of ns->head->disk

Ivan Orlov (4):
      block/rnbd: make all 'class' structures const
      aoe: make aoe_class a static const structure
      ublk: make ublk_chr_class a static const structure
      bsg: make bsg_class a static const structure

Jan Kara (1):
      ext4: Fix warning in blkdev_put()

Jens Axboe (3):
      Merge branch 'for-6.5/splice' into for-6.5/block
      Merge tag 'md-next-20230613' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.5/block
      Merge tag 'nvme-6.5-2023-06-16' of git://git.infradead.org/nvme into for-6.5/block

Jingbo Xu (2):
      block: disallow Persistent Reservation on partitions
      block: fine-granular CAP_SYS_ADMIN for Persistent Reservation

Johannes Thumshirn (20):
      swap: use __bio_add_page to add page to bio
      drbd: use __bio_add_page to add page to bio
      dm: dm-zoned: use __bio_add_page for adding single metadata page
      fs: buffer: use __bio_add_page to add single page to bio
      md: use __bio_add_page to add single page
      md: raid5-log: use __bio_add_page to add single page
      md: raid5: use __bio_add_page to add single page to new bio
      jfs: logmgr: use __bio_add_page to add single page to bio
      gfs2: use __bio_add_page for adding single page to bio
      zonefs: use __bio_add_page for adding single page to bio
      zram: use __bio_add_page for adding single page to bio
      floppy: use __bio_add_page for adding single page to bio
      md: check for failure when adding pages in alloc_behind_master_bio
      md: raid1: use __bio_add_page for adding single page to bio
      md: raid1: check if adding pages to resync bio fails
      dm-crypt: use __bio_add_page to add single page to clone bio
      block: mark bio_add_page as __must_check
      block: add bio_add_folio_nofail
      fs: iomap: use bio_add_folio_nofail where possible
      block: mark bio_add_folio as __must_check

Jordy Zomer (1):
      cdrom: Fix spectre-v1 gadget

Keith Busch (3):
      nvme-fabrics: add queue setup helpers
      nvme: skip optional id ctrl csi if it failed
      nvme: forward port sysfs delete fix

Li Nan (11):
      block: remove redundant req_op in blk_rq_is_passthrough
      blk-iocost: use spin_lock_irqsave in adjust_inuse_and_calc_cost
      md/raid10: check slab-out-of-bounds in md_bitmap_get_counter
      md/raid10: fix overflow of md/safe_mode_delay
      md/raid10: fix wrong setting of max_corr_read_errors
      md/raid10: fix null-ptr-deref of mreplace in raid10_sync_request
      md/raid10: improve code of mrdev in raid10_sync_request
      md/raid10: prioritize adding disk to 'removed' mirror
      md/raid10: clean up md_add_new_disk()
      md/raid10: Do not add spare disk when recovery fails
      md/raid10: fix io loss while replacement replace rdev

Max Gurtovoy (5):
      nvme-rdma: fix typo in comment
      nvme-fabrics: unify common code in admin and io queue connect
      nvme-fabrics: check hostid using uuid_equal
      nvme-fabrics: prevent overriding of existing host
      nvme: move sysfs code to a dedicated sysfs.c file

Michael Schmitz (3):
      block: fix signed int overflow in Amiga partition support
      block: change all __u32 annotations to __be32 in affs_hardblocks.h
      block: add overflow checks for Amiga partition support

Min Li (1):
      block: add capacity validation in bdev_add_partition()

Ming Lei (12):
      blk-mq: don't queue plugged passthrough requests into scheduler
      ublk: kill queuing request by task_work_add
      ublk: cleanup io cmd code path by adding ublk_fill_io_cmd()
      ublk: cleanup ublk_copy_user_pages
      ublk: grab request reference when the request is handled by userspace
      ublk: support to copy any part of request pages
      ublk: add read()/write() support for ublk char device
      ublk: support user copy
      ublk: fix build warning on iov_iter_get_pages2
      ublk: add control command of UBLK_U_CMD_GET_FEATURES
      blk-mq: fix NULL dereference on q->elevator in blk_mq_elv_switch_none
      blk-mq: don't insert passthrough request into sw queue

Mingzhe Zou (1):
      bcache: fixup btree_cache_wait list damage

Pankaj Raghav (2):
      brd: use XArray instead of radix-tree to index backing pages
      brd: use cond_resched instead of cond_resched_rcu

Thomas Wei?schuh (5):
      block: constify partition prober array
      block: constify struct part_type part_type
      block: constify struct part_attr_group
      block: constify the whole_disk device_attribute
      bcache: make kobj_type structures constant

Waiman Long (1):
      blk-cgroup: Reinit blkg_iostat_set after clearing in blkcg_reset_stats()

Yu Kuai (29):
      block/rq_qos: protect rq_qos apis with a new lock
      blk-ioc: protect ioc_destroy_icq() by 'queue_lock'
      blk-ioc: fix recursive spin_lock/unlock_irq() in ioc_clear_queue()
      blk-mq: fix potential io hang by wrong 'wake_batch'
      md/raid5: don't allow replacement while reshape is in progress
      md: fix data corruption for raid456 when reshape restart while grow up
      md: export md_is_rdwr() and is_md_suspended()
      md: add a new api prepare_suspend() in md_personality
      md/raid5: fix a deadlock in the case that reshape is interrupted
      md: fix duplicate filename for rdev
      md: factor out a helper to wake up md_thread directly
      dm-raid: remove useless checking in raid_message()
      md/bitmap: always wake up md_thread in timeout_store
      md/bitmap: factor out a helper to set timeout
      md: protect md_thread with rcu
      md/raid5: don't start reshape when recovery or replace is in progress
      md/raid10: prevent soft lockup while flush writes
      md/raid1-10: factor out a helper to add bio to plug
      md/raid1-10: factor out a helper to submit normal write
      md/raid1-10: submit write io directly if bitmap is not enabled
      md/md-bitmap: add a new helper to unplug bitmap asynchrously
      md/raid1-10: don't handle pluged bio by daemon thread
      md/raid1-10: limit the number of plugged bio
      blktrace: use inline function for blk_trace_remove() while blktrace is disabled
      scsi: sg: fix blktrace debugfs entries leakage
      block: fix blktrace debugfs entries leakage
      block: fix wrong mode for blkdev_get_by_dev() from disk_scan_partitions()
      reiserfs: fix blkdev_put() warning from release_journal_dev()
      scsi/sg: don't grab scsi host module reference

Zheng Wang (2):
      bcache: Remove unnecessary NULL point check in node allocations
      bcache: Fix __bch_btree_node_alloc to make the failure behavior consistent

Zhong Jinghua (1):
      nbd: Add the maximum limit of allocated index in nbd_dev_add

ye xingchen (1):
      bcache: Convert to use sysfs_emit()/sysfs_emit_at() APIs

 Documentation/admin-guide/bcache.rst            |   3 -
 Documentation/admin-guide/cgroup-v2.rst         |  42 +-
 Documentation/admin-guide/kernel-parameters.txt |   7 +-
 Documentation/core-api/pin_user_pages.rst       |   6 +
 arch/alpha/kernel/setup.c                       |   2 +-
 arch/ia64/kernel/setup.c                        |   2 +-
 arch/powerpc/platforms/powermac/setup.c         |   3 +-
 arch/um/drivers/ubd_kern.c                      |  20 +-
 arch/xtensa/platforms/iss/simdisk.c             |   6 +-
 block/Makefile                                  |   2 +-
 block/bdev.c                                    | 252 +++++----
 block/bfq-iosched.c                             |   9 +
 block/bio.c                                     |  37 +-
 block/blk-cgroup-fc-appid.c                     |   2 +-
 block/blk-cgroup.c                              |  14 +
 block/blk-core.c                                |   1 +
 block/blk-flush.c                               | 110 ++--
 block/blk-ioc.c                                 |  36 +-
 block/blk-iocost.c                              |   7 +-
 block/blk-ioprio.c                              |  23 +-
 block/blk-map.c                                 |  22 +-
 block/blk-mq-debugfs.c                          |  10 +-
 block/blk-mq-sched.h                            |   8 +-
 block/blk-mq-tag.c                              |  15 +-
 block/blk-mq.c                                  | 141 ++---
 block/blk-mq.h                                  |  14 +-
 block/blk-rq-qos.c                              |  20 +-
 block/blk-wbt.c                                 |   2 +
 block/blk-zoned.c                               |  20 +-
 block/blk.h                                     |  40 +-
 block/bsg-lib.c                                 |   2 +-
 block/bsg.c                                     |  26 +-
 block/disk-events.c                             |  19 +-
 block/early-lookup.c                            | 316 +++++++++++
 block/elevator.c                                |   2 +-
 block/fops.c                                    |  63 ++-
 block/genhd.c                                   | 187 +++----
 block/ioctl.c                                   | 107 ++--
 block/mq-deadline.c                             | 125 +++--
 block/partitions/amiga.c                        | 102 +++-
 block/partitions/core.c                         |  50 +-
 drivers/base/dd.c                               |   6 +-
 drivers/block/amiflop.c                         |  20 +-
 drivers/block/aoe/aoeblk.c                      |   8 +-
 drivers/block/aoe/aoechr.c                      |  30 +-
 drivers/block/ataflop.c                         |  43 +-
 drivers/block/brd.c                             |  91 +---
 drivers/block/drbd/drbd_bitmap.c                |   4 +-
 drivers/block/drbd/drbd_main.c                  |  14 +-
 drivers/block/drbd/drbd_nl.c                    |  24 +-
 drivers/block/drbd/drbd_receiver.c              |   1 -
 drivers/block/floppy.c                          |  74 +--
 drivers/block/loop.c                            |  26 +-
 drivers/block/mtip32xx/mtip32xx.c               |   4 +-
 drivers/block/nbd.c                             |  15 +-
 drivers/block/pktcdvd.c                         | 560 ++++++++++----------
 drivers/block/rbd.c                             |   6 +-
 drivers/block/rnbd/Makefile                     |   6 +-
 drivers/block/rnbd/rnbd-clt-sysfs.c             |  24 +-
 drivers/block/rnbd/rnbd-clt.c                   |   8 +-
 drivers/block/rnbd/rnbd-common.c                |  23 -
 drivers/block/rnbd/rnbd-proto.h                 |  31 +-
 drivers/block/rnbd/rnbd-srv-sysfs.c             |  28 +-
 drivers/block/rnbd/rnbd-srv.c                   |  67 ++-
 drivers/block/rnbd/rnbd-srv.h                   |   4 +-
 drivers/block/sunvdc.c                          |   2 +-
 drivers/block/swim.c                            |  26 +-
 drivers/block/swim3.c                           |  33 +-
 drivers/block/ublk_drv.c                        | 498 +++++++++++++-----
 drivers/block/xen-blkback/xenbus.c              |   4 +-
 drivers/block/xen-blkfront.c                    |   2 +-
 drivers/block/z2ram.c                           |   8 +-
 drivers/block/zram/zram_drv.c                   |  23 +-
 drivers/cdrom/cdrom.c                           |  42 +-
 drivers/cdrom/gdrom.c                           |  12 +-
 drivers/md/bcache/bcache.h                      |  12 +-
 drivers/md/bcache/btree.c                       |  25 +-
 drivers/md/bcache/btree.h                       |   1 +
 drivers/md/bcache/request.c                     |   4 +-
 drivers/md/bcache/stats.h                       |   1 -
 drivers/md/bcache/super.c                       |  29 +-
 drivers/md/bcache/sysfs.c                       |  31 +-
 drivers/md/bcache/sysfs.h                       |   2 +-
 drivers/md/bcache/writeback.c                   |  10 +
 drivers/md/dm-cache-target.c                    |  12 +-
 drivers/md/dm-clone-target.c                    |  10 +-
 drivers/md/dm-core.h                            |   7 +-
 drivers/md/dm-crypt.c                           |   3 +-
 drivers/md/dm-era-target.c                      |   6 +-
 drivers/md/dm-init.c                            |   4 +-
 drivers/md/dm-ioctl.c                           |  10 +-
 drivers/md/dm-raid.c                            |   4 +-
 drivers/md/dm-snap.c                            |  18 +-
 drivers/md/dm-table.c                           |  37 +-
 drivers/md/dm-thin.c                            |   9 +-
 drivers/md/dm-verity-fec.c                      |   2 +-
 drivers/md/dm-verity-target.c                   |   6 +-
 drivers/md/dm-zoned-metadata.c                  |   6 +-
 drivers/md/dm.c                                 |  20 +-
 drivers/md/dm.h                                 |   2 +-
 drivers/md/md-autodetect.c                      |   3 +-
 drivers/md/md-bitmap.c                          |  93 +++-
 drivers/md/md-bitmap.h                          |   8 +
 drivers/md/md-cluster.c                         |  17 +-
 drivers/md/md-multipath.c                       |   4 +-
 drivers/md/md.c                                 | 280 +++++-----
 drivers/md/md.h                                 |  37 +-
 drivers/md/raid1-10.c                           |  74 ++-
 drivers/md/raid1.c                              |  43 +-
 drivers/md/raid1.h                              |   2 +-
 drivers/md/raid10.c                             | 199 +++----
 drivers/md/raid10.h                             |   2 +-
 drivers/md/raid5-cache.c                        |  24 +-
 drivers/md/raid5-ppl.c                          |   4 +-
 drivers/md/raid5.c                              |  68 ++-
 drivers/md/raid5.h                              |   2 +-
 drivers/mmc/core/block.c                        |  12 +-
 drivers/mtd/devices/block2mtd.c                 |  64 ++-
 drivers/mtd/mtd_blkdevs.c                       |   8 +-
 drivers/mtd/mtdblock.c                          |   2 +-
 drivers/mtd/ubi/block.c                         |   9 +-
 drivers/nvme/host/Makefile                      |   2 +-
 drivers/nvme/host/auth.c                        |   6 +-
 drivers/nvme/host/core.c                        | 669 +-----------------------
 drivers/nvme/host/fabrics.c                     | 241 ++++++---
 drivers/nvme/host/fabrics.h                     |  21 +-
 drivers/nvme/host/ioctl.c                       |  66 +--
 drivers/nvme/host/multipath.c                   |   6 +-
 drivers/nvme/host/nvme.h                        |  15 +-
 drivers/nvme/host/pci.c                         |   3 +-
 drivers/nvme/host/rdma.c                        |  81 +--
 drivers/nvme/host/sysfs.c                       | 668 +++++++++++++++++++++++
 drivers/nvme/host/tcp.c                         |  92 +---
 drivers/nvme/target/fabrics-cmd-auth.c          |  13 -
 drivers/nvme/target/fcloop.c                    |   5 +-
 drivers/nvme/target/io-cmd-bdev.c               |   4 +-
 drivers/nvme/target/nvmet.h                     |   2 +-
 drivers/s390/block/dasd.c                       |  10 +-
 drivers/s390/block/dasd_genhd.c                 |   5 +-
 drivers/s390/block/dasd_int.h                   |   3 +-
 drivers/s390/block/dasd_ioctl.c                 |   2 +-
 drivers/s390/block/dcssblk.c                    |  11 +-
 drivers/scsi/ch.c                               |   3 +-
 drivers/scsi/scsi_bsg.c                         |   4 +-
 drivers/scsi/scsi_ioctl.c                       |  38 +-
 drivers/scsi/sd.c                               |  39 +-
 drivers/scsi/sg.c                               |  16 +-
 drivers/scsi/sr.c                               |  22 +-
 drivers/scsi/st.c                               |   2 +-
 drivers/target/target_core_iblock.c             |  11 +-
 drivers/target/target_core_pscsi.c              |   9 +-
 fs/Makefile                                     |  10 +-
 fs/btrfs/dev-replace.c                          |   8 +-
 fs/btrfs/ioctl.c                                |  12 +-
 fs/btrfs/super.c                                |  21 +-
 fs/btrfs/volumes.c                              |  59 +--
 fs/btrfs/volumes.h                              |  11 +-
 fs/buffer.c                                     |   3 +-
 fs/direct-io.c                                  |  71 ++-
 fs/erofs/super.c                                |   7 +-
 fs/ext4/ext4.h                                  |   1 +
 fs/ext4/ioctl.c                                 |  24 +-
 fs/ext4/super.c                                 |  27 +-
 fs/f2fs/super.c                                 |  12 +-
 fs/gfs2/ops_fstype.c                            |   2 +-
 fs/inode.c                                      |   3 +-
 fs/iomap/buffered-io.c                          |   6 +-
 fs/iomap/direct-io.c                            |   1 -
 fs/jfs/jfs_logmgr.c                             |  12 +-
 fs/nfs/blocklayout/dev.c                        |  10 +-
 fs/nilfs2/super.c                               |  12 +-
 fs/no-block.c                                   |  19 -
 fs/ocfs2/cluster/heartbeat.c                    |   7 +-
 fs/pstore/blk.c                                 |   4 +-
 fs/reiserfs/journal.c                           |  25 +-
 fs/reiserfs/reiserfs.h                          |   1 -
 fs/splice.c                                     |  15 +-
 fs/super.c                                      |  48 +-
 fs/xfs/xfs_fsops.c                              |   3 +
 fs/xfs/xfs_mount.h                              |   4 +-
 fs/xfs/xfs_super.c                              |  34 +-
 fs/zonefs/super.c                               |   2 +-
 include/linux/bio.h                             |  12 +-
 include/linux/blk-mq.h                          |  67 ++-
 include/linux/blk_types.h                       |   4 +-
 include/linux/blkdev.h                          | 101 ++--
 include/linux/blktrace_api.h                    |   6 +-
 include/linux/bsg.h                             |   2 +-
 include/linux/cdrom.h                           |  12 +-
 include/linux/device-mapper.h                   |  10 +-
 include/linux/device/driver.h                   |   2 +-
 include/linux/fs.h                              |   9 +-
 include/linux/mm.h                              |  27 +-
 include/linux/mount.h                           |   1 -
 include/linux/mtd/blktrans.h                    |   2 +-
 include/linux/nvme-fc-driver.h                  |  10 +-
 include/linux/pktcdvd.h                         |   1 -
 include/linux/root_dev.h                        |   9 +-
 include/linux/uio.h                             |   6 -
 include/scsi/scsi_ioctl.h                       |   4 +-
 include/trace/events/block.h                    |  26 +
 include/uapi/linux/affs_hardblocks.h            |  68 +--
 include/uapi/linux/pktcdvd.h                    |   1 +
 include/uapi/linux/ublk_cmd.h                   |  33 +-
 init/do_mounts.c                                | 416 ++++-----------
 init/do_mounts.h                                |  14 +-
 init/do_mounts_initrd.c                         |  11 +-
 kernel/power/hibernate.c                        | 179 ++++---
 kernel/power/power.h                            |   5 +-
 kernel/power/swap.c                             |  30 +-
 lib/iov_iter.c                                  |  35 +-
 lib/raid6/neon.h                                |  22 +
 lib/raid6/neon.uc                               |   1 +
 lib/raid6/recov_neon.c                          |   8 +-
 lib/raid6/recov_neon_inner.c                    |   1 +
 mm/gup.c                                        |  58 +-
 mm/page_io.c                                    |   8 +-
 mm/swapfile.c                                   |   6 +-
 218 files changed, 4742 insertions(+), 3876 deletions(-)
 create mode 100644 block/early-lookup.c
 delete mode 100644 drivers/block/rnbd/rnbd-common.c
 create mode 100644 drivers/nvme/host/sysfs.c
 delete mode 100644 fs/no-block.c
 create mode 100644 lib/raid6/neon.h

-- 
Jens Axboe

