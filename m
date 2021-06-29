Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E38CBC11F67
	for <linux-block@archiver.kernel.org>; Tue, 29 Jun 2021 19:55:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9EB461D9A
	for <linux-block@archiver.kernel.org>; Tue, 29 Jun 2021 19:55:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232615AbhF2T6L (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 29 Jun 2021 15:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232315AbhF2T6L (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 29 Jun 2021 15:58:11 -0400
Received: from mail-io1-xd2c.google.com (mail-io1-xd2c.google.com [IPv6:2607:f8b0:4864:20::d2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7320EC061760
        for <linux-block@vger.kernel.org>; Tue, 29 Jun 2021 12:55:43 -0700 (PDT)
Received: by mail-io1-xd2c.google.com with SMTP id k11so189142ioa.5
        for <linux-block@vger.kernel.org>; Tue, 29 Jun 2021 12:55:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=COoFVYyZ6Voor5XYzuxZL4LrYEcS01CrLaooJmAT7cU=;
        b=cyeC7yD+5vs60ztOZsemoUxZEGmk4m7O4OKVlrUB/LarAT1HReZTNyAc2vo3TVN1sH
         SkE5tjapsWJcdCFxwJJdHkiSQBNNTaBdfR5D3YmdMtbqN7ZZcsmPhMT298QVWC5SH06x
         PlUHqW3/lrlDsh4xv+zHa2xror6hN+P9TwG+1XaopZlUXPkEnSBzpFMlcuyBJQME7CIm
         Uu4DYTcESOqJmbs3nck8htXQPS3I6isvMuA+01NTzKH6ONNKUQ+7eNiCkhBrX70ni0Mx
         6leXIHYODSEYhul0LrHYw6PtjmQEy3vjMGRFMBL1Mw0dOp3xD+vzZL6luIYUuUGsCLcX
         S9BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=COoFVYyZ6Voor5XYzuxZL4LrYEcS01CrLaooJmAT7cU=;
        b=LK3UAZA5kPU4ICpF6EHn6rE66d2FQAnHUCuOhALIgdt78VTRuRcZq4Va8+ERBzJSJG
         eQma+borXWs57uWaJqmSM2QSbXthOUoWHKeO0UKGgrlHb9kyPN3Be6KGdhPZIxNTSJ9G
         RXoohDWuWh+fRWYagw9N7lUkJjS8faHcyh4XopAuW6zUS8idka3i09awvWjmSP2nXnGt
         TbtAhFJ29VeP58sUWOnpet4Mzqv5GDQ4jHwXlUT3ZVKwlXQTs7a+4xQVM9wMpmtVy2vY
         s2llF6qNR9EqFqxnQqwYa/wulvDjA38+5liAvHOyc1AxBVJdIDScs1Mlc2OIIk+mXsaO
         PrYg==
X-Gm-Message-State: AOAM531jLPOpjsZFHQPOhhZ4lyIjG4/KVGQG8oOb8GgmtEqDI6MxW7yt
        tDGCIkR6IQUK7hMXsJmepwsRU7HHe4BSIw==
X-Google-Smtp-Source: ABdhPJyhH0UFF9pIZEHIiYBy2cx5l0E121JjWdervW65slwTNugSFRl846iUwEug+UYy8AimEuTpmQ==
X-Received: by 2002:a05:6602:1c4:: with SMTP id w4mr5142277iot.44.1624996542465;
        Tue, 29 Jun 2021 12:55:42 -0700 (PDT)
Received: from [192.168.1.134] ([198.8.77.61])
        by smtp.gmail.com with ESMTPSA id t8sm11111693iog.21.2021.06.29.12.55.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Jun 2021 12:55:42 -0700 (PDT)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block driver updates for 5.14-rc1
Message-ID: <ee6c32c8-e643-f817-bf45-1280e7f254ea@kernel.dk>
Date:   Tue, 29 Jun 2021 13:55:41 -0600
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

Block driver updates for 5.14-rc1, sitting on top of the core block
changes sent in. Pretty calm round, mostly just NVMe and a bit of
MD.

- NVMe updates (via Christoph)
	- improve the APST configuration algorithm (Alexey Bogoslavsky)
	- look for StorageD3Enable on companion ACPI device
	  (Mario Limonciello)
	- allow selecting the network interface for TCP connections
	  (Martin Belanger)
	- misc cleanups (Amit Engel, Chaitanya Kulkarni, Colin Ian King,
	  Christoph)
	- move the ACPI StorageD3 code to drivers/acpi/ and add quirks for
	  certain AMD CPUs (Mario Limonciello)
	- zoned device support for nvmet (Chaitanya Kulkarni)
	- fix the rules for changing the serial number in nvmet
	  (Noam Gottlieb)
	- various small fixes and cleanups (Dan Carpenter, JK Kim,
	  Chaitanya Kulkarni, Hannes Reinecke, Wesley Sheng,
	  Geert Uytterhoeven, Daniel Wagner)

- MD updates (Via Song)
	- iostats rewrite (Guoqing Jiang)
  	- raid5 lock contention optimization (Gal Ofri)

- Fall through warning fix (Gustavo)

- Misc fixes (Gustavo, Jiapeng)

Note that this will throw a trivial merge conflict in
drivers/nvme/host/fabrics.c due to the NVME_SC_HOST_PATH_ERROR addition.

Please pull!


The following changes since commit c4681547bcce777daf576925a966ffa824edd09d:

  Linux 5.13-rc3 (2021-05-23 11:42:48 -1000)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.14/drivers-2021-06-29

for you to fetch changes up to 5ed9b357024dc43f75099f597187df05bcd5173c:

  Merge tag 'nvme-5.14-2021-06-22' of git://git.infradead.org/nvme into for-5.14/drivers (2021-06-24 09:39:02 -0600)

----------------------------------------------------------------
for-5.14/drivers-2021-06-29

----------------------------------------------------------------
Alexey Bogoslavsky (1):
      nvme: extend and modify the APST configuration algorithm

Amit Engel (1):
      nvmet: move ka_work initialization to nvmet_alloc_ctrl

Chaitanya Kulkarni (30):
      nvme-fabrics: fix the kerneldco comment for nvmf_log_connect_error()
      nvme-fabrics: remove extra new lines in the switch
      nvme-fabrics: remove an extra comment
      nvme-fabrics: remove extra braces
      nvmet: remove a superfluous variable
      nvme: factor out a nvme_validate_passthru_nsid helper
      nvme-pci: remove trailing lines for helpers
      nvme: add a helper to check ctrl sgl support
      nvme-fc: use ctrl sgl check helper
      nvme-pci: use ctrl sgl check helper
      nvme-tcp: use ctrl sgl check helper
      nvme-fabrics: remove memset in nvmf_reg_read64()
      nvme-fabrics: remove memset in nvmf_reg_write32()
      nvme-fabrics: remove memset in connect admin q
      nvme-fabrics: remove memset in connect io q
      nvmet: use req->cmd directly in bdev-ns fast path
      nvmet: use req->cmd directly in file-ns fast path
      nvmet: use u32 for nvmet_subsys max_nsid
      nvmet: use u32 type for the local variable nsid
      nvmet: use nvme status value directly
      nvmet: remove local variable
      block: export blk_next_bio()
      nvmet: add req cns error complete helper
      nvmet: add nvmet_req_bio put helper for backends
      nvmet: add Command Set Identifier support
      nvmet: add ZBD over ZNS backend support
      nvmet: remove zeroout memset call for struct
      nvme-pci: remove zeroout memset call for struct
      nvme: remove zeroout memset call for struct
      nvmet: use NVMET_MAX_NAMESPACES to set nn value

Christoph Hellwig (8):
      nvme: open code nvme_put_ns_from_disk in nvme_ns_head_chr_ioctl
      nvme: open code nvme_{get,put}_ns_from_disk in nvme_ns_head_ioctl
      nvme: open code nvme_put_ns_from_disk in nvme_ns_head_ctrl_ioctl
      nvme: add a sparse annotation to nvme_ns_head_ctrl_ioctl
      nvme: move the CSI sanity check into nvme_ns_report_zones
      nvme: split nvme_report_zones
      nvme: remove nvme_{get,put}_ns_from_disk
      mark pstore-blk as broken

Colin Ian King (1):
      nvme: remove redundant initialization of variable ret

Dan Carpenter (1):
      nvme-tcp: fix error codes in nvme_tcp_setup_ctrl()

Daniel Wagner (2):
      nvme: verify MNAN value if ANA is enabled
      nvme: remove superfluous bio_set_dev in nvme_requeue_work

Gal Ofri (1):
      md/raid5: avoid device_lock in read_one_chunk()

Geert Uytterhoeven (1):
      nvme: fix grammar in the CONFIG_NVME_MULTIPATH kconfig help text

Guoqing Jiang (10):
      md: revert io stats accounting
      md: add io accounting for raid0 and raid5
      md/raid5: move checking badblock before clone bio in raid5_read_one_chunk
      md/raid5: avoid redundant bio clone in raid5_read_one_chunk
      md/raid1: rename print_msg with r1bio_existed
      md/raid1: enable io accounting
      md/raid10: enable io accounting
      md: mark some personalities as deprecated
      md: check level before create and exit io_acct_set
      md: add comments in md_integrity_register

Gustavo A. R. Silva (2):
      rsxx: Use struct_size() in vmalloc()
      floppy: Fix fall-through warning for Clang

Hannes Reinecke (1):
      nvmet-fc: do not check for invalid target port in nvmet_fc_handle_fcp_rqst()

JK Kim (1):
      nvme-pci: fix var. type for increasing cq_head

Jens Axboe (4):
      Merge tag 'nvme-5.14-2021-06-08' of git://git.infradead.org/nvme into for-5.14/drivers
      Merge tag 'floppy-for-5.14' of https://github.com/evdenis/linux-floppy into for-5.14/drivers
      Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.14/drivers
      Merge tag 'nvme-5.14-2021-06-22' of git://git.infradead.org/nvme into for-5.14/drivers

Jiapeng Chong (1):
      floppy: cleanup: remove redundant assignment to nr_sectors

Kristian Klausen (1):
      loop: Fix missing discard support when using LOOP_CONFIGURE

Mario Limonciello (3):
      nvme-pci: look for StorageD3Enable on companion ACPI device instead
      ACPI: Check StorageD3Enable _DSD property in ACPI code
      ACPI: Add quirks for AMD Renoir/Lucienne CPUs to force the D3 hint

Martin Belanger (1):
      nvme-tcp: allow selecting the network interface for connections

Noam Gottlieb (4):
      nvmet: change sn size and check validity
      nvmet: make sn stable once connection was established
      nvmet: allow mn change if subsys not discovered
      nvmet: make ver stable once connection established

Rikard Falkeborn (1):
      md: Constify attribute_group structs

Wesley Sheng (1):
      nvme.h: add missing nvme_lba_range_type endianness annotations

Yang Yingliang (1):
      aoe: remove unnecessary mutex_init()

Zhen Lei (6):
      aoe: remove unnecessary oom message
      drbd: remove unnecessary oom message
      mtip32xx: remove unnecessary oom message
      sunvdc: remove unnecessary oom message
      sx8: remove unnecessary oom message
      z2ram: remove unnecessary oom message

 block/blk-lib.c                    |   1 +
 drivers/acpi/device_pm.c           |  32 ++
 drivers/acpi/internal.h            |   9 +
 drivers/acpi/x86/utils.c           |  25 ++
 drivers/block/aoe/aoechr.c         |   4 +-
 drivers/block/drbd/drbd_receiver.c |  22 +-
 drivers/block/floppy.c             |   2 +-
 drivers/block/loop.c               |   1 +
 drivers/block/mtip32xx/mtip32xx.c  |  26 +-
 drivers/block/rsxx/dma.c           |   6 +-
 drivers/block/sunvdc.c             |   3 +-
 drivers/block/sx8.c                |   2 -
 drivers/block/z2ram.c              |  10 +-
 drivers/md/Kconfig                 |   6 +-
 drivers/md/md-bitmap.c             |   2 +-
 drivers/md/md-faulty.c             |   2 +-
 drivers/md/md-linear.c             |   2 +-
 drivers/md/md-multipath.c          |   2 +-
 drivers/md/md.c                    | 116 +++---
 drivers/md/md.h                    |  13 +-
 drivers/md/raid0.c                 |   3 +
 drivers/md/raid1.c                 |  15 +-
 drivers/md/raid1.h                 |   1 +
 drivers/md/raid10.c                |   6 +
 drivers/md/raid10.h                |   1 +
 drivers/md/raid5.c                 |  63 ++-
 drivers/nvme/host/Kconfig          |   2 +-
 drivers/nvme/host/core.c           | 192 ++++++---
 drivers/nvme/host/fabrics.c        |  56 +--
 drivers/nvme/host/fabrics.h        |   6 +-
 drivers/nvme/host/fc.c             |   2 +-
 drivers/nvme/host/ioctl.c          |  61 +--
 drivers/nvme/host/multipath.c      |  33 +-
 drivers/nvme/host/nvme.h           |  17 +-
 drivers/nvme/host/pci.c            |  82 +---
 drivers/nvme/host/rdma.c           |   2 +-
 drivers/nvme/host/tcp.c            |  31 +-
 drivers/nvme/host/zns.c            |  27 +-
 drivers/nvme/target/Makefile       |   1 +
 drivers/nvme/target/admin-cmd.c    | 155 +++++---
 drivers/nvme/target/configfs.c     | 102 +++--
 drivers/nvme/target/core.c         | 100 +++--
 drivers/nvme/target/discovery.c    |   8 +-
 drivers/nvme/target/fc.c           |  10 +-
 drivers/nvme/target/io-cmd-bdev.c  |  36 +-
 drivers/nvme/target/io-cmd-file.c  |   4 +-
 drivers/nvme/target/nvmet.h        |  41 +-
 drivers/nvme/target/passthru.c     |   3 +-
 drivers/nvme/target/rdma.c         |   3 +-
 drivers/nvme/target/zns.c          | 615 +++++++++++++++++++++++++++++
 fs/pstore/Kconfig                  |   1 +
 include/linux/acpi.h               |   5 +
 include/linux/bio.h                |   2 +
 include/linux/nvme.h               |  12 +-
 54 files changed, 1467 insertions(+), 517 deletions(-)
 create mode 100644 drivers/nvme/target/zns.c

-- 
Jens Axboe

