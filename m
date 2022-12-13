Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29FC7C4332F
	for <linux-block@archiver.kernel.org>; Tue, 13 Dec 2022 03:24:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbiLMDYw (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 12 Dec 2022 22:24:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiLMDYv (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Mon, 12 Dec 2022 22:24:51 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 263291AF26
        for <linux-block@vger.kernel.org>; Mon, 12 Dec 2022 19:24:49 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id c7so1291823pfc.12
        for <linux-block@vger.kernel.org>; Mon, 12 Dec 2022 19:24:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uZZLEL28V2aKtaNI87TDi6Oi0cMmQN0HoqAnNS8RSiA=;
        b=cJ63Wpnv7gdWSrZFhWJELVLLMKPqPatcm2El70n99rjnrHN67l16KDpSf3v0jAU32a
         TK3rkrU+vE6GeJmCh0wbzOaFCQeTj20Y1R33LG6/TIPvgFI5OVeKMlzYk7RUCwtV9pHG
         hkEij9BId1q73lrEQJKGALV8SEN/ZGeDz29IPM4a+OhPkDxfkkZAI6FNR50ZsUM6TTfp
         y6TkcDECnYt5phdUsyrabi7DB3xNni1pZYiMT1rh9IECMy0nn6u+JAAXO9s/3Vj1Ipw1
         tF7dvKDlKoihVsGHG6u08kqNN2bKD/PHKIqD9xTqWLbfNjbaSvSNhIDThdyp3oGS/3I2
         55JA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:subject:from:cc:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=uZZLEL28V2aKtaNI87TDi6Oi0cMmQN0HoqAnNS8RSiA=;
        b=EfgrpUDmbcC88GDRzox7lcg2GOhHuQtYBcfLVpySpqv9ZtLOE9FvZ7QObSpx39VJCI
         NTGT5sjbMMHDQ8h4gJMZToleMDt3yjP/yfybSQds3bV4fIB1S3GHzmsH+RA5JRNLd2iC
         xyyySzcW1najrYMyLiXdIdMkpLs09/HTlpbVAtvOpID+YeOKSVrjvhloHtp6gspdeY2O
         0J5d5QsIBH0034A73plHrkjhOzAqYrnxO8TTiFaqmlIXO4aTLAmzBMFsKmsbdVffuasi
         YiIZZB9E/39u4r3JERilouAF6u1xys+6QHyhx3+73vjPvmzIaviM/hZzIduHVZjmdc1V
         +QIw==
X-Gm-Message-State: ANoB5pnDyYHS35o/y7qn6HniUtX5qIi5JYp6cnj56dWHxQRERYrhDnkc
        75ixEMDaRJ0G1sevhLIKm9DJUn/6AmHcNu3RZ6I=
X-Google-Smtp-Source: AA0mqf61E8WiPbFLIiE9TZU3XV7PbLFtnjhlRk0wlPNJHMBUZUcBQjtg808O+BtbgXdoQ3IDblTszA==
X-Received: by 2002:a05:6a00:1c96:b0:578:451c:84a9 with SMTP id y22-20020a056a001c9600b00578451c84a9mr2107633pfw.2.1670901888159;
        Mon, 12 Dec 2022 19:24:48 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w206-20020a627bd7000000b005748aca80fesm6504232pfc.32.2022.12.12.19.24.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 19:24:47 -0800 (PST)
Message-ID: <99cd4a7d-32c2-497b-d35b-950eebcd5319@kernel.dk>
Date:   Mon, 12 Dec 2022 20:24:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block updates for 6.2-rc1
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Here are the block changes for the 6.2-rc1 merge window. This pull
request contains:

- NVMe pull requests via Christoph
	- Support some passthrough commands without CAP_SYS_ADMIN
	  (Kanchan Joshi)
	- Refactor PCIe probing and reset (Christoph Hellwig)
	- Various fabrics authentication fixes and improvements
	  (Sagi Grimberg)
	- Avoid fallback to sequential scan due to transient issues
	  (Uday Shankar)
	- Implement support for the DEAC bit in Write Zeroes
	  (Christoph Hellwig)
	- Allow overriding the IEEE OUI and firmware revision in configfs
	  for nvmet (Aleksandr Miloserdov)
	- Force reconnect when number of queue changes in nvmet
	  (Daniel Wagner)
	- Minor fixes and improvements (Uros Bizjak, Joel Granados,
	  Sagi Grimberg, Christoph Hellwig, Christophe JAILLET)
	- Fix and cleanup nvme-fc req allocation (Chaitanya Kulkarni)
	- Use the common tagset helpers in nvme-pci driver
	  (Christoph Hellwig)
	- Cleanup the nvme-pci removal path (Christoph Hellwig)
	- Use kstrtobool() instead of strtobool (Christophe JAILLET)
	- Allow unprivileged passthrough of Identify Controller
	  (Joel Granados)
	- Support io stats on the mpath device (Sagi Grimberg)
	- Minor nvmet cleanup (Sagi Grimberg)

- MD pull requests via Song
	- Code cleanups (Christoph)
	- Various fixes

- Series fixing some batch wakeup issues with sbitmap (Gabriel)

- Removal of the pktcdvd driver that was deprecated more than 5 years
  ago, and subsequent removal of the devnode callback in struct
  block_device_operations as no users are now left (Greg)

- Fix for partition read on an exclusively opened bdev (Jan)

- Series of elevator API cleanups (Jinlong, Christoph)

- Series of fixes and cleanups for blk-iocost (Kemeng)

- Series of fixes and cleanups for blk-throttle (Kemeng)

- Series adding concurrent support for sync queues in BFQ (Yu)

- Floppy pull request from Denis
	- Fix a memory leak in the init error path (Yuan)

- Series bringing drbd a bit closer to the out-of-tree maintained
  version (Christian, Joel, Lars, Philipp)

- Misc drbd fixes (Wang)

- blk-wbt fixes and tweaks for enable/disable (Yu)

- Fixes for mq-deadline for zoned devices (Damien)

- Add support for read-only and offline zones for null_blk (Shin'ichiro)

- Series fixing the delayed holder tracking, as used by DM (Yu,
  Christoph)

- Series enabling bio alloc caching for IRQ based IO (Pavel)

- Series enabling userspace peer-to-peer DMA (Logan)

- BFQ waker fixes (Khazhismel)

- Series fixing elevator refcount issues (Christoph, Jinlong)

- Series cleaning up references around queue destruction (Christoph)

- Series doing quiesce by tagset, enabling cleanups in drivers
  (Christoph, Chao)

- Series untangling the queue kobject and queue references (Christoph)

- Misc fixes and cleanups (Bart, David, Dawei, Jinlong, Kemeng, Ye,
  Yang, Waiman, Shin'ichiro, Randy, Pankaj, Christoph)

Please pull!


The following changes since commit 247f34f7b80357943234f93f247a1ae6b6c3a740:

  Linux 6.1-rc2 (2022-10-23 15:27:33 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux.git tags/for-6.2/block-2022-12-08

for you to fetch changes up to f596da3efaf4130ff61cd029558845808df9bf99:

  blktrace: Fix output non-blktrace event when blk_classic option enabled (2022-12-08 09:26:11 -0700)

----------------------------------------------------------------
for-6.2/block-2022-12-08

----------------------------------------------------------------
Aleksandr Miloserdov (2):
      nvmet: expose IEEE OUI to configfs
      nvmet: expose firmware revision to configfs

Bart Van Assche (4):
      block: Remove request.write_hint
      block: Constify most queue limits pointers
      block: Micro-optimize get_max_segment_size()
      blk-crypto: Add a missing include directive

Chaitanya Kulkarni (2):
      nvme-fc: avoid null pointer dereference
      nvme-fc: move common code into helper

Chao Leng (2):
      blk-mq: add tagset quiesce interface
      nvme: use blk_mq_[un]quiesce_tagset

Christoph Böhmwalder (9):
      drbd: use blk_queue_max_discard_sectors helper
      drbd: Store op in drbd_peer_request
      lru_cache: remove compiled out code
      drbd: use consistent license
      drbd: unify how failed assertions are logged
      drbd: split polymorph printk to its own file
      drbd: introduce dynamic debug
      drbd: introduce drbd_ratelimit()
      drbd: add context parameter to expect() macro

Christoph Hellwig (79):
      block: add proper helpers for elevator_type module refcount management
      block: sanitize the elevator name before passing it to __elevator_change
      blk-mq: move the call to blk_put_queue out of blk_mq_destroy_queue
      scsi: remove an extra queue reference
      nvme-pci: remove an extra queue reference
      nvme-apple: remove an extra queue reference
      block: remove bio_start_io_acct_time
      block: cleanup elevator_get
      block: exit elv_iosched_show early when I/O schedulers are not supported
      block: cleanup the variable naming in elv_iosched_store
      block: simplify the check for the current elevator in elv_iosched_show
      block: don't check for required features in elevator_match
      block: split elevator_switch
      block: set the disk capacity to 0 in blk_mark_disk_dead
      nvme-pci: refactor the tagset handling in nvme_reset_work
      nvme: don't remove namespaces in nvme_passthru_end
      nvme: remove the NVME_NS_DEAD check in nvme_remove_invalid_namespaces
      nvme: remove the NVME_NS_DEAD check in nvme_validate_ns
      nvme: don't unquiesce the admin queue in nvme_kill_queues
      nvme: split nvme_kill_queues
      nvme-pci: don't unquiesce the I/O queues in nvme_remove_dead_ctrl
      nvme-apple: don't unquiesce the I/O queues in apple_nvme_reset_work
      blk-mq: skip non-mq queues in blk_mq_quiesce_queue
      blk-mq: move the srcu_struct used for quiescing to the tagset
      blk-mq: pass a tagset to blk_mq_wait_quiesce_done
      blk-mq: remove blk_mq_alloc_tag_set_tags
      blk-mq: simplify blk_mq_realloc_tag_set_tags
      md/raid5: use bdev_write_cache instead of open coding it
      nvmet: only allocate a single slab for bvecs
      nvme: implement the DEAC bit for the Write Zeroes command
      nvme: don't call nvme_init_ctrl_finish from nvme_passthru_end
      nvme: move OPAL setup from PCIe to core
      nvme: simplify transport specific device attribute handling
      nvme-pci: put the admin queue in nvme_dev_remove_admin
      nvme-pci: move more teardown work to nvme_remove
      nvme-pci: factor the iod mempool creation into a helper
      nvme-pci: factor out a nvme_pci_alloc_dev helper
      nvme-pci: set constant paramters in nvme_pci_alloc_ctrl
      nvme-pci: call nvme_pci_configure_admin_queue from nvme_pci_enable
      nvme-pci: simplify nvme_dbbuf_dma_alloc
      nvme-pci: move the HMPRE check into nvme_setup_host_mem
      nvme-pci: split the initial probe from the rest path
      nvme-pci: don't unbind the driver on reset failure
      block: remove blkdev_writepages
      block: clear ->slave_dir when dropping the main slave_dir reference
      dm: remove free_table_devices
      dm: cleanup open_table_device
      dm: cleanup close_table_device
      dm: track per-add_disk holder relations in DM
      block: remove delayed holder registration
      nvme: rename the queue quiescing helpers
      blk-crypto: don't use struct request_queue for public interfaces
      blk-crypto: add a blk_crypto_config_supported_natively helper
      blk-crypto: move internal only declarations to blk-crypto-internal.h
      blk-crypto: pass a gendisk to blk_crypto_sysfs_{,un}register
      block: factor out a blk_debugfs_remove helper
      block: fix error unwinding in blk_register_queue
      block: untangle request_queue refcounting from sysfs
      block: mark blk_put_queue as potentially blocking
      md: remove lock_bdev / unlock_bdev
      md: mark md_kick_rdev_from_array static
      md: fold unbind_rdev_from_array into md_kick_rdev_from_array
      nvme: don't call blk_mq_{,un}quiesce_tagset when ctrl->tagset is NULL
      nvme-apple: fix controller shutdown in apple_nvme_disable
      nvme: use nvme_wait_ready in nvme_shutdown_ctrl
      nvme: merge nvme_shutdown_ctrl into nvme_disable_ctrl
      nvme-pci: remove nvme_disable_admin_queue
      nvme-pci: remove nvme_pci_disable
      nvme-pci: cleanup nvme_suspend_queue
      nvme-pci: rename nvme_disable_io_queues
      nvme-pci: return early on ctrl state mismatch in nvme_reset_work
      nvme-pci: split out a nvme_pci_ctrl_is_dead helper
      block: bio_copy_data_iter
      nvme: pass nr_maps explicitly to nvme_alloc_io_tag_set
      nvme: consolidate setting the tagset flags
      nvme: only set reserved_tags in nvme_alloc_io_tag_set for fabrics controllers
      nvme: add the Apple shared tag workaround to nvme_alloc_io_tag_set
      nvme-pci: use the tagset alloc/free helpers
      block: remove bio_set_op_attrs

Christophe JAILLET (3):
      nvme-fc: improve memory usage in nvme_fc_rcv_ls_req()
      nvme: use kstrtobool() instead of strtobool()
      block: sed-opal: Don't include <linux/kernel.h>

Damien Le Moal (3):
      block: mq-deadline: Fix dd_finish_request() for zoned devices
      block: mq-deadline: Do not break sequential write streams to zoned HDDs
      block: mq-deadline: Rename deadline_is_seq_writes()

Daniel Wagner (1):
      nvmet: force reconnect when number of queue changes

David Jeffery (1):
      blk-mq: avoid double ->queue_rq() because of early timeout

Dawei Li (1):
      block: simplify blksize_bits() implementation

Florian-Ewald Mueller (1):
      md/bitmap: Fix bitmap chunk size overflow issues

Gabriel Krisman Bertazi (4):
      sbitmap: Use single per-bitmap counting to wake up queued tags
      sbitmap: Advance the queue index before waking up a queue
      wait: Return number of exclusive waiters awaken
      sbitmap: Try each queue to wake up at least one waiter

Giulio Benetti (1):
      lib/raid6: drop RAID6_USE_EMPTY_ZERO_PAGE

Greg Kroah-Hartman (2):
      pktcdvd: remove driver.
      block: remove devnode callback from struct block_device_operations

Jan Kara (1):
      block: Do not reread partition table on exclusively open device

Jens Axboe (6):
      Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.2/block
      Merge tag 'nvme-6.2-2022-11-29' of git://git.infradead.org/nvme into for-6.2/block
      Revert "blk-cgroup: Flush stats at blkgs destruction path"
      Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-6.2/block
      Merge tag 'floppy-for-6.2' of https://github.com/evdenis/linux-floppy into for-6.2/block
      Merge tag 'nvme-6.2-2022-12-07' of git://git.infradead.org/nvme into for-6.2/block

Jiang Li (1):
      md/raid1: stop mdx_raid1 thread when raid1 array run failed

Jinlong Chen (15):
      block: check for an unchanged elevator earlier in __elevator_change
      block: fix up elevator_type refcounting
      blk-mq: move queue_is_mq out of blk_mq_cancel_work_sync
      blk-mq: remove redundant call to blk_freeze_queue_start in blk_mq_destroy_queue
      blk-mq: improve error handling in blk_mq_alloc_rq_map()
      blk-mq: use if-else instead of goto in blk_mq_alloc_cached_request()
      elevator: update the document of elevator_switch
      elevator: printk a warning if switching to a new io scheduler fails
      elevator: update the document of elevator_match
      elevator: remove an outdated comment in elevator_change
      block: include 'none' for initial elv_iosched_show call
      block: replace continue with else-if in elv_iosched_show
      block: always use 'e' when printing scheduler name
      block: replace "len+name" with "name+len" in elv_iosched_show
      block: use bool as the return type of elv_iosched_allow_bio_merge

Joel Colledge (1):
      lru_cache: remove unused lc_private, lc_set, lc_index_of

Joel Granados (2):
      nvme: return err on nvme_init_non_mdts_limits fail
      nvme: allow unprivileged passthrough of Identify Controller

Kanchan Joshi (2):
      nvme: fine-granular CAP_SYS_ADMIN for nvme io commands
      nvme: identify-namespace without CAP_SYS_ADMIN

Kemeng Shi (18):
      block: Remove redundant parent blkcg_gp check in check_scale_change
      block: Correct comment for scale_cookie_change
      block: Replace struct rq_depth with unsigned int in struct iolatency_grp
      blk-iocost: Fix typo in comment
      blk-iocost: Reset vtime_base_rate in ioc_refresh_params
      blk-iocost: Trace vtime_base_rate instead of vtime_rate
      blk-iocost: Remove vrate member in struct ioc_now
      blk-iocost: Correct comment in blk_iocost_init
      blk-throttle: correct stale comment in throtl_pd_init
      blk-throttle: Fix that bps of child could exceed bps limited in parent
      blk-throttle: ignore cgroup without io queued in blk_throtl_cancel_bios
      blk-throttle: correct calculation of wait time in tg_may_dispatch
      blk-throttle: simpfy low limit reached check in throtl_tg_can_upgrade
      blk-throttle: fix typo in comment of throtl_adjusted_limit
      blk-throttle: remove incorrect comment for tg_last_low_overflow_time
      blk-throttle: remove repeat check of elapsed time
      blk-throttle: Use more suitable time_after check for update of slice_start
      blk-cgroup: Fix typo in comment

Khazhismel Kumykov (2):
      bfq: fix waker_bfqq inconsistency crash
      bfq: ignore oom_bfqq in bfq_check_waker

Lars Ellenberg (1):
      lru_cache: use atomic operations when accessing lc->flags, always

Li Zhong (1):
      drivers/md/md-bitmap: check the return value of md_bitmap_get_counter()

Logan Gunthorpe (9):
      mm: allow multiple error returns in try_grab_page()
      mm: introduce FOLL_PCI_P2PDMA to gate getting PCI P2PDMA pages
      iov_iter: introduce iov_iter_get_pages_[alloc_]flags()
      block: add check when merging zone device pages
      lib/scatterlist: add check when merging zone device pages
      block: set FOLL_PCI_P2PDMA in __bio_iov_iter_get_pages()
      block: set FOLL_PCI_P2PDMA in bio_map_user_iov()
      PCI/P2PDMA: Allow userspace VMA allocations through sysfs
      ABI: sysfs-bus-pci: add documentation for p2pmem allocate

Luca Boccassi (1):
      sed-opal: allow using IOC_OPAL_SAVE for locking too

Mikulas Patocka (1):
      md: fix a crash in mempool_free

Pankaj Raghav (1):
      virtio-blk: replace ida_simple[get|remove] with ida_[alloc_range|free]

Pavel Begunkov (6):
      mempool: introduce mempool_is_saturated
      bio: don't rob starving biosets of bios
      bio: split pcpu cache part of bio_put into a helper
      bio: add pcpu caching for non-polling bio_put
      bio: shrink max number of pcpu cached bios
      io_uring/rw: enable bio caches for IRQ rw

Philipp Reisner (1):
      drbd: disable discard support if granularity > max

Randy Dunlap (1):
      block: bdev & blktrace: use consistent function doc. notation

Sagi Grimberg (23):
      nvme-auth: rename __nvme_auth_[reset|free] to nvme_auth[reset|free]_dhchap
      nvme-auth: rename authentication work elements
      nvme-auth: remove symbol export from nvme_auth_reset
      nvme-auth: don't re-authenticate if the controller is not LIVE
      nvme-auth: remove redundant buffer deallocations
      nvme-auth: don't ignore key generation failures when initializing ctrl keys
      nvme-auth: don't override ctrl keys before validation
      nvme-auth: remove redundant if statement
      nvme-auth: don't keep long lived 4k dhchap buffer
      nvme-auth: guarantee dhchap buffers under memory pressure
      nvme-auth: clear sensitive info right after authentication completes
      nvme-auth: remove redundant deallocations
      nvme-auth: no need to reset chap contexts on re-authentication
      nvme-auth: check chap ctrl_key once constructed
      nvme-auth: convert dhchap_auth_list to an array
      nvme-auth: remove redundant auth_work flush
      nvme-auth: have dhchap_auth_work wait for queues auth to complete
      nvme-tcp: stop auth work after tearing down queues in error recovery
      nvme-rdma: stop auth work after tearing down queues in error recovery
      nvmet: fix a memory leak in nvmet_auth_set_key
      nvme: introduce nvme_start_request
      nvme-multipath: support io stats on the mpath device
      nvmet: don't open-code NVME_NS_ATTR_RO enumeration

Shin'ichiro Kawasaki (2):
      block: fix missing nr_hw_queues update in blk_mq_realloc_tag_set_tags
      null_blk: support read-only and offline zone conditions

Uday Shankar (1):
      nvme: avoid fallback to sequential scan due to transient issues

Uros Bizjak (2):
      raid5-cache: use try_cmpxchg in r5l_wake_reclaim
      nvmet: use try_cmpxchg in nvmet_update_sq_head

Waiman Long (3):
      blk-cgroup: Return -ENOMEM directly in blkcg_css_alloc() error path
      blk-cgroup: Optimize blkcg_rstat_flush()
      blk-cgroup: Flush stats at blkgs destruction path

Wang ShaoBo (2):
      drbd: remove call to memset before free device/resource/connection
      drbd: destroy workqueue when drbd device was freed

Xiao Ni (1):
      md/raid0, raid10: Don't set discard sectors for request queue

Yang Jihong (1):
      blktrace: Fix output non-blktrace event when blk_classic option enabled

Yang Li (2):
      block: Fix some kernel-doc comments
      blk-cgroup: Fix some kernel-doc comments

Ye Bin (4):
      md: factor out __md_set_array_info()
      md: introduce md_ro_state
      block: fix crash in 'blk_mq_elv_switch_none'
      blk-mq: fix possible memleak when register 'hctx' failed

Yu Kuai (25):
      blk-iocost: disable writeback throttling
      blk-iocost: don't release 'ioc->lock' while updating params
      blk-iocost: prevent configuration update concurrent with io throttling
      blk-iocost: read 'ioc->params' inside 'ioc->lock' in ioc_timer_fn()
      elevator: remove redundant code in elv_unregister_queue()
      blk-wbt: remove unnecessary check in wbt_enable_default()
      blk-wbt: make enable_state more accurate
      blk-wbt: don't show valid wbt_lat_usec in sysfs while wbt is disabled
      elevator: add new field flags in struct elevator_queue
      blk-wbt: don't enable throttling if default elevator is bfq
      block, bfq: support to track if bfqq has pending requests
      block, bfq: record how many queues have pending requests
      block, bfq: refactor the counting of 'num_groups_with_pending_reqs'
      block, bfq: do not idle if only one group is activated
      block, bfq: cleanup bfq_weights_tree add/remove apis
      block, bfq: cleanup __bfq_weights_tree_remove()
      block, bfq: remove set but not used variable in __bfq_entity_update_weight_prio
      block, bfq: factor out code to update 'active_entities'
      block, bfq: cleanup bfq_activate_requeue_entity()
      block, bfq: remove dead code for updating 'rq_in_driver'
      block, bfq: don't declare 'bfqd' as type 'void *' in bfq_group
      dm: make sure create and remove dm device won't race with open and close table
      block: fix use after free for bd_holder_dir
      block: store the holder kobject in bd_holder_disk
      block: don't allow a disk link holder to itself

Yuan Can (1):
      floppy: Fix memory leak in do_floppy_init()

 Documentation/ABI/testing/debugfs-pktcdvd     |   18 -
 Documentation/ABI/testing/sysfs-bus-pci       |   10 +
 Documentation/ABI/testing/sysfs-class-pktcdvd |   97 -
 Documentation/block/inline-encryption.rst     |   12 +-
 MAINTAINERS                                   |    7 -
 block/bdev.c                                  |    4 +-
 block/bfq-cgroup.c                            |   12 +-
 block/bfq-iosched.c                           |  102 +-
 block/bfq-iosched.h                           |   32 +-
 block/bfq-wf2q.c                              |  157 +-
 block/bio.c                                   |  146 +-
 block/blk-cgroup.c                            |   94 +-
 block/blk-cgroup.h                            |   10 +
 block/blk-core.c                              |   83 +-
 block/blk-crypto-internal.h                   |   22 +-
 block/blk-crypto-profile.c                    |    1 +
 block/blk-crypto-sysfs.c                      |   11 +-
 block/blk-crypto.c                            |   37 +-
 block/blk-ia-ranges.c                         |    3 +-
 block/blk-iocost.c                            |   57 +-
 block/blk-iolatency.c                         |   37 +-
 block/blk-map.c                               |   14 +-
 block/blk-merge.c                             |   44 +-
 block/blk-mq-sched.c                          |    8 +-
 block/blk-mq-sysfs.c                          |   11 +-
 block/blk-mq.c                                |  229 +-
 block/blk-mq.h                                |   14 +-
 block/blk-settings.c                          |    6 +-
 block/blk-sysfs.c                             |  137 +-
 block/blk-throttle.c                          |  102 +-
 block/blk-wbt.c                               |   26 +-
 block/blk-wbt.h                               |   17 +-
 block/blk.h                                   |   27 +-
 block/bsg-lib.c                               |    2 +
 block/bsg.c                                   |   11 +-
 block/elevator.c                              |  254 +--
 block/elevator.h                              |   20 +-
 block/fops.c                                  |    7 -
 block/genhd.c                                 |   35 +-
 block/holder.c                                |  103 +-
 block/ioctl.c                                 |   12 +-
 block/mq-deadline.c                           |   83 +-
 block/sed-opal.c                              |   39 +
 drivers/block/Kconfig                         |   43 -
 drivers/block/Makefile                        |    1 -
 drivers/block/drbd/Kconfig                    |    2 +-
 drivers/block/drbd/Makefile                   |    2 +-
 drivers/block/drbd/drbd_actlog.c              |    8 +-
 drivers/block/drbd/drbd_bitmap.c              |   62 +-
 drivers/block/drbd/drbd_debugfs.c             |    2 +-
 drivers/block/drbd/drbd_debugfs.h             |    2 +-
 drivers/block/drbd/drbd_int.h                 |   78 +-
 drivers/block/drbd/drbd_interval.c            |    2 +-
 drivers/block/drbd/drbd_interval.h            |    2 +-
 drivers/block/drbd/drbd_main.c                |   21 +-
 drivers/block/drbd/drbd_nl.c                  |   27 +-
 drivers/block/drbd/drbd_nla.c                 |    2 +-
 drivers/block/drbd/drbd_nla.h                 |    2 +-
 drivers/block/drbd/drbd_polymorph_printk.h    |  141 ++
 drivers/block/drbd/drbd_proc.c                |    2 +-
 drivers/block/drbd/drbd_protocol.h            |    2 +-
 drivers/block/drbd/drbd_receiver.c            |   99 +-
 drivers/block/drbd/drbd_req.c                 |    8 +-
 drivers/block/drbd/drbd_req.h                 |    2 +-
 drivers/block/drbd/drbd_state.c               |    2 +-
 drivers/block/drbd/drbd_state.h               |    2 +-
 drivers/block/drbd/drbd_state_change.h        |    2 +-
 drivers/block/drbd/drbd_strings.c             |    2 +-
 drivers/block/drbd/drbd_strings.h             |    2 +-
 drivers/block/drbd/drbd_vli.h                 |    2 +-
 drivers/block/drbd/drbd_worker.c              |   18 +-
 drivers/block/floppy.c                        |    4 +-
 drivers/block/null_blk/main.c                 |   22 +-
 drivers/block/null_blk/null_blk.h             |    8 +
 drivers/block/null_blk/zoned.c                |   95 +-
 drivers/block/pktcdvd.c                       | 2944 -------------------------
 drivers/block/virtio_blk.c                    |    8 +-
 drivers/block/xen-blkfront.c                  |    1 -
 drivers/md/bcache/movinggc.c                  |    2 +-
 drivers/md/bcache/request.c                   |    2 +-
 drivers/md/bcache/writeback.c                 |    4 +-
 drivers/md/dm-table.c                         |    2 +-
 drivers/md/dm-thin.c                          |    2 +-
 drivers/md/dm.c                               |  138 +-
 drivers/md/md-bitmap.c                        |   47 +-
 drivers/md/md.c                               |  323 ++-
 drivers/md/md.h                               |    1 -
 drivers/md/raid0.c                            |    1 -
 drivers/md/raid1.c                            |   13 +-
 drivers/md/raid10.c                           |   20 +-
 drivers/md/raid5-cache.c                      |   10 +-
 drivers/md/raid5-ppl.c                        |    5 +-
 drivers/nvme/host/apple.c                     |   30 +-
 drivers/nvme/host/auth.c                      |  258 ++-
 drivers/nvme/host/core.c                      |  319 +--
 drivers/nvme/host/fc.c                        |   59 +-
 drivers/nvme/host/ioctl.c                     |  118 +-
 drivers/nvme/host/multipath.c                 |   26 +
 drivers/nvme/host/nvme.h                      |   69 +-
 drivers/nvme/host/pci.c                       |  606 +++--
 drivers/nvme/host/rdma.c                      |   42 +-
 drivers/nvme/host/tcp.c                       |   45 +-
 drivers/nvme/target/admin-cmd.c               |   11 +-
 drivers/nvme/target/auth.c                    |    2 +
 drivers/nvme/target/configfs.c                |  138 +-
 drivers/nvme/target/core.c                    |   44 +-
 drivers/nvme/target/io-cmd-file.c             |   16 +-
 drivers/nvme/target/loop.c                    |   16 +-
 drivers/nvme/target/nvmet.h                   |    6 +-
 drivers/pci/p2pdma.c                          |  124 ++
 drivers/scsi/scsi_lib.c                       |    2 +-
 drivers/scsi/scsi_scan.c                      |    1 -
 drivers/ufs/core/ufshcd.c                     |    2 +
 fs/crypto/inline_crypt.c                      |   14 +-
 include/linux/bio.h                           |    2 -
 include/linux/blk-crypto-profile.h            |   12 -
 include/linux/blk-crypto.h                    |   13 +-
 include/linux/blk-mq.h                        |    9 +-
 include/linux/blk_types.h                     |    7 -
 include/linux/blkdev.h                        |   32 +-
 include/linux/lru_cache.h                     |    3 -
 include/linux/mempool.h                       |    5 +
 include/linux/mm.h                            |    3 +-
 include/linux/mmzone.h                        |   24 +
 include/linux/nvme.h                          |    2 +
 include/linux/pktcdvd.h                       |  197 --
 include/linux/raid/pq.h                       |    8 -
 include/linux/sbitmap.h                       |   16 +-
 include/linux/sed-opal.h                      |    3 +-
 include/linux/uio.h                           |    6 +
 include/linux/wait.h                          |    2 +-
 include/trace/events/iocost.h                 |    4 +-
 include/uapi/linux/pktcdvd.h                  |  112 -
 include/uapi/linux/sed-opal.h                 |    8 +-
 io_uring/rw.c                                 |    3 +-
 kernel/sched/wait.c                           |   18 +-
 kernel/trace/blktrace.c                       |    7 +-
 lib/iov_iter.c                                |   32 +-
 lib/lru_cache.c                               |   59 +-
 lib/raid6/algos.c                             |    2 -
 lib/sbitmap.c                                 |  144 +-
 lib/scatterlist.c                             |   25 +-
 mm/gup.c                                      |   45 +-
 mm/huge_memory.c                              |   19 +-
 mm/hugetlb.c                                  |   23 +-
 145 files changed, 3231 insertions(+), 5907 deletions(-)
 delete mode 100644 Documentation/ABI/testing/debugfs-pktcdvd
 delete mode 100644 Documentation/ABI/testing/sysfs-class-pktcdvd
 create mode 100644 drivers/block/drbd/drbd_polymorph_printk.h
 delete mode 100644 drivers/block/pktcdvd.c
 delete mode 100644 include/linux/pktcdvd.h
 delete mode 100644 include/uapi/linux/pktcdvd.h

-- 
Jens Axboe

