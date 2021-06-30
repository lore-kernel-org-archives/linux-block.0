Return-Path: <linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24B0CC11F68
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 17:27:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F069E61426
	for <linux-block@archiver.kernel.org>; Wed, 30 Jun 2021 17:27:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbhF3R3k (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 30 Jun 2021 13:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232222AbhF3R3j (ORCPT
        <rfc822;linux-block@vger.kernel.org>);
        Wed, 30 Jun 2021 13:29:39 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7481C0617A8
        for <linux-block@vger.kernel.org>; Wed, 30 Jun 2021 10:27:09 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id f6so3302524qka.0
        for <linux-block@vger.kernel.org>; Wed, 30 Jun 2021 10:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition;
        bh=zB+yYeYlRbesjsTSmi355np3eoCrr3mJXJ6lzxXNB20=;
        b=iNh1VsLxZ4RN/vfQYbLnQ0aus7YdWxH8pi+5ghcKxmFLJJ0nCqKg/oDprs9cc12WxR
         +/KWMJhaQbLWFK5VoRmX2vf//JACnbuvPE8RwXFtfx4hF15Lats84jP62BxJaKm7hN+E
         hOhmIW0mL6HmQjhloH8gRhW869TxRHw5pdFrLoSQH8GIZ7fSI8ntuLL5IkTonH+CZUq8
         zBlIe1olNPwuTI80zK4132rz1MuMB95wxFjLRmTVLMO5rjTzzfbXoCsl5RyF0pFzvqfg
         R+/JFTyNPy4XkHdQv5yPOhL5Qr4YykdnEIjuFyOhZKlPHv5g5NoM+Jb3pCGmJ/92JZ3n
         PPZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition;
        bh=zB+yYeYlRbesjsTSmi355np3eoCrr3mJXJ6lzxXNB20=;
        b=HMZ++SmE4V5DE5Zc9DWTrS/QAMySyIBDD3OOQtmGLRhbSB65oRANhNPS37BfPxapZJ
         Awt3mIkrQMohCXY+A9INz6O8i5hlbGqlSyTYSHrTc4XULl7ojCtsuR2ZBBru0nQyFBAn
         MpLu+3ujBCK/MHPTxmvLhfFE0pEDkB1C0E4f6ZNevqrYJuOtSBHTjRpSnuD5WqdQa/F0
         2WtxB3Cd9Qs12GKbgJFfa7vv89z6Ah6ihSIMvt/1fBInJ+274XEbHGWfnPwcexOKyFh2
         FoDV36B7x0B/oZvjxtf7BOX3Ny8FBIfFyVZ8rG6bj8thIFmhNgJk5aPvG+70p7ekjggJ
         TL1A==
X-Gm-Message-State: AOAM532QR4wY+SmtiY0aEbWXEw/Da85f2YQd55BG/yL2Cm1X6JoxxsFx
        XJtKuLHcn+C2qfWpRPZzErs=
X-Google-Smtp-Source: ABdhPJwiTb3gcWZhVWRtc8I1GvgfTk1j5fxrpTENxnEk+CvU6HeMrYenvZ7JAuXyQOVt8bG3ZeuCSw==
X-Received: by 2002:a37:4685:: with SMTP id t127mr37627406qka.384.1625074028318;
        Wed, 30 Jun 2021 10:27:08 -0700 (PDT)
Received: from localhost (pool-68-160-176-52.bstnma.fios.verizon.net. [68.160.176.52])
        by smtp.gmail.com with ESMTPSA id h6sm10806403qta.65.2021.06.30.10.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Jun 2021 10:27:07 -0700 (PDT)
Sender: Mike Snitzer <snitzer@gmail.com>
Date:   Wed, 30 Jun 2021 13:27:06 -0400
From:   Mike Snitzer <snitzer@redhat.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     dm-devel@redhat.com, linux-block@vger.kernel.org,
        Alasdair G Kergon <agk@redhat.com>,
        Baokun Li <libaokun1@huawei.com>,
        Colin Ian King <colin.king@canonical.com>,
        Damien Le Moal <damien.lemoal@wdc.com>,
        Hou Tao <houtao1@huawei.com>, Joe Thornber <ejt@redhat.com>,
        Mikulas Patocka <mpatocka@redhat.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>
Subject: [git pull] device mapper changes for 5.14
Message-ID: <YNyparaGoPleiSxX@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi Linus,

The following changes since commit 7e768532b2396bcb7fbf6f82384b85c0f1d2f197:

  dm snapshot: properly fix a crash when an origin has no snapshots (2021-05-25 16:19:58 -0400)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/device-mapper/linux-dm.git tags/for-5.14/dm-changes

for you to fetch changes up to 5c0de3d72f8c05678ed769bea24e98128f7ab570:

  dm writecache: make writeback pause configurable (2021-06-28 16:30:13 -0400)

Please pull, thanks.
Mike

----------------------------------------------------------------
- Various DM persistent-data library improvements and fixes that
  benefit both the DM thinp and cache targets.

- A few small DM kcopyd efficiency improvements.

- Significant zoned related block core, DM core and DM zoned target
  changes that culminate with adding zoned append emulation (which is
  required to properly fix DM crypt's zoned support).

- Various DM writecache target changes that improve efficiency. Adds
  an optional "metadata_only" feature that only promotes bios flagged
  with REQ_META. But the most significant improvement is writecache's
  ability to pause writeback, for a confiurable time, if/when the
  working set is larger than the cache (and the cache is full) -- this
  ensures performance is no worse than the slower origin device.

----------------------------------------------------------------
Baokun Li (1):
      dm writecache: use list_move instead of list_del/list_add in writecache_writeback()

Colin Ian King (1):
      dm ps io affinity: remove redundant continue statement

Damien Le Moal (13):
      dm zoned: check zone capacity
      dm: Fix dm_accept_partial_bio() relative to zone management commands
      dm: cleanup device_area_is_invalid()
      dm: move zone related code to dm-zone.c
      dm: Introduce dm_report_zones()
      dm: Forbid requeue of writes to zones
      block: improve handling of all zones reset operation
      block: introduce bio zone helpers
      block: introduce BIO_ZONE_WRITE_LOCKED bio flag
      dm: rearrange core declarations for extended use from dm-zone.c
      dm: introduce zone append emulation
      dm crypt: Fix zoned block device support
      dm zone: fix dm_revalidate_zones() memory allocation

Hou Tao (1):
      dm btree remove: assign new_root only when removal succeeds

Joe Thornber (4):
      dm btree: improve btree residency
      dm space maps: don't reset space map allocation cursor when committing
      dm space maps: improve performance with inc/dec on ranges of blocks
      dm space map disk: cache a small number of index entries

Mike Snitzer (2):
      dm writecache: add "cleaner" and "max_age" to Documentation
      dm io tracker: factor out IO tracker

Mikulas Patocka (12):
      dm kcopyd: avoid useless atomic operations
      dm kcopyd: avoid spin_lock_irqsave from process context
      dm writecache: don't split bios when overwriting contiguous cache content
      dm writecache: interrupt writeback if suspended
      dm writecache: remove unused gfp_t argument from wc_add_block()
      dm writecache: commit just one block, not a full page
      dm writecache: have ssd writeback wait if the kcopyd workqueue is busy
      dm writecache: flush origin device when writing and cache is full
      dm writecache: write at least 4k when committing
      dm writecache: add optional "metadata_only" parameter
      dm writecache: pause writeback if cache full and origin being written directly
      dm writecache: make writeback pause configurable

Rikard Falkeborn (1):
      dm table: Constify static struct blk_ksm_ll_ops

 .../admin-guide/device-mapper/writecache.rst       |  25 +-
 block/blk-zoned.c                                  | 119 +++-
 drivers/md/Makefile                                |   4 +
 drivers/md/dm-cache-target.c                       |  82 +--
 drivers/md/dm-core.h                               |  65 ++
 drivers/md/dm-crypt.c                              |  31 +-
 drivers/md/dm-era-target.c                         |  24 +-
 drivers/md/dm-flakey.c                             |   7 +-
 drivers/md/dm-io-tracker.h                         |  81 +++
 drivers/md/dm-kcopyd.c                             |  41 +-
 drivers/md/dm-linear.c                             |   7 +-
 drivers/md/dm-ps-io-affinity.c                     |   1 -
 drivers/md/dm-raid1.c                              |   2 +-
 drivers/md/dm-table.c                              |  23 +-
 drivers/md/dm-thin-metadata.c                      |  91 +--
 drivers/md/dm-writecache.c                         | 140 ++++-
 drivers/md/dm-zone.c                               | 660 +++++++++++++++++++++
 drivers/md/dm-zoned-metadata.c                     |   7 +
 drivers/md/dm-zoned-reclaim.c                      |   2 +-
 drivers/md/dm.c                                    | 208 ++-----
 drivers/md/dm.h                                    |  30 +-
 drivers/md/persistent-data/dm-array.c              |  52 +-
 drivers/md/persistent-data/dm-btree-internal.h     |  13 +
 drivers/md/persistent-data/dm-btree-remove.c       |   7 +-
 drivers/md/persistent-data/dm-btree-spine.c        |  16 +-
 drivers/md/persistent-data/dm-btree.c              | 542 +++++++++++++++--
 drivers/md/persistent-data/dm-btree.h              |  10 +-
 drivers/md/persistent-data/dm-space-map-common.c   | 534 ++++++++++++++++-
 drivers/md/persistent-data/dm-space-map-common.h   |  34 +-
 drivers/md/persistent-data/dm-space-map-disk.c     |  83 +--
 drivers/md/persistent-data/dm-space-map-metadata.c | 105 ++--
 drivers/md/persistent-data/dm-space-map.h          |  18 +-
 .../md/persistent-data/dm-transaction-manager.c    |  61 ++
 .../md/persistent-data/dm-transaction-manager.h    |  22 +-
 include/linux/blk_types.h                          |   1 +
 include/linux/blkdev.h                             |  12 +
 include/linux/device-mapper.h                      |   9 +-
 include/linux/dm-kcopyd.h                          |   1 +
 38 files changed, 2548 insertions(+), 622 deletions(-)
 create mode 100644 drivers/md/dm-io-tracker.h
 create mode 100644 drivers/md/dm-zone.c
