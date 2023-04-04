Return-Path: <linux-block-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5D8C6FD1D
	for <linux-block@archiver.kernel.org>; Tue,  4 Apr 2023 22:57:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230455AbjDDW5X (ORCPT <rfc822;linux-block@archiver.kernel.org>);
        Tue, 4 Apr 2023 18:57:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231460AbjDDW5W (ORCPT
        <rfc822;linux-block@vger.kernel.org>); Tue, 4 Apr 2023 18:57:22 -0400
Received: from out-27.mta1.migadu.com (out-27.mta1.migadu.com [95.215.58.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C74401999
        for <linux-block@vger.kernel.org>; Tue,  4 Apr 2023 15:57:19 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680649037;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=et9yveK1f0SJqjkaI654SqxiGTZgBFxS0E+zwS62Obg=;
        b=Vjc/MXEeH4ZJ4p+WJiFQ6dap9fLbbQFHZnAsdDEdteB5pafuUK+OvHVVkAn45yyM9/V4c+
        xuGI/hxLzp2aWYwaPg4ccj6I6Ee3MS7MK0Gc3MgSssoI5lhv3/FABebcJ/6LtFJnmJ+J2g
        /SZZIpq5SgEjMeMyBvHvN1VjOMGswcE=
From:   Kent Overstreet <kent.overstreet@linux.dev>
To:     linux-kernel@vger.kernel.org, linux-block@vger.kernel.org,
        axboe@kernel.dk
Cc:     Kent Overstreet <kent.overstreet@linux.dev>, willy@infradead.org,
        phillip@squashfs.org.uk, ming.lei@redhat.com, hch@infradead.org
Subject: [PATCH v2 0/2] bio iter improvements
Date:   Tue,  4 Apr 2023 18:57:07 -0400
Message-Id: <20230404225709.862208-1-kent.overstreet@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
Precedence: bulk
List-ID: <linux-block.vger.kernel.org>
X-Mailing-List: linux-block@vger.kernel.org

previous lore link:
https://lore.kernel.org/linux-block/ZCxaMIP%2Fl7BeLzz7@moria.home.lan/T/#t

changes since v1:
 - fixed squashfs issues
 - renamed foliovec to folio_seg, thanks Matthew for the suggestion
 - moved the WARN_ON() to an out of line function to reduce data size,
   per Christoph
 - fixed kernel doc comment on bio_for_each_folio_all(), added one for
   bio_for_each_folio()

Kent Overstreet (2):
  block: Rework bio_for_each_segment_all()
  block: Rework bio_for_each_folio_all()

 block/bio.c                |  43 ++++++-----
 block/blk-map.c            |  38 +++++-----
 block/bounce.c             |  12 ++--
 drivers/md/bcache/btree.c  |   8 +--
 drivers/md/dm-crypt.c      |  10 +--
 drivers/md/raid1.c         |   4 +-
 fs/btrfs/disk-io.c         |  10 +--
 fs/btrfs/extent_io.c       |  52 +++++++-------
 fs/btrfs/inode.c           |   8 +--
 fs/btrfs/raid56.c          |  18 ++---
 fs/crypto/bio.c            |   8 +--
 fs/erofs/zdata.c           |   4 +-
 fs/ext4/page-io.c          |   8 +--
 fs/ext4/readpage.c         |   4 +-
 fs/f2fs/data.c             |  20 +++---
 fs/gfs2/lops.c             |  10 +--
 fs/gfs2/meta_io.c          |   8 +--
 fs/iomap/buffered-io.c     |  14 ++--
 fs/mpage.c                 |   4 +-
 fs/squashfs/block.c        |  59 +++++++--------
 fs/squashfs/lz4_wrapper.c  |  17 +++--
 fs/squashfs/lzo_wrapper.c  |  17 +++--
 fs/squashfs/xz_wrapper.c   |  19 ++---
 fs/squashfs/zlib_wrapper.c |  18 ++---
 fs/squashfs/zstd_wrapper.c |  19 ++---
 fs/verity/verify.c         |   4 +-
 include/linux/bio.h        | 142 +++++++++++++++++++++++--------------
 include/linux/bvec.h       |  70 +++++++++++-------
 28 files changed, 358 insertions(+), 290 deletions(-)

-- 
2.40.0

