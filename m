Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BACABC433EF
	for <linux-block@archiver.kernel.org>; Tue, 11 Jan 2022 21:55:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345017AbiAKVzZ (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 11 Jan 2022 16:55:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345347AbiAKVzW (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Tue, 11 Jan 2022 16:55:22 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 52461C061751
        for <linux-block@vger.kernel.org>; Tue, 11 Jan 2022 13:55:22 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id i82so808600ioa.8
        for <linux-block@vger.kernel.org>; Tue, 11 Jan 2022 13:55:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=Ry3DcuoCx9nryaOoThUMlEfvwH/+OFGvmLsDhRYu0so=;
        b=mDgl5nDYYPa+Cc2LPQwRImj3QRQTv+c3Hb5F4Z2Osfhu/euArlykTkD0gwkRnN3j4x
         plzNJJ0EGCIdJXR4MC+CAYziz2pkgjE1Z2/TNQKjGi2k4lFtpBrOeYEptgacWQrrGcfV
         oXzjQJzfRAsrAaGyQVoFU4oeQ9+AUCXXvzOVEhQQxS2lK7ur6n3OKdJDLSdK+EmrOV+n
         Ta4s4dvtW5x3uD6KvtgZkcREc0lRVfr5esHFivf55boQ/uBLzBG9Eyto/Tw2/JzUdjpk
         xn5uhXmZ1KrtcWPARFrKHI5jkmuhHlepJR6T6l/RzOGa2jYOTUOSsoNjwAXjiqGv1b97
         qvSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=Ry3DcuoCx9nryaOoThUMlEfvwH/+OFGvmLsDhRYu0so=;
        b=1R1FKIQ7TSUSSJ3AGy75YBBMrvOGo0NKH/6ChgfHqB+N0FUqcwICMDTgv3hVR6dzNH
         eGwK0/dXOXH/54olcYBEeRGhdFOEo/nomzCZf/Tb6jAI7bXUEfXDHymeBRHCkv8aNYZD
         YhPvnV2RrXFfx4+i2tcW1dASJoyjnp+wALVnvlBYpRVgRoxH+EggCQDxB7BdXXLChaJs
         /sOmFNw/AAHX6ssciGhOtg3aU57rmbUUHgVgj1V677meayvlOqxxKwzHxNpLz8iLX9JR
         b+U8pZZwxytykfYDru7xcUwQIoVOFBMVVIgGaG/KKTixP8TcWZKfC3Wn4RW+JUrMMunn
         uWZQ==
X-Gm-Message-State: AOAM530blwg3/ADOWjQiV8J/x67+qZvM4VA21simqfjSVaLLgiLSzjWd
        IsM021DHCpqIFXayBJ9rc1tRUoWJExp9ew==
X-Google-Smtp-Source: ABdhPJyQBe3XgnBly2G6HFn/Ra5U1FMOcZEjefjlwI+z4lCRZrr9zpOsJQ3DFQmr3lf40BOFlYA8Bg==
X-Received: by 2002:a02:b044:: with SMTP id q4mr3328068jah.316.1641938121248;
        Tue, 11 Jan 2022 13:55:21 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id g1sm6680429ila.26.2022.01.11.13.55.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jan 2022 13:55:20 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block drivers updates for 5.17-rc1
Message-ID: <5d0c0268-8d1d-fdb4-e054-584a94fb49f3@kernel.dk>
Date:   Tue, 11 Jan 2022 14:55:20 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

On top of the core block changes, here are the block driver changes
queued up for the 5.17-rc1 merge window. This pull request contains:

- mtip32xx pci cleanups (Bjorn)

- mtip32xx conversion to generic power management (Vaibhav)

- rsxx pci powermanagement cleanups (Bjorn)

- Remove the rsxx driver. This hardware never saw much adoption, and
  it's been end of lifed for a while. (Christoph)

- MD pull request from Song:
	- REQ_NOWAIT support (Vishal Verma)
	- raid6 benchmark optimization (Dirk Müller)
	- Fix for acct bioset (Xiao Ni)
	- Clean up max_queued_requests (Mariusz Tkaczyk)
	- PREEMPT_RT optimization (Davidlohr Bueso)
	- Use default_groups in kobj_type (Greg Kroah-Hartman)

- Use attribute groups in pktcdvd and rnbd (Greg)

- NVMe pull request from Christoph:
	- increment request genctr on completion (Keith Busch,
	  Geliang Tang)
	- add a 'iopolicy' module parameter (Hannes Reinecke)
	- print out valid arguments when reading from /dev/nvme-fabrics
	  (Hannes Reinecke)

- Use struct_group() in drbd (Kees)

- null_blk fixes (Ming)

- Get rid of congestion logic in pktcdvd (Neil)

- Floppy ejection hang fix (Tasos)

- Floppy max user request size fix (Xiongwei)

- Loop locking fix (Tetsuo)

Please pull!


The following changes since commit a30e3441325ba4011ddf125932cda21ca820c0bb:

  scsi: remove the gendisk argument to scsi_ioctl (2021-11-29 06:41:29 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.17/drivers-2022-01-11

for you to fetch changes up to d85bd8233fff000567cda4e108112bcb33478616:

  Merge branch 'md-next' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.17/drivers (2022-01-06 12:36:04 -0700)

----------------------------------------------------------------
for-5.17/drivers-2022-01-11

----------------------------------------------------------------
Bjorn Helgaas (3):
      mtip32xx: remove pointless drvdata checking
      mtip32xx: remove pointless drvdata lookups
      rsxx: Drop PCI legacy power management

Christoph Hellwig (1):
      block: remove the rsxx driver

Davidlohr Bueso (1):
      md/raid5: play nice with PREEMPT_RT

Dirk Müller (2):
      lib/raid6: skip benchmark of non-chosen xor_syndrome functions
      lib/raid6: Use strict priority ranking for pq gen() benchmarking

Geliang Tang (1):
      nvme: drop unused variable ctrl in nvme_setup_cmd

Greg Kroah-Hartman (3):
      pktcdvd: convert to use attribute groups
      block/rnbd-clt-sysfs: use default_groups in kobj_type
      md: use default_groups in kobj_type

Hannes Reinecke (2):
      nvme-fabrics: print out valid arguments when reading from /dev/nvme-fabrics
      nvme: add 'iopolicy' module parameter

Jens Axboe (3):
      null_blk: cast command status to integer
      Merge tag 'nvme-5.17-2021-12-29' of git://git.infradead.org/nvme into for-5.17/drivers
      Merge branch 'md-next' of ssh://gitolite.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.17/drivers

Kees Cook (1):
      drbd: Use struct_group() to zero algs

Keith Busch (1):
      nvme: increment request genctr on completion

Mariusz Tkaczyk (1):
      md: drop queue limitation for RAID1 and RAID10

Ming Lei (3):
      null_blk: allow zero poll queues
      block: null_blk: batched complete poll requests
      block: null_blk: only set set->nr_maps as 3 if active poll_queues is > 0

NeilBrown (1):
      pktdvd: stop using bdi congestion framework.

Randy Dunlap (1):
      md: fix spelling of "its"

Tasos Sahanidis (1):
      floppy: Fix hang in watchdog when disk is ejected

Tetsuo Handa (2):
      loop: don't hold lo_mutex during __loop_clr_fd()
      loop: make autoclear operation asynchronous

Vaibhav Gupta (1):
      mtip32xx: convert to generic power management

Vishal Verma (4):
      md: add support for REQ_NOWAIT
      md: raid1 add nowait support
      md: raid10 add nowait support
      md: raid456 add nowait support

Xiao Ni (1):
      md: Move alloc/free acct bioset in to personality

Xiongwei Song (1):
      floppy: Add max size check for user space request

 MAINTAINERS                         |    6 -
 drivers/block/Kconfig               |   11 -
 drivers/block/Makefile              |    1 -
 drivers/block/drbd/drbd_main.c      |    3 +-
 drivers/block/drbd/drbd_protocol.h  |    6 +-
 drivers/block/drbd/drbd_receiver.c  |    3 +-
 drivers/block/floppy.c              |    6 +-
 drivers/block/loop.c                |  108 ++--
 drivers/block/loop.h                |    1 +
 drivers/block/mtip32xx/mtip32xx.c   |   86 +--
 drivers/block/null_blk/main.c       |   12 +-
 drivers/block/pktcdvd.c             |  306 +++++-----
 drivers/block/rnbd/rnbd-clt-sysfs.c |    3 +-
 drivers/block/rsxx/Makefile         |    3 -
 drivers/block/rsxx/config.c         |  197 ------
 drivers/block/rsxx/core.c           | 1126 -----------------------------------
 drivers/block/rsxx/cregs.c          |  789 ------------------------
 drivers/block/rsxx/dev.c            |  306 ----------
 drivers/block/rsxx/dma.c            | 1085 ---------------------------------
 drivers/block/rsxx/rsxx.h           |   33 -
 drivers/block/rsxx/rsxx_cfg.h       |   58 --
 drivers/block/rsxx/rsxx_priv.h      |  418 -------------
 drivers/md/md-cluster.c             |    2 +-
 drivers/md/md.c                     |   53 +-
 drivers/md/md.h                     |    2 +
 drivers/md/raid0.c                  |   38 +-
 drivers/md/raid1-10.c               |    6 -
 drivers/md/raid1.c                  |   83 ++-
 drivers/md/raid10.c                 |  107 ++--
 drivers/md/raid5.c                  |   67 ++-
 drivers/md/raid5.h                  |    4 +-
 drivers/nvme/host/core.c            |    7 +-
 drivers/nvme/host/fabrics.c         |   22 +-
 drivers/nvme/host/multipath.c       |   41 +-
 drivers/nvme/host/nvme.h            |    8 +
 include/linux/pktcdvd.h             |   12 +-
 include/linux/raid/pq.h             |    2 +-
 lib/raid6/algos.c                   |   78 ++-
 lib/raid6/avx2.c                    |    8 +-
 lib/raid6/avx512.c                  |    6 +-
 40 files changed, 612 insertions(+), 4501 deletions(-)
 delete mode 100644 drivers/block/rsxx/Makefile
 delete mode 100644 drivers/block/rsxx/config.c
 delete mode 100644 drivers/block/rsxx/core.c
 delete mode 100644 drivers/block/rsxx/cregs.c
 delete mode 100644 drivers/block/rsxx/dev.c
 delete mode 100644 drivers/block/rsxx/dma.c
 delete mode 100644 drivers/block/rsxx/rsxx.h
 delete mode 100644 drivers/block/rsxx/rsxx_cfg.h
 delete mode 100644 drivers/block/rsxx/rsxx_priv.h

-- 
Jens Axboe

