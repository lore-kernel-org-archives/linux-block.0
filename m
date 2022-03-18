Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6231CC433F5
	for <linux-block@archiver.kernel.org>; Fri, 18 Mar 2022 21:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241206AbiCRWAy (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Fri, 18 Mar 2022 18:00:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241235AbiCRWAx (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Fri, 18 Mar 2022 18:00:53 -0400
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79EDDFD6EA
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 14:59:32 -0700 (PDT)
Received: by mail-pf1-x435.google.com with SMTP id s42so10682517pfg.0
        for <linux-block@vger.kernel.org>; Fri, 18 Mar 2022 14:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:subject:to:cc
         :content-language:content-transfer-encoding;
        bh=NJK5pW5HqTX+YYe9PhRkxYIYzPGqa/m2nevw3Gp6UwY=;
        b=XIZUY5b3doW7Gyzy8xDjeKTnl+Y33NSd1IUD5Sxw54yqy2PtiLRm7PRZIYi3jXM+Cu
         pVH8+2Xjyg0mUtrH1McEa8mcfyQ4IdQQ7aCJpNR0K/L9kGMz4NKEPN5ueqv0LVcByyRP
         iLMw08OK+Cy6jbl4be/7NOK/0kZ/NLTr/BEJegY2rDvkWCwtcWMdyvzg3ZSlAQF+YVhY
         5f3YvIopkwNxN0To85YdtaCidFcCcMfuPIHpbwdmOejzn6F9+8fnwbdLlyFjoDPan3N+
         6KtU9SrRBguWaTIWmw+ruViB++zgs8S8n90MatmcfUfrIkeBOkbxnl9McWAG3L4FtGP/
         LNnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from
         :subject:to:cc:content-language:content-transfer-encoding;
        bh=NJK5pW5HqTX+YYe9PhRkxYIYzPGqa/m2nevw3Gp6UwY=;
        b=klOH0rqrFY3IFa1NOUIRML0z9tMtbH3B6ujN+BiuEKR/xuQftFkUfdpPW8Dvd/zlMC
         suB3RduJDyxF8d98PSoxsEv7bgsD5kWcywH9gVFGhruTMGMkp1mz6B0aDlVRHod403Xj
         dCV82IuNQhCxyykOh3XCogt8YHPAOaMqcwsJJdjbMhCLF4sOoVUIaIJ4PKeCCox9bv5p
         Tlb7fPMMm2NJfZ9KpJ8SXrBkk2gsdMq4aijbDUETd+jEDTf7EAB9t60fz4a3c1zSHZuJ
         om2fkdeKDZdFxxzsicid5BHGcUia+5gmNlnrLGDmZxsne3WpTRoiThiuFp+TJRVOCVTs
         4dqg==
X-Gm-Message-State: AOAM532RHe2w1Fv3sZQKsjQda9nYDte/eQTDS4Cs4bF4czZtrs0mKwqe
        umJYtyB4AsRHEfxDG99fA9N37BAOL0KP3xkh
X-Google-Smtp-Source: ABdhPJy4mJW+0LFq/e43jNCRc7jO56iXy0BOVQl/BxIq0uwmkRNcVPz1Wrl8TnrUpLBaTmPUY9rsVQ==
X-Received: by 2002:a63:4f08:0:b0:34c:6090:603e with SMTP id d8-20020a634f08000000b0034c6090603emr9133118pgb.15.1647640771756;
        Fri, 18 Mar 2022 14:59:31 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id nn15-20020a17090b38cf00b001b90c745188sm9010564pjb.25.2022.03.18.14.59.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Mar 2022 14:59:31 -0700 (PDT)
Message-ID: <83ce22b4-bae1-9c97-1ad5-10835d6c5424@kernel.dk>
Date:   Fri, 18 Mar 2022 15:59:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block driver updates for 5.18-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

On top of the core block updates for the 5.18-rc1 merge window, here are
the driver updates for this merge window. In detail:

- NVMe updates via Christoph:
	- add vectored-io support for user-passthrough (Kanchan Joshi)
	- add verbose error logging (Alan Adamson)
	- support buffered I/O on block devices in nvmet (Chaitanya Kulkarni)
	- central discovery controller support (Martin Belanger)
	- fix and extended the globally unique idenfier validation
	  (Christoph)
	- move away from the deprecated IDA APIs (Sagi Grimberg)
	- misc code cleanup (Keith Busch, Max Gurtovoy, Qinghua Jin,
	  Chaitanya Kulkarni)
	- add lockdep annotations for in-kernel sockets (Chris Leech)
	- use vmalloc for ANA log buffer (Hannes Reinecke)
	- kerneldoc fixes (Chaitanya Kulkarni)
	- cleanups (Guoqing Jiang, Chaitanya Kulkarni, Christoph)
	- warn about shared namespaces without multipathing (Christoph)

- MD updates via Song with a set of cleanups (Christoph, Mariusz, Paul,
  Erik, Dirk)

- loop cleanups and queue depth configuration (Chaitanya)

- null_blk cleanups and fixes (Chaitanya)

- Use descriptive init/exit names in virtio_blk (Randy)

- Use bvec_kmap_local() in drivers (Christoph)

- bcache fixes (Mingzhe)

- xen blk-front persistent grant speedups (Juergen)

- rnbd fix and cleanup (Gioh)

- Misc fixes (Christophe, Colin)

This will throw a merge conflict in drivers/nvme/target/configfs.c,
resolution is just to delete the two discovery helpers and the configfs
attribute, basically everything in the conflict section. This is due to
conflicting with a last minute revert in 5.17.

Please pull!


The following changes since commit 451f0b6f4c44d7b649ae609157b114b71f6d7875:

  block: default BLOCK_LEGACY_AUTOLOAD to y (2022-02-27 14:49:23 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.18/drivers-2022-03-18

for you to fetch changes up to ae53aea611b7a532a52ba966281a8b7a8cfd008a:

  Merge tag 'nvme-5.18-2022-03-17' of git://git.infradead.org/nvme into for-5.18/drivers (2022-03-17 20:46:22 -0600)

----------------------------------------------------------------
for-5.18/drivers-2022-03-18

----------------------------------------------------------------
Alan Adamson (1):
      nvme: add verbose error logging

Chaitanya Kulkarni (24):
      null_blk: fix return value from null_add_dev()
      loop: use sysfs_emit() in the sysfs xxx show()
      loop: remove extra variable in lo_fallocate()
      loop: remove extra variable in lo_req_flush
      loop: allow user to set the queue depth
      null_blk: remove hardcoded alloc_cmd() parameter
      null_blk: remove hardcoded null_alloc_page() param
      null_blk: null_alloc_page() cleanup
      nvme-core: remove unnecessary semicolon
      nvme-core: remove unnecessary function parameter
      nvme-fabrics: use unsigned int type
      nvme-fabrics: use unsigned int type
      nvme-fabrics: use consistent zeroout pattern
      nvme-fabrics: remove unnecessary braces for case
      nvmet: use i_size_read() to set size for file-ns
      nvmet: allow bdev in buffered_io mode
      nvme: add a helper to initialize connect_q
      nvme-tcp: don't initialize ret variable
      nvme-tcp: don't fold the line
      nvmet-fc: fix kernel-doc warning for nvmet_fc_register_targetport
      nvmet-fc: fix kernel-doc warning for nvmet_fc_unregister_targetport
      nvmet-rdma: fix kernel-doc warning for nvmet_rdma_device_removal
      nvmet: don't fold lines
      nvmet: use snprintf() with PAGE_SIZE in configfs

Chris Leech (1):
      nvme-tcp: lockdep: annotate in-kernel sockets

Christoph Hellwig (22):
      nvme: cleanup __nvme_check_ids
      nvme: fix the check for duplicate unique identifiers
      nvme: check for duplicate identifiers earlier
      nvme: check that EUI/GUID/UUID are globally unique
      iss-simdisk: use bvec_kmap_local in simdisk_submit_bio
      aoe: use bvec_kmap_local in bvcpy
      zram: use memcpy_to_bvec in zram_bvec_read
      zram: use memcpy_from_bvec in zram_bvec_write
      nvdimm-blk: use bvec_kmap_local in nd_blk_rw_integrity
      nvdimm-btt: use bvec_kmap_local in btt_rw_integrity
      bcache: use bvec_kmap_local in bio_csum
      drbd: use bvec_kmap_local in drbd_csum_bio
      drbd: use bvec_kmap_local in recv_dless_read
      floppy: use memcpy_{to,from}_bvec
      raid5-ppl: fully initialize the bio in ppl_new_iounit
      raid5-cache: fully initialize flush_bio when needed
      raid5-cache: statically allocate the recovery ra bio
      raid5: initialize the stripe_head embeeded bios as needed
      nvmet: move the call to nvmet_ns_changed out of nvmet_ns_revalidate
      nvme: cleanup how disk->disk_name is assigned
      nvme: remove nvme_alloc_request and nvme_alloc_request_qid
      nvme: warn about shared namespaces without CONFIG_NVME_MULTIPATH

Christophe JAILLET (1):
      block/rnbd: Remove a useless mutex

Colin Ian King (1):
      loop: clean up grammar in warning message

Dirk Müller (1):
      lib/raid6/test: fix multiple definition linking error

Eric Dumazet (1):
      md: use msleep() in md_notify_reboot()

Gioh Kim (2):
      block/rnbd-clt: fix CHECK:BRACES warning
      block/rnbd: client device does not care queue/rotational

Guoqing Jiang (1):
      nvme-multipath: call bio_io_error in nvme_ns_head_submit_bio

Hannes Reinecke (1):
      nvme-multipath: use vmalloc for ANA log buffer

Jens Axboe (5):
      Merge tag 'nvme-5.18-2022-03-03' of git://git.infradead.org/nvme into for-5.18/drivers
      Merge branch 'for-next' of git://git.kernel.org/pub/scm/linux/kernel/git/colyli/linux-bcache into for-5.18/drivers
      Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.18/drivers
      Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.18/drivers
      Merge tag 'nvme-5.18-2022-03-17' of git://git.infradead.org/nvme into for-5.18/drivers

Juergen Gross (1):
      xen/blkfront: speed up purge_persistent_grants()

Kanchan Joshi (1):
      nvme: add vectored-io support for user-passthrough

Keith Busch (2):
      nvme: explicitly set non-error for directives
      nvme: remove nssa from struct nvme_ctrl

Mariusz Tkaczyk (1):
      md: raid1/raid10: drop pending_cnt

Martin Belanger (2):
      nvme: send uevent on connection up
      nvme: expose cntrltype and dctype through sysfs

Max Gurtovoy (1):
      nvme-rdma: add helpers for mapping/unmapping request

Mingzhe Zou (2):
      bcache: fixup bcache_dev_sectors_dirty_add() multithreaded CPU false sharing
      bcache: fixup multiple threads crash

Paul Menzel (2):
      lib/raid6/test/Makefile: Use $(pound) instead of \# for Make 4.3
      lib/raid6: Include <asm/ppc-opcode.h> for VPERMXOR

Qinghua Jin (1):
      nvme-fc: fix a typo

Randy Dunlap (1):
      virtio_blk: eliminate anonymous module_init & module_exit

Sagi Grimberg (6):
      nvme: replace ida_simple[get|remove] with the simler ida_[alloc|free]
      nvme-fc: replace ida_simple[get|remove] with the simler ida_[alloc|free]
      nvmet: replace ida_simple[get|remove] with the simler ida_[alloc|free]
      nvmet-fc: replace ida_simple[get|remove] with the simler ida_[alloc|free]
      nvmet-rdma: replace ida_simple[get|remove] with the simler ida_[alloc|free]
      nvmet-tcp: replace ida_simple[get|remove] with the simler ida_[alloc|free]

 arch/xtensa/platforms/iss/simdisk.c |   4 +-
 drivers/block/aoe/aoecmd.c          |   4 +-
 drivers/block/drbd/drbd_receiver.c  |   4 +-
 drivers/block/drbd/drbd_worker.c    |   6 +-
 drivers/block/floppy.c              |   6 +-
 drivers/block/loop.c                |  42 ++++--
 drivers/block/null_blk/main.c       |  54 ++++----
 drivers/block/rnbd/rnbd-clt.c       |  26 ++--
 drivers/block/rnbd/rnbd-clt.h       |   1 -
 drivers/block/rnbd/rnbd-proto.h     |   4 +-
 drivers/block/rnbd/rnbd-srv.c       |   1 -
 drivers/block/virtio_blk.c          |   8 +-
 drivers/block/xen-blkfront.c        |   5 +-
 drivers/block/zram/zram_drv.c       |   9 +-
 drivers/md/bcache/btree.c           |   6 +-
 drivers/md/bcache/request.c         |   4 +-
 drivers/md/bcache/writeback.c       |  17 ++-
 drivers/md/md.c                     |   2 +-
 drivers/md/raid1-10.c               |   5 +
 drivers/md/raid1.c                  |  11 --
 drivers/md/raid1.h                  |   1 -
 drivers/md/raid10.c                 |  17 +--
 drivers/md/raid10.h                 |   1 -
 drivers/md/raid5-cache.c            |  33 +++--
 drivers/md/raid5-ppl.c              |   5 +-
 drivers/md/raid5.c                  |  25 ++--
 drivers/nvdimm/blk.c                |   7 +-
 drivers/nvdimm/btt.c                |  10 +-
 drivers/nvme/host/Kconfig           |   8 ++
 drivers/nvme/host/Makefile          |   2 +-
 drivers/nvme/host/constants.c       | 185 +++++++++++++++++++++++++
 drivers/nvme/host/core.c            | 268 +++++++++++++++++++++++++-----------
 drivers/nvme/host/fabrics.c         |   9 +-
 drivers/nvme/host/fc.c              |  22 ++-
 drivers/nvme/host/ioctl.c           |  38 +++--
 drivers/nvme/host/multipath.c       |  32 +----
 drivers/nvme/host/nvme.h            |  47 +++++--
 drivers/nvme/host/pci.c             |  17 ++-
 drivers/nvme/host/rdma.c            | 117 +++++++++-------
 drivers/nvme/host/tcp.c             |  51 ++++++-
 drivers/nvme/target/admin-cmd.c     |   6 +-
 drivers/nvme/target/configfs.c      |  30 ++--
 drivers/nvme/target/core.c          |   9 +-
 drivers/nvme/target/fc.c            |  16 +--
 drivers/nvme/target/io-cmd-bdev.c   |   8 ++
 drivers/nvme/target/io-cmd-file.c   |  17 +--
 drivers/nvme/target/loop.c          |   6 +-
 drivers/nvme/target/nvmet.h         |   4 +-
 drivers/nvme/target/passthru.c      |   3 +-
 drivers/nvme/target/rdma.c          |   8 +-
 drivers/nvme/target/tcp.c           |   6 +-
 drivers/nvme/target/zns.c           |   6 +-
 include/linux/nvme-fc-driver.h      |   2 +-
 include/linux/nvme.h                |  11 +-
 include/uapi/linux/nvme_ioctl.h     |   6 +-
 lib/raid6/test/Makefile             |   4 +-
 lib/raid6/test/test.c               |   1 -
 lib/raid6/vpermxor.uc               |   2 +-
 58 files changed, 820 insertions(+), 439 deletions(-)
 create mode 100644 drivers/nvme/host/constants.c

-- 
Jens Axboe

