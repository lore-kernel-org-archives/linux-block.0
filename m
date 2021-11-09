Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2950C433F5
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 17:06:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C6E7161152
	for <linux-block@archiver.kernel.org>; Tue,  9 Nov 2021 17:06:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240796AbhKIRJg (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 9 Nov 2021 12:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240787AbhKIRJg (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 9 Nov 2021 12:09:36 -0500
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5284DC061764
        for <linux-block@vger.kernel.org>; Tue,  9 Nov 2021 09:06:50 -0800 (PST)
Received: by mail-il1-x12f.google.com with SMTP id k1so21318803ilo.7
        for <linux-block@vger.kernel.org>; Tue, 09 Nov 2021 09:06:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=rYtV50YrR+LhFdhj3b8QF8qXrvtlqBtoyEi4mbrYnNY=;
        b=5CmSnnLW0f2VPg0MYo+aUZmiPxMiFbZtS/r/nOT1KErtAIyz3fPqDefbpYMDIRe9Wp
         Nz7nfvd0NZrIMpzLoOFBqj/GJDVM4AHqTTocgA8Cy5AubyGBPonf3WoPo7PBCCKdI9Sg
         cYvtPcGfG/KbZEWCW7AVvRtgJvTxH84igRgpbcWiDei8fE2me5VCRSBC+jNTTKFRnVy3
         XrYTyil2fvl3+K5KZw8IiPvEImiV5OlUj87cdsVRVkjePyz8/u2H4hMi3CdwMv2WAPaL
         TfCtihYHsKMQssgfDgBMWVkKw5F4eSXYlJ2lHwOtIQzWKjHRevkQaqdR8DMG1LTECvU/
         v0eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=rYtV50YrR+LhFdhj3b8QF8qXrvtlqBtoyEi4mbrYnNY=;
        b=NBtuv7ser6dmSYZGHDDdMtpdY4V575xbU++8sH8yUwkxKmN/vBVrRKDAAQB8ac5xQU
         3mWp/++F2RB1uR4cjnAlcBqHbAHNa5lSYvtc3cP8voo11CBYUTVKd7HkAyX+9SxUk3Vo
         A2jFZFU4vsNJ7ktD9EhjHvBeG7U37io5X//0lMXy18ljS/5VBspfNyz6LMEjH0vDjQgZ
         uErr07Kl2nVeFoFLNLMaIGi057xafew7vBYz+NY0rIMzVe8ETn0ZaZkpbxIkiW0qTTjI
         WP0nesiworT00V43I1uSpauFD1pA5cgVqrl2tJsyA7WhQF8aUMGXuo+au4ti0ekYgrER
         XkVA==
X-Gm-Message-State: AOAM531qbbJaFRtfnRj5f0SHGdV4mysAuoqfPKcKcxiFyueDOz7R/dAs
        2jG2DUOFee04xC3uT2ZckTuPu0YD5UYGXYRw
X-Google-Smtp-Source: ABdhPJzaBggHS1JBcW+4FZAuHG7yzk1Ylr5FaAH3DYOFkfBQs0CPGZbUMac6Y3Fo7FH3lm2irucxDA==
X-Received: by 2002:a05:6e02:1d9d:: with SMTP id h29mr6140136ila.29.1636477609470;
        Tue, 09 Nov 2021 09:06:49 -0800 (PST)
Received: from [192.168.1.30] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id d14sm12177799ilv.2.2021.11.09.09.06.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 09 Nov 2021 09:06:49 -0800 (PST)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] Followup block driver changes
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <be148553-4784-34ca-af75-ff77251a7da2@kernel.dk>
Date:   Tue, 9 Nov 2021 10:06:48 -0700
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

Followup block driver changes for the 5.16 release:

- Last series adding error handling support for add_disk() in drivers.
  After this one, and once the SCSI side has been merged, we can finally
  annotate add_disk() as must_check. (Luis)

- bcache fixes (Coly)

- zram fixes (Ming)

- ataflop locking fix (Tetsuo)

- nbd fixes (Ye, Yu)

- MD merge via Song
	- Cleanup (Yang)
	- sysfs fix (Guoqing)

- Misc fixes (Geert, Wu, luo)

Please pull!


The following changes since commit 15dfc662ef31a20b59097d59b0792b06770255fa:

  null_blk: Fix handling of submit_queues and poll_queues attributes (2021-10-29 06:55:39 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.16/drivers-2021-11-09

for you to fetch changes up to 2878feaed543c35f9dbbe6d8ce36fb67ac803eef:

  bcache: Revert "bcache: use bvec_virt" (2021-11-08 06:23:17 -0700)

----------------------------------------------------------------
for-5.16/drivers-2021-11-09

----------------------------------------------------------------
Coly Li (2):
      bcache: fix use-after-free problem in bcache_device_free()
      bcache: Revert "bcache: use bvec_virt"

Geert Uytterhoeven (1):
      ataflop: Add missing semicolon to return statement

Guoqing Jiang (1):
      md/bitmap: don't set max_write_behind if there is no write mostly device

Jens Axboe (1):
      Merge branch 'md-next' of https://git.kernel.org/pub/scm/linux/kernel/git/song/md into for-5.16/drivers

Luis Chamberlain (17):
      zram: add error handling support for add_disk()
      ps3disk: add error handling support for add_disk()
      ps3vram: add error handling support for add_disk()
      block/brd: add error handling support for add_disk()
      nvdimm/btt: do not call del_gendisk() if not needed
      nvdimm/btt: use goto error labels on btt_blk_init()
      nvdimm/btt: add error handling support for add_disk()
      nvdimm/blk: avoid calling del_gendisk() on early failures
      nvdimm/blk: add error handling support for add_disk()
      nvdimm/pmem: cleanup the disk if pmem_release_disk() is yet assigned
      nvdimm/pmem: use add_disk() error handling
      z2ram: add error handling support for add_disk()
      block/sunvdc: add error handling support for add_disk()
      mtd/ubi/block: add error handling support for add_disk()
      block: update __register_blkdev() probe documentation
      ataflop: address add_disk() error handling on probe
      floppy: address add_disk() error handling on probe

Ming Lei (4):
      zram: fix race between zram_reset_device() and disksize_store()
      zram: don't fail to remove zram during unloading module
      zram: avoid race between zram_remove and disksize_store
      zram: replace fsync_bdev with sync_blockdev

Tetsuo Handa (1):
      ataflop: remove ataflop_probe_lock mutex

Wu Bo (1):
      drbd: Fix double free problem in drbd_create_device

Yang Guang (1):
      raid5-ppl: use swap() to make code cleaner

Ye Bin (2):
      nbd: Fix incorrect error handle when first_minor is illegal in nbd_dev_add
      nbd: Fix hungtask when nbd_config_put

Yu Kuai (3):
      nbd: fix max value for 'first_minor'
      nbd: fix possible overflow for 'first_minor' in nbd_dev_add()
      nbd: error out if socket index doesn't match in nbd_handle_reply()

luo penghao (1):
      loop: Remove duplicate assignments

 block/genhd.c                  |  5 +++-
 drivers/block/ataflop.c        | 61 +++++++++++++++++++++++++-----------------
 drivers/block/brd.c            |  9 +++++--
 drivers/block/drbd/drbd_main.c |  4 +--
 drivers/block/floppy.c         | 17 +++++++++---
 drivers/block/loop.c           |  1 -
 drivers/block/nbd.c            | 44 +++++++++++++++---------------
 drivers/block/ps3disk.c        |  8 ++++--
 drivers/block/ps3vram.c        |  7 ++++-
 drivers/block/sunvdc.c         | 14 +++++++---
 drivers/block/z2ram.c          |  7 +++--
 drivers/block/zram/zram_drv.c  | 45 ++++++++++++++++++++++++-------
 drivers/md/bcache/btree.c      |  2 +-
 drivers/md/bcache/super.c      |  2 +-
 drivers/md/md-bitmap.c         | 19 +++++++++++++
 drivers/md/raid5-ppl.c         |  6 ++---
 drivers/mtd/ubi/block.c        |  8 +++++-
 drivers/nvdimm/blk.c           | 21 ++++++++++-----
 drivers/nvdimm/btt.c           | 21 +++++++++------
 drivers/nvdimm/pmem.c          | 21 +++++++++++----
 20 files changed, 221 insertions(+), 101 deletions(-)

-- 
Jens Axboe

