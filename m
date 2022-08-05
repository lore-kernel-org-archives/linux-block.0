Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 17CE7C19F2D
	for <linux-block@archiver.kernel.org>; Fri,  5 Aug 2022 02:45:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236642AbiHECpG (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Thu, 4 Aug 2022 22:45:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236906AbiHECpE (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Thu, 4 Aug 2022 22:45:04 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D44D71722
        for <linux-block@vger.kernel.org>; Thu,  4 Aug 2022 19:45:02 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id bf13so1511923pgb.11
        for <linux-block@vger.kernel.org>; Thu, 04 Aug 2022 19:45:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:from:to:cc;
        bh=zDTb5g8Zwt3f56UvKa+2PAFj0rp3/8bMDAifz9FWj9o=;
        b=2Rhgk29ZAQufxNVIkICVyntuO83SbCw2CQ3IZMtb/aTd6gMwrTKC6LEB3O3ab9VHPz
         ij0ZA/6uOOZl0xJv16J+/1vkCFn2YNkH2v2KxnMaLBhx6apMF0kJ4QHiNgHx3jJzb7Yw
         eNFZOCKLCOKYjgqNFjjE+pdDKZvpsUubpAdQeD+veH3NCa1cHJ9HdVPYdIzGTkni/yz3
         ddZC/WzIzpp99Q4jIatQsV0XdRPdMRMDfOUxOuOKGrhujRxOdFoUpbNTSfR7rKFn4yAb
         ulantx0gSiNYTFAzo/R5wT+1MqfriNmBTdeXnZmIhNJKQ8FOPz4WHjkHhC1KETHww83C
         dpJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:cc:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc;
        bh=zDTb5g8Zwt3f56UvKa+2PAFj0rp3/8bMDAifz9FWj9o=;
        b=s/0eAK6ZTGEqnLfJsBGtjCGaV+j5knz9e4OTuz0VPJtPh8SpOWMcmJ58yyoMbci2pD
         fXDBUrB23VKfRnDSNZIk3YMPM5KFcoLcC7NJqKdVfGHQFf36si2pbkiSQnM6kT03STdg
         5FE63GdM2+cLwQWcCUmhdHIsBRz3kHRiQm1iAxEPykxM71p0bytjKijfQ4ZhoU7MSFgv
         FCYIdXqYaqYQPuH/654ADzoaXtMmoo33qoVTUJNfa32Wqya7g/7jCdDGUGXWamuVpUIp
         50/d0jmVOvIpk1R55LI/qvLZT6wYayKVwRDevNYoO6aUQfiNn7GoGV3/Pj7lvjez2SeM
         u3pw==
X-Gm-Message-State: ACgBeo32aqmgTg0Sd6g/BW+rzEO/MncZcGmBdfrGRyxeeEm+84qHvn4K
        6WKxJuKbTvCm20Fi9UMDC73p0oWkU0X+WA==
X-Google-Smtp-Source: AA6agR67aE5Ulb4LroINgHPjIkTBwPfv0C4G3t3ySziPXoiF+Jn/5QR4OFVjTo2QG8nR6ynKSKR3DA==
X-Received: by 2002:a05:6a00:a8e:b0:527:9d23:c613 with SMTP id b14-20020a056a000a8e00b005279d23c613mr4670891pfl.53.1659667501658;
        Thu, 04 Aug 2022 19:45:01 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id w6-20020a170902904600b0016bea74d11esm1590600plz.267.2022.08.04.19.45.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 Aug 2022 19:45:01 -0700 (PDT)
Message-ID: <49f205eb-a4e0-e091-5c21-24c548dcbacd@kernel.dk>
Date:   Thu, 4 Aug 2022 20:45:00 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Followup block changes for 6.0-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

This is a rebase (and collapse of the fix with the original change) of
the original driver pull request for this merge window, with the changes
staged for a later pull queued into this branch as well. This pull
request contains:

- NVMe pull requests via Christoph
	- add support for In-Band authentication (Hannes Reinecke)
	- handle the persistent internal error AER (Michael Kelley)
	- use in-capsule data for TCP I/O queue connect (Caleb Sander)
	- remove timeout for getting RDMA-CM established event
	  (Israel Rukshin)
	- misc cleanups (Joel Granados, Sagi Grimberg, Chaitanya Kulkarni,
	  Guixin Liu, Xiang wangx)
	- use command_id instead of req->tag in trace_nvme_complete_rq()
	  (Bean Huo)
	- various fixes for the new authentication code (Lukas Bulwahn,
	  Dan Carpenter, Colin Ian King, Chaitanya Kulkarni,
	  Hannes Reinecke)
	- small cleanups (Liu Song, Christoph Hellwig)
	- restore compat_ioctl support (Nick Bowler)
	- make a nvmet-tcp workqueue lockdep-safe (Sagi Grimberg)
	- enable generic interface (/dev/ngXnY) for unknown command sets
	   (Joel Granados, Christoph Hellwig)
	- don't always build constants.o (Christoph Hellwig)
	- print the command name of aborted commands (Christoph Hellwig)

- MD pull requests via Song
	- Improve raid5 lock contention, by Logan Gunthorpe.
	- Misc fixes to raid5, by Logan Gunthorpe.
	- Fix race condition with md_reap_sync_thread(), by Guoqing Jiang.
	- Fix potential deadlock with raid5_quiesce and
          raid5_get_active_stripe, by Logan Gunthorpe.
	- Refactoring md_alloc(), by Christoph"
	- Fix md disk_name lifetime problems, by Christoph Hellwig
	- Convert prepare_to_wait() to wait_woken() api, by
          Logan Gunthorpe;
	- Fix sectors_to_do bitmap issue, by Logan Gunthorpe.

- Work on unifying the null_blk module parameters and configfs API
  (Vincent)

- drbd bitmap IO error fix (Lars)

- Set of rnbd fixes (Guoqing, Md Haris)

- Remove experimental marker on bcache async device registration (Coly)

- Series from cleaning up the bio splitting (Christoph)

- Removal of the sx8 block driver. This hardware never really
  widespread, and it didn't receive a lot of attention after the initial
  merge of it back in 2005 (Christoph)

- A few fixes for s390 dasd (Eric, Jiang)

- Followup set of fixes for ublk (Ming)

- Support for UBLK_IO_NEED_GET_DATA for ublk (ZiyangZhang)

- Fixes for the dio dma alignment (Keith)

- Misc fixes and cleanups (Ming, Yu, Dan, Christophe

Please pull!


The following changes since commit 8374cfe647a1f360be3228b949dd6d753c55c19c:

  Merge tag 'for-6.0/dm-changes' of git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm (2022-08-02 14:21:25 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.20/block-2022-08-04

for you to fetch changes up to bc792884b76f0da2f5c9a8d720e430e2de9756f5:

  s390/dasd: Establish DMA alignment (2022-08-04 16:19:15 -0600)

----------------------------------------------------------------
for-5.20/block-2022-08-04

----------------------------------------------------------------
Bean Huo (1):
      nvme: use command_id instead of req->tag in trace_nvme_complete_rq()

Caleb Sander (1):
      nvme-tcp: use in-capsule data for I/O connect

Chaitanya Kulkarni (4):
      nvme: remove unused timeout parameter
      nvme: fix qid param blk_mq_alloc_request_hctx
      nvmet-auth: fix return value check in auth send
      nvmet-auth: fix return value check in auth receive

Chris Webb (1):
      md: Explicitly create command-line configured devices

Christoph Hellwig (34):
      md: fix mddev->kobj lifetime
      md: fix error handling in md_alloc
      md: implement ->free_disk
      md: rename md_free to md_kobj_release
      md: factor out the rdev overlaps check from rdev_size_store
      md: stop using for_each_mddev in md_do_sync
      md: stop using for_each_mddev in md_notify_reboot
      md: stop using for_each_mddev in md_exit
      md: only delete entries from all_mddevs when the disk is freed
      md: simplify md_open
      remove the sx8 block driver
      md: open code md_probe in autorun_devices
      md: return the allocated devices from md_alloc
      nvme: don't always build constants.o
      nvme-pci: print the command name of aborted commands
      nvme-pci: split nvme_alloc_admin_tags
      nvme-pci: split nvme_dev_add
      nvme-rdma: split nvme_rdma_alloc_tagset
      nvme-tcp: split nvme_tcp_alloc_tagset
      nvme-apple: stop casting function pointer signatures
      nvmet: don't check for NULL pointer before kfree in nvmet_host_release
      nvmet: fix a format specifier in nvmet_auth_ctrl_exponential
      nvme: catch -ENODEV from nvme_revalidate_zones again
      nvme: rename nvme_validate_or_alloc_ns to nvme_scan_ns
      nvme: generalize the nvme_multi_css check in nvme_scan_ns
      nvme: refactor namespace probing
      nvme: factor out a nvme_ns_is_readonly helper
      nvme: update MAINTAINERS for the new auth code
      block: change the blk_queue_split calling convention
      block: change the blk_queue_bounce calling convention
      block: move ->bio_split to the gendisk
      block: move the call to get_max_io_size out of blk_bio_segment_split
      block: move bio_allowed_max_sectors to blk-merge.c
      block: pass struct queue_limits to the bio splitting helpers

Christophe JAILLET (1):
      block: null_blk: Use the bitmap API to allocate bitmaps

Colin Ian King (1):
      nvmet-auth: fix a couple of spelling mistakes

Coly Li (1):
      bcache: remove EXPERIMENTAL for Kconfig option 'Asynchronous device registration'

Dan Carpenter (3):
      null_blk: fix ida error handling in null_add_dev()
      nvme-auth: fix off by one checks
      nvme-auth: uninitialized variable in nvme_auth_transform_key()

Eric Farman (1):
      s390/dasd: Establish DMA alignment

Guixin Liu (2):
      nvme-pci: use nvme core helper to cancel requests in tagset
      nvme-apple: use nvme core helper to cancel requests in tagset

Guoqing Jiang (9):
      md: unlock mddev before reap sync_thread in action_store
      rnbd-clt: open code send_msg_open in rnbd_clt_map_device
      rnbd-clt: don't free rsp in msg_open_conf for map scenario
      rnbd-clt: kill read_only from struct rnbd_clt_dev
      rnbd-clt: reduce the size of struct rnbd_clt_dev
      rnbd-clt: adjust the layout of struct rnbd_clt_dev
      rnbd-clt: check capacity inside rnbd_clt_change_capacity
      rnbd-clt: pass sector_t type for resize capacity
      rnbd-clt: make rnbd_clt_change_capacity return void

Hannes Reinecke (11):
      crypto: add crypto_has_shash()
      crypto: add crypto_has_kpp()
      lib/base64: RFC4648-compliant base64 encoding
      nvme: add definitions for NVMe In-Band authentication
      nvme-fabrics: decode 'authentication required' connect error
      nvme: implement In-Band authentication
      nvme-auth: Diffie-Hellman key exchange support
      nvmet: parse fabrics commands on io queues
      nvmet: implement basic In-Band Authentication
      nvmet-auth: Diffie-Hellman key exchange support
      nvmet-auth: expire authentication sessions

Israel Rukshin (1):
      nvme-rdma: remove timeout for getting RDMA-CM established event

Jackie Liu (1):
      raid5: fix duplicate checks for rdev->saved_raid_disk

Jiang Jian (1):
      s390/dasd: drop unexpected word 'for' in comments

Joel Granados (2):
      nvme-multipath: refactor nvme_mpath_add_disk
      nvme: enable generic interface (/dev/ngXnY) for unknown command sets

Keith Busch (3):
      block: ensure iov_iter advances for added pages
      block: ensure bio_iov_add_page can't fail
      block: fix leaking page ref on truncated direct io

Lars Ellenberg (1):
      drbd: bm_page_async_io: fix spurious bitmap "IO error" on large volumes

Liu Song (1):
      nvme-pci: remove useless assignment in nvme_pci_setup_prps

Logan Gunthorpe (32):
      md/raid5-log: Drop extern decorators for function prototypes
      md/raid5-ppl: Drop unused argument from ppl_handle_flush_request()
      md/raid5: suspend the array for calls to log_exit()
      md/raid5-cache: Take mddev_lock in r5c_journal_mode_show()
      md/raid5-cache: Drop RCU usage of conf->log
      md/raid5-cache: Clear conf->log after finishing work
      md/raid5-cache: Annotate pslot with __rcu notation
      md: Use enum for overloaded magic numbers used by mddev->curr_resync
      md: Ensure resync is reported after it starts
      md: Notify sysfs sync_completed in md_reap_sync_thread()
      md/raid5: Make logic blocking check consistent with logic that blocks
      md/raid5: Factor out ahead_of_reshape() function
      md/raid5: Refactor raid5_make_request loop
      md/raid5: Move stripe_add_to_batch_list() call out of add_stripe_bio()
      md/raid5: Move common stripe get code into new find_get_stripe() helper
      md/raid5: Factor out helper from raid5_make_request() loop
      md/raid5: Drop the do_prepare flag in raid5_make_request()
      md/raid5: Move read_seqcount_begin() into make_stripe_request()
      md/raid5: Refactor for loop in raid5_make_request() into while loop
      md/raid5: Keep a reference to last stripe_head for batch
      md/raid5: Refactor add_stripe_bio()
      md/raid5: Check all disks in a stripe_head for reshape progress
      md/raid5: Pivot raid5_make_request()
      md/raid5: Improve debug prints
      md/raid5: Increase restriction on max segments per request
      md/raid5: Fix sectors_to_do bitmap overflow in raid5_make_request()
      md/raid5: Convert prepare_to_wait() to wait_woken() api
      md/raid5: Refactor raid5_get_active_stripe()
      md/raid5: Make is_inactive_blocked() helper
      md/raid5: Drop unnecessary call to r5c_check_stripe_cache_usage()
      md/raid5: Move stripe_request_ctx up
      md/raid5: Ensure batch_last is released before sleeping for quiesce

Lukas Bulwahn (1):
      nvmet-auth: select the intended CRYPTO_DH_RFC7919_GROUPS

Md Haris Iqbal (2):
      block/rnbd-srv: Set keep_id to true after mutex_trylock
      block/rnbd-srv: Replace sess_dev_list with index_idr

Michael Kelley (1):
      nvme: handle the persistent internal error AER

Mikulas Patocka (2):
      md-raid: destroy the bitmap after destroying the thread
      md-raid10: fix KASAN warning

Ming Lei (4):
      ublk_drv: cancel device even though disk isn't up
      ublk_drv: fix ublk device leak in case that add_disk fails
      ublk_drv: add SET_PARAMS/GET_PARAMS control command
      ublk_drv: cleanup ublksrv_ctrl_dev_info

Nick Bowler (1):
      nvme: define compat_ioctl again to unbreak 32-bit userspace.

Sagi Grimberg (2):
      nvme-loop: use nvme core helpers to cancel all requests in a tagset
      nvmet-tcp: fix lockdep complaint on nvmet_tcp_wq flush during queue teardown

Song Liu (1):
      MAINTAINERS: add patchwork link to linux-raid project

Stephen Rothwell (1):
      md: fix build failure for !MODULE

Vincent Fu (2):
      null_blk: add module parameters for 4 options
      null_blk: add configfs variables for 2 options

Wentao_Liang (1):
      drivers:md:fix a potential use-after-free bug

Xiang wangx (1):
      nvme: remove a double word in a comment

Yang Li (1):
      md: remove unneeded semicolon

Yu Kuai (1):
      nbd: add missing definition of pr_fmt

Zhang Jiaming (1):
      md: Fix spelling mistake in comments

ZiyangZhang (2):
      ublk_cmd.h: add one new ublk command: UBLK_IO_NEED_GET_DATA
      ublk_drv: add support for UBLK_IO_NEED_GET_DATA

 Documentation/block/null_blk.rst       |   22 +
 MAINTAINERS                            |    4 +-
 block/bio-integrity.c                  |    2 +-
 block/bio.c                            |   51 +-
 block/blk-core.c                       |    9 +-
 block/blk-merge.c                      |  185 ++--
 block/blk-mq.c                         |    6 +-
 block/blk-sysfs.c                      |    2 -
 block/blk.h                            |   47 +-
 block/bounce.c                         |   26 +-
 block/genhd.c                          |    8 +-
 crypto/kpp.c                           |    6 +
 crypto/shash.c                         |    6 +
 drivers/block/Kconfig                  |    9 -
 drivers/block/Makefile                 |    2 -
 drivers/block/drbd/drbd_bitmap.c       |   49 +-
 drivers/block/drbd/drbd_req.c          |    2 +-
 drivers/block/nbd.c                    |    6 +-
 drivers/block/null_blk/main.c          |  108 ++-
 drivers/block/null_blk/null_blk.h      |    2 +
 drivers/block/pktcdvd.c                |    2 +-
 drivers/block/ps3vram.c                |    2 +-
 drivers/block/rnbd/rnbd-clt-sysfs.c    |    2 +-
 drivers/block/rnbd/rnbd-clt.c          |  201 ++--
 drivers/block/rnbd/rnbd-clt.h          |   18 +-
 drivers/block/rnbd/rnbd-srv.c          |   20 +-
 drivers/block/rnbd/rnbd-srv.h          |    4 -
 drivers/block/sx8.c                    | 1582 --------------------------------
 drivers/block/ublk_drv.c               |  348 ++++++-
 drivers/md/bcache/Kconfig              |    2 +-
 drivers/md/dm-raid.c                   |    1 +
 drivers/md/dm.c                        |    8 +-
 drivers/md/md-autodetect.c             |   21 +-
 drivers/md/md-cluster.c                |    4 +-
 drivers/md/md.c                        |  424 +++++----
 drivers/md/md.h                        |   19 +
 drivers/md/raid10.c                    |    5 +-
 drivers/md/raid5-cache.c               |   40 +-
 drivers/md/raid5-log.h                 |   77 +-
 drivers/md/raid5-ppl.c                 |    2 +-
 drivers/md/raid5.c                     |  727 ++++++++++-----
 drivers/md/raid5.h                     |    2 +-
 drivers/nvme/Kconfig                   |    1 +
 drivers/nvme/Makefile                  |    1 +
 drivers/nvme/common/Kconfig            |    4 +
 drivers/nvme/common/Makefile           |    7 +
 drivers/nvme/common/auth.c             |  483 ++++++++++
 drivers/nvme/host/Kconfig              |   15 +
 drivers/nvme/host/Makefile             |    4 +-
 drivers/nvme/host/apple.c              |   28 +-
 drivers/nvme/host/auth.c               | 1017 ++++++++++++++++++++
 drivers/nvme/host/constants.c          |    3 +-
 drivers/nvme/host/core.c               |  490 +++++++---
 drivers/nvme/host/fabrics.c            |   94 +-
 drivers/nvme/host/fabrics.h            |    7 +
 drivers/nvme/host/multipath.c          |    9 +-
 drivers/nvme/host/nvme.h               |   39 +-
 drivers/nvme/host/pci.c                |  145 +--
 drivers/nvme/host/rdma.c               |  106 ++-
 drivers/nvme/host/tcp.c                |   95 +-
 drivers/nvme/host/trace.c              |   32 +
 drivers/nvme/host/trace.h              |    2 +-
 drivers/nvme/target/Kconfig            |   15 +
 drivers/nvme/target/Makefile           |    1 +
 drivers/nvme/target/admin-cmd.c        |    4 +-
 drivers/nvme/target/auth.c             |  525 +++++++++++
 drivers/nvme/target/configfs.c         |  136 +++
 drivers/nvme/target/core.c             |   15 +
 drivers/nvme/target/fabrics-cmd-auth.c |  544 +++++++++++
 drivers/nvme/target/fabrics-cmd.c      |   55 +-
 drivers/nvme/target/loop.c             |    8 +-
 drivers/nvme/target/nvmet.h            |   75 +-
 drivers/nvme/target/tcp.c              |    3 +-
 drivers/s390/block/dasd.c              |    2 +-
 drivers/s390/block/dasd_diag.c         |    1 +
 drivers/s390/block/dasd_eckd.c         |    1 +
 drivers/s390/block/dcssblk.c           |    2 +-
 include/crypto/hash.h                  |    2 +
 include/crypto/kpp.h                   |    2 +
 include/linux/base64.h                 |   16 +
 include/linux/blkdev.h                 |    5 +-
 include/linux/nvme-auth.h              |   41 +
 include/linux/nvme.h                   |  213 ++++-
 include/uapi/linux/ublk_cmd.h          |   80 +-
 lib/Makefile                           |    2 +-
 lib/base64.c                           |  103 +++
 86 files changed, 5640 insertions(+), 2856 deletions(-)
 delete mode 100644 drivers/block/sx8.c
 create mode 100644 drivers/nvme/common/Kconfig
 create mode 100644 drivers/nvme/common/Makefile
 create mode 100644 drivers/nvme/common/auth.c
 create mode 100644 drivers/nvme/host/auth.c
 create mode 100644 drivers/nvme/target/auth.c
 create mode 100644 drivers/nvme/target/fabrics-cmd-auth.c
 create mode 100644 include/linux/base64.h
 create mode 100644 include/linux/nvme-auth.h
 create mode 100644 lib/base64.c

-- 
Jens Axboe

