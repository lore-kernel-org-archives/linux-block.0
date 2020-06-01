Return-Path: <SRS0=rAsZ=7O=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65231C433DF
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 17:50:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2576F2073B
	for <linux-block@archiver.kernel.org>; Mon,  1 Jun 2020 17:50:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="x3gJJDpn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726113AbgFARuW (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726073AbgFARuW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Mon, 1 Jun 2020 13:50:22 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88176C05BD43
        for <linux-block@vger.kernel.org>; Mon,  1 Jun 2020 10:50:20 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 64so3811208pfg.8
        for <linux-block@vger.kernel.org>; Mon, 01 Jun 2020 10:50:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Bg7QZNcolSrsG5GXAOr5iCiC5Tg/oPdKmzCbkW/n68M=;
        b=x3gJJDpnyDijNoIBQOKYv/pYAeLUL2piJbkwj3pxs0g6nV6p/yFsMBatuViVvCXo+i
         6npLtKc94MhXIoliVr+qd2hMa+7nYBEYWCPRGZ79aoSXDGT4Y8GN1RyQsoij7I1YBVfd
         Q5xlRftp2mJoZtQ2Z/cA+Dq7vHeQSXwOCTDQ8HAeIB8QcdTqi/5ufRwsv9VH0fgQJR3W
         Bmgk2aL/84dl1gCjazDIWMtlUBLwstmlbT7Xv8BvLhVb1vqvtjCUPwSWG98jUphx6APO
         Qw9FHQKdPOMZzqGQdRb5He4uh21H6U2v3DMiUuiHh5S5VwsQEN4ZsMHoaUOke8lY4RW9
         Uxaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Bg7QZNcolSrsG5GXAOr5iCiC5Tg/oPdKmzCbkW/n68M=;
        b=e/V78skpLEfzCFp9xHPwUJBL5vS5cFS77voQeLjuD77u3b4uiO3w2hSVZctCoirM5Q
         VbbjGoo1ScJurOAKnTIV1DeNcC56kgEUxTh5+Mxi+xTkN49tu8m20Fl/yg1y5EUHwIU0
         4DS8gUM2txhs7Tj2ADxNEG+++tCf4QsZBiElasxCWKjN0tB1+Hxx6TpZ44d+ohFWpc4U
         QKuIWEOB3haq3JwVhrsS4KDxK1Hf7t/6hQzr/lmLBTjdzWU8aTMGhCSIS3FGYGZX8Sl7
         NlrcEMMU1GuSXlvRkk0COARhCdERAzSyisPmfBWVgnwpn9OC8bR6nG6ZjOip7AnP+hs5
         LTUQ==
X-Gm-Message-State: AOAM530JVw1v7eiRZd1WYM5/+f4XRnM3QZU6OIHw4rap9IicBAPjBf4O
        mCfdY0nQPCqRNnZUAF5qD1QmabDxWX/Ysg==
X-Google-Smtp-Source: ABdhPJyevCOx1kLoI5RYNU+QVax33Is6PELm6iK/AsWW1c+YvVBrpiOjZDhrs4khpl0h4poz892bXg==
X-Received: by 2002:a65:4c4c:: with SMTP id l12mr20251118pgr.159.1591033819396;
        Mon, 01 Jun 2020 10:50:19 -0700 (PDT)
Received: from [192.168.1.188] ([66.219.217.173])
        by smtp.gmail.com with ESMTPSA id x1sm69375pfn.76.2020.06.01.10.50.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 10:50:18 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block driver changes for 5.8-rc1
Message-ID: <aa7e82d7-9ed6-dbb7-458a-12346e867686@kernel.dk>
Date:   Mon, 1 Jun 2020 11:50:17 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

On top of the core changes, here are the block driver changes for this
merge window:

- NVMe changes:
	- NVMe over Fibre Channel protocol updates, which also reach
	  over to drivers/scsi/lpfc (James Smart)
	- namespace revalidation support on the target (Anthony
	  Iliopoulos)
	- gcc zero length array fix (Arnd Bergmann)
	- nvmet cleanups (Chaitanya Kulkarni)
	- misc cleanups and fixes (me, Keith Busch, Sagi Grimberg)
	- use a SRQ per completion vector (Max Gurtovoy)
	- fix handling of runtime changes to the queue count (Weiping
	  Zhang)
	- t10 protection information support for nvme-rdma and nvmet-rdma
          (Israel Rukshin and Max Gurtovoy)
	- target side AEN improvements (Chaitanya Kulkarni)
	- various fixes and minor improvements all over, icluding the
	  nvme part of the lpfc driver"

- Floppy code cleanup series (Willy, Denis)

- Floppy contention fix (Jiri)

- Loop CONFIGURE support (Martijn)

- bcache fixes/improvements (Coly, Joe, Colin)

- q->queuedata cleanups (Christoph)

- Get rid of ioctl_by_bdev (Christoph, Stefan)

- md/raid5 allocation fixes (Coly)

- zero length array fixes (Gustavo)

- swim3 task state fix (Xu)

Please pull!


  git://git.kernel.dk/linux-block.git tags/for-5.8/drivers-2020-06-01


----------------------------------------------------------------
Anthony Iliopoulos (1):
      nvmet: add ns revalidation support

Arnd Bergmann (1):
      nvme-fc: avoid gcc-10 zero-length-bounds warning

Chaitanya Kulkarni (10):
      nvmet: add generic type-name mapping
      nvmet: use type-name map for address family
      nvmet: use type-name map for ana states
      nvmet: use type-name map for address treq
      nvmet: centralize port enable access for configfs
      nvmet: align addrfam list to spec
      nvmet: add async event tracing support
      nvmet: add helper to revalidate bdev and file ns
      nvmet: generate AEN for ns revalidate size change
      nvmet: revalidate-ns & generate AEN from configfs

Chen Zhou (1):
      nvmet: replace kstrndup() with kmemdup_nul()

Christoph Hellwig (11):
      nvme: refine the Qemu Identify CNS quirk
      nvme: clean up nvme_scan_work
      nvme: factor out a nvme_ns_remove_by_nsid helper
      nvme: avoid an Identify Controller command for each namespace scan
      nvme: remove the magic 1024 constant in nvme_scan_ns_list
      nvme: clean up error handling in nvme_init_ns_head
      nvme-multipath: stop using ->queuedata
      md: stop using ->queuedata
      dasd: refactor dasd_ioctl_information
      block: remove ioctl_by_bdev
      nvmet: mark nvmet_ana_state static

Colin Ian King (2):
      loop: remove redundant assignment to variable error
      bcache: remove redundant variables i and n

Coly Li (7):
      md: use memalloc scope APIs in mddev_suspend()/mddev_resume()
      raid5: remove gfp flags from scribble_alloc()
      raid5: update code comment of scribble_alloc()
      md: remove redundant memalloc scope API usage
      bcache: fix refcount underflow in bcache_device_free()
      bcache: asynchronous devices registration
      bcache: configure the asynchronous registertion to be experimental

Damien Le Moal (1):
      nvme: fix io_opt limit setting

Dan Carpenter (1):
      nvme: delete an unnecessary declaration

David Jeffery (1):
      md/raid1: release pending accounting for an I/O only after write-behind is also finished

David Milburn (1):
      nvmet: cleanups the loop in nvmet_async_events_process

Denis Efremov (4):
      floppy: use print_hex_dump() in setup_DMA()
      floppy: add FD_AUTODETECT_SIZE define for struct floppy_drive_params
      floppy: add defines for sizes of cmd & reply buffers of floppy_raw_cmd
      floppy: suppress UBSAN warning in setup_rw_floppy()

Guoqing Jiang (5):
      md: add checkings before flush md_misc_wq
      md: add new workqueue for delete rdev
      md: don't flush workqueue unconditionally in md_open
      md: flush md_rdev_misc_wq for HOT_ADD_DISK case
      md: remove the extra line for ->hot_add_disk

Gustavo A. R. Silva (2):
      md/raid1: Replace zero-length array with flexible-array
      nvme: replace zero-length array with flexible-array

Israel Rukshin (9):
      nvme: introduce NVME_INLINE_METADATA_SG_CNT
      nvme-rdma: introduce nvme_rdma_sgl structure
      nvmet: add metadata characteristics for a namespace
      nvmet: rename nvmet_rw_len to nvmet_rw_data_len
      nvmet: rename nvmet_check_data_len to nvmet_check_transfer_len
      nvme: add Metadata Capabilities enumerations
      nvmet: add metadata/T10-PI support
      nvmet: add metadata support for block devices
      nvmet-rdma: add metadata/T10-PI support

James Smart (31):
      nvme-fc: Sync header to FC-NVME-2 rev 1.08
      nvme-fc and nvmet-fc: revise LLDD api for LS reception and LS request
      nvme-fc nvmet-fc: refactor for common LS definitions
      nvmet-fc: Better size LS buffers
      nvme-fc: Ensure private pointers are NULL if no data
      nvme-fc: convert assoc_active flag to bit op
      nvme-fc: Update header and host for common definitions for LS handling
      nvmet-fc: Update target for common definitions for LS handling
      nvme-fc: Add Disconnect Association Rcv support
      nvmet-fc: add LS failure messages
      nvmet-fc: perform small cleanups on unneeded checks
      nvmet-fc: track hostport handle for associations
      nvmet-fc: rename ls_list to ls_rcv_list
      nvmet-fc: Add Disconnect Association Xmt support
      nvme-fcloop: refactor to enable target to host LS
      nvme-fcloop: add target to host LS request support
      lpfc: Refactor lpfc nvme headers
      lpfc: Refactor nvmet_rcv_ctx to create lpfc_async_xchg_ctx
      lpfc: Commonize lpfc_async_xchg_ctx state and flag definitions
      lpfc: Refactor NVME LS receive handling
      lpfc: Refactor Send LS Request support
      lpfc: Refactor Send LS Abort support
      lpfc: Refactor Send LS Response support
      lpfc: nvme: Add Receive LS Request and Send LS Response support to nvme
      lpfc: nvmet: Add support for NVME LS request hosthandle
      lpfc: nvmet: Add Send LS Request and Abort LS Request support
      nvmet-fc: slight cleanup for kbuild test warnings
      nvme: make nvme_ns_has_pi accessible to transports
      lpfc: Fix pointer checks and comments in LS receive refactoring
      lpfc: fix axchg pointer reference after free and double frees
      lpfc: Fix return value in __lpfc_nvme_ls_abort

Jens Axboe (3):
      Merge tag 'floppy-for-5.8' of https://github.com/evdenis/linux-floppy into for-5.8/drivers
      Merge branch 'md-next' of git://git.kernel.org/.../song/md into for-5.8/drivers
      Merge branch 'nvme-5.8' of git://git.infradead.org/nvme into for-5.8/drivers

Jiri Kosina (1):
      block/floppy: fix contended case in floppy_queue_rq()

Joe Perches (1):
      bcache: Convert pr_<level> uses to a more typical style

Keith Busch (16):
      nvme: provide num dword helper
      nvme: remove unused parameter
      nvme: unlink head after removing last namespace
      nvme: release namespace head reference on error
      nvme: always search for namespace head
      nvme: check namespace head shared property
      nvme-multipath: set bdi capabilities once
      nvme: revalidate after verifying identifiers
      nvme: consolidate chunk_sectors settings
      nvme: revalidate namespace stream parameters
      nvme: consolodate io settings
      nvme: flush scan work on passthrough commands
      nvme-pci: remove volatile cqes
      nvme-pci: remove last_sq_tail
      nvme: define constants for identification values
      nvme: set dma alignment to qword

Martijn Coenen (11):
      loop: Call loop_config_discard() only after new config is applied
      loop: Remove sector_t truncation checks
      loop: Factor out setting loop device size
      loop: Switch to set_capacity_revalidate_and_notify()
      loop: Refactor loop_set_status() size calculation
      loop: Remove figure_loop_size()
      loop: Factor out configuring loop from status
      loop: Move loop_set_status_from_info() and friends up
      loop: Rework lo_ioctl() __user argument casting
      loop: Clean up LOOP_SET_STATUS lo_flags handling
      loop: Add LOOP_CONFIGURE ioctl

Martin George (1):
      nvme-fc: print proper nvme-fc devloss_tmo value

Max Gurtovoy (7):
      nvmet-rdma: use SRQ per completion vector
      block: always define struct blk_integrity in genhd.h
      nvme: introduce namespace features flag
      nvme: introduce NVME_NS_METADATA_SUPPORTED flag
      nvme: introduce max_integrity_segments ctrl attribute
      nvme: enforce extended LBA format for fabrics metadata
      nvme-rdma: add metadata/T10-PI support

Sagi Grimberg (8):
      nvme-tcp: use bh_lock in data_ready
      nvme-tcp: avoid scheduling io_work if we are already polling
      nvme-tcp: try to send request in queue_rq context
      nvme-tcp: set MSG_SENDPAGE_NOTLAST with MSG_MORE when we have more to send
      nvmet-tcp: set MSG_SENDPAGE_NOTLAST with MSG_MORE when we have more to send
      nvmet-tcp: set MSG_EOR if we send last payload in the batch
      nvmet-tcp: move send/recv error handling in the send/recv methods instead of call-sites
      nvmet: fix memory leak when removing namespaces and controllers concurrently

Stefan Haberland (1):
      s390/dasd: remove ioctl_by_bdev calls

Weiping Zhang (2):
      nvme-pci: align io queue count with allocted nvme_queue in nvme_probe
      nvme-pci: make sure write/poll_queues less or equal then cpu count

Willy Tarreau (27):
      floppy: split the base port from the register in I/O accesses
      floppy: add references to 82077's extra registers
      floppy: use symbolic register names in the m68k port
      floppy: use symbolic register names in the parisc port
      floppy: use symbolic register names in the powerpc port
      floppy: use symbolic register names in the sparc32 port
      floppy: use symbolic register names in the sparc64 port
      floppy: use symbolic register names in the x86 port
      floppy: cleanup: make twaddle() not rely on current_{fdc,drive} anymore
      floppy: cleanup: make reset_fdc_info() not rely on current_fdc anymore
      floppy: cleanup: make show_floppy() not rely on current_fdc anymore
      floppy: cleanup: make wait_til_ready() not rely on current_fdc anymore
      floppy: cleanup: make output_byte() not rely on current_fdc anymore
      floppy: cleanup: make result() not rely on current_fdc anymore
      floppy: cleanup: make need_more_output() not rely on current_fdc anymore
      floppy: cleanup: make perpendicular_mode() not rely on current_fdc anymore
      floppy: cleanup: make fdc_configure() not rely on current_fdc anymore
      floppy: cleanup: make fdc_specify() not rely on current_{fdc,drive} anymore
      floppy: cleanup: make check_wp() not rely on current_{fdc,drive} anymore
      floppy: cleanup: make next_valid_format() not rely on current_drive anymore
      floppy: cleanup: make get_fdc_version() not rely on current_fdc anymore
      floppy: cleanup: do not iterate on current_fdc in DMA grab/release functions
      floppy: cleanup: add a few comments about expectations in certain functions
      floppy: cleanup: do not iterate on current_fdc in do_floppy_init()
      floppy: make sure to reset all FDCs upon resume()
      floppy: cleanup: get rid of current_reqD in favor of current_drive
      floppy: cleanup: make set_fdc() always set current_drive and current_fd

Wu Bo (1):
      nvme: disable streams when get stream params failed

Xiongfeng Wang (1):
      md: add a newline when printing parameter 'start_ro' by sysfs

Xu Wang (1):
      block/swim3: use set_current_state macro

 MAINTAINERS                                 |   1 +
 arch/alpha/include/asm/floppy.h             |   4 +-
 arch/arm/include/asm/floppy.h               |   8 +-
 arch/m68k/include/asm/floppy.h              |  27 +-
 arch/mips/include/asm/mach-generic/floppy.h |   8 +-
 arch/mips/include/asm/mach-jazz/floppy.h    |   8 +-
 arch/parisc/include/asm/floppy.h            |  19 +-
 arch/powerpc/include/asm/floppy.h           |  19 +-
 arch/sparc/include/asm/floppy_32.h          |  50 +-
 arch/sparc/include/asm/floppy_64.h          |  59 +-
 arch/x86/include/asm/floppy.h               |  19 +-
 block/partitions/ibm.c                      |  24 +-
 drivers/block/floppy.c                      | 466 ++++++++--------
 drivers/block/loop.c                        | 383 +++++++------
 drivers/block/swim.c                        |   6 +-
 drivers/md/bcache/Kconfig                   |   9 +
 drivers/md/bcache/bcache.h                  |   2 +-
 drivers/md/bcache/bset.c                    |   6 +-
 drivers/md/bcache/btree.c                   |  16 +-
 drivers/md/bcache/extents.c                 |  12 +-
 drivers/md/bcache/io.c                      |   8 +-
 drivers/md/bcache/journal.c                 |  34 +-
 drivers/md/bcache/request.c                 |   6 +-
 drivers/md/bcache/super.c                   | 232 +++++---
 drivers/md/bcache/sysfs.c                   |   8 +-
 drivers/md/bcache/writeback.c               |   6 +-
 drivers/md/md-linear.h                      |   2 +-
 drivers/md/md.c                             |  71 ++-
 drivers/md/md.h                             |   1 +
 drivers/md/raid1.c                          |  13 +-
 drivers/md/raid1.h                          |   2 +-
 drivers/md/raid10.h                         |   2 +-
 drivers/md/raid5.c                          |  22 +-
 drivers/nvme/host/core.c                    | 322 ++++++-----
 drivers/nvme/host/fc.c                      | 577 +++++++++++++++----
 drivers/nvme/host/fc.h                      | 227 ++++++++
 drivers/nvme/host/lightnvm.c                |   7 +-
 drivers/nvme/host/multipath.c               |  16 +-
 drivers/nvme/host/nvme.h                    |  28 +-
 drivers/nvme/host/pci.c                     | 117 ++--
 drivers/nvme/host/rdma.c                    | 321 ++++++++++-
 drivers/nvme/host/tcp.c                     |  64 ++-
 drivers/nvme/target/Kconfig                 |   1 +
 drivers/nvme/target/admin-cmd.c             |  42 +-
 drivers/nvme/target/configfs.c              | 272 +++++----
 drivers/nvme/target/core.c                  | 166 ++++--
 drivers/nvme/target/discovery.c             |   8 +-
 drivers/nvme/target/fabrics-cmd.c           |  15 +-
 drivers/nvme/target/fc.c                    | 805 +++++++++++++++++++--------
 drivers/nvme/target/fcloop.c                | 155 +++++-
 drivers/nvme/target/io-cmd-bdev.c           | 118 +++-
 drivers/nvme/target/io-cmd-file.c           |  23 +-
 drivers/nvme/target/nvmet.h                 |  36 +-
 drivers/nvme/target/rdma.c                  | 416 +++++++++++---
 drivers/nvme/target/tcp.c                   |  53 +-
 drivers/nvme/target/trace.h                 |  28 +
 drivers/s390/block/dasd_ioctl.c             |  76 ++-
 drivers/scsi/lpfc/lpfc.h                    |   2 +-
 drivers/scsi/lpfc/lpfc_attr.c               |   3 -
 drivers/scsi/lpfc/lpfc_crtn.h               |   9 +-
 drivers/scsi/lpfc/lpfc_ct.c                 |   1 -
 drivers/scsi/lpfc/lpfc_debugfs.c            |   5 +-
 drivers/scsi/lpfc/lpfc_hbadisc.c            |   8 +-
 drivers/scsi/lpfc/lpfc_init.c               |   7 +-
 drivers/scsi/lpfc/lpfc_mem.c                |   4 -
 drivers/scsi/lpfc/lpfc_nportdisc.c          |  13 +-
 drivers/scsi/lpfc/lpfc_nvme.c               | 491 ++++++++++------
 drivers/scsi/lpfc/lpfc_nvme.h               | 180 ++++++
 drivers/scsi/lpfc/lpfc_nvmet.c              | 833 +++++++++++++++++-----------
 drivers/scsi/lpfc/lpfc_nvmet.h              | 158 ------
 drivers/scsi/lpfc/lpfc_sli.c                | 128 ++++-
 fs/block_dev.c                              |  12 -
 include/linux/dasd_mod.h                    |   9 +
 include/linux/fs.h                          |   1 -
 include/linux/genhd.h                       |   4 -
 include/linux/nvme-fc-driver.h              | 368 ++++++++----
 include/linux/nvme-fc.h                     |  11 +-
 include/linux/nvme.h                        |  16 +-
 include/uapi/linux/fd.h                     |  26 +-
 include/uapi/linux/fdreg.h                  |  16 +-
 include/uapi/linux/loop.h                   |  31 +-
 81 files changed, 5429 insertions(+), 2353 deletions(-)
 create mode 100644 drivers/nvme/host/fc.h
 delete mode 100644 drivers/scsi/lpfc/lpfc_nvmet.h
 create mode 100644 include/linux/dasd_mod.h

-- 
Jens Axboe

