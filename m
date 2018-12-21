Return-Path: <SRS0=3SAf=O6=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6E4C43387
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 04:05:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A9E5F218F0
	for <linux-block@archiver.kernel.org>; Fri, 21 Dec 2018 04:04:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="0259qkcO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733167AbeLUEE7 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 20 Dec 2018 23:04:59 -0500
Received: from mail-pf1-f179.google.com ([209.85.210.179]:33214 "EHLO
        mail-pf1-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732492AbeLUEE6 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Thu, 20 Dec 2018 23:04:58 -0500
Received: by mail-pf1-f179.google.com with SMTP id c123so1947954pfb.0
        for <linux-block@vger.kernel.org>; Thu, 20 Dec 2018 20:04:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=YWR4Rfbt4e2N1ljgBSnFwXioUkDLY+XjngoctZs2I/0=;
        b=0259qkcOq1v+UCvRx3lRX8IdROpODbD944xdJYpMckQtFjaFwGTezp2M6exe5dgSam
         ymCImrjpEL8KqvZtB0MJ8mhOSJDf6y7KJLe/52HaAaczo8v0KvGUR0TLO5asFU2CXxCt
         psDBdRvP+tCf6wGk8jbz0qnuUykPmA4T6gF1hLikpiSxrBIqLdpg0Al0xMX1nDPhErlO
         qknfo5l2ABOf9/z8K7idqntQGTXnVSrHZdJ6KpWeFiihvo/AFbitn40hsXtJ1ArN3NxM
         +Z96nSyyWeGLEHPgGrmROLmAi/SWKzPmdQs7pT9B8GF+CeVNNJlnv+NIlxrBNJXs7icI
         2DqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=YWR4Rfbt4e2N1ljgBSnFwXioUkDLY+XjngoctZs2I/0=;
        b=YHZq+Ptia/rbLeuYNic47oYkVxIkL/y/220vv8McLApYp8+s4gNYsum+nd20HsHcDF
         6yMoU38DPdk1jA3/2QOEvEL4c6nTIPpFe6hhgPBW2Cw8RCvr1qXeCgGP3Hi/iPVXtr4H
         dylnAcYEZ9zwahklaCW3aCMbtqGbDA9QO8tUuHKhB8WL27XrS1FWmQ05E525xmOuclun
         3BcerT8zEU0FZLyEFpx+TP/9PobISrmpoF7jZRtCJnTxmF45YPtvMyXMnGfKHSz2EM4X
         l0WcUI8fVZWI7hKXA045DlfTbW5rdycAy7ELn09dtRvIawJRWYlI2Eh1zqdWUklVBoAH
         VW/g==
X-Gm-Message-State: AA+aEWasN76Q+ylK2O8yaZtCDsbKVyUBEc/tXOMBYDty4FGtPRZeOHQs
        SOh7ODVQLKeOW7EoVJzsNJ0i3TXT9Pjn6Q==
X-Google-Smtp-Source: AFSGD/XGSnoHsvFzBdAZSs36EfB1Z28+UncRq9l7b3tz1PCJ9w45r9x3dpliCMcNjmTkq34D/7+wfw==
X-Received: by 2002:a62:3141:: with SMTP id x62mr947887pfx.12.1545365094972;
        Thu, 20 Dec 2018 20:04:54 -0800 (PST)
Received: from [192.168.1.121] (66.29.188.166.static.utbb.net. [66.29.188.166])
        by smtp.gmail.com with ESMTPSA id k137sm35374241pfd.56.2018.12.20.20.04.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 20 Dec 2018 20:04:53 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block changes for 4.21-rc
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <84df20e9-00af-37e5-c37f-ad7ff2437073@kernel.dk>
Date:   Thu, 20 Dec 2018 21:04:50 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Sending this out a bit early to get this sorted for the holiday break.
This is the main pull request for block/storage for 4.21. Larger than
usual, it was a busy round with lots of goodies queued up. Most notable
is the removal of the old IO stack, which has been a long time coming.
No new features for a while, everything coming in this week has all
been fixes for things that were previously merged.

Note that I've pulled in 4.20-rc a few times to both resolve a few
conflicts, but mostly to get the important fixes that went into mainline
late in this series.

The IRQ changes are staged in Thomas's tree, but I pulled a branch from
him to get them in here as well, as the multiple queue maps feature
depends on it.

This pull request contains:

- Use atomic counters instead of semaphores for mtip32xx (Arnd)

- Cleanup of the mtip32xx request setup (Christoph)

- Fix for circular locking dependency in loop (Jan, Tetsuo)

- bcache (Coly, Guoju, Shenghui)
 - Optimizations for writeback caching
 - Various fixes and improvements

nvme (Chaitanya, Christoph, Sagi, Jay, me, Keith)
 - host and target support for NVMe over TCP
 - Error log page support
 - Support for separate read/write/poll queues
 - Much improved polling
 - discard OOM fallback
 - Tracepoint improvements

lightnvm (Hans, Hua, Igor, Matias, Javier)
 - Igor added packed metadata to pblk. Now drives without metadata
   per LBA can be used as well.
 - Fix from Geert on uninitialized value on chunk metadata reads.
 - Fixes from Hans and Javier to pblk recovery and write path.
 - Fix from Hua Su to fix a race condition in the pblk recovery code.
 - Scan optimization added to pblk recovery from Zhoujie.
 - Small geometry cleanup from me.

- Conversion of the last few drivers that used the legacy path to
  blk-mq (me)

- Removal of legacy IO path in SCSI (me, Christoph)

- Removal of legacy IO stack and schedulers (me)

- Support for much better polling, now without interrupts at all. blk-mq
  adds support for multiple queue maps, which enables us to have a map
  per type. This in turn enables nvme to have separate completion queues
  for polling, which can then be interrupt-less. Also means we're ready
  for async polled IO, which is hopefully coming in the next release.

- Killing of (now) unused block exports (Christoph)

- Unification of the blk-rq-qos and blk-wbt wait handling (Josef)

- Support for zoned testing with null_blk (Masato)

- sx8 conversion to per-host tag sets (Christoph)

- IO priority improvements (Damien)

- mq-deadline zoned fix (Damien)

- Ref count blkcg series (Dennis)

- Lots of blk-mq improvements and speedups (me)

- sbitmap scalability improvements (me)

- Make core inflight IO accounting per-cpu (Mikulas)

- Export timeout setting in sysfs (Weiping)

- Cleanup the direct issue path (Jianchao)

- Export blk-wbt internals in block debugfs for easier debugging (Ming)

- Lots of other fixes and improvements

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-4.21/block-20181221


----------------------------------------------------------------
Arnd Bergmann (1):
      mtip32xx: avoid using semaphores

Balbir Singh (1):
      block: add cmd_flags to print_req_error

Chaitanya Kulkarni (17):
      nvme: consolidate memset calls in the nvme_setup_cmd path
      nvmet: use IOCB_NOWAIT for file-ns buffered I/O
      nvmet: use unlikely for req status check
      nvmet: fix the structure member indentation
      nvme: remove nvme_common command cdw10 array
      nvme: add error log page slot definition
      nvmet: add error-log definitions
      nvmet: add interface to update error-log page
      nvmet: add error log support in the core
      nvmet: add error log support for fabrics-cmd
      nvmet: add error log support for rdma backend
      nvmet: add error log support for admin-cmd
      nvmet: add error log support for bdev backend
      nvmet: add error log support for file backend
      nvmet: add error log page cmd handler
      nvmet: update smart log with num err log entries
      nvmet: use a macro for default error location

Chengguang Xu (3):
      nvme: add __exit annotation
      aoe: add __exit annotation
      block: loop: check error using IS_ERR instead of IS_ERR_OR_NULL in loop_add()

Christoph Hellwig (76):
      sx8: cleanup queue and disk allocation / freeing
      sx8: use a per-host tag_set
      mtip32xx: move the blk_rq_map_sg call to mtip_hw_submit_io
      mtip32xx: merge mtip_submit_request into mtip_queue_rq
      mtip32xx: return a blk_status_t from mtip_send_trim
      mtip32xx: remove __force_bit2int
      mtip32xx: add missing endianess annotations on struct smart_attr
      mtip32xx: remove mtip_init_cmd_header
      mtip32xx: remove mtip_get_int_command
      mtip32xx: don't use req->special
      mtip32xxx: use for_each_sg
      block: remove req->timeout_list
      ide: cleanup ->prep_rq calling convention
      scsi: simplify scsi_prep_state_check
      scsi: push blk_status_t up into scsi_setup_{fs,scsi}_cmnd
      scsi: clean up error handling in scsi_init_io
      scsi: return blk_status_t from scsi_init_io and ->init_command
      scsi: return blk_status_t from device handler ->prep_fn
      block: remove the BLKPREP_* values.
      fnic: fix fnic_scsi_host_{start,end}_tag
      nullb: remove leftover legacy request code
      skd_main: don't use req->special
      aoe: replace ->special use with private data in the request
      pd: replace ->special use with private data in the request
      ide: don't use req->special
      block: remove QUEUE_FLAG_BYPASS and ->bypass
      block: remove deadline __deadline manipulation helpers
      block: don't hold the queue_lock over blk_abort_request
      block: use atomic bitops for ->queue_flags
      block: remove queue_lockdep_assert_held
      block: remove the unused lock argument to rq_qos_throttle
      block: update a few comments for the legacy request removal
      block: remove a few unused exports
      blk-cgroup: consolidate error handling in blkcg_init_queue
      blk-cgroup: move locking into blkg_destroy_all
      drbd: don't override the queue_lock
      umem: don't override the queue_lock
      mmc: simplify queue initialization
      mmc: stop abusing the request queue_lock pointer
      block: remove the lock argument to blk_alloc_queue_node
      block: remove the queue_lock indirection
      block: remove the rq_alloc_data request_queue field
      floppy: remove queue_lock around floppy_end_request
      pktcdvd: remove queue_lock around blk_queue_max_hw_sectors
      ide: don't acquire queue lock in ide_pm_execute_rq
      ide: don't acquire queue_lock in ide_complete_pm_rq
      mmc: stop abusing the request queue_lock pointer
      block: avoid extra bio reference for async O_DIRECT
      aio: clear IOCB_HIPRI
      block: move queues types to the block layer
      nvme-pci: use atomic bitops to mark a queue enabled
      nvme-pci: cleanup SQ allocation a bit
      nvme-pci: only allow polling with separate poll queues
      nvme-pci: consolidate code for polling non-dedicated queues
      nvme-pci: refactor nvme_disable_io_queues
      nvme-pci: don't poll from irq context when deleting queues
      nvme-pci: remove the CQ lock for interrupt driven queues
      nvme-rdma: remove I/O polling support
      nvme-mpath: remove I/O polling support
      block: remove ->poll_fn
      block: only allow polling if a poll queue_map exists
      block: enable polling by default if a poll map is initalized
      nvmet: mark nvmet_genctr static
      block: remove the bio_phys_segments export
      block: remove the blk_recount_segments export
      block: remove the unused bio_iov_iter_get_pages export
      block: remove the unused bio_set_pages_dirty and bio_check_pages_dirty exports
      block: remove the bioset_integrity_free export
      block: remove the bio_integrity_advance export
      block: clear REQ_HIPRI if polling is not supported
      blk-mq: only dispatch to non-defauly queue maps if they have queues
      nvme-pci: don't share queue maps
      nvme-pci: only set nr_maps to 2 if poll queues are supported
      nvme-pci: refactor nvme_poll_irqdisable to make sparse happy
      nvmet-tcp: fix endianess annotations
      nvme-tcp: fix endianess annotations

Colin Ian King (4):
      ms_block: remove unused pointer 'set'
      block: clean up dead code that is now redundant
      nvmet: fix comparison of a u16 with -1
      nvme-tcp: fix spelling mistake "attepmpt" -> "attempt"

Coly Li (5):
      bcache: introduce force_wake_up_gc()
      bcache: option to automatically run gc thread after writeback
      bcache: add MODULE_DESCRIPTION information
      bcache: make cutoff_writeback and cutoff_writeback_sync tunable
      bcache: set writeback_percent in a flexible range

Damien Le Moal (8):
      aio: Comment use of IOCB_FLAG_IOPRIO aio flag
      block: Remove bio->bi_ioc
      block: Introduce get_current_ioprio()
      aio: Fix fallback I/O priority value
      block: prevent merging of requests with different priorities
      block: Initialize BIO I/O priority early
      block: update sysfs documentation
      block: mq-deadline: Fix write completion handling

Dan Carpenter (3):
      ataflop: fix error handling in atari_floppy_init()
      blk-mq: Add a NULL check in blk_mq_free_map_and_requests()
      scsi: Fix a harmless double shift bug

Dennis Zhou (17):
      blkcg: fix ref count issue with bio_blkcg() using task_css
      blkcg: update blkg_lookup_create() to do locking
      blkcg: convert blkg_lookup_create() to find closest blkg
      blkcg: introduce common blkg association logic
      dm: set the static flush bio device on demand
      blkcg: associate blkg when associating a device
      blkcg: consolidate bio_issue_init() to be a part of core
      blkcg: associate a blkg for pages being evicted by swap
      blkcg: associate writeback bios with a blkg
      blkcg: remove bio->bi_css and instead use bio->bi_blkg
      blkcg: remove additional reference to the css
      blkcg: remove bio_disassociate_task()
      blkcg: change blkg reference counting to use percpu_ref
      blkcg: rename blkg_try_get() to blkg_tryget()
      blkcg: put back rcu lock in blkcg_bio_issue_check()
      blkcg: handle dying request_queue when associating a blkg
      block: fix blk-iolatency accounting underflow

Eric Biggers (1):
      block: make blk_try_req_merge() static

Geert Uytterhoeven (1):
      lightnvm: Fix uninitialized return value in nvm_get_chunk_meta()

Guoju Fang (1):
      bcache: print number of keys in trace_bcache_journal_write

Hannes Reinecke (1):
      nvme: add a numa_node field to struct nvme_ctrl

Hans Holmberg (8):
      lightnvm: pblk: fix chunk close trace event check
      lightnvm: pblk: fix resubmission of overwritten write err lbas
      lightnvm: pblk: account for write error sectors in emeta
      lightnvm: pblk: stop writes gracefully when running out of lines
      lightnvm: pblk: set conservative threshold for user writes
      lightnvm: pblk: remove unused macro
      lightnvm: pblk: fix pblk_lines_init error handling path
      lightnvm: pblk: remove dead code in pblk_recov_l2p

Hua Su (2):
      lightnvm: pblk: fix spelling in comment
      lightnvm: pblk: add lock protection to list operations

Igor Konopko (6):
      lightnvm: pblk: move lba list to partial read context
      lightnvm: pblk: add helpers for OOB metadata
      lightnvm: dynamic DMA pool entry size
      lightnvm: disable interleaved metadata
      lightnvm: pblk: support packed metadata
      lightnvm: pblk: do not overwrite ppa list with meta list

Israel Rukshin (3):
      nvme: Remove unused forward declaration
      nvmet-rdma: Add unlikely for response allocated check
      nvme: remove unused function nvme_ctrl_ready

James Smart (1):
      nvmet-fc: remove the IN_ISR deferred scheduling options

Jan Kara (14):
      loop: Fold __loop_release into loop_release
      loop: Get rid of loop_index_mutex
      loop: Push lo_ctl_mutex down into individual ioctls
      loop: Split setting of lo_state from loop_clr_fd
      loop: Push loop_ctl_mutex down into loop_clr_fd()
      loop: Push loop_ctl_mutex down to loop_get_status()
      loop: Push loop_ctl_mutex down to loop_set_status()
      loop: Push loop_ctl_mutex down to loop_set_fd()
      loop: Push loop_ctl_mutex down to loop_change_fd()
      loop: Move special partition reread handling in loop_clr_fd()
      loop: Move loop_reread_partitions() out of loop_ctl_mutex
      loop: Fix deadlock when calling blkdev_reread_part()
      loop: Avoid circular locking dependency between loop_ctl_mutex and bd_mutex
      loop: Get rid of 'nested' acquisition of loop_ctl_mutex

Javier González (2):
      lightnvm: pblk: add comments wrt locking in recovery path
      lightnvm: pblk: avoid ref warning on cache creation

Jay Sternberg (7):
      nvmet: provide aen bit functions for multiple controller types
      nvmet: change aen mask functions to use bit numbers
      nvmet: allow Keep Alive for Discovery controller
      nvmet: make kato and AEN processing for use by other controllers
      nvmet: add defines for discovery change async events
      nvmet: add support to Discovery controllers for commands
      nvmet: enable Discovery Controller AENs

Jens Axboe (108):
      genirq/affinity: Add support for allocating interrupt sets
      sunvdc: convert to blk-mq
      ms_block: convert to blk-mq
      mspro_block: convert to blk-mq
      ide: convert to blk-mq
      blk-mq: remove the request_list usage
      blk-mq: remove legacy check in queue blk_freeze_queue()
      blk-mq: provide mq_ops->busy() hook
      scsi: provide mq_ops->busy() hook
      scsi: kill off the legacy IO path
      block: remove q->lld_busy_fn()
      dasd: remove dead code
      bsg: pass in desired timeout handler
      bsg: provide bsg_remove_queue() helper
      bsg: convert to use blk-mq
      block: remove blk_complete_request()
      blk-wbt: kill check for legacy queue type
      blk-cgroup: remove legacy queue bypassing
      block: remove legacy rq tagging
      block: remove non mq parts from the flush code
      block: cleanup kick/queued handling
      block: remove legacy IO schedulers
      block: remove dead elevator code
      block: get rid of MQ scheduler ops union
      block: remove __blk_put_request()
      block: kill legacy parts of timeout handling
      bsg: move bsg-lib parts outside of request queue
      block: remove request_list code
      block: kill request slab cache
      block: remove req_no_special_merge() from merging code
      blk-merge: kill dead queue lock held check
      block: get rid of blk_queued_rq()
      block: get rid of q->softirq_done_fn()
      block: kill request ->cpu member
      Merge branch 'irq/for-block' of git://git.kernel.org/.../tip/tip into for-4.21/block
      blk-mq: kill q->mq_map
      blk-mq: abstract out queue map
      blk-mq: provide dummy blk_mq_map_queue_type() helper
      blk-mq: pass in request/bio flags to queue mapping
      blk-mq: allow software queue to map to multiple hardware queues
      blk-mq: add 'type' attribute to the sysfs hctx directory
      blk-mq: support multiple hctx maps
      blk-mq: separate number of hardware queues from nr_cpu_ids
      blk-mq: cache request hardware queue mapping
      blk-mq: cleanup and improve list insertion
      blk-mq: improve plug list sorting
      blk-mq: initial support for multiple queue maps
      nvme: utilize two queue maps, one for reads and one for writes
      block: add REQ_HIPRI and inherit it from IOCB_HIPRI
      nvme: add separate poll queue map
      sunvdc: fix compiler warning
      blk-mq-tag: change busy_iter_fn to return whether to continue or not
      blk-mq: provide a helper to check if a queue is busy
      blk-mq-tag: document tag iteration helper return value
      null_blk: remove unused nullb device
      ide: don't clear special on ide_queue_rq() entry
      nvme: fix boot hang with only being able to get one IRQ vector
      block: remove dead queue members
      block: add wbt_disable_default export for BFQ
      nvme: fix handling of EINVAL on pci_alloc_irq_vectors_affinity()
      ide: clear ide_req()->special for non-passthrough requests
      nvme: provide optimized poll function for separate poll queues
      block: add queue_is_mq() helper
      blk-rq-qos: inline check for q->rq_qos functions
      block: add polled wakeup task helper
      block: for async O_DIRECT, mark us as polling if asked to
      block: don't plug for aio/O_DIRECT HIPRI IO
      floppy: remove now unused 'flags' variable
      Merge tag 'v4.20-rc3' into for-4.21/block
      nvme: default to 0 poll queues
      block: avoid ordered task state change for polled IO
      block: have ->poll_fn() return number of entries polled
      nvme-fc: remove ->poll implementation
      block: fix attempt to assign NULL io_context
      blk-mq: when polling for IO, look for any completion
      blk-mq: remove 'tag' parameter from mq_ops->poll()
      nvme: remove opportunistic polling from bdev target
      block: make blk_poll() take a parameter on whether to spin or not
      blk-mq: ensure mq_ops ->poll() is entered at least once
      blk-mq: never redirect polled IO completions
      block: sum requests in the plug structure
      blk-mq: fix failure to decrement plug count on single rq removal
      block: improve logic around when to sort a plug list
      blk-mq: add mq_ops->commit_rqs()
      nvme: implement mq_ops->commit_rqs() hook
      virtio_blk: implement mq_ops->commit_rqs() hook
      ataflop: implement mq_ops->commit_rqs() hook
      blk-mq: use bd->last == true for list inserts
      blk-mq: use plug for devices that implement ->commits_rqs()
      sbitmap: don't loop for find_next_zero_bit() for !round_robin
      sbitmap: ammortize cost of clearing bits
      sbitmap: optimize wakeup check
      blk-mq: don't call ktime_get_ns() if we don't need it
      Merge tag 'v4.20-rc5' into for-4.21/block
      blk-mq: remove QUEUE_FLAG_POLL from default MQ flags
      sbitmap: silence bogus lockdep IRQ warning
      Merge tag 'v4.20-rc6' into for-4.21/block
      mtip32xx: use BLK_STS_DEV_RESOURCE for device resources
      dm: fix inflight IO check
      nvme: fix irq vs io_queue calculations
      sbitmap: flush deferred clears for resize and shallow gets
      nvme: provide fallback for discard alloc failure
      Merge branch 'nvme-4.21' of git://git.infradead.org/nvme into for-4.21/block
      blk-mq: change blk_mq_queue_busy() to blk_mq_queue_inflight()
      Merge branch 'nvme-4.21' of git://git.infradead.org/nvme into for-4.21/block
      dm: don't reuse bio for flushes
      sbitmap: add helpers for add/del wait queue handling
      kyber: use sbitmap add_wait_queue/list_del wait helpers

Jianchao Wang (3):
      blk-mq: refactor the code of issue request directly
      blk-mq: issue directly with bypass 'false' in blk_mq_sched_insert_requests
      blk-mq: replace and kill blk_mq_request_issue_directly

Josef Bacik (3):
      block: add rq_qos_wait to rq_qos
      block: convert wbt_wait() to use rq_qos_wait()
      block: convert io-latency to use rq_qos_wait

Keith Busch (4):
      blk-mq: Return true if request was completed
      scsi: Do not rely on blk-mq for double completions
      blk-mq: Simplify request completion state
      nvme: implement Enhanced Command Retry

Long Li (1):
      genirq/affinity: Spread IRQs to all available NUMA nodes

Masato Suzuki (1):
      null_blk: Add conventional zone configuration for zoned support

Matias Bjørling (1):
      lightnvm: simplify geometry enumeration

Mike Snitzer (3):
      dm rq: leverage blk_mq_queue_busy() to check for outstanding IO
      block: stop passing 'cpu' to all percpu stats methods
      dm: fix request-based dm's use of dm_wait_for_completion

Mikulas Patocka (5):
      dm: dont rewrite dm_disk(md)->part0.in_flight
      block: delete part_round_stats and switch to less precise counting
      block: switch to per-cpu in-flight counters
      block: return just one value from part_in_flight
      dm: remove the pending IO accounting

Ming Lei (13):
      genirq/affinity: Move two stage affinity spreading into a helper function
      genirq/affinity: Pass first vector to __irq_build_affinity_masks()
      blk-mq: not embed .mq_kobj and ctx->kobj into queue instance
      blk-mq: re-build queue map in case of kdump kernel
      block: deactivate blk_stat timer in wbt_disable_default()
      blk-mq-debugfs: support rq_qos
      blk-wbt: export internal state via debugfs
      blk-mq: fix allocation for queue mapping table
      blk-mq: export hctx->type in debugfs instead of sysfs
      blk-mq: fix dispatch from sw queue
      blk-mq: skip zero-queue maps in blk_mq_map_swqueue
      blk-mq: enable IO poll if .nr_queues of type poll > 0
      block: save irq state in blkg_lookup_create()

Omar Sandoval (1):
      sbitmap: fix sbitmap_for_each_set()

Sagi Grimberg (34):
      nvme: introduce ctrl attributes enumeration
      nvme: cache controller attributes
      nvme: support traffic based keep-alive
      nvmet: support for traffic based keep-alive
      nvmet: allow host connect even if no allowed subsystems are exported
      nvmet: support fabrics sq flow control
      nvmet: don't override treq upon modification.
      nvmet: expose support for fabrics SQ flow control disable in treq
      nvme: disable fabrics SQ flow control when asked by the user
      ath6kl: add ath6kl_ prefix to crypto_type
      datagram: open-code copy_page_to_iter
      iov_iter: pass void csum pointer to csum_and_copy_to_iter
      datagram: consolidate datagram copy to iter helpers
      iov_iter: introduce hash_and_copy_to_iter helper
      datagram: introduce skb_copy_and_hash_datagram_iter helper
      nvmet: Add install_queue callout
      nvme-fabrics: allow user passing header digest
      nvme-fabrics: allow user passing data digest
      nvme-tcp: Add protocol header
      nvmet-tcp: add NVMe over TCP target driver
      nvmet: allow configfs tcp trtype configuration
      nvme-tcp: add NVMe over TCP host driver
      nvmet: remove unused variable
      blk-mq-rdma: pass in queue map to blk_mq_rdma_map_queues
      nvme-fabrics: add missing nvmf_ctrl_options documentation
      nvme-fabrics: allow user to set nr_write_queues for separate queue maps
      nvme-tcp: support separate queue maps for read and write
      nvme-rdma: support separate queue maps for read and write
      nvme: fix kernel paging oops
      block: make request_to_qc_t public
      nvme-core: optionally poll sync commands
      nvme-fabrics: allow nvmf_connect_io_queue to poll
      nvme-fabrics: allow user to pass in nr_poll_queues
      nvme-rdma: implement polling queue map

Shenghui Wang (6):
      bcache: add comment for cache_set->fill_iter
      bcache: do not check if debug dentry is ERR or NULL explicitly on remove
      bcache: update comment for bch_data_insert
      bcache: update comment in sysfs.c
      bcache: do not mark writeback_running too early
      bcache: cannot set writeback_running via sysfs if no writeback kthread created

Tetsuo Handa (3):
      block/loop: Don't grab "struct file" for vfs_getattr() operation.
      block/loop: Use global lock for ioctl() operation.
      loop: Fix double mutex_unlock(&loop_ctl_mutex) in loop_control_ioctl()

Weiping Zhang (1):
      block: add io timeout to sysfs

Young Xiao (1):
      sunvdc: Do not spin in an infinite loop when vio_ldc_send() returns EAGAIN

YueHaibing (1):
      block: remove set but not used variable 'et'

Yufen Yu (1):
      block: use rcu_work instead of call_rcu to avoid sleep in softirq

Zhoujie Wu (1):
      lightnvm: pblk: ignore the smeta oob area scan

yupeng (1):
      nvme-pci: trace SQ status on completions

 Documentation/ABI/testing/sysfs-block       |   12 +-
 Documentation/admin-guide/cgroup-v2.rst     |    8 +-
 Documentation/block/biodoc.txt              |   88 -
 Documentation/block/cfq-iosched.txt         |  291 --
 Documentation/block/queue-sysfs.txt         |   29 +-
 Documentation/scsi/scsi-parameters.txt      |    5 -
 block/Kconfig                               |    6 -
 block/Kconfig.iosched                       |   61 -
 block/Makefile                              |    5 +-
 block/bfq-cgroup.c                          |    6 +-
 block/bfq-iosched.c                         |   21 +-
 block/bio-integrity.c                       |    2 -
 block/bio.c                                 |  202 +-
 block/blk-cgroup.c                          |  272 +-
 block/blk-core.c                            | 2278 +------------
 block/blk-exec.c                            |   20 +-
 block/blk-flush.c                           |  188 +-
 block/blk-ioc.c                             |   54 +-
 block/blk-iolatency.c                       |   75 +-
 block/blk-merge.c                           |   53 +-
 block/blk-mq-cpumap.c                       |   19 +-
 block/blk-mq-debugfs.c                      |  147 +-
 block/blk-mq-debugfs.h                      |   17 +
 block/blk-mq-pci.c                          |   10 +-
 block/blk-mq-rdma.c                         |    8 +-
 block/blk-mq-sched.c                        |   82 +-
 block/blk-mq-sched.h                        |   25 +-
 block/blk-mq-sysfs.c                        |   35 +-
 block/blk-mq-tag.c                          |   41 +-
 block/blk-mq-virtio.c                       |    8 +-
 block/blk-mq.c                              |  757 +++--
 block/blk-mq.h                              |   70 +-
 block/blk-pm.c                              |   20 +-
 block/blk-pm.h                              |    6 +-
 block/blk-rq-qos.c                          |  154 +-
 block/blk-rq-qos.h                          |   96 +-
 block/blk-settings.c                        |   65 +-
 block/blk-softirq.c                         |   27 +-
 block/blk-stat.c                            |    4 -
 block/blk-stat.h                            |    5 +
 block/blk-sysfs.c                           |  107 +-
 block/blk-tag.c                             |  378 --
 block/blk-throttle.c                        |   39 +-
 block/blk-timeout.c                         |  117 +-
 block/blk-wbt.c                             |  176 +-
 block/blk-zoned.c                           |    2 +-
 block/blk.h                                 |  188 +-
 block/bounce.c                              |    3 +-
 block/bsg-lib.c                             |  146 +-
 block/bsg.c                                 |    2 +-
 block/cfq-iosched.c                         | 4916 ---------------------------
 block/deadline-iosched.c                    |  560 ---
 block/elevator.c                            |  477 +--
 block/genhd.c                               |   63 +-
 block/kyber-iosched.c                       |   37 +-
 block/mq-deadline.c                         |   15 +-
 block/noop-iosched.c                        |  124 -
 block/partition-generic.c                   |   18 +-
 drivers/ata/libata-eh.c                     |    4 -
 drivers/block/aoe/aoe.h                     |    4 +
 drivers/block/aoe/aoeblk.c                  |    1 +
 drivers/block/aoe/aoecmd.c                  |   27 +-
 drivers/block/aoe/aoedev.c                  |   11 +-
 drivers/block/aoe/aoemain.c                 |    2 +-
 drivers/block/ataflop.c                     |   26 +-
 drivers/block/drbd/drbd_main.c              |    2 +-
 drivers/block/floppy.c                      |    6 -
 drivers/block/loop.c                        |  415 ++-
 drivers/block/loop.h                        |    1 -
 drivers/block/mtip32xx/mtip32xx.c           |  226 +-
 drivers/block/mtip32xx/mtip32xx.h           |   48 +-
 drivers/block/nbd.c                         |    3 +-
 drivers/block/null_blk.h                    |    1 +
 drivers/block/null_blk_main.c               |   21 +-
 drivers/block/null_blk_zoned.c              |   27 +-
 drivers/block/paride/pd.c                   |   30 +-
 drivers/block/pktcdvd.c                     |    2 -
 drivers/block/skd_main.c                    |   16 +-
 drivers/block/sunvdc.c                      |  153 +-
 drivers/block/sx8.c                         |  434 +--
 drivers/block/umem.c                        |    3 +-
 drivers/block/virtio_blk.c                  |   17 +-
 drivers/ide/ide-atapi.c                     |   27 +-
 drivers/ide/ide-cd.c                        |  179 +-
 drivers/ide/ide-devsets.c                   |    4 +-
 drivers/ide/ide-disk.c                      |   15 +-
 drivers/ide/ide-eh.c                        |    2 +-
 drivers/ide/ide-floppy.c                    |    2 +-
 drivers/ide/ide-io.c                        |  112 +-
 drivers/ide/ide-park.c                      |    8 +-
 drivers/ide/ide-pm.c                        |   46 +-
 drivers/ide/ide-probe.c                     |   69 +-
 drivers/ide/ide-tape.c                      |    2 +-
 drivers/ide/ide-taskfile.c                  |    2 +-
 drivers/lightnvm/core.c                     |   25 +-
 drivers/lightnvm/pblk-core.c                |   77 +-
 drivers/lightnvm/pblk-init.c                |  103 +-
 drivers/lightnvm/pblk-map.c                 |   63 +-
 drivers/lightnvm/pblk-rb.c                  |    5 +-
 drivers/lightnvm/pblk-read.c                |   66 +-
 drivers/lightnvm/pblk-recovery.c            |   46 +-
 drivers/lightnvm/pblk-rl.c                  |    5 +-
 drivers/lightnvm/pblk-sysfs.c               |    7 +
 drivers/lightnvm/pblk-write.c               |   64 +-
 drivers/lightnvm/pblk.h                     |   43 +-
 drivers/md/bcache/bcache.h                  |   20 +-
 drivers/md/bcache/btree.c                   |    5 +
 drivers/md/bcache/btree.h                   |   18 +
 drivers/md/bcache/debug.c                   |    3 +-
 drivers/md/bcache/journal.c                 |    2 +-
 drivers/md/bcache/request.c                 |    6 +-
 drivers/md/bcache/super.c                   |   48 +-
 drivers/md/bcache/sysfs.c                   |   61 +-
 drivers/md/bcache/writeback.c               |   30 +-
 drivers/md/bcache/writeback.h               |   12 +-
 drivers/md/dm-core.h                        |    5 -
 drivers/md/dm-rq.c                          |    7 +-
 drivers/md/dm-table.c                       |    4 +-
 drivers/md/dm.c                             |   79 +-
 drivers/md/md.c                             |    7 +-
 drivers/md/raid0.c                          |    2 +-
 drivers/memstick/core/ms_block.c            |  109 +-
 drivers/memstick/core/ms_block.h            |    1 +
 drivers/memstick/core/mspro_block.c         |  121 +-
 drivers/mmc/core/block.c                    |   26 +-
 drivers/mmc/core/queue.c                    |  110 +-
 drivers/mmc/core/queue.h                    |    4 +-
 drivers/net/wireless/ath/ath6kl/cfg80211.c  |    2 +-
 drivers/net/wireless/ath/ath6kl/common.h    |    2 +-
 drivers/net/wireless/ath/ath6kl/wmi.c       |    6 +-
 drivers/net/wireless/ath/ath6kl/wmi.h       |    6 +-
 drivers/nvdimm/pmem.c                       |    2 +-
 drivers/nvme/host/Kconfig                   |   15 +
 drivers/nvme/host/Makefile                  |    3 +
 drivers/nvme/host/core.c                    |  191 +-
 drivers/nvme/host/fabrics.c                 |   61 +-
 drivers/nvme/host/fabrics.h                 |   17 +-
 drivers/nvme/host/fc.c                      |   43 +-
 drivers/nvme/host/lightnvm.c                |   33 +-
 drivers/nvme/host/multipath.c               |   20 +-
 drivers/nvme/host/nvme.h                    |   24 +-
 drivers/nvme/host/pci.c                     |  518 ++-
 drivers/nvme/host/rdma.c                    |  119 +-
 drivers/nvme/host/tcp.c                     | 2278 +++++++++++++
 drivers/nvme/host/trace.c                   |    3 +
 drivers/nvme/host/trace.h                   |   27 +-
 drivers/nvme/target/Kconfig                 |   10 +
 drivers/nvme/target/Makefile                |    2 +
 drivers/nvme/target/admin-cmd.c             |  146 +-
 drivers/nvme/target/configfs.c              |   43 +-
 drivers/nvme/target/core.c                  |  220 +-
 drivers/nvme/target/discovery.c             |  139 +-
 drivers/nvme/target/fabrics-cmd.c           |   64 +-
 drivers/nvme/target/fc.c                    |   66 +-
 drivers/nvme/target/io-cmd-bdev.c           |   89 +-
 drivers/nvme/target/io-cmd-file.c           |  165 +-
 drivers/nvme/target/loop.c                  |    2 +-
 drivers/nvme/target/nvmet.h                 |   68 +-
 drivers/nvme/target/rdma.c                  |   12 +-
 drivers/nvme/target/tcp.c                   | 1737 ++++++++++
 drivers/pci/msi.c                           |   14 +
 drivers/s390/block/dasd_ioctl.c             |   22 +-
 drivers/scsi/Kconfig                        |   12 -
 drivers/scsi/bnx2i/bnx2i_hwi.c              |    8 +-
 drivers/scsi/csiostor/csio_scsi.c           |    8 +-
 drivers/scsi/cxlflash/main.c                |    6 -
 drivers/scsi/device_handler/scsi_dh_alua.c  |   21 +-
 drivers/scsi/device_handler/scsi_dh_emc.c   |    8 +-
 drivers/scsi/device_handler/scsi_dh_hp_sw.c |    7 +-
 drivers/scsi/device_handler/scsi_dh_rdac.c  |    7 +-
 drivers/scsi/fnic/fnic_scsi.c               |    4 +-
 drivers/scsi/hosts.c                        |   29 +-
 drivers/scsi/libsas/sas_ata.c               |    5 -
 drivers/scsi/libsas/sas_scsi_host.c         |   10 +-
 drivers/scsi/lpfc/lpfc_scsi.c               |    2 +-
 drivers/scsi/osd/osd_initiator.c            |    4 +-
 drivers/scsi/osst.c                         |    2 +-
 drivers/scsi/qedi/qedi_main.c               |    3 +-
 drivers/scsi/qla2xxx/qla_nvme.c             |   12 -
 drivers/scsi/qla2xxx/qla_os.c               |   37 +-
 drivers/scsi/scsi.c                         |    5 +-
 drivers/scsi/scsi_debug.c                   |    3 +-
 drivers/scsi/scsi_error.c                   |   24 +-
 drivers/scsi/scsi_lib.c                     |  806 +----
 drivers/scsi/scsi_priv.h                    |    1 -
 drivers/scsi/scsi_scan.c                    |   10 +-
 drivers/scsi/scsi_sysfs.c                   |    8 +-
 drivers/scsi/scsi_transport_fc.c            |   71 +-
 drivers/scsi/scsi_transport_iscsi.c         |    7 +-
 drivers/scsi/scsi_transport_sas.c           |   10 +-
 drivers/scsi/sd.c                           |   85 +-
 drivers/scsi/sd.h                           |    6 +-
 drivers/scsi/sd_zbc.c                       |   10 +-
 drivers/scsi/sg.c                           |    2 +-
 drivers/scsi/smartpqi/smartpqi_init.c       |    3 +-
 drivers/scsi/sr.c                           |   12 +-
 drivers/scsi/st.c                           |    2 +-
 drivers/scsi/ufs/ufs_bsg.c                  |    4 +-
 drivers/scsi/virtio_scsi.c                  |    3 +-
 drivers/target/iscsi/iscsi_target_util.c    |   12 +-
 drivers/target/target_core_pscsi.c          |    2 +-
 fs/aio.c                                    |   13 +-
 fs/block_dev.c                              |   50 +-
 fs/buffer.c                                 |   10 +-
 fs/direct-io.c                              |    4 +-
 fs/ext4/page-io.c                           |    2 +-
 fs/iomap.c                                  |   16 +-
 include/linux/bio.h                         |   29 +-
 include/linux/blk-cgroup.h                  |  227 +-
 include/linux/blk-mq-pci.h                  |    4 +-
 include/linux/blk-mq-rdma.h                 |    2 +-
 include/linux/blk-mq-virtio.h               |    4 +-
 include/linux/blk-mq.h                      |   83 +-
 include/linux/blk_types.h                   |   24 +-
 include/linux/blkdev.h                      |  250 +-
 include/linux/bsg-lib.h                     |    6 +-
 include/linux/cgroup.h                      |    2 +
 include/linux/elevator.h                    |   94 +-
 include/linux/fs.h                          |    2 +-
 include/linux/genhd.h                       |   57 +-
 include/linux/ide.h                         |   14 +-
 include/linux/init.h                        |    1 -
 include/linux/interrupt.h                   |    4 +
 include/linux/ioprio.h                      |   13 +
 include/linux/lightnvm.h                    |    3 +-
 include/linux/nvme-fc-driver.h              |   17 -
 include/linux/nvme-tcp.h                    |  189 +
 include/linux/nvme.h                        |   73 +-
 include/linux/sbitmap.h                     |   89 +-
 include/linux/skbuff.h                      |    3 +
 include/linux/uio.h                         |    5 +-
 include/linux/writeback.h                   |    5 +-
 include/scsi/scsi_cmnd.h                    |    6 +-
 include/scsi/scsi_dh.h                      |    2 +-
 include/scsi/scsi_driver.h                  |    3 +-
 include/scsi/scsi_host.h                    |   18 +-
 include/scsi/scsi_tcq.h                     |   14 +-
 include/trace/events/bcache.h               |   27 +-
 include/uapi/linux/aio_abi.h                |    2 +
 init/do_mounts_initrd.c                     |    3 -
 init/initramfs.c                            |    6 -
 init/main.c                                 |   12 -
 kernel/cgroup/cgroup.c                      |   48 +-
 kernel/irq/affinity.c                       |  148 +-
 kernel/trace/blktrace.c                     |    4 +-
 lib/iov_iter.c                              |   19 +-
 lib/sbitmap.c                               |  170 +-
 mm/page_io.c                                |    9 +-
 net/core/datagram.c                         |  159 +-
 249 files changed, 10663 insertions(+), 14494 deletions(-)
 delete mode 100644 Documentation/block/cfq-iosched.txt
 delete mode 100644 block/blk-tag.c
 delete mode 100644 block/cfq-iosched.c
 delete mode 100644 block/deadline-iosched.c
 delete mode 100644 block/noop-iosched.c
 create mode 100644 drivers/nvme/host/tcp.c
 create mode 100644 drivers/nvme/target/tcp.c
 create mode 100644 include/linux/nvme-tcp.h

-- 
Jens Axboe

