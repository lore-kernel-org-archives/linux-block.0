Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4798BC433EF
	for <linux-block@archiver.kernel.org>; Sun, 31 Oct 2021 19:41:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2B0AC60F46
	for <linux-block@archiver.kernel.org>; Sun, 31 Oct 2021 19:41:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231241AbhJaTo0 (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Sun, 31 Oct 2021 15:44:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231134AbhJaToZ (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Sun, 31 Oct 2021 15:44:25 -0400
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC6FC061570
        for <linux-block@vger.kernel.org>; Sun, 31 Oct 2021 12:41:53 -0700 (PDT)
Received: by mail-io1-xd35.google.com with SMTP id q127so18154762iod.12
        for <linux-block@vger.kernel.org>; Sun, 31 Oct 2021 12:41:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=from:subject:to:cc:message-id:date:user-agent:mime-version
         :content-language:content-transfer-encoding;
        bh=OaMHO6FMV/ZQrAc9nOrGS124QbBuKlxzWWDYGXxPahM=;
        b=PwND1RaFXrBUZ8ul7f+/MXFANRt7+IdkGj2UH075gCo+zHuwvktLUkOF0mcTHgm8Rb
         Tux+bI437/yjrnHJfWASqL7DnQVczo220FKqB0FtKTtUbR00A2eK6mYwlmkPWD/9Pz7H
         N6vQZ1FbakqmyQmtmFzVFWruzibCwc5IOYNphKPEtG8HzoZMEMnsi9oYuyobyVjiU3VW
         jkbtl7Q5cLSVDICpciEkxZpqjswe6ujmIDGrgP4bjpVIiYOuMN9ZS/28dzDBJPUMukRw
         TzOrzgmeIj5DlTFOlIzJyUi54uks35Ht004QxRw1vjs/bZkE/4DcrqEgdMw8Eax9FuSJ
         T3sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:subject:to:cc:message-id:date:user-agent
         :mime-version:content-language:content-transfer-encoding;
        bh=OaMHO6FMV/ZQrAc9nOrGS124QbBuKlxzWWDYGXxPahM=;
        b=gJLVbpiU4fhT5rLoBa9zCCl+seFcpHrznAsRmInkuG4lXvOH6XCuoFIxvCMyPlZ2cP
         yr+75NldyRYkLZ7aGNAR7T2p9TC12sTJRTd8wRWqiNYE6Lt0Ao6R/bLd7RoTTjIGBBpo
         Ub7S/xP+ixY/0ndsaIdscd+VLN4x7i0ezlTAkiUvMc4cVfwsx5IcEcfN5TuR/sypft8e
         /cOdTqBTlwt8dghKWXF8WmNFbTgIACiL+6gl60/GHusRAZi9qoQgC3Vavknp5aldFMcS
         F/3LT9tIw/7uK47un81wvg2PLJd4zd6kl6BJ3ZsmWIyKUdRReItvCr1tztiOulmz2pbd
         QkZA==
X-Gm-Message-State: AOAM5331aPBHxMKnkUH0aSarZozE1MP4kmzcSVou7jdg2+ooNL0Qec8k
        igLyu25fogpN1An5rGPgoPjm+6eRsYATAw==
X-Google-Smtp-Source: ABdhPJwXZxC6Vq/c3DckmVfBixfCqOhtSJ7+ecmqEs7m2dp5nixhf4j0qLYFqIoMX4594/HgTStoqw==
X-Received: by 2002:a05:6602:2ac8:: with SMTP id m8mr18278912iov.112.1635709312877;
        Sun, 31 Oct 2021 12:41:52 -0700 (PDT)
Received: from [192.168.1.116] ([66.219.217.159])
        by smtp.gmail.com with ESMTPSA id o16sm994427iow.29.2021.10.31.12.41.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Oct 2021 12:41:52 -0700 (PDT)
From:   Jens Axboe <axboe@kernel.dk>
Subject: [GIT PULL] bdev size cleanups
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "linux-block@vger.kernel.org" <linux-block@vger.kernel.org>
Message-ID: <f870c029-140d-3e77-dcd1-1890025b5795@kernel.dk>
Date:   Sun, 31 Oct 2021 13:41:51 -0600
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

On top of the core block branch, this topic branch cleans up the bdev
size handling.

Please pull!


The following changes since commit 4f5022453acd0f7b28012e20b7d048470f129894:

  nvme: wire up completion batching for the IRQ path (2021-10-18 14:40:47 -0600)

are available in the Git repository at:

  git://git.kernel.dk/linux-block.git tags/for-5.16/bdev-size-2021-10-29

for you to fetch changes up to 97eeb5fc14cc4b2091df8b841a07a1ac69f2d762:

  partitions/ibm: use bdev_nr_sectors instead of open coding it (2021-10-19 06:17:33 -0600)

----------------------------------------------------------------
for-5.16/bdev-size-2021-10-29

----------------------------------------------------------------
Christoph Hellwig (33):
      block: move the SECTOR_SIZE related definitions to blk_types.h
      block: add a bdev_nr_bytes helper
      bcache: remove bdev_sectors
      drbd: use bdev_nr_sectors instead of open coding it
      dm: use bdev_nr_sectors and bdev_nr_bytes instead of open coding them
      md: use bdev_nr_sectors instead of open coding it
      nvmet: use bdev_nr_bytes instead of open coding it
      target/iblock: use bdev_nr_bytes instead of open coding it
      fs: use bdev_nr_bytes instead of open coding it in blkdev_max_block
      fs: simplify init_page_buffers
      affs: use bdev_nr_sectors instead of open coding it
      btrfs: use bdev_nr_bytes instead of open coding it
      cramfs: use bdev_nr_bytes instead of open coding it
      fat: use bdev_nr_sectors instead of open coding it
      hfs: use bdev_nr_sectors instead of open coding it
      hfsplus: use bdev_nr_sectors instead of open coding it
      jfs: use bdev_nr_bytes instead of open coding it
      nfs/blocklayout: use bdev_nr_bytes instead of open coding it
      nilfs2: use bdev_nr_bytes instead of open coding it
      ntfs3: use bdev_nr_bytes instead of open coding it
      pstore/blk: use bdev_nr_bytes instead of open coding it
      reiserfs: use bdev_nr_bytes instead of open coding it
      squashfs: use bdev_nr_bytes instead of open coding it
      block: use bdev_nr_bytes instead of open coding it in blkdev_fallocate
      block: add a sb_bdev_nr_blocks helper
      ext4: use sb_bdev_nr_blocks
      jfs: use sb_bdev_nr_blocks
      ntfs: use sb_bdev_nr_blocks
      reiserfs: use sb_bdev_nr_blocks
      udf: use sb_bdev_nr_blocks
      block/ioctl: use bdev_nr_sectors and bdev_nr_bytes
      partitions/efi: use bdev_nr_bytes instead of open coding it
      partitions/ibm: use bdev_nr_sectors instead of open coding it

Jens Axboe (1):
      block: cache inode size in bdev

 block/fops.c                        |  2 +-
 block/genhd.c                       |  1 +
 block/ioctl.c                       | 20 ++++++++------------
 block/partitions/core.c             |  1 +
 block/partitions/efi.c              |  2 +-
 block/partitions/ibm.c              | 19 ++++++++++---------
 drivers/block/drbd/drbd_int.h       |  3 +--
 drivers/md/bcache/super.c           |  2 +-
 drivers/md/bcache/util.h            |  4 ----
 drivers/md/bcache/writeback.c       |  2 +-
 drivers/md/dm-bufio.c               |  2 +-
 drivers/md/dm-cache-metadata.c      |  2 +-
 drivers/md/dm-cache-target.c        |  2 +-
 drivers/md/dm-clone-target.c        |  2 +-
 drivers/md/dm-dust.c                |  5 ++---
 drivers/md/dm-ebs-target.c          |  2 +-
 drivers/md/dm-era-target.c          |  2 +-
 drivers/md/dm-exception-store.h     |  2 +-
 drivers/md/dm-flakey.c              |  3 +--
 drivers/md/dm-integrity.c           |  6 +++---
 drivers/md/dm-linear.c              |  3 +--
 drivers/md/dm-log-writes.c          |  4 ++--
 drivers/md/dm-log.c                 |  2 +-
 drivers/md/dm-mpath.c               |  2 +-
 drivers/md/dm-raid.c                |  6 +++---
 drivers/md/dm-switch.c              |  2 +-
 drivers/md/dm-table.c               |  3 +--
 drivers/md/dm-thin-metadata.c       |  2 +-
 drivers/md/dm-thin.c                |  2 +-
 drivers/md/dm-verity-target.c       |  3 +--
 drivers/md/dm-writecache.c          |  2 +-
 drivers/md/dm-zoned-target.c        |  2 +-
 drivers/md/md.c                     | 26 +++++++++++---------------
 drivers/nvme/target/io-cmd-bdev.c   |  4 ++--
 drivers/target/target_core_iblock.c |  4 ++--
 fs/affs/super.c                     |  2 +-
 fs/btrfs/dev-replace.c              |  3 +--
 fs/btrfs/disk-io.c                  |  2 +-
 fs/btrfs/ioctl.c                    |  4 ++--
 fs/btrfs/volumes.c                  |  8 ++++----
 fs/buffer.c                         |  4 ++--
 fs/cramfs/inode.c                   |  2 +-
 fs/ext4/super.c                     |  2 +-
 fs/fat/inode.c                      |  5 +----
 fs/hfs/mdb.c                        |  2 +-
 fs/hfsplus/wrapper.c                |  2 +-
 fs/jfs/resize.c                     |  5 ++---
 fs/jfs/super.c                      |  5 ++---
 fs/nfs/blocklayout/dev.c            |  4 ++--
 fs/nilfs2/ioctl.c                   |  2 +-
 fs/nilfs2/super.c                   |  2 +-
 fs/nilfs2/the_nilfs.c               |  2 +-
 fs/ntfs/super.c                     |  8 +++-----
 fs/ntfs3/super.c                    |  2 +-
 fs/pstore/blk.c                     |  8 +++-----
 fs/reiserfs/super.c                 |  8 ++------
 fs/squashfs/super.c                 |  5 +++--
 fs/udf/lowlevel.c                   |  5 ++---
 fs/udf/super.c                      |  9 +++------
 include/linux/blk_types.h           | 18 ++++++++++++++++++
 include/linux/blkdev.h              | 17 -----------------
 include/linux/genhd.h               | 13 ++++++++++++-
 62 files changed, 140 insertions(+), 160 deletions(-)

-- 
Jens Axboe

