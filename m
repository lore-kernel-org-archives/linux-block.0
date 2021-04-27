Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49522C433B4
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 15:13:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1837D613DE
	for <linux-block@archiver.kernel.org>; Tue, 27 Apr 2021 15:13:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236928AbhD0PO3 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 27 Apr 2021 11:14:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236861AbhD0PO3 (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 27 Apr 2021 11:14:29 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9B31C061574
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 08:13:45 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id k25so16905815iob.6
        for <linux-block@vger.kernel.org>; Tue, 27 Apr 2021 08:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=noFSycE0Hm2IZbaH5yDmqSb0Cz34KR7M0k42Ey+jGpY=;
        b=u+7AG/D4VHbJ7PmnkUuFrYEk77LVf53HcPaHMRm5qI8CBPnj7CbJVsLt4go3krJrIz
         mR2N2Km89Rwf6ivO8JuZKfiehyvtvxrHEm7KIvivflhtpjgcMSQShf+LE//SxNukRLZL
         l4HAzSyZhNbL46CsMgQFy2zM6t0TfbWaNx+ZW9dNgzUxkKCyM5XWW33uIRmDhEOpLtpY
         mvt7PothEIh5sR8UgGVwRIz5vpVnYu31GsNv/JUul8XjTU09z3coqyTP60DjoVg15P6a
         P+tcd7x6HM6gFvwT3zEtqx5A55dBEjhoYP39560Fe6vaqoc6Q5E7bE8T/SNxtO3B8+FF
         GtGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=noFSycE0Hm2IZbaH5yDmqSb0Cz34KR7M0k42Ey+jGpY=;
        b=SNd02m/mg5swQhKyLIGmM9PtREXxgNgiU3ConvMordRCsrNWKDYzxluE9hzkLL5MWw
         WX+SlP/MObRV7D6YhXHIBRdfEHUg5R1WXVD0h6jP7mG7tG/UdWYZ6I30NTRQZjIci2nq
         NftqLcnuesSuLWAGWBeNp7k9mTJ9UTjZNNfavhWn2mfo+RxzKGdSbZgVV5DDgVg5dGDA
         f3onhhEWy/tpZVTmsLsRMl5fc7Ps5VC2zbUqYA/7burKU/AxWBqxaI/nRSy9AouXTc4h
         9vfmv2rt7zACTkA0mmToOnXu+LE69zHChdlw6YALJe/rrBl9VIE9pAS7h0msI6AQzjql
         2vgg==
X-Gm-Message-State: AOAM532oBkvFTAKu7XF0GjvXgDja6S4byqn8Aatf3d5Ch7icZwPB1gqe
        vzmkDLGFaXprR/XcOl4XG7A6hiem0ERasg==
X-Google-Smtp-Source: ABdhPJxEuO8wcTL+FZ5F4arWEfzDHNG2yvc2/okzg0QlpMUKtpLVAJf1gXxE2RZWGyR+/2+CtpvtaA==
X-Received: by 2002:a02:c912:: with SMTP id t18mr22059818jao.100.1619536424736;
        Tue, 27 Apr 2021 08:13:44 -0700 (PDT)
Received: from [192.168.1.30] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id b79sm75493iof.15.2021.04.27.08.13.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Apr 2021 08:13:44 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block driver changes for 5.13-rc
Message-ID: <f332f5e8-8c45-7d20-de68-ea8f706a2350@kernel.dk>
Date:   Tue, 27 Apr 2021 09:13:43 -0600
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

Here are the block driver changes queued up for 5.13-rc1:

- MD changes via Song:
	- raid5 POWER fix
	- raid1 failure fix
	- UAF fix for md cluster
	- mddev_find_or_alloc() clean up
	- Fix NULL pointer deref with external bitmap
	- Performance improvement for raid10 discard requests
	- Fix missing information of /proc/mdstat

- rsxx const qualifier removal (Arnd)

- Expose allocated brd pages (Calvin)

- rnbd via Gioh Kim:
	- Change maintainer
	- Change domain address of maintainers' email
	- Add polling IO mode and document update
	- Fix memory leak and some bug detected by static code analysis
	  tools
	- Code refactoring

- Series of floppy cleanups/fixes (Denis)

- s390 dasd fixes (Julian)

- kerneldoc fixes (Lee)

- null_blk double free (Lv)

- null_blk virtual boundary addition (Max)

- Remove xsysace driver (Michal)

- umem driver removal (Davidlohr)

- ataflop fixes (Dan)

- Revalidate disk removal (Christoph)

- Bounce buffer cleanups (Christoph)

- Mark lightnvm as deprecated (Christoph)

- mtip32xx init cleanups (Shixin)

- Various fixes (Tian, Gustavo, Coly, Yang, Zhang, Zhiqiang)

You'll get a trivial merge conflict in drivers/nvme/host/core.c, and the
resolution is to use the write zeroes part from my tree (eg killing
nvme_config_write_zeroes() and ensuring the other hunk uses
blk_queue_max_write_zeroes_sectors().

Please pull!


The following changes since commit 1e28eed17697bcf343c6743f0028cc3b5dd88bf0:

  Linux 5.12-rc3 (2021-03-14 14:41:02 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.13/drivers-2021-04-27

for you to fetch changes up to 8324fbae75ce65fc2eb960a8434799dca48248ac:

  Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.13/drivers (2021-04-26 11:20:54 -0600)

----------------------------------------------------------------
for-5.13/drivers-2021-04-27

----------------------------------------------------------------
Amit Engel (1):
      nvmet-fc: simplify nvmet_fc_alloc_hostport

Arnd Bergmann (2):
      rsxx: remove extraneous 'const' qualifier
      md: bcache: avoid -Wempty-body warnings

Bart Van Assche (1):
      nvme: fix handling of large MDTS values

Bhaskar Chowdhury (1):
      md: bcache: Trivial typo fixes in the file journal.c

Calvin Owens (1):
      brd: expose number of allocated pages in debugfs

Chaitanya Kulkarni (16):
      nvme-pci: remove the barriers in nvme_irq()
      nvme-pci: cleanup nvme_irq()
      nvmet: remove a duplicate status assignment in nvmet_alloc_ctrl
      nvmet: update error log page in nvmet_alloc_ctrl()
      nvmet: remove an unnecessary function parameter to nvmet_check_ctrl_status
      nvmet: replace white spaces with tabs
      nvme: rename nvme_init_identify()
      nvme: split init identify into helper
      nvme: mark nvme_setup_passsthru() inline
      nvme: don't check nvme_req flags for new req
      nvme: add new line after variable declatation
      nvme-fc: fix the function documentation comment
      nvmet-fc: update function documentation
      nvmet: remove unnecessary ctrl parameter
      gdrom: fix compilation error
      lightnvm: use kobj_to_dev()

Christoph Hellwig (27):
      paride/pd: remove ->revalidate_disk
      block: remove the revalidate_disk method
      gdrom: support highmem
      swim: don't call blk_queue_bounce_limit
      floppy: always use the track buffer
      swim3: support highmem
      md: factor out a mddev_find_locked helper from mddev_find
      md: split mddev_find
      bcache: remove PTR_CACHE
      block: remove the -ERESTARTSYS handling in blkdev_get_by_dev
      lightnvm: deprecated OCSSD support and schedule it for removal in Linux 5.15
      nvme: cleanup setting the disk name
      nvme: pass a user pointer to nvme_nvm_ioctl
      nvme: factor out a nvme_ns_ioctl helper
      nvme: simplify the compat ioctl handling
      nvme: simplify block device ioctl handling for the !multipath case
      nvme: don't bother to look up a namespace for controller ioctls
      nvme: move the ioctl code to a separate file
      nvme: factor out a nvme_tryget_ns_head helper
      nvme: move nvme_ns_head_ops to multipath.c
      nvme: factor out nvme_ns_open and nvme_ns_release helpers
      nvme: let namespace probing continue for unsupported features
      md: factor out a mddev_alloc_unit helper from mddev_find
      md: refactor mddev_find_or_alloc
      md: do not return existing mddevs from mddev_find_or_alloc
      nvme: do not try to reconfigure APST when the controller is not live
      nvme: cleanup nvme_configure_apst

Colin Ian King (2):
      nvmet: fix a spelling mistake "nubmer" -> "number"
      floppy: remove redundant assignment to variable st

Coly Li (1):
      bcache: fix a regression of code compiling failure in debug.c

Dan Carpenter (2):
      ataflop: potential out of bounds in do_format()
      ataflop: fix off by one in ataflop_probe()

Daniel Wagner (3):
      nvme: use sysfs_emit instead of sprintf
      nvme: remove superfluous else in nvme_ctrl_loss_tmo_store
      nvme: export fast_io_fail_tmo to sysfs

Danil Kipnis (1):
      MAINTAINERS: Change maintainer for rnbd module

Davidlohr Bueso (1):
      drivers/block: remove the umem driver

Denis Efremov (5):
      floppy: cleanups: remove trailing whitespaces
      floppy: cleanups: use ST0 as reply_buffer index 0
      floppy: cleanups: use memset() to zero reply_buffer
      floppy: cleanups: use memcpy() to copy reply_buffer
      floppy: cleanups: remove FLOPPY_SILENT_DCL_CLEAR undef

Dima Stepanov (2):
      block/rnbd-clt-sysfs: Remove copy buffer overlap in rnbd_clt_get_path_name
      block/rnbd: Use strscpy instead of strlcpy

Elad Grupi (1):
      nvmet-tcp: fix a segmentation fault during io parsing error

Gioh Kim (8):
      Documentation/sysfs-block-rnbd: Add descriptions for remap_device and resize
      block/rnbd-clt: Replace {NO_WAIT,WAIT} with RTRS_PERMIT_{WAIT,NOWAIT}
      block/rnbd-srv: Prevent a deadlock generated by accessing sysfs in parallel
      block/rnbd-srv: Remove force_close file after holding a lock
      block/rnbd-clt: Fix missing a memory free when unloading the module
      block/rnbd-clt: Support polling mode for IO latency optimization
      Documentation/ABI/rnbd-clt: Add description for nr_poll_queues
      block/rnbd-srv: Remove unused arguments of rnbd_srv_rdma_ev

Gopal Tiwari (1):
      nvme: fix NULL derefence in nvme_ctrl_fast_io_fail_tmo_show/store

Guobin Huang (1):
      drbd: use DEFINE_SPINLOCK() for spinlock

Guoqing Jiang (5):
      block/rnbd-clt: Remove some arguments from insert_dev_if_not_exists_devpath
      block/rnbd-clt: Remove some arguments from rnbd_client_setup_device
      block/rnbd-clt: Move add_disk(dev->gd) to rnbd_clt_setup_gen_disk
      block/rnbd: Kill rnbd_clt_destroy_default_group
      block/rnbd: Kill destroy_device_cb

Gustavo A. R. Silva (2):
      bcache: Use 64-bit arithmetic instead of 32-bit
      drbd: Fix fall-through warnings for Clang

Hannes Reinecke (3):
      nvme: retrigger ANA log update if group descriptor isn't found
      nvme: sanitize KATO setting
      nvme: add 'kato' sysfs attribute

Heming Zhao (1):
      md-cluster: fix use-after-free issue when removing rdev

Hou Pu (2):
      nvmet: return proper error code from discovery ctrl
      nvmet: avoid queuing keep-alive timer if it is disabled

Jack Wang (1):
      block/rnbd-clt: Remove max_segment_size

Jan Glauber (1):
      md: Fix missing unused status line of /proc/mdstat

Jens Axboe (8):
      Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.13/drivers
      Merge tag 'nvme-5.13-2021-04-06' of git://git.infradead.org/nvme into for-5.13/drivers
      Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.13/drivers
      Merge tag 'nvme-5.13-2021-04-15' of git://git.infradead.org/nvme into for-5.13/drivers
      Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.13/drivers
      Merge tag 'nvme-5.13-2021-04-22' of git://git.infradead.org/nvme into for-5.13/drivers
      Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.13/drivers
      Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.13/drivers

Julian Wiedmann (2):
      s390/dasd: remove dasd_fba_probe() wrapper
      s390/dasd: let driver core manage the sysfs attributes

Kanchan Joshi (2):
      nvme: use NVME_CTRL_CMIC_ANA macro
      nvme: reduce checks for zero command effects

Keith Busch (4):
      nvme-pci: allocate nvme_command within driver pdu
      nvme: use driver pdu command for passthrough
      nvme: warn of unhandled effects only once
      nvme: implement non-mdts command limits

Lee Jones (10):
      block: drbd: drbd_interval: Demote some kernel-doc abuses and fix another header
      block: mtip32xx: mtip32xx: Mark debugging variable 'start' as __maybe_unused
      block: drbd: drbd_state: Fix some function documentation issues
      block: drbd: drbd_receiver: Demote non-conformant kernel-doc headers
      block: drbd: drbd_main: Remove duplicate field initialisation
      block: drbd: drbd_nl: Make conversion to 'enum drbd_ret_code' explicit
      block: drbd: drbd_main: Fix a bunch of function documentation discrepancies
      block: drbd: drbd_receiver: Demote less than half complete kernel-doc header
      block: xen-blkfront: Demote kernel-doc abuses
      block: drbd: drbd_nl: Demote half-complete kernel-doc headers

Lv Yunlong (1):
      drivers/block/null_blk/main: Fix a double free in null_init.

Max Gurtovoy (3):
      nvme-tcp: check sgl supported by target
      nvme-fc: check sgl supported by target
      null_blk: add option for managing virtual boundary

Md Haris Iqbal (1):
      block/rnbd-clt: Generate kobject_uevent when the rnbd device state changes

Michal Simek (1):
      xsysace: Remove SYSACE driver

Minwoo Im (2):
      nvme: add a nvme_ns_head_multipath helper
      nvme: introduce generic per-namespace chardev

Niklas Cassel (5):
      nvme: disallow passthru cmd from targeting a nsid != nsid of the block dev
      nvme-pci: don't simple map sgl when sgls are disabled
      nvme-pci: remove single trailing whitespace
      nvme-multipath: remove single trailing whitespace
      nvme: remove single trailing whitespace

Noam Gottlieb (1):
      nvmet: do not allow model_number exceed 40 bytes

Paul Clements (1):
      md/raid1: properly indicate failure when ending a failed write request

Sagi Grimberg (2):
      nvme-tcp: block BH in sk state_change sk callback
      nvmet-tcp: fix incorrect locking in state_change sk callback

Shixin Liu (2):
      mtip32xx: use DEFINE_SPINLOCK() for spinlock
      mtip32xx: use LIST_HEAD() for list_head

Sudhakar Panneerselvam (1):
      md/bitmap: wait for external bitmap writes to complete during tear down

Tian Tao (1):
      lightnvm: return the correct return value

Tom Rix (1):
      block/rnbd-clt: Improve find_or_create_sess() return check

Wunderlich, Mark (1):
      nvmet-tcp: enable optional queue idle period tracking

Xiao Ni (6):
      md: add md_submit_discard_bio() for submitting discard bio
      md/raid10: extend r10bio devs to raid disks
      md/raid10: pull the code that wait for blocked dev into one function
      md/raid10: improve raid10 discard request
      md/raid10: improve discard request for far layout
      async_xor: increase src_offs when dropping destination page

Yang Li (1):
      bcache: use NULL instead of using plain integer as pointer

Zhang Yunkai (1):
      lightnvm: remove duplicate include in lightnvm.h

Zhao Heming (1):
      md: md_open returns -EBUSY when entering racing area

Zhiqiang Liu (1):
      bcache: reduce redundant code in bch_cached_dev_run()

 Documentation/ABI/testing/sysfs-block-rnbd        |   18 +
 Documentation/ABI/testing/sysfs-class-rnbd-client |   13 +
 Documentation/filesystems/locking.rst             |    2 -
 MAINTAINERS                                       |    5 +-
 arch/microblaze/boot/dts/system.dts               |    8 -
 arch/mips/configs/malta_defconfig                 |    1 -
 arch/mips/configs/malta_kvm_defconfig             |    1 -
 arch/mips/configs/maltaup_xpa_defconfig           |    1 -
 arch/powerpc/boot/dts/icon.dts                    |    7 -
 arch/powerpc/configs/44x/icon_defconfig           |    1 -
 arch/x86/include/asm/floppy.h                     |    1 -
 crypto/async_tx/async_xor.c                       |    1 +
 drivers/block/Kconfig                             |   25 +-
 drivers/block/Makefile                            |    2 -
 drivers/block/ataflop.c                           |   16 +-
 drivers/block/brd.c                               |   19 +-
 drivers/block/drbd/drbd_interval.c                |    8 +-
 drivers/block/drbd/drbd_main.c                    |   35 +-
 drivers/block/drbd/drbd_nl.c                      |   17 +-
 drivers/block/drbd/drbd_receiver.c                |   27 +-
 drivers/block/drbd/drbd_req.c                     |    1 +
 drivers/block/drbd/drbd_state.c                   |    7 +-
 drivers/block/floppy.c                            |  159 +--
 drivers/block/mtip32xx/mtip32xx.c                 |   13 +-
 drivers/block/null_blk/main.c                     |   12 +-
 drivers/block/null_blk/null_blk.h                 |    1 +
 drivers/block/null_blk/zoned.c                    |    1 +
 drivers/block/paride/pd.c                         |   11 -
 drivers/block/rnbd/rnbd-clt-sysfs.c               |   84 +-
 drivers/block/rnbd/rnbd-clt.c                     |  171 ++-
 drivers/block/rnbd/rnbd-clt.h                     |    6 +-
 drivers/block/rnbd/rnbd-srv-sysfs.c               |    5 +-
 drivers/block/rnbd/rnbd-srv.c                     |   69 +-
 drivers/block/rnbd/rnbd-srv.h                     |    3 +-
 drivers/block/rsxx/core.c                         |    2 +-
 drivers/block/swim.c                              |    2 -
 drivers/block/swim3.c                             |   34 +-
 drivers/block/umem.c                              | 1130 ------------------
 drivers/block/umem.h                              |  132 ---
 drivers/block/xen-blkfront.c                      |    6 +-
 drivers/block/xsysace.c                           | 1273 ---------------------
 drivers/cdrom/gdrom.c                             |    5 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.c            |   75 +-
 drivers/infiniband/ulp/rtrs/rtrs-clt.h            |    1 -
 drivers/infiniband/ulp/rtrs/rtrs-pri.h            |    1 +
 drivers/infiniband/ulp/rtrs/rtrs-srv.c            |    4 +-
 drivers/infiniband/ulp/rtrs/rtrs.h                |   13 +-
 drivers/lightnvm/Kconfig                          |    4 +-
 drivers/lightnvm/core.c                           |    4 +-
 drivers/md/bcache/alloc.c                         |    5 +-
 drivers/md/bcache/bcache.h                        |   11 +-
 drivers/md/bcache/btree.c                         |    4 +-
 drivers/md/bcache/debug.c                         |    2 +-
 drivers/md/bcache/extents.c                       |    4 +-
 drivers/md/bcache/features.c                      |    2 +-
 drivers/md/bcache/io.c                            |    4 +-
 drivers/md/bcache/journal.c                       |    6 +-
 drivers/md/bcache/super.c                         |   25 +-
 drivers/md/bcache/util.h                          |    2 +-
 drivers/md/bcache/writeback.c                     |   11 +-
 drivers/md/md-bitmap.c                            |    2 +
 drivers/md/md.c                                   |  206 ++--
 drivers/md/md.h                                   |    2 +
 drivers/md/raid0.c                                |   14 +-
 drivers/md/raid1.c                                |    2 +
 drivers/md/raid10.c                               |  434 ++++++-
 drivers/md/raid10.h                               |    1 +
 drivers/nvme/host/Makefile                        |    2 +-
 drivers/nvme/host/core.c                          | 1088 +++++++-----------
 drivers/nvme/host/fabrics.c                       |    4 +-
 drivers/nvme/host/fc.c                            |   14 +-
 drivers/nvme/host/ioctl.c                         |  481 ++++++++
 drivers/nvme/host/lightnvm.c                      |   10 +-
 drivers/nvme/host/multipath.c                     |  114 +-
 drivers/nvme/host/nvme.h                          |   64 +-
 drivers/nvme/host/pci.c                           |   30 +-
 drivers/nvme/host/rdma.c                          |    7 +-
 drivers/nvme/host/tcp.c                           |   16 +-
 drivers/nvme/host/zns.c                           |    4 +-
 drivers/nvme/target/admin-cmd.c                   |   14 +-
 drivers/nvme/target/configfs.c                    |    6 +
 drivers/nvme/target/core.c                        |   33 +-
 drivers/nvme/target/discovery.c                   |    6 +-
 drivers/nvme/target/fabrics-cmd.c                 |   17 +-
 drivers/nvme/target/fc.c                          |   78 +-
 drivers/nvme/target/loop.c                        |    6 +-
 drivers/nvme/target/nvmet.h                       |    8 +-
 drivers/nvme/target/tcp.c                         |   79 +-
 drivers/s390/block/dasd.c                         |   17 +-
 drivers/s390/block/dasd_devmap.c                  |   15 +-
 drivers/s390/block/dasd_eckd.c                    |    1 +
 drivers/s390/block/dasd_fba.c                     |   10 +-
 drivers/s390/block/dasd_int.h                     |    3 +-
 fs/block_dev.c                                    |    9 -
 include/linux/blkdev.h                            |    1 -
 include/linux/lightnvm.h                          |    2 -
 include/linux/nvme.h                              |   10 +
 include/uapi/linux/fd.h                           |   46 +-
 include/uapi/linux/lightnvm.h                     |    1 -
 99 files changed, 2303 insertions(+), 4067 deletions(-)
 delete mode 100644 drivers/block/umem.c
 delete mode 100644 drivers/block/umem.h
 delete mode 100644 drivers/block/xsysace.c
 create mode 100644 drivers/nvme/host/ioctl.c

-- 
Jens Axboe

