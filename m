Return-Path: <SRS0=aWxv=TB=vger.kernel.org=linux-block-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36A89C43219
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:28:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E754A20866
	for <linux-block@archiver.kernel.org>; Wed,  1 May 2019 04:28:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=wdc.com header.i=@wdc.com header.b="CouY4Tew"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725958AbfEAE2h (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Wed, 1 May 2019 00:28:37 -0400
Received: from esa5.hgst.iphmx.com ([216.71.153.144]:9392 "EHLO
        esa5.hgst.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725799AbfEAE2h (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Wed, 1 May 2019 00:28:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=wdc.com; i=@wdc.com; q=dns/txt; s=dkim.wdc.com;
  t=1556684916; x=1588220916;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=Y742O/olkIVywR1rgp+/Rsv5/sGxk3Ux2khTb42p6uo=;
  b=CouY4TewAETKphKNbsBz/DYaMmog9ctRKT+rMkqeF8pCF1+svMY5oL8j
   FAc7npw8cP+m+EjP55WgfOFRivJ7V42TG2nKFlORYlSVoAFfiSikuliWo
   Gw1g2EhoXokTDDcWfeTH4jMrcRqmE9pM4jyqWV75q+CrYl9fbzstUGCFY
   DQJdsfaG/8JzOYSOSg+N7qwRsOOw03/duMj6v1yt1z5HP9HVaydbhfmCD
   926Bz4kQilxN23s/+5+C661nHYm6Rc1+T9j+1YtbTgbJba4aJWrCpzhMv
   PS/MyWyhuvSyuL0ykO+mJYChyBtUm+ngP4WgG3nzUB8aVS3+HqK1la/R/
   A==;
X-IronPort-AV: E=Sophos;i="5.60,416,1549900800"; 
   d="scan'208";a="108436740"
Received: from h199-255-45-15.hgst.com (HELO uls-op-cesaep02.wdc.com) ([199.255.45.15])
  by ob1.hgst.iphmx.com with ESMTP; 01 May 2019 12:28:36 +0800
IronPort-SDR: 4OFAe8/sC9fFoFKkFUvQoWwHJMagZqcDBErUoBM6G+mRa0sKg6JicxenoRFT5TOaxgEVx1hpHZ
 WchVeHMoD9GKKB9nJg0oIwts72eTRRXgCMcAwEuw9x3HoJflNXGRlnWIzHTzRX05DVuM06mGj+
 cka8gytWnFYFkUOnNsM7XhozNpHrLEtSp7ZKFGs8cl54gk+i2vW4+wOxT+E7PNP4vtEgLOK/nk
 1jTy0f0NF0btFGXKgVNux1H238M5Dg9BZZJoyrIcIoLC/u1GsHE0tDd30pJSzM0UktXIqcY0VK
 5ZWRzGgG4Zd4/tmBNZpbQWEf
Received: from uls-op-cesaip01.wdc.com ([10.248.3.36])
  by uls-op-cesaep02.wdc.com with ESMTP; 30 Apr 2019 21:07:04 -0700
IronPort-SDR: /0FhCGuvdJgYfNhcOJCsey9xe1Uf/kKO6vS0M2aqLgVt+EDkk/ayhcT3FQ7CPJnptT3pNA+1ms
 AHVoCAEs2xgkXAc0ciZFky+SVWEEW0i1B2tmfqceuf4i5X3w/sUPVkI6q54mBtKQ9UtNbgt3zr
 G5cSWCRJ71HvelbcHNY4H3JixsP2tlU5aHw4vdpR/WxynSu/DHh0u1hqoNS5vQRkBePo3vtEHg
 61wqjkZ8XB0//3w0Ni6aE6Lf97NzCnBg+qbEmfWBVnCCmpJ3pUCIkngkXg39KygtcWZQ1FiVro
 7Vc=
Received: from cmercuryqemu.hgst.com ([10.202.65.32])
  by uls-op-cesaip01.wdc.com with ESMTP; 30 Apr 2019 21:28:36 -0700
From:   Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
To:     linux-block@vger.kernel.org
Cc:     Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>
Subject: [RFC PATCH 00/18] blktrace: add blktrace extension support
Date:   Tue, 30 Apr 2019 21:28:13 -0700
Message-Id: <20190501042831.5313-1-chaitanya.kulkarni@wdc.com>
X-Mailer: git-send-email 2.19.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-block-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

Hi,

This patch series adds support to track more request based flags and 
different request fields to the blktrace infrastructure.

In this series, we increase the action and action mask field and add 
priority and priority mask field to existing infrastructure.

The userland tools part of the patch-series is followed by this
one, here is the reference:-
Chaitanya Kulkarni (10):
        blktrace.h: add blktrace extension to the header
        blktrace_api.h: update blktrace API header
        act-mask: add blktrace extension to act_mask
        blktrace.c: add support for extensions
        blkparse.c: add support for extensions
        blkparse-fmt.c: add extension support
        iowatcher/blkparse: add extension definitions
        blkiomon: add extension support
        blkrawverify: add extension support
        blktrace-tools: add extension support


Following is the detailed overview of how this patch-series is
organized:-

1. The first few patches focus on adding block trace extension:-

  blktrace: increase the size of action mask
  blktrace: add more definitions for BLK_TC_ACT
  blktrace: update trace to track more actions
  kernel/trace: add KConfig to enable blktrace_ext

2. Next set of patches adds support to track request based priority and
allows the user to configure request priority maks just like action
mask:-

  blktrace: add iopriority mask
  blktrace: add iopriority mask
  blktrace: allow user to track iopriority
  blktrace: add sysfs ioprio mask
  blktrace: add debug support for extension

3. Following patches just set the bio priority so that blktrace will not
report wrong priority while tracing bios:-

  block: set ioprio for write-zeroes, discard etc 
  block: set ioprio for zone-reset
  block: set ioprio for flush bio 
  drivers: set bio iopriority field
  fs: set bio iopriority field
  power/swap: set bio iopriority field
  mm: set bio iopriority field

  Ideally, the above patches for drivers and fs category should be sent
  separately to the respective subsystem for the RFC review purpose I
  kept it all in the one patch.
  

4. Last two patches add support for null_blk driver to specify
module parameter for discard and write-zeroes operations which
makes testing easier:-

  null_blk: add write-zeroes flag to nullb_device
  null_blk: add module param discard/write-zeroes

P.S. I've not added linux-btrace mailing list as I'm having trouble
subscribing to it. 

RFC is little light on the detail but would like to start the discussion
about how should we add extensions to the block trace
infrastructure to track more request operations and priorities.

Regards,
Chaitanya


Chaitanya Kulkarni (18):
  blktrace: increase the size of action mask
  blktrace: add more definitions for BLK_TC_ACT
  blktrace: update trace to track more actions
  kernel/trace: add KConfig to enable blktrace_ext
  blktrace: add iopriority mask
  blktrace: add iopriority mask
  blktrace: allow user to track iopriority
  blktrace: add sysfs ioprio mask
  blktrace: add debug support for extension
  block: set ioprio for write-zeroes, discard etc
  block: set ioprio for zone-reset
  block: set ioprio for flush bio
  drivers: set bio iopriority field
  fs: set bio iopriority field
  power/swap: set bio iopriority field
  mm: set bio iopriority field
  null_blk: add write-zeroes flag to nullb_device
  null_blk: add module param discard/write-zeroes

 block/blk-flush.c                   |   2 +
 block/blk-lib.c                     |   6 +
 block/blk-zoned.c                   |   2 +
 drivers/block/drbd/drbd_actlog.c    |   2 +
 drivers/block/drbd/drbd_bitmap.c    |   3 +
 drivers/block/null_blk.h            |   1 +
 drivers/block/null_blk_main.c       |  37 +++-
 drivers/block/xen-blkback/blkback.c |   3 +
 drivers/block/zram/zram_drv.c       |   2 +
 drivers/lightnvm/pblk-read.c        |   2 +
 drivers/lightnvm/pblk-write.c       |   1 +
 drivers/md/bcache/journal.c         |   2 +
 drivers/md/bcache/super.c           |   2 +
 drivers/md/dm-bufio.c               |   2 +
 drivers/md/dm-cache-target.c        |   1 +
 drivers/md/dm-io.c                  |   2 +
 drivers/md/dm-log-writes.c          |   5 +
 drivers/md/dm-thin.c                |   1 +
 drivers/md/dm-writecache.c          |   2 +
 drivers/md/dm-zoned-metadata.c      |   4 +
 drivers/md/md.c                     |   4 +
 drivers/md/raid5-cache.c            |   4 +
 drivers/md/raid5-ppl.c              |   3 +
 drivers/nvme/target/io-cmd-bdev.c   |   7 +
 drivers/staging/erofs/internal.h    |   3 +
 drivers/target/target_core_iblock.c |   3 +
 fs/btrfs/disk-io.c                  |   2 +
 fs/btrfs/extent_io.c                |   3 +
 fs/btrfs/raid56.c                   |   6 +
 fs/btrfs/scrub.c                    |   2 +
 fs/btrfs/volumes.c                  |   3 +
 fs/buffer.c                         |   2 +
 fs/crypto/bio.c                     |   3 +
 fs/direct-io.c                      |   2 +
 fs/ext4/page-io.c                   |   2 +
 fs/ext4/readpage.c                  |   1 +
 fs/f2fs/data.c                      |   3 +
 fs/f2fs/segment.c                   |   1 +
 fs/gfs2/lops.c                      |   2 +
 fs/gfs2/meta_io.c                   |   2 +
 fs/gfs2/ops_fstype.c                |   2 +
 fs/hfsplus/wrapper.c                |   2 +
 fs/iomap.c                          |   2 +
 fs/jfs/jfs_logmgr.c                 |   3 +
 fs/jfs/jfs_metapage.c               |   3 +
 fs/mpage.c                          |   1 +
 fs/nfs/blocklayout/blocklayout.c    |   2 +
 fs/nilfs2/segbuf.c                  |   2 +
 fs/ocfs2/cluster/heartbeat.c        |   2 +
 fs/xfs/xfs_aops.c                   |   3 +
 fs/xfs/xfs_buf.c                    |   2 +
 include/linux/blktrace_api.h        |  13 +-
 include/uapi/linux/blktrace_api.h   |  65 ++++--
 kernel/power/swap.c                 |   2 +
 kernel/trace/Kconfig                |  36 ++++
 kernel/trace/blktrace.c             | 323 +++++++++++++++++++++++++++-
 mm/page_io.c                        |   2 +
 57 files changed, 579 insertions(+), 26 deletions(-)

-- 
2.19.1

