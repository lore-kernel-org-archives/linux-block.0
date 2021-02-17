Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5D0DC433DB
	for <linux-block@archiver.kernel.org>; Wed, 17 Feb 2021 22:59:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 86C2564E58
	for <linux-block@archiver.kernel.org>; Wed, 17 Feb 2021 22:59:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229808AbhBQW6r (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 17 Feb 2021 17:58:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbhBQW6q (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 17 Feb 2021 17:58:46 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D24C061574
        for <linux-block@vger.kernel.org>; Wed, 17 Feb 2021 14:58:05 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id z15so9414995pfc.3
        for <linux-block@vger.kernel.org>; Wed, 17 Feb 2021 14:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20150623.gappssmtp.com; s=20150623;
        h=to:cc:from:subject:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=8c2uibjykA4XG9QuCASioJo/mUhntl7LilMbCbjLglQ=;
        b=fgdCfTLJbqSqyeEYR8ub/PSsQBvk25m0kkwqLOpjJYEBGVSgLnOvDW3/L5xrgTy3oN
         TTC0cEyHp5GtSbvR37dasSUcv3tJSTX/jFT2XM+YHvbgG01s6wc7GpjeWl45iz4H8wz3
         4ViPKqwKftRvcog5XIytPqrkqkM17DAWlQD1Ijiud6FFVZdsr/+PgD0m2cUdF5uFUSSV
         QC7bwoGZTfRlLTk7K9c3tK9hsPIENaXfcdDOscBfHQLqnfxzWvbGdsf9Y0mGNEMPT5VJ
         MNLx9AnP/0WnPDmFRFyB2hWbRtGIBU4kalKDWcJ2wAOA9gNBFQsT3k96wUKxvvpC+Suq
         rwBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:to:cc:from:subject:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=8c2uibjykA4XG9QuCASioJo/mUhntl7LilMbCbjLglQ=;
        b=HIG8Q/ATmCQcIggW96fmBnfI252WhV2Bl46hf3MQevLo5Ae+V6JH1fZ9WtLbwBmzzb
         auqoc4aGtEucVZoxSDSXobyhP77m6H4ZR0H4mI0QmOIO6bLCZuPvKBAgI7t9y6OXJBf/
         fTkgp+YQoJIlcRS5cqY00WfaYeFYUDXV72KfNrdGgLIN+ExC8Q5q5mPYtlr2cB9xLUk8
         zI8oymuOKi+GPGoNeRV+otKZPvvzOpz+FbnCD1EiT+IjNUHCPb48+R2QxYMcsqZ1YMkM
         PGnPPxV9zNlf033Hr4E802LPiZgUwVR2ZG4JIaWLHL/aWlNHz4wh2DwMOCnLww/yLRbC
         j1PQ==
X-Gm-Message-State: AOAM532e4HbYdZDssHMSUVDHmjLgKu6grNoHdyd+HLD895pfsxNnSW2g
        bDou7SH53UFfhbvPXGLKbYN1ueaUebivqA==
X-Google-Smtp-Source: ABdhPJyk82+JQpdoznFdMzYYxZsN82YD7o9xTn/uR1XxTF2IIbEkMCXDEkgIYp3Inqc0kZDsj8mAvQ==
X-Received: by 2002:a63:d355:: with SMTP id u21mr1443373pgi.133.1613602684808;
        Wed, 17 Feb 2021 14:58:04 -0800 (PST)
Received: from ?IPv6:2620:10d:c085:21e1::19db? ([2620:10d:c090:400::5:5c48])
        by smtp.gmail.com with ESMTPSA id o20sm3037618pjt.43.2021.02.17.14.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 Feb 2021 14:58:04 -0800 (PST)
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Block driver changes for 5.12-rc
Message-ID: <2026e767-054e-00ba-46bd-716eb827a600@kernel.dk>
Date:   Wed, 17 Feb 2021 15:58:02 -0700
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

On top of the core block branch, here are the 5.12 driver changes. This
pull request contains:

- Removal of the skd driver. It's been EOL for a long time (Damien)

- NVMe pull requests
	- fix multipath handling of ->queue_rq errors (Chao Leng)
	- nvmet cleanups (Chaitanya Kulkarni)
	- add a quirk for buggy Amazon controller (Filippo Sironi)
	- avoid devm allocations in nvme-hwmon that don't interact well with
	  fabrics (Hannes Reinecke)
	- sysfs cleanups (Jiapeng Chong)
	- fix nr_zones for multipath (Keith Busch)
	- nvme-tcp crash fix for no-data commands (Sagi Grimberg)
	- nvmet-tcp fixes (Sagi Grimberg)
	- add a missing __rcu annotation (Christoph)
	- failed reconnect fixes (Chao Leng)
	- various tracing improvements (Michal Krakowiak, Johannes Thumshirn)
	- switch the nvmet-fc assoc_list to use RCU protection (Leonid Ravich)
	- resync the status codes with the latest spec (Max Gurtovoy)
	- minor nvme-tcp improvements (Sagi Grimberg)
	- various cleanups (Rikard Falkeborn, Minwoo Im, Chaitanya Kulkarni,
	  Israel Rukshin)

- Floppy O_NDELAY fix (Denis)

- MD pull request
	- raid5 chunk_sectors fix (Guoqing)

- Use lore links (Kees)

- Use DEFINE_SHOW_ATTRIBUTE for nbd (Liao)

- loop lock scaling (Pavel)

- mtip32xx PCI fixes (Bjorn)

- bcache fixes (Kai, Dongdong)

- Misc fixes (Tian, Yang, Guoqing, Joe, Andy)

Note that this throws a trivial merge conflict with master, due to a
late addition to the quirk list in the 5.11 series.

Please pull!


The following changes since commit 767630c63bb23acf022adb265574996ca39a4645:

  bdev: Do not return EBUSY if bdev discard races with write (2021-01-26 10:22:18 -0700)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.12/drivers-2021-02-17

for you to fetch changes up to f4b64ae6745177642cd9610cfd7df0041e7fca58:

  lightnvm: pblk: Replace guid_copy() with export_guid()/import_guid() (2021-02-14 21:27:24 -0700)

----------------------------------------------------------------
for-5.12/drivers-2021-02-17

----------------------------------------------------------------
Andy Shevchenko (1):
      lightnvm: pblk: Replace guid_copy() with export_guid()/import_guid()

Bjorn Helgaas (2):
      mtip32xx: use PCI #defines instead of numbers
      mtip32xx: prefer pcie_capability_read_word()

Chaitanya Kulkarni (15):
      nvmet: remove extra variable in smart log nsid
      nvmet: remove extra variable in id-desclist
      nvmet: remove extra variable in identify ns
      nvmet: add lba to sect conversion helpers
      nvme-core: get rid of the extra space
      nvmet: set status to 0 in case for invalid nsid
      nvmet: return uniform error for invalid ns
      nvmet: make nvmet_find_namespace() req based
      nvmet: remove extra variable in id-ns handler
      nvmet: add helper to report invalid opcode
      nvmet: use invalid cmd opcode helper
      nvmet: use invalid cmd opcode helper
      nvmet: use min of device_path and disk len
      nvmet: add nvmet_req_subsys() helper
      nvmet: remove else at the end of the function

Chao Leng (9):
      nvme-core: add cancel tagset helpers
      nvme-rdma: add clean action for failed reconnection
      nvme-tcp: add clean action for failed reconnection
      nvme-rdma: use cancel tagset helper for tear down
      nvme-tcp: use cancel tagset helper for tear down
      blk-mq: introduce blk_mq_set_request_complete
      nvme: introduce a nvme_host_path_error helper
      nvme-fabrics: avoid double completions in nvmf_fail_nonready_command
      nvme-rdma: handle nvme_rdma_post_send failures better

Christoph Hellwig (1):
      nvmet-fc: add a missing __rcu annotation to nvmet_fc_tgt_assoc.queues

Damien Le Moal (1):
      block: remove skd driver

Filippo Sironi (1):
      nvme: add 48-bit DMA address quirk for Amazon NVMe controllers

Guoqing Jiang (2):
      drbd: remove unused argument from drbd_request_prepare and __drbd_make_request
      md/raid5: cast chunk_sectors to sector_t value

Hannes Reinecke (1):
      nvme-hwmon: rework to avoid devm allocation

Israel Rukshin (2):
      nvmet: Use nvmet_is_port_enabled helper for pi_enable
      nvmet: Fix nvmet_is_port_enabled indentation

Jens Axboe (4):
      Merge tag 'nvme-5.21-2020-02-02' of git://git.infradead.org/nvme into for-5.12/drivers
      Merge tag 'floppy-for-5.12' of https://github.com/evdenis/linux-floppy into for-5.12/drivers
      Merge branch 'md-next' of https://git.kernel.org/.../song/md into for-5.12/drivers
      Merge tag 'nvme-5.12-2021-02-11' of git://git.infradead.org/nvme into for-5.12/drivers

Jiapeng Chong (1):
      nvme: convert sysfs sprintf/snprintf family to sysfs_emit

Jiri Kosina (1):
      floppy: reintroduce O_NDELAY fix

Joe Perches (2):
      drbd: Avoid comma separated statements
      bcache: Avoid comma separated statements

Johannes Thumshirn (1):
      nvme: add tracing of zns commands

Kai Krakow (4):
      bcache: Fix register_device_aync typo
      Revert "bcache: Kill btree_io_wq"
      bcache: Give btree_io_wq correct semantics again
      bcache: Move journal work to new flush wq

Kees Cook (1):
      block: Replace lkml.org links with lore

Keith Busch (1):
      nvme-multipath: set nr_zones for zoned namespaces

Leonid Ravich (1):
      nvmet-fc: use RCU proctection for assoc_list

Liao Pingfang (1):
      nbd: Convert to DEFINE_SHOW_ATTRIBUTE

Max Gurtovoy (1):
      nvme: update enumerations for status codes

Michal Krakowiak (1):
      nvme: parse format nvm command details when tracing

Minwoo Im (2):
      nvme: support command retry delay for admin command
      nvme: refactor ns->ctrl by request

Pavel Tatashin (1):
      loop: scale loop device by introducing per device lock

Rikard Falkeborn (1):
      nvme: constify static attribute_group structs

Sagi Grimberg (6):
      nvme-tcp: fix wrong setting of request iov_iter
      nvme-tcp: get rid of unused helper function
      nvme-tcp: pass multipage bvec to request iov_iter
      nvmet-tcp: fix receive data digest calculation for multiple h2cdata PDUs
      nvmet-tcp: fix potential race of tcp socket closing accept_work
      nvme-tcp: fix crash triggered with a dataless request submission

Tian Tao (2):
      zram: fix NULL check before some freeing functions is not needed
      lightnvm: fix unnecessary NULL check warnings

Yang Li (1):
      rsxx: remove redundant NULL check

dongdong tao (1):
      bcache: consider the fragmentation when update the writeback rate

 MAINTAINERS                        |    6 -
 drivers/block/Kconfig              |   10 -
 drivers/block/Makefile             |    2 -
 drivers/block/aoe/aoecmd.c         |    2 +-
 drivers/block/drbd/drbd_int.h      |    2 +-
 drivers/block/drbd/drbd_main.c     |    3 +-
 drivers/block/drbd/drbd_receiver.c |    6 +-
 drivers/block/drbd/drbd_req.c      |   11 +-
 drivers/block/floppy.c             |   30 +-
 drivers/block/loop.c               |   93 +-
 drivers/block/loop.h               |    1 +
 drivers/block/mtip32xx/mtip32xx.c  |   15 +-
 drivers/block/nbd.c                |   28 +-
 drivers/block/rsxx/dma.c           |    3 +-
 drivers/block/skd_main.c           | 3670 ------------------------------------
 drivers/block/skd_s1120.h          |  322 ----
 drivers/block/zram/zram_drv.c      |    3 +-
 drivers/lightnvm/pblk-core.c       |    5 +-
 drivers/lightnvm/pblk-gc.c         |    3 +-
 drivers/lightnvm/pblk-recovery.c   |    3 +-
 drivers/md/bcache/bcache.h         |    7 +
 drivers/md/bcache/bset.c           |   12 +-
 drivers/md/bcache/btree.c          |   21 +-
 drivers/md/bcache/journal.c        |    4 +-
 drivers/md/bcache/super.c          |   24 +-
 drivers/md/bcache/sysfs.c          |   29 +-
 drivers/md/bcache/writeback.c      |   42 +
 drivers/md/bcache/writeback.h      |    4 +
 drivers/md/raid5.c                 |    2 +-
 drivers/nvme/host/core.c           |   63 +-
 drivers/nvme/host/fabrics.c        |    6 +-
 drivers/nvme/host/fc.c             |    2 +-
 drivers/nvme/host/hwmon.c          |   31 +-
 drivers/nvme/host/multipath.c      |    4 +
 drivers/nvme/host/nvme.h           |   17 +
 drivers/nvme/host/pci.c            |   21 +-
 drivers/nvme/host/rdma.c           |   34 +-
 drivers/nvme/host/tcp.c            |   55 +-
 drivers/nvme/host/trace.c          |   53 +
 drivers/nvme/target/admin-cmd.c    |  114 +-
 drivers/nvme/target/configfs.c     |    6 +-
 drivers/nvme/target/core.c         |   37 +-
 drivers/nvme/target/fc.c           |   83 +-
 drivers/nvme/target/fcloop.c       |    2 +-
 drivers/nvme/target/io-cmd-bdev.c  |   13 +-
 drivers/nvme/target/io-cmd-file.c  |    5 +-
 drivers/nvme/target/nvmet.h        |   20 +-
 drivers/nvme/target/passthru.c     |    6 +-
 drivers/nvme/target/tcp.c          |   59 +-
 drivers/nvme/target/trace.h        |    9 +-
 include/linux/blk-mq.h             |   12 +
 include/linux/nvme.h               |   30 +-
 52 files changed, 669 insertions(+), 4376 deletions(-)
 delete mode 100644 drivers/block/skd_main.c
 delete mode 100644 drivers/block/skd_s1120.h

-- 
Jens Axboe

