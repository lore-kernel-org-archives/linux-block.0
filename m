Return-Path: <SRS0=uCqz=BO=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE0A9C433DF
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 15:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78B24207FC
	for <linux-block@archiver.kernel.org>; Tue,  4 Aug 2020 15:39:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20150623.gappssmtp.com header.i=@kernel-dk.20150623.gappssmtp.com header.b="Lxb0Narp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725950AbgHDPjY (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Aug 2020 11:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725924AbgHDPjW (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Aug 2020 11:39:22 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB202C06174A
        for <linux-block@vger.kernel.org>; Tue,  4 Aug 2020 08:39:22 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id t4so34557636iln.1
        for <linux-block@vger.kernel.org>; Tue, 04 Aug 2020 08:39:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=j8lQtan6aHB9X/jKjOXtRDcjACwVSfziQNcIcTQGuIM=;
        b=Lxb0NarpMnsYaxZQvhn0y6vlP9KZxcNr1OyjKbgBtBSSrGmIAnWFaI0+IxE8PrfKVy
         lqXxvwfoR0w7tlZodyCTqmWaJ/QDPVHWodrkVCLSLB4aIUwEEXj+3cPgN9Gx/pBKRSC9
         s1Vm3BtDd0MlYpwK9cw84Df6X0MGihs3iQQe3MWkld8xx8ilxzeNeUwm/WisJetH0egW
         /Yg3Bnh1dsXunaQCPi8XQJ6mE4A8/K9rPnRzacfc0aYI0eM7T/oLMVt5L/0F/nn4YPxT
         mugtEvXMd1CJauXlUfdG42A0okrx+6jFLMGnBs/0SJupbMePTqdcdpO9JvCIDsoJe7uL
         fpUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=j8lQtan6aHB9X/jKjOXtRDcjACwVSfziQNcIcTQGuIM=;
        b=Pwhvudep66EdWM5Pz2wcE/XZuQhFkzyOPlBPb3Lfa9mCvkSLJCBS3mGYp/3KkLvlKw
         MYpMnTM+TXzJa0V7bhIVbE6fbRfIWw13nRvS+dTR6CdOUofIQOKZGRVHVUvPMKEuYydB
         yOf57//64rXeHIknI2fYGj0hbSPczDDO8TcvG1g8In0vnSRHMRJYzwHXGtpyk7x6c2IZ
         V9EQUYUqDj0Mi4L8whpD7+vKXTMn4CD+d9iQp4Ovxt9k1SI0WJTdpF4aYY4vCZESPJNW
         E9jwDaz9t+fvIbQBoeJrqBiR+E6ay/0NvhX6ycegKHLvb8DM5+SpsMMqlC4cJub6rOVD
         H+oQ==
X-Gm-Message-State: AOAM532YXuELLxpqSVv2ZGx0dMvi/xStHQpnraodW0XTP+osy8o7U1B3
        XzgJyQHsqEtNw1/ku6ZmMapwjpLJ44s=
X-Google-Smtp-Source: ABdhPJzp63wRoMJZ+a2YkogCqvoJFHD1+suMC+q93rh4eglTJyTkIvnVQCwlhap/PtyLoAL5ywbS9w==
X-Received: by 2002:a92:8b51:: with SMTP id i78mr5230447ild.179.1596555560567;
        Tue, 04 Aug 2020 08:39:20 -0700 (PDT)
Received: from [192.168.1.58] ([65.144.74.34])
        by smtp.gmail.com with ESMTPSA id c14sm12710005ild.41.2020.08.04.08.39.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Aug 2020 08:39:20 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block driver changes for 5.9-rc1
Message-ID: <ea8f5f71-477c-1668-cef6-a30c8d1aa3e6@kernel.dk>
Date:   Tue, 4 Aug 2020 09:39:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

Changes in this pull request:

- NVMe
	- ZNS support (Aravind, Keith, Matias, Niklas)
	- Misc cleanups, optimizations, fixes (Baolin, Chaitanya, David,
		Dongli, Max, Sagi)

- null_blk zone capacity support (Aravind)

- MD
	- raid5/6 fixes (ChangSyun)
	- Warning fixes (Damien)
	- raid5 stripe fixes (Guoqing, Song, Yufen)
	- sysfs deadlock fix (Junxiao)
	- raid10 deadlock fix (Vitaly)

- struct_size conversions (Gustavo)

- Set of bcache updates/fixes (Coly)


Please pull!

The following changes since commit 0e6e255e7a58cdf4ee4163f83deeb5ce4946051e:

  block: remove a bogus warning in __submit_bio_noacct_mq (2020-07-07 11:45:59 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.9/drivers-20200803

for you to fetch changes up to f59589fc89665102923725e80e12f782d5f74f67:

  Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.9/drivers (2020-08-03 06:38:44 -0600)

----------------------------------------------------------------
for-5.9/drivers-20200803

----------------------------------------------------------------
Aravind Ramesh (1):
      null_blk: introduce zone capacity for zoned device

Artur Paszkiewicz (1):
      md: improve io stats accounting

Baolin Wang (7):
      nvme: use USEC_PER_SEC instead of magic numbers
      nvme-pci: remove redundant segment validation
      nvme-pci: fix some comments issues
      nvme-pci: add a blank line after declarations
      nvme-pci: use the consistent return type of nvme_pci_iod_alloc_size()
      nvme-pci: use standard block status symbolic names
      nvme: remove redundant validation in nvme_start_ctrl()

Chaitanya Kulkarni (11):
      nvme-core: use u16 type for directives
      nvme-core: use u16 type for ctrl->sqsize
      nvme-pci: use unsigned for io queue depth
      nvme-pci: code cleanup for nvme_alloc_host_mem()
      nvmet: use unsigned type for u64
      nvme-core: replace ctrl page size with a macro
      nvme-pci: use max of PRP or SGL for iod size
      nvmet: use xarray for ctrl ns storing
      nvmet: introduce the passthru Kconfig option
      nvme-loop: set ctrl state connecting after init
      nvme-loop: remove extra variable in create ctrl

ChangSyun Peng (2):
      md/raid5: Fix Force reconstruct-write io stuck in degraded raid5
      md/raid5: Allow degraded raid6 to do rmw

Christoph Hellwig (1):
      nvme: remove ns->disk checks

Christophe JAILLET (1):
      rsxx: switch from 'pci_free_consistent()' to 'dma_free_coherent()'

Colin Ian King (1):
      md: raid0/linear: fix dereference before null check on pointer mddev

Coly Li (21):
      bcache: allocate meta data pages as compound pages
      bcache: avoid nr_stripes overflow in bcache_device_init()
      bcache: fix overflow in offset_to_stripe()
      bcache: add read_super_common() to read major part of super block
      bcache: add more accurate error information in read_super_common()
      bcache: disassemble the big if() checks in bch_cache_set_alloc()
      bcache: fix super block seq numbers comparision in register_cache_set()
      bcache: increase super block version for cache device and backing device
      bcache: move bucket related code into read_super_common()
      bcache: struct cache_sb is only for in-memory super block now
      bcache: introduce meta_bucket_pages() related helper routines
      bcache: handle c->uuids properly for bucket size > 8MB
      bcache: handle cache prio_buckets and disk_buckets properly for bucket size > 8MB
      bcache: handle cache set verify_ondisk properly for bucket size > 8MB
      bcache: handle btree node memory allocation properly for bucket size > 8MB
      bcache: add bucket_size_hi into struct cache_sb_disk for large bucket
      bcache: add sysfs file to display feature sets information of cache set
      bcache: avoid extra memory allocation from mempool c->fill_iter
      bcache: avoid extra memory consumption in struct bbio for large bucket size
      bcache: fix bio_{start,end}_io_acct with proper device
      bcache: use disk_{start,end}_io_acct() to count I/O for bcache device

Damien Le Moal (4):
      md: Fix compilation warning
      md: raid5-cache: Remove set but unused variable
      md: raid5: Fix compilation warning
      md: raid10: Fix compilation warning

Dan Carpenter (1):
      nvme: remove an unnecessary condition

David E. Box (1):
      nvme-pci: add support for ACPI StorageD3Enable property

David Fugate (1):
      nvme: document quirked Intel models

Dongli Zhang (3):
      nvme-pci: remove the empty line at the beginning of nvme_should_reset()
      nvmet-loop: remove unused 'target_ctrl' in nvme_loop_ctrl
      nvme-fcloop: verify wwnn and wwpn format

Guoqing Jiang (7):
      raid5: call clear_batch_ready before set STRIPE_ACTIVE
      raid5: put the comment of clear_batch_ready to the right place
      raid5: remove the meaningless check in raid5_make_request
      md/raid5: remove the redundant setting of STRIPE_HANDLE
      md: print errno in super_written
      raid5-cache: hold spinlock instead of mutex in r5c_journal_mode_show
      raid5: don't duplicate code for different paths in handle_stripe

Gustavo A. R. Silva (3):
      s390/dasd: Use struct_size() helper
      bcache: movinggc: Use struct_size() helper in kzalloc()
      bcache: Use struct_size() in kzalloc()

Hannes Reinecke (1):
      nvme-multipath: do not fall back to __nvme_find_path() for non-optimized paths

James Smart (3):
      nvme-fc: set max_segments to lldd max value
      nvmet-fc: check successful reference in nvmet_fc_find_target_assoc
      nvmet-fc: remove redundant del_work_active flag

Jean Delvare (1):
      bcache: Fix typo in Kconfig name

Jens Axboe (8):
      Merge tag 'v5.8-rc4' into for-5.9/drivers
      Merge branch 'nvme-5.9' of git://git.infradead.org/nvme into for-5.9/drivers
      Merge branch 'md-next' of https://git.kernel.org/.../song/md into for-5.9/drivers
      Merge branch 'md-next' of https://git.kernel.org/.../song/md into for-5.9/drivers
      Merge branch 'md-next' of https://git.kernel.org/.../song/md into for-5.9/drivers
      Merge branch 'nvme-5.9' of git://git.infradead.org/nvme into for-5.9/drivers
      Merge branch 'md-next' of https://git.kernel.org/.../song/md into for-5.9/drivers

Junxiao Bi (1):
      md: fix deadlock causing by sysfs_notify

Keith Busch (2):
      nvme: support for multiple Command Sets Supported and Effects log pages
      nvme: support for zoned namespaces

Logan Gunthorpe (8):
      nvme: clear any SGL flags in passthru commands
      nvme: create helper function to obtain command effects
      nvme: introduce nvme_execute_passthru_rq to call nvme_passthru_[start|end]()
      nvme: introduce nvme_ctrl_get_by_path()
      nvme: export nvme_find_get_ns() and nvme_put_ns()
      nvmet: add passthru code to process commands
      nvmet: Add passthru enable/disable helpers
      nvmet: introduce the passthru configfs interface

Martin Wilck (1):
      nvme-multipath: fix logic for non-optimized paths

Matias Bjørling (1):
      block: add capacity field to zone descriptors

Max Gurtovoy (2):
      nvmet-tcp: remove has_keyed_sgls initialization
      nvmet: introduce flags member in nvmet_fabrics_ops

Niklas Cassel (3):
      nvme: implement multiple I/O Command Set support
      block: add max_open_zones to blk-sysfs
      block: add max_active_zones to blk-sysfs

Randy Dunlap (2):
      raid: md_p.h: drop duplicated word in a comment
      nvme-fc: drop a duplicated word in a comment

Sagi Grimberg (10):
      nvme-tcp: have queue prod/cons send list become a llist
      nvme-tcp: leverage request plugging
      nvme-tcp: optimize network stack with setting msg flags according to batch size
      nvmet-tcp: simplify nvmet_process_resp_list
      nvme: expose reconnect_delay and ctrl_loss_tmo via sysfs
      nvme: document nvme controller states
      nvme: fix deadlock in disconnect during scan_work and/or ana_work
      nvme-hwmon: log the controller device name
      nvme-tcp: fix controller reset hang during traffic
      nvme-rdma: fix controller reset hang during traffic

Sebastian Parschauer (1):
      md: register new md sysfs file 'uuid' read-only

Song Liu (1):
      md/raid5-cache: clear MD_SB_CHANGE_PENDING before flushing stripes

Stefan Haberland (1):
      s390/dasd: fix inability to use DASD with DIAG driver

Vitaly Mayatskikh (1):
      md/raid10: avoid deadlock on recovery.

Xiao Ni (1):
      md: fix max sectors calculation for super 1.0

Xu Wang (2):
      bcache: journel: use for_each_clear_bit() to simplify the code
      bcache: writeback: Remove unneeded variable i

Yamin Friedman (2):
      nvme-rdma: use new shared CQ mechanism
      nvmet-rdma: use new shared CQ mechanism

Yufen Yu (4):
      md/raid456: convert macro STRIPE_* to RAID5_STRIPE_*
      md/raid5: set default stripe_size as 4096
      md/raid5: support config stripe_size by sysfs entry
      md/raid5: use do_div() for 64 bit divisions in raid5_sync_request

Zhao Heming (3):
      md-cluster: fix wild pointer of unlock_all_bitmaps()
      md-cluster: fix safemode_delay value when converting to clustered bitmap
      md-cluster: fix rmmod issue when md_cluster convert bitmap to none

 Documentation/ABI/testing/sysfs-block |  18 ++
 Documentation/admin-guide/md.rst      |   4 +
 Documentation/block/queue-sysfs.rst   |  14 +
 block/Kconfig                         |   5 +-
 block/blk-sysfs.c                     |  27 ++
 block/blk-zoned.c                     |   1 +
 drivers/acpi/property.c               |   3 +
 drivers/block/null_blk.h              |   1 +
 drivers/block/null_blk_main.c         |  10 +-
 drivers/block/null_blk_zoned.c        |  16 +-
 drivers/block/rsxx/core.c             |  30 +-
 drivers/md/bcache/Kconfig             |   2 +-
 drivers/md/bcache/Makefile            |   2 +-
 drivers/md/bcache/alloc.c             |   2 +-
 drivers/md/bcache/bcache.h            |  31 +-
 drivers/md/bcache/bset.c              |   2 +-
 drivers/md/bcache/btree.c             |  12 +-
 drivers/md/bcache/features.c          |  75 +++++
 drivers/md/bcache/features.h          |  86 ++++++
 drivers/md/bcache/io.c                |   2 +-
 drivers/md/bcache/journal.c           |   9 +-
 drivers/md/bcache/movinggc.c          |   8 +-
 drivers/md/bcache/request.c           |  14 +-
 drivers/md/bcache/super.c             | 277 +++++++++++------
 drivers/md/bcache/sysfs.c             |  14 +
 drivers/md/bcache/writeback.c         |  22 +-
 drivers/md/bcache/writeback.h         |  19 +-
 drivers/md/md-bitmap.c                |   2 +-
 drivers/md/md-cluster.c               |   1 +
 drivers/md/md.c                       | 181 ++++++++---
 drivers/md/md.h                       |   9 +-
 drivers/md/raid10.c                   |  20 +-
 drivers/md/raid5-cache.c              |  28 +-
 drivers/md/raid5-ppl.c                |  11 +-
 drivers/md/raid5.c                    | 386 ++++++++++++++---------
 drivers/md/raid5.h                    |  53 ++--
 drivers/nvme/host/Makefile            |   1 +
 drivers/nvme/host/core.c              | 561 +++++++++++++++++++++++++---------
 drivers/nvme/host/fabrics.c           |   2 +-
 drivers/nvme/host/fabrics.h           |   3 +-
 drivers/nvme/host/fc.c                |   6 +-
 drivers/nvme/host/hwmon.c             |   5 +-
 drivers/nvme/host/lightnvm.c          |   4 +-
 drivers/nvme/host/multipath.c         |  37 ++-
 drivers/nvme/host/nvme.h              |  86 +++++-
 drivers/nvme/host/pci.c               | 190 ++++++++----
 drivers/nvme/host/rdma.c              |  99 ++++--
 drivers/nvme/host/tcp.c               | 100 ++++--
 drivers/nvme/host/zns.c               | 256 ++++++++++++++++
 drivers/nvme/target/Kconfig           |  12 +
 drivers/nvme/target/Makefile          |   1 +
 drivers/nvme/target/admin-cmd.c       |  26 +-
 drivers/nvme/target/configfs.c        | 117 ++++++-
 drivers/nvme/target/core.c            |  79 ++---
 drivers/nvme/target/discovery.c       |   2 +-
 drivers/nvme/target/fc.c              |  30 +-
 drivers/nvme/target/fcloop.c          |  29 +-
 drivers/nvme/target/loop.c            |  14 +-
 drivers/nvme/target/nvmet.h           |  60 +++-
 drivers/nvme/target/passthru.c        | 544 +++++++++++++++++++++++++++++++++
 drivers/nvme/target/rdma.c            |  17 +-
 drivers/nvme/target/tcp.c             |  13 +-
 drivers/s390/block/dasd_diag.c        |  33 +-
 drivers/scsi/sd_zbc.c                 |   6 +
 include/linux/blkdev.h                |  50 +++
 include/linux/nvme-fc-driver.h        |   2 +-
 include/linux/nvme.h                  | 138 ++++++++-
 include/uapi/linux/bcache.h           |  38 ++-
 include/uapi/linux/blkzoned.h         |  15 +-
 include/uapi/linux/raid/md_p.h        |   2 +-
 70 files changed, 3149 insertions(+), 826 deletions(-)
 create mode 100644 drivers/md/bcache/features.c
 create mode 100644 drivers/md/bcache/features.h
 create mode 100644 drivers/nvme/host/zns.c
 create mode 100644 drivers/nvme/target/passthru.c

-- 
Jens Axboe

